import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:codelabs/direction.dart';
import 'package:codelabs/snake_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'block.dart';
import 'food.dart';
import 'log.dart';

class SnakePainter extends CustomPainter {

  SnakeGame _snakeGame;
  Paint _paint = Paint();

  bool _isResourceInit = false;

  late ui.Image _foodImage;
  late ui.Image _barrierImage;
  late ui.Image _snakeHeadUpImage;
  late ui.Image _snakeHeadDownImage;
  late ui.Image _snakeHeadLeftImage;
  late ui.Image _snakeHeadRightImage;
  late ui.Image _snakeBodyImage;

  SnakePainter(SnakeGame game) : _snakeGame = game, super(repaint: game.ticker);

  @override
  void paint(Canvas canvas, Size size) async {
    Log.d("paint()");

    // draw background
    _paint.color = Colors.grey;
    canvas.drawPaint(_paint);

    double blockSize = min(size.width / SnakeGame.Width, size.height / SnakeGame.Height);
    double horizontalPadding = (size.width - blockSize * SnakeGame.Width) / 2;
    double verticalPadding = (size.height - blockSize * SnakeGame.Height) / 2;
    // draw horizontal lines
    _paint.color = Colors.black;
    for (int row = 0; row < SnakeGame.Height + 1; ++row) {
      canvas.drawLine(
          Offset(horizontalPadding, row * blockSize + verticalPadding),
          Offset(size.width - horizontalPadding, row * blockSize + verticalPadding),
          _paint);
    }

    // draw vertical lines
    for (int col = 0; col < SnakeGame.Width + 1; ++col) {
      canvas.drawLine(
          Offset(col * blockSize + horizontalPadding, verticalPadding),
          Offset(col * blockSize + horizontalPadding, size.height - verticalPadding),
          _paint);
    }

    if (!_isResourceInit) {
      _isResourceInit = true;
      _foodImage = await getImage('assets/food.png');
      _barrierImage = await getImage('assets/barrier.png');
      _snakeHeadUpImage = await getImage('assets/snake_head_up.png');
      _snakeHeadDownImage = await getImage('assets/snake_head_down.png');
      _snakeHeadLeftImage = await getImage('assets/snake_head_left.png');
      _snakeHeadRightImage = await getImage('assets/snake_head_right.png');
      _snakeBodyImage = await getImage('assets/snake_body.png');
    }

    // draw snake
    for (int i = 0; i < _snakeGame.snake.body.length; ++i) {
      var block = _snakeGame.snake.body[i];
      var center = new Offset((block.x + 0.5) * blockSize + horizontalPadding, (block.y + 0.5) * blockSize + verticalPadding);
      var src = Rect.fromLTWH(0, 0, _snakeBodyImage.width.toDouble(), _snakeBodyImage.height.toDouble());
      var dst = Rect.fromCenter(center : center, width: blockSize - 1, height: blockSize - 1);

      if (i == 0) {
        // draw snake head
        switch (_snakeGame.snake.direction) {
          case Direction.Up:
            canvas.drawImageRect(_snakeHeadUpImage, src, dst, _paint);
            break;
          case Direction.Down:
            canvas.drawImageRect(_snakeHeadDownImage, src, dst, _paint);
            break;
          case Direction.Left:
            canvas.drawImageRect(_snakeHeadLeftImage, src, dst, _paint);
            break;
          case Direction.Right:
            canvas.drawImageRect(_snakeHeadRightImage, src, dst, _paint);
            break;
        }
      } else {
        canvas.drawImageRect(_snakeBodyImage, src, dst, _paint);
      }
    }

    // draw foods
    for (Food food in _snakeGame.foods) {
      var center = new Offset((food.x + 0.5) * blockSize + horizontalPadding, (food.y + 0.5) * blockSize + verticalPadding);
      var src = Rect.fromLTWH(0, 0, _foodImage.width.toDouble(), _foodImage.height.toDouble());
      var dst = Rect.fromCenter(center : center, width: blockSize - 1, height: blockSize - 1);
      canvas.drawImageRect(_foodImage, src, dst, _paint);
    }

    // draw barriers
    _paint.color = Colors.blue;
    for (Block block in _snakeGame.barriers) {
      var center = new Offset((block.x + 0.5) * blockSize + horizontalPadding, (block.y + 0.5) * blockSize + verticalPadding);
      var src = Rect.fromLTWH(0, 0, _barrierImage.width.toDouble(), _barrierImage.height.toDouble());
      var dst = Rect.fromCenter(center : center, width: blockSize - 1, height: blockSize - 1);
      canvas.drawImageRect(_barrierImage, src, dst, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant SnakePainter oldDelegate) {
    return true;
  }

  Future<ui.Image> getImage(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}