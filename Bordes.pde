FBox crearBordeIzquierdo(float x, float y, float w, float h, color c, float g, boolean s) {
  FBox main = new FBox(w, h);
  main.setPosition(x, y);
  main.setFillColor(c);
  float we = (w / 20);
  float he = (h / 20);
  main.setDensity(g / (we * he));
  main.setStatic(s);

  return main;
}

FBox dibujarBordeIzquierdo(float x, float y, float w, float h, color c) {
  return crearBordeIzquierdo(x, y, w, h, c, 20, true);
}

FBox crearBordeDerecho(float x, float y, float w, float h, color c, float g, boolean s) {
  FBox main = new FBox(w, h);
  main.setPosition(x, y);
  main.setFillColor(c);
  float we = (w / 20);
  float he = (h / 20);
  main.setDensity(g / (we * he));
  main.setStatic(s);

  return main;
}

FBox dibujarBordeDerecho(float x, float y, float w, float h, color c) {
  return crearBordeDerecho(x, y, w, h, c, 20, true);
}

FBox crearBordeArriba(float x, float y, float w, float h, color c, float g, boolean s) {
  FBox main = new FBox(w, h);
  main.setPosition(x, y);
  main.setFillColor(c);
  float we = (w / 20);
  float he = (h / 20);
  main.setDensity(g / (we * he));
  main.setStatic(s);

  return main;
}

FBox dibujarBordeArriba(float x, float y, float w, float h, color c) {
  return crearBordeArriba(x, y, w, h, c, 20, true);
}
