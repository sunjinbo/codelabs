
abstract class Spirit {

  late final Function _onDie;

  Spirit(Function onDie) : _onDie = onDie;

  void tick();

  void die() {
    _onDie();
  }
}
