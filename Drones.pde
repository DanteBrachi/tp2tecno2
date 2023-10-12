FCircle crearDrones(float x, float y, float d, color c, float g, boolean s, float r) {
  FCircle main = new FCircle(d);
  main.setPosition(x, y);
  main.setFillColor(c);
  main.attachImage(loadImage("dron.png"));
  float de = (g / 20);
  main.setDensity(g / de);
  main.setStatic(s);
  main.setRestitution(r);

  return main;
}

FCircle dibujarDrones(float x, float y, float d, color c) {
  return crearDrones(x, y, d, c, 10, false, 0.2);
}
