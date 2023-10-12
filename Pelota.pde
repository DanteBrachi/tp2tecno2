FCircle crearPelota(float x, float y, float d, color c, float g, boolean s, float r) {
  FCircle main = new FCircle(d);
  main.setPosition(x, y);
  main.setFillColor(c);
  main.attachImage(loadImage("pelota.png"));
  float de = (g / 20);
  main.setDensity(g / de);
  main.setStatic(s);
  main.setRestitution(r);
  main.setRotation(1);

  return main;
}

FCircle dibujarPelota(float x, float y, float d, color c) {
  return crearPelota(x, y, d, c, 20, false, 2.1);
}
