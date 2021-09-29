import 'package:codelabs/barrier.dart';
import 'package:codelabs/block.dart';
import 'package:codelabs/block_type.dart';
import 'package:codelabs/direction.dart';
import 'package:codelabs/food.dart';
import 'package:codelabs/snake.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("测试Block通过Json数据实例化", () {
    var jsonString = "{\"x\":1,\"y\":3,\"type\":\"SnakeBody\"}";
    var block = Block.fromJson(json.decode(jsonString));
    expect(block.x, 1);
    expect(block.y, 3);
    expect(block.type, BlockType.SnakeBody);
  });

  test("测试Barrier通过Json数据实例化", () {
    var jsonString = "{\"x\":8,\"y\":9}";
    var barrier = Barrier.fromJson(json.decode(jsonString));
    expect(barrier.x, 8);
    expect(barrier.y, 9);
    expect(barrier.type, BlockType.Barrier);
  });

  test("测试Food通过Json数据实例化", () {
    var jsonString = "{\"x\":11,\"y\":13,\"life\":20}";
    var food = Food.fromJson(json.decode(jsonString), onDie: (){});
    expect(food.x, 11);
    expect(food.y, 13);
    expect(food.life, 20);
    expect(food.type, BlockType.Food);
  });

  test("测试Snake通过Json数据实例化", () {
    var jsonString = "{\"direction\":\"Down\",\"body\":[{\"x\":1,\"y\":2,\"type\":\"SnakeBody\"},{\"x\":1,\"y\":2,\"type\":\"SnakeBody\"}]}";
    var snake = Snake.fromJson(json.decode(jsonString), onDie: (){});
    expect(snake.head.x, 1);
    expect(snake.head.y, 2);
    expect(snake.body.length, 2);
    expect(snake.direction, Direction.Down);
  });
}