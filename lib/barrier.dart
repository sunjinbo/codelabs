import 'package:codelabs/block.dart';
import 'package:codelabs/block_type.dart';

class Barrier extends Block {
  Barrier(int x, int y) : super(x, y, BlockType.Barrier);

  factory Barrier.fromJson(Map<String, dynamic> json) {
    final int x = json['x'];
    final int y = json['y'];
    return Barrier(x, y);
  }

  Map toJson() => {"x":x, "y":y, "type":type.name};

  @override
  String toString() {
    return "{\"x\":$x,\"y\":$y,\"type\":\"${type.name}\"}";
  }
}
