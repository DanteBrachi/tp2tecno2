FBox crearJugador(float x, float y, float w, float h, color c, float g, boolean s, float d) {
  FBox main = new FBox(w, h);
  main.setPosition(x, y);
  main.setFillColor(c);
  main.attachImage(loadImage("messi.png"));
  main.setDensity(g);
  main.setStatic(s);
  main.setDamping(d);

  return main;
}

FBox dibujarJugador(float x, float y, float w, float h, color c) {
  return crearJugador(x, y, w, h, c, 1, false, 1);
}
