PVector cameraRotation = new PVector(radians(10), 0, 0);
float cameraDistance = 100.0;
float xOffset = 0.0;
float yOffset = 0.0;
int input = 0;

Spaceship spaceship;

CelestialBody sun;
CelestialBody mercury;
CelestialBody venus;
CelestialBody earth;
CelestialBody moon;
CelestialBody mars;
CelestialBody phobos;
CelestialBody deimos;
CelestialBody jupiter;
CelestialBody io;
CelestialBody europa;
CelestialBody ganymede;

void setup()
{
  size(916, 916, P3D);
  noStroke();
  smooth(8);
  
  spaceship = new Spaceship();
  
  sun = new CelestialBody(110, 0, new PVector(0, 0, 0), 0, new PVector(0, 0, 0), 0, color(253, 247, 168), true);

  mercury = new CelestialBody(32, 350, new PVector(-0.01, -1, 0), 0.005, new PVector(-0.01, 1, 0), 0.02, color(159, 112, 52), false);

  venus = new CelestialBody(40, 600, new PVector(0.05, -1, 0), 0.003, new PVector(0.02, 1, 0), -0.04, color(166, 95, 25), false);

  earth = new CelestialBody(50, 900, new PVector(0, -1, 0), 0.002, new PVector(-0.2, 1, 0), 0.06, color(85, 110, 118), false);
  moon = new CelestialBody(12, 112, new PVector(0.08, -1, 0), -0.024, new PVector(0, 0, 0), 0, color(139), false);
  earth.addSatelite(moon);
  
  mars = new CelestialBody(36, 1240, new PVector(0.02, -1, 0.02), 0.0001, new PVector(-0.25, 1, 0), 0.02, color(148, 97, 85), false);
  phobos = new CelestialBody(8, 60, new PVector(0.5, -1, 0), -0.04, new PVector(-0.46, 1, 0), 0.015, color(65, 35, 46), false);
  deimos = new CelestialBody(10, 105, new PVector(0.44, -1, 0), -0.03, new PVector(-0.4, 1, 0), 0.012, color(65, 35, 46), false);
  mars.addSatelite(phobos);
  mars.addSatelite(deimos);
  
  jupiter = new CelestialBody(96, 2000, new PVector(-0.12, -1, 0.04), 0.0001, new PVector(-0.009, 1, 0), 0.001, color(201, 152, 108), false);
  io = new CelestialBody(9, 120, new PVector(-0.8, -1, -0.1), -0.05, new PVector(0.9, 1, 0), 0.042, color(154, 128, 87), false);
  europa = new CelestialBody(7, 160, new PVector(-0.7, -1, -0.08), -0.03, new PVector(0.7, 1, 0), 0.038, color(144), false);
  ganymede = new CelestialBody(12, 240, new PVector(-0.6, -1, -0.1), -0.022, new PVector(0.55, 1, 0), 0.033, color(117, 113, 104), false);
  jupiter.addSatelite(io);
  jupiter.addSatelite(europa);
  jupiter.addSatelite(ganymede);
  
  sun.addSatelite(mercury);
  sun.addSatelite(venus);
  sun.addSatelite(earth);
  sun.addSatelite(mars);
  sun.addSatelite(jupiter);
}

void draw()
{
  background(0);
  lightSpecular(100, 100, 100);

  sun.draw();
  spaceship.draw();
  
  if ((input & Input.SPACEBAR.code()) != 0)
  {
    spaceship.goForward();
  }
  if ((input & Input.R.code()) != 0)
  {
    spaceship.goBackward();
  }
  if ((input & Input.D.code()) != 0)
  {
    spaceship.yawRight();
  }
  if ((input & Input.A.code()) != 0)
  {
    spaceship.yawLeft();
  }
  if ((input & Input.W.code()) != 0)
  {
    spaceship.pitchUp();
  }
  if ((input & Input.S.code()) != 0)
  {
    spaceship.pitchDown();
  }
  if ((input & Input.Q.code()) != 0)
  {
    spaceship.rollLeft();
  }
  if ((input & Input.E.code()) != 0)
  {
    spaceship.rollRight();
  }
  if ((input & Input.LEFT_MOUSE.code()) != 0)
  {
    spaceship.shoot();
  }
}

void keyPressed()
{
    if (key == ' ')      input |= Input.SPACEBAR.code();
    else if (key == 'r') input |= Input.R.code();
    else if (key == 'd') input |= Input.D.code();
    else if (key == 'a') input |= Input.A.code();
    else if (key == 'w') input |= Input.W.code();
    else if (key == 's') input |= Input.S.code();
    else if (key == 'q') input |= Input.Q.code();
    else if (key == 'e') input |= Input.E.code();
}

void keyReleased()
{
    if (key == ' ')      input &= ~Input.SPACEBAR.code();
    else if (key == 'r') input &= ~Input.R.code();
    else if (key == 'd') input &= ~Input.D.code();
    else if (key == 'a') input &= ~Input.A.code();
    else if (key == 'w') input &= ~Input.W.code();
    else if (key == 's') input &= ~Input.S.code();
    else if (key == 'q') input &= ~Input.Q.code();
    else if (key == 'e') input &= ~Input.E.code();
}

void mousePressed()
{
  if (mouseButton == LEFT)
  {
    input |= Input.LEFT_MOUSE.code();
  }
  else if (mouseButton == RIGHT)
  {
    input |= Input.RIGHT_MOUSE.code();
    xOffset = mouseX;
    yOffset = mouseY;
  }
  else if (mouseButton == CENTER)
  {
    cameraRotation = new PVector(radians(10), 0, 0);
    cameraDistance = 100.0;
  }
}

void mouseReleased()
{
  if (mouseButton == LEFT)
  {
    input &= ~Input.LEFT_MOUSE.code();
  }
  else if (mouseButton == RIGHT)
  {
    input &= ~Input.RIGHT_MOUSE.code();
  }
}

void mouseDragged()
{
  if ((input & Input.RIGHT_MOUSE.code()) != 0)
  {
    if (abs(cameraRotation.x + radians(mouseY - yOffset)) < PI / 2)
    {
      cameraRotation.x += radians(mouseY - yOffset);
    }
    if (abs(cameraRotation.y - radians(mouseX - xOffset)) < PI / 2)
    {
      cameraRotation.y -= radians(mouseX - xOffset);
    }
    xOffset = mouseX;
    yOffset = mouseY;
  }
}

void mouseWheel(MouseEvent event)
{
  float delta = event.getCount();
  if (cameraDistance + delta >= 90 && cameraDistance + delta <= 200)
  {
    cameraDistance += delta;
  }
}
