import 'package:codelabs/direction.dart';
import 'package:codelabs/snake_game.dart';
import 'package:codelabs/snake_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'direction.dart';

class SnakePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snake'),
      ),
      body: Center(
        child: SnakeConsole(),
      ),
    );
  }
}

class SnakeConsole extends StatelessWidget {
  late var snakeGame;
  late var snakePainter;

  SnakeConsole() {
    snakeGame = SnakeGame();
    snakePainter = SnakePainter(snakeGame);
  }

  @override
  Widget build(BuildContext context) {
    snakeGame.play();

    return Column(
      children: [
        CustomPaint(
          size: Size(360, 360),
          painter: snakePainter,
          // child: Container(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              height: 50,
              child: new Text('Up'),
              onPressed: () {
                snakeGame.turn(Direction.Top);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  height: 50,
                  child: new Text('Left'),
                  onPressed: () {
                    snakeGame.turn(Direction.Left);
                  },
                ),
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  height: 50,
                  child: new Text('Down'),
                  onPressed: () {
                    snakeGame.turn(Direction.Bottom);
                  },
                ),
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  height: 50,
                  child: new Text('Right'),
                  onPressed: () {
                    snakeGame.turn(Direction.Right);
                  },
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}