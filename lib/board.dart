import 'dart:math';

import 'package:codelabs/barrier.dart';
import 'package:codelabs/block.dart';
import 'package:codelabs/block_type.dart';
import 'package:codelabs/snake.dart';

import 'food.dart';

class Board {

  late int _width;
  late int _height;
  late Snake _snake;
  late List<Barrier> _barriers;
  late List<Food> _foods;

  Board(int w, int h, Snake snake, List<Barrier> barriers, List<Food> foods) :
        assert(w >= 0 && h >= 0),
        _width = w,
        _height = h,
        _snake = snake,
        _barriers = barriers,
        _foods = foods;

  int get width => _width;

  int get height => _height;

  Block getRandomSpace() {
    var random = Random();
    while (true) {
      int x = random.nextInt(_width);
      int y = random.nextInt(_height);
      bool exist = false;

      for (Block block in _snake.body) {
        if (block.x == x && block.y == y) {
          exist = true;
          break;
        }
      }

      for (Block block in _barriers) {
        if (block.x == x && block.y == y) {
          exist = true;
          break;
        }
      }

      for (Food food in _foods) {
        if (food.x == x && food.y == y) {
          exist = true;
          break;
        }
      }

      if (exist) {
        continue;
      } else {
        return Block(x.toInt(), y.toInt(), BlockType.Food);
      }
    }
  }

  bool hitTest(int x, int y) {
    // 判断snake的head是否超过board的边界
    if (x < 0 || y < 0 || x > width - 1 || y > height - 1) {
      return true;
    }

    // 判断snake的head是否碰到自己的身体
    for (int i = 1; i < _snake.body.length; ++i) {
      if (x == _snake.body[i].x && y == _snake.body[i].y) {
        return true;
      }
    }

    // 判断snake的head是否碰到barrier
    for (Barrier barrier in _barriers) {
      if (x == barrier.x && y == barrier.y) {
        return true;
      }
    }

    return false;
  }

  BlockType? block(int x, int y) {
    if (x < 0 || x >= _width || y < 0 || y >= _height) return null;

    for (Block block in _snake.body) {
      if (x == block.x && y == block.y) {
        return BlockType.SnakeBody;
      }
    }
    for (Block block in _barriers) {
      if (x == block.x && y == block.y) {
        return BlockType.Barrier;
      }
    }
    for (Food food in _foods) {
      if (x == food.x && y == food.y) {
        return BlockType.Barrier;
      }
    }

    return null;
  }
}
