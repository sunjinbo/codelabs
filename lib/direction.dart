import 'package:flutter/foundation.dart';

enum Direction {
  Up,
  Down,
  Left,
  Right
}

extension DirectionExtension on Direction {
  String get name => describeEnum(this);

  static Direction covert(String name) {
    switch (name) {
      case "Up": return Direction.Up;
      case "Down": return Direction.Down;
      case "Left": return Direction.Left;
      case "Right": return Direction.Right;
    }
    throw Exception("Incorrect name of Direction");
  }
}