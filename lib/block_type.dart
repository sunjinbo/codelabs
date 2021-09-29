import 'package:flutter/foundation.dart';

enum BlockType {
  SnakeBody,
  Food,
  Barrier
}

extension BlockTypeExtension on BlockType {
  String get name => describeEnum(this);

  static BlockType covert(String name) {
    switch (name) {
      case "SnakeBody": return BlockType.SnakeBody;
      case "Food": return BlockType.Food;
      case "Barrier": return BlockType.Barrier;
    }
    throw Exception("Incorrect name of BlockType");
  }
}
