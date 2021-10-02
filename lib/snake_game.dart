import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:codelabs/board.dart';
import 'package:codelabs/snake.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'direction.dart';
import 'food.dart';
import 'barrier.dart';
import 'log.dart';

typedef GameOverCallback = void Function();

abstract class SnakeGameCallback {
  void onGameOver();
}

class SnakeGame {
  static const int Width = 20;
  static const int Height = 20;
  static const int FOOD_LIFE = 50;
  static const int FOOD_HATCH_INTERVAL = 2;

  late Board _board;
  late Snake _snake;
  late Timer _timer;

  var _foods = <Food>[];
  var _barriers = <Barrier>[];

  var _isPlaying = false;

  var _hatchFoodInterval = FOOD_HATCH_INTERVAL;

  var _ticker = ValueNotifier<int>(-1);

  var _callback;

  SnakeGame(SnakeGameCallback? callback) : _callback = callback;

  Snake get snake => _snake;
  List<Food> get foods => _foods;
  List<Barrier> get barriers => _barriers;
  ValueNotifier<int> get ticker => _ticker;

  void play() {
    if (!_isPlaying) {
      _isPlaying = true;

      _hatchFoodInterval = FOOD_HATCH_INTERVAL;

      _foods.clear();
      _barriers.clear();

      _barriers.add(new Barrier(10, 9));
      _barriers.add(new Barrier(10, 10));
      _barriers.add(new Barrier(10, 11));

      _snake = Snake.born(Width, Height, onDie: () {
        gameOver();
      });

      _board = new Board(Width, Height, _snake, _barriers, _foods);

      _hatchFood();

      _initTimer();
    }
  }

  void replay() {
    play();
  }

  void turn(Direction direction) {
    _snake.direction = direction;
  }

  void gameOver() {
    Log.d("gameOver()");
    _cancelTimer();
    _isPlaying = false;
    _callback?.onGameOver();
  }

  void tick() {
    if (_isPlaying) {
      for (Food food in _foods) {
        food.tick();
      }

      // 判断snake是否吃到食物
      bool hasEatFood = false;
      int nextX = _snake.nextX;
      int nextY = _snake.nextY;
      for (Food food in _foods) {
        if (nextX == food.x && nextY == food.y) {
          _snake.eat(food);
          hasEatFood = true;
          break;
        }
      }

      if (!hasEatFood) {
        if (!_board.hitTest(nextX, nextY)) {
          _snake.tick();
        } else {
          gameOver();
        }
      } else {
        _snake.tick();
      }

      _hatchFood();

      redraw();
    }
  }

  void redraw() {
    Log.d("redraw()");
    _ticker.value++;
  }

  void save() {
    if (_isPlaying) {
      String jsonString = toString();
      Log.d(jsonString);
      _saveData(jsonString);
    } else {
      _deleteData();
    }
  }

  Map toJson() => {"snake":snake, "foods":foods, "barriers":barriers};

  @override
  String toString() {
    if (_isPlaying) {
      return json.encode(this);
    }
    return "";
  }

  void _initTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 666), (timer) {
      tick();
    });
  }

  void _cancelTimer() {
    Log.d("_cancelTimer()");
    _timer.cancel();
  }

  void _hatchFood() {
    if (_isPlaying) {
      if (_hatchFoodInterval > 0) {
        --_hatchFoodInterval;
        if (_hatchFoodInterval == 0) {
          _foods.add(Food.born(_board, FOOD_LIFE, onDie: () {
            _foods.clear();
            _hatchFoodInterval = FOOD_HATCH_INTERVAL;
          }));
        }
      }
    }
  }

  Future<void> _saveData(String jsonData) async {
    Directory dir = await getTemporaryDirectory();
    File file = new File('${dir.path}/snake.txt');
    if (!file.existsSync()) {
      file.createSync();
    }
    await file.writeAsString(jsonData);
  }

  Future<void> _deleteData() async {
    Directory dir = await getTemporaryDirectory();
    File file = new File('${dir.path}/snake.txt');
    if (file.existsSync()) {
      file.deleteSync();
    }
  }
}
