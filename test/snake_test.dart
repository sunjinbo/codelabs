import 'package:codelabs/barrier.dart';
import 'package:codelabs/block.dart';
import 'package:codelabs/block_type.dart';
import 'package:codelabs/direction.dart';
import 'package:codelabs/food.dart';
import 'package:codelabs/snake.dart';
import 'package:codelabs/snake_game.dart';
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

  test("测试将Block对象转成Json字符串", () {
    var jsonString = "{\"x\":1,\"y\":3,\"type\":\"SnakeBody\"}";
    var block = new Block(1, 3, BlockType.SnakeBody);
    expect(block.toString(), jsonString);
  });

  test("测试将Barrier对象转成Json字符串", () {
    var jsonString = "{\"x\":8,\"y\":9,\"type\":\"Barrier\"}";
    var barrier = new Barrier(8, 9);
    expect(barrier.toString(), jsonString);
  });

  test("测试将Food对象转成Json字符串", () {
    var jsonString = "{\"x\":11,\"y\":13,\"life\":20,\"type\":\"Food\"}";
    var food = new Food(11, 13, 20, onDie: (){});
    expect(food.toString(), jsonString);
  });

  test("测试将Snake对象转成Json字符串", () {
    var jsonString = "{\"direction\":\"Left\",\"body\":[{\"x\":1,\"y\":1,\"type\":\"SnakeBody\"},{\"x\":1,\"y\":2,\"type\":\"SnakeBody\"}]}";
    var snake = new Snake(onDie: (){});
    snake.body.add(new Block(1, 1, BlockType.SnakeBody));
    snake.body.add(new Block(1, 2, BlockType.SnakeBody));
    snake.direction = Direction.Left;
    expect(snake.toString(), jsonString);
  });
}
