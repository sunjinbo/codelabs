import 'package:codelabs/block.dart';
import 'package:codelabs/block_type.dart';
import 'package:codelabs/board.dart';
import 'package:codelabs/spirit.dart';

class Food extends Spirit {
  late Block _block;
  late int _life;

  Food(int x, int y, int life, {required Function onDie}) : super(onDie) {
    _block = Block(x, y, BlockType.Food);
    _life = life;
  }

  factory Food.born(Board board, int life, {required Function onDie}) {
    var block = board.getRandomSpace();
    return Food(block.x, block.y, life, onDie: onDie);
  }

  Block get block => _block;

  @override
  void tick() {
    _life -= 1;
    if (_life <= 0) {
      die();
    }
  }
}
