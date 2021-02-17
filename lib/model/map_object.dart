class MapObject {
  double _x;
  double _y;

  double get x => this._x;
  double get y => this._y;

  set x(double newPosition) {
    this._x = newPosition;
  }

  set y(double newPosition) {
    this._y = newPosition;
  }
}