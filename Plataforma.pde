FBox crearPlataforma(float x, float y, float w, float h, color c, float g, boolean s) {
  FBox main = new FBox(w, h);
  main.setPosition(x, y);
  main.setFillColor(c);
  main.setNoStroke();
  main.attachImage(loadImage("plataforma.png"));
  float we = (w / 20);
  float he = (h / 20);
  main.setDensity(g / (we * he));
  main.setStatic(s);

  return main;
}

FBox dibujarPlataforma(float x, float y, float w, float h, color c) {
  return crearPlataforma(x, y, w, h, c, 20, true);
}
