import 'dart:math';

import 'package:codelabs/snake_game.dart';
import 'package:flutter/material.dart';

import 'block.dart';
import 'food.dart';
import 'log.dart';

class SnakePainter extends CustomPainter {

  SnakeGame _snakeGame;
  Paint _paint = Paint();

  SnakePainter(SnakeGame game) : _snakeGame = game, super(repaint: game.ticker);

  @override
  void paint(Canvas canvas, Size size) {
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

    // draw snake
    _paint.color = Colors.red;
    for (Block block in _snakeGame.snake.body) {
      var center = new Offset((block.x + 0.5) * blockSize + horizontalPadding, (block.y + 0.5) * blockSize + verticalPadding);
      canvas.drawRect(Rect.fromCenter(center : center, width: blockSize - 1, height: blockSize - 1), _paint);
    }

    // draw foods
    _paint.color = Colors.purple;
    for (Food food in _snakeGame.foods) {
      var center = new Offset((food.block.x + 0.5) * blockSize + horizontalPadding, (food.block.y + 0.5) * blockSize + verticalPadding);
      canvas.drawRect(Rect.fromCenter(center : center, width: blockSize - 1, height: blockSize - 1), _paint);
    }

    // draw barriers
    _paint.color = Colors.blue;
    for (Block block in _snakeGame.barriers) {
      var center = new Offset((block.x + 0.5) * blockSize + horizontalPadding, (block.y + 0.5) * blockSize + verticalPadding);
      canvas.drawRect(Rect.fromCenter(center : center, width: blockSize - 1, height: blockSize - 1), _paint);
    }
  }

  @override
  bool shouldRepaint(covariant SnakePainter oldDelegate) {
    return true;
  }
}