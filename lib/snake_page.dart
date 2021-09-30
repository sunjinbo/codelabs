import 'package:codelabs/direction.dart';
import 'package:codelabs/snake_game.dart';
import 'package:codelabs/snake_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'codelabs_localizations.dart';
import 'direction.dart';

class SnakePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CodeLabsLocalizations.of(context).snake),
      ),
      body: Center(
        child: SnakeConsole(context),
      ),
    );
  }
}

class SnakeConsole extends StatelessWidget implements SnakeGameCallback {
  late final snakeGame;
  late final snakePainter;
  final context;

  SnakeConsole(BuildContext context) : this.context = context {
    snakeGame = SnakeGame(this);
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
            SizedBox(height: 10,),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              height: 50,
              child: new Text(CodeLabsLocalizations.of(context).up),
              onPressed: () {
                snakeGame.turn(Direction.Up);
              },
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  height: 50,
                  child: new Text(CodeLabsLocalizations.of(context).left),
                  onPressed: () {
                    snakeGame.turn(Direction.Left);
                  },
                ),
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  height: 50,
                  child: new Text(CodeLabsLocalizations.of(context).down),
                  onPressed: () {
                    snakeGame.turn(Direction.Down);
                  },
                ),
                MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  height: 50,
                  child: new Text(CodeLabsLocalizations.of(context).right),
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

  void _showReplayDialog() async {
    var result = await showDialog(
        context:context,
        builder: (context){
          return AlertDialog(
            title: Text(CodeLabsLocalizations.of(context).gameOver),
            content: Text(CodeLabsLocalizations.of(context).replayTips),
            actions: <Widget>[
              TextButton(
                child: Text(CodeLabsLocalizations.of(context).cancel),
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
              ),
              TextButton(
                child: Text(CodeLabsLocalizations.of(context).ok),
                onPressed: () {
                  Navigator.pop(context, 'Ok');
                  snakeGame.play();
                },
              )
            ],
          );
        }
    );
  }

  @override
  void onGameOver() {
    _showReplayDialog();
  }
}