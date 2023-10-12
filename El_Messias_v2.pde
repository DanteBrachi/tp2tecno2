import processing.sound.*;

import fisica.*;

FWorld mundo;

FBox plataforma, bordeIzq, bordeDer, bordeArriba, jugador;

FCircle botellas, drones, pelota;

FRevoluteJoint anclajePieIzq, anclajePieDer;

SoundFile intro, reboteSonido, gameplay, click, ganar, perder, viento;

String estado;

int cantidad = 0;

PImage fondoInicio, fondoTutorial, fondoGanar, fondoPerder, fondoJuego;

PFont fuente;

int PUERTO_OSC = 12345;

Receptor receptor;
Administrador admin;

void setup() {
  size(1024, 768);

  Fisica.init(this);

  textAlign(CENTER, CENTER);

  mundo = new FWorld();

  bordeIzq = dibujarBordeIzquierdo(-10, height/2, 10, 768, color(0));
  mundo.add(bordeIzq);
  bordeDer = dibujarBordeDerecho(1034, height/2, 10, 768, color(0));
  mundo.add(bordeDer);
  bordeArriba = dibujarBordeArriba(width/2, -10, 1025, 10, color(0));
  mundo.add(bordeArriba);

  plataforma = dibujarPlataforma(width/2, height/2 + 338, 1025, 100, color(75, 175, 71));
  mundo.add(plataforma);

  jugador = dibujarJugador(width/2 - 50, height/2 + 200, 75, 175, color(255));
  mundo.add(jugador);

  pelota = dibujarPelota(width/2 - 50, height/2 - 100, 30, color(255));
  mundo.add(pelota);

  botellas = dibujarBotellas(-20, random(5, 75), 30, color(255));
  drones = dibujarDrones(1044, random(5, 75), 30, color(255));

  estado = "Inicio";

  fondoInicio = loadImage("fondo.png");
  fondoTutorial = loadImage("fondoTutorial.png");
  fondoGanar = loadImage("fondoGanaste.png");
  fondoPerder = loadImage("fondoPerdiste.png");
  fondoJuego = loadImage("estadio1.jpg");

  fuente = loadFont("VCROSDMono-48.vlw");

  intro = new SoundFile(this, "muchachos.wav");
  reboteSonido = new SoundFile(this, "rebote.wav");
  gameplay = new SoundFile(this, "inGame.wav");
  click = new SoundFile(this, "click.wav");
  ganar = new SoundFile(this, "ganar.wav");
  perder = new SoundFile(this, "perder.wav");
  viento = new SoundFile(this, "viento.wav");

  intro.play();

  setupOSC(PUERTO_OSC);

  receptor = new Receptor();
  admin = new Administrador(mundo);
}

void draw() {
  if (estado.equals("Inicio")) {
    image(fondoInicio, 0, 0);
  } else if (estado.equals("Tutorial")) {
    image(fondoTutorial, 0, 0);

    push();
    fill(255, 245, 134);
    textFont(fuente, 32);
    text("Como jugar", width/2 + 20, height/2 - 300);
    pop();

    push();
    fill(255, 245, 134);
    textFont(fuente, 18);
    text("Messi tiene que hacer la cantidad de rebotes necesarios para ganar", width/2 + 10, height/2 - 225);
    text("Si la pelota toca el suelo perdiste", width/2 + 10, height/2 - 160);
    text("Cuidado los obstaculos que se presenten n/en el juego", width/2 + 10, height/2 - 100);
    pop();
  } else if (estado.equals("Juego")) {
    background(0);
    image(fondoJuego, 0, 0);

    mundo.step();
    mundo.draw();

    push();
    textFont(fuente, 32);
    fill(255);
    text("Rebotes: " + cantidad, 115, 715);
    pop();

    viento.pause();
    intro.stop();
  } else if (estado.equals("Ganar")) {
    image(fondoGanar, 0, 0);

    push();
    textFont(fuente, 72);
    fill(0);
    text("GANASTE", width/2 - 250, height/2 - 300);
    pop();

    push();
    textFont(fuente, 34);
    fill(255);
    text("Creado por", width/2 + 250, height/2);
    text("Dante Brachi", width/2 + 250, height/2 + 50);
    text("Mateo Andrade", width/2 + 250, height/2 + 100);
    text("Jonatan Arramendi", width/2 + 250, height/2 + 150);
    pop();
  } else if (estado.equals("Perder")) {
    image(fondoPerder, 0, 0);

    push();
    textFont(fuente, 72);
    fill(0);
    text("PERDISTE", width/2 - 250, height/2 - 300);
    pop();

    push();
    textFont(fuente, 34);
    fill(255);
    text("Creado por", width/2 + 250, height/2);
    text("Dante Brachi", width/2 + 250, height/2 + 50);
    text("Mateo Andrade", width/2 + 250, height/2 + 100);
    text("Jonatan Arramendi", width/2 + 250, height/2 + 150);
    pop();
  }

  if (cantidad > 4) {
    estado = "Ganar";
    ganar.play();
  }

  if (frameCount % 280 == 0) {
    mundo.add(botellas);
  } else if (frameCount % 480 == 0) {
    mundo.add(drones);
  }
  if (botellas.getX() > 1000) {
    mundo.remove(botellas);
  }
  if (drones.getX() < 20) {
    mundo.remove(drones);
  }
  botellas.addImpulse(random(350, 450), 0);
  botellas.getRotation();
  drones.addImpulse(random(-350, -450), 0);

  if (pelota.getY() < 200) {
    pelota.addImpulse(random(-500, 500), 0);

    push();
    textFont(fuente, 32);
    fill(255);
    text("Viento", 800, 715);
    pop();

    viento.play();
  }

  receptor.actualizar(mensajes);

  for (Blob b : receptor.blobs) {
    if (b.entro) {
      admin.crearPuntero(b);
      println("--> entro blob: " + b.id);
    }
    if (b.salio) {
      admin.removerPuntero(b);
      println("<-- salio blob: " + b.id);
    }
    admin.actualizarPuntero(b);
  }
}

void contactStarted(FContact rebote) {
  if (rebote.contains(jugador) && rebote.contains(pelota)) {
    cantidad ++;
    reboteSonido.play();
  } else if (rebote.contains(plataforma) && rebote.contains(pelota)) {
    estado = "Perder";
    perder.play();
  }
}

void keyPressed() {
  if (keyCode == ' ') {
    estado = "Juego";
    click.play();
  } else if (keyCode == 't' || keyCode == 'T') {
    estado = "Tutorial";
    click.play();
  }

  if (keyCode == LEFT) {
    jugador.addImpulse(-500, 0);
  } else if (keyCode == RIGHT) {
    jugador.addImpulse(500, 0);
  }
}
