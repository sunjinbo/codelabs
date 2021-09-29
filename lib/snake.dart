import 'dart:math';

import 'package:codelabs/block.dart';
import 'package:codelabs/block_type.dart';
import 'package:codelabs/spirit.dart';

import 'direction.dart';
import 'food.dart';
import 'log.dart';

class Snake extends Spirit {
  var body = <Block>[];
  late var direction;

  Snake(int x, int y, {required Function onDie}) : super(onDie) {
    body.add(Block(x, y, BlockType.SnakeBody));
    direction = _direction();
  }

  factory Snake.born(int width, int height, {required Function onDie}) {
    Random random = new Random();
    final int x = random.nextInt(width - 2) + 1;
    final int y = random.nextInt(height - 2) + 1;
    return new Snake(x, y, onDie: onDie);
  }

  Block get head => body[0];
  int get nextX => head.x + _dx();
  int get nextY => head.y + _dy();

  void walk() {
    Log.d("walk() - before - x = ${body[0].x}, y = ${body[0].y}");

    if (body.length > 1) {
      for (var i = body.length - 1; i >= 1; --i) {
        body[i].x = body[i - 1].x;
        body[i].y = body[i - 1].y;
        Log.d("walk() - run - x = ${body[i].x}, y = ${body[i].y}");
      }
    }

    Log.d("walk() - run - direction = ${direction.toString()}");
    Log.d("walk() - run - dx = ${_dx()}, dy = ${_dy()}");

    int nextX = body[0].x + _dx();
    int nextY = body[0].y + _dy();

    body[0].x = nextX;
    body[0].y = nextY;

    Log.d("walk() - after - x = ${body[0].x}, y = ${body[0].y}");
  }

  void eat(Food food) {
    Log.d("eat() - before - x = ${body[0].x}, y = ${body[0].y}");

    food.block.type = BlockType.SnakeBody;
    body.insert(0, food.block);
    food.die();

    Log.d("eat() - after - x = ${body[0].x}, y = ${body[0].y}");
  }

  @override
  void tick() {
    walk();
  }

  int _dx() {
    switch (direction) {
      case Direction.Top:
      case Direction.Bottom: return 0;
      case Direction.Left: return -1;
      case Direction.Right: return 1;
    }
    return 0;
  }

  int _dy() {
    switch (direction) {
      case Direction.Top: return -1;
      case Direction.Bottom: return 1;
      case Direction.Left:
      case Direction.Right: return 0;
    }
    return 0;
  }

  Direction _direction() {
    var rand = new Random();
    var ang = rand.nextInt(4);
    switch (ang) {
      case 0: return Direction.Top;
      case 1: return Direction.Bottom;
      case 2: return Direction.Left;
      case 3: return Direction.Bottom;
    }
    return Direction.Top;
  }
}