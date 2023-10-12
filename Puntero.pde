class Puntero {
  float id;
  float x;
  float y;

  FWorld mundo;
  FMouseJoint mj;

  Puntero(FWorld _mundo, float _id, float _x, float _y) {
    mundo = _mundo;
    id = _id;
    x = _x;
    y = _y;

    mj = new FMouseJoint(jugador, x, y);

    mundo.add(mj);
  }

  void setTarget(float nx, float ny) {
    mj.setTarget(nx, ny);
  }

  void setID(float id) {
    this.id = id;
  }

  void borrar() {
    mundo.remove(mj);
  }
}
