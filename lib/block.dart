import 'dart:core';

import 'block_type.dart';

class Block {
  late int _x;
  late int _y;

  Block(int x, int y, BlockType t) :
      assert(x >= 0 && y >= 0),
      _x = x,
      _y = y,
      type = t;

  factory Block.fromJson(Map<String, dynamic> json) {
    Block block = new Block(json['x'], json['y'], BlockTypeExtension.covert(json['type']));
    return block;
  }

  int get x => _x;

  set x(int value) {
    if (value >= 0) {
      _x = value;
    }
  }

  int get y => _y;

  set y(int value) {
    if (value >= 0) {
      _y = value;
    }
  }

  BlockType type;

  Map toJson() => {"x":x, "y":y, "type":type.name};

  @override
  String toString() {
    return "{\"x\":$x,\"y\":$y,\"type\":\"${type.name}\"}";
  }
}