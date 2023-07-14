import toxi.geom.*;
import java.lang.System.*;

class Spaceship
{
  final static float WIDTH = 6.0;
  final static float HEIGHT = 3.6;
  final static float LENGTH = 16.0;
  final static float SPEED = 5.0;
  final static float ROTATION_SPEED = 1.5;
  final static float FIRERATE = 8.0; // Projectiles per second
  
  long timeFired;
  
  PVector position;
  Quaternion orientation;
  
  PVector front;
  PVector top;
  
  Projectile projectile;
  ArrayList<Projectile> projectiles;
  
  Spaceship()
  {
    this.position = new PVector(0, 0, 3000);
    this.orientation = new Quaternion();
    this.front = new PVector(0, 0, -1);
    this.top = new PVector(0, -1, 0);
    this.projectile = null;
    this.projectiles = new ArrayList<Projectile>();
    this.timeFired = System.currentTimeMillis();
  }
  
  void draw()
  {
    float rotation[] = spaceship.orientation.toAxisAngle();
    
    pushMatrix();
    rotate(rotation[0], rotation[1], rotation[2], rotation[3]);
    front = new PVector(modelX(0, 0, -1), modelY(0, 0, -1), modelZ(0, 0, -1)).normalize();
    top = new PVector(modelX(0, -1, 0), modelY(0, -1, 0), modelZ(0, -1, 0)).normalize();
    
    pushMatrix();
    rotateX(cameraRotation.x);
    rotateY(cameraRotation.y);
    PVector eye = new PVector(modelX(0, 0, 1), modelY(0, 0, 1), modelZ(0, 0, 1)).setMag(cameraDistance).add(spaceship.position);
    popMatrix();
    popMatrix();
    
    camera(eye.x, eye.y, eye.z, spaceship.position.x, spaceship.position.y, spaceship.position.z, -top.x, -top.y, -top.z);

    pushMatrix();
  
    translate(spaceship.position.x, spaceship.position.y, spaceship.position.z);
    rotate(rotation[0], rotation[1], rotation[2], rotation[3]);
    
    noStroke();
    fill(#ffffff);
    specular(255, 255, 255);
    shininess(5.0);

    // Back panel
    beginShape();
    vertex(-WIDTH / 2, HEIGHT / 2, LENGTH / 2);
    vertex(WIDTH / 2, HEIGHT / 2, LENGTH / 2);
    vertex(0, -HEIGHT / 2, LENGTH / 2);
    endShape(CLOSE);
    
    // Bottom panel
    beginShape();
    vertex(0, HEIGHT / 2, -LENGTH / 2);
    vertex(-WIDTH / 2, HEIGHT / 2, LENGTH / 2);
    vertex(WIDTH / 2, HEIGHT / 2, LENGTH / 2);
    endShape(CLOSE);
    
    // Starboard
    beginShape();
    vertex(WIDTH / 2, HEIGHT / 2, LENGTH / 2);
    vertex(0, HEIGHT / 2, -LENGTH / 2);
    vertex(0, -HEIGHT / 2, LENGTH / 2);
    endShape(CLOSE);
    
    // Port
    beginShape();
    vertex(-WIDTH / 2, HEIGHT / 2, LENGTH / 2);
    vertex(0, HEIGHT / 2, -LENGTH / 2);
    vertex(0, -HEIGHT / 2, LENGTH / 2);
    endShape(CLOSE);
    
    popMatrix();
    
    for (Projectile projectile : projectiles)
    {
      projectile.draw();
    }
    
    if (projectiles.size() > 0
        && (abs(projectiles.get(0).position.x) > 10000
            || abs(projectiles.get(0).position.y) > 10000
            || abs(projectiles.get(0).position.z) > 10000))
    {
      projectiles.remove(0);
    }
  }
  
  void pitchUp()
  {
    this.orientation = this.orientation.multiply(Quaternion.createFromEuler(radians(0), radians(0), radians(-ROTATION_SPEED)));
  }

  void pitchDown()
  {
    this.orientation = this.orientation.multiply(Quaternion.createFromEuler(radians(0), radians(0), radians(ROTATION_SPEED)));
  }

  void rollLeft()
  {
    this.orientation = this.orientation.multiply(Quaternion.createFromEuler(radians(0), radians(-ROTATION_SPEED), radians(0)));
  }

  void rollRight()
  {
    this.orientation = this.orientation.multiply(Quaternion.createFromEuler(radians(0), radians(ROTATION_SPEED), radians(0)));
  }

  void yawLeft()
  {
    this.orientation = this.orientation.multiply(Quaternion.createFromEuler(radians(ROTATION_SPEED), radians(0), radians(0)));
  }

  void yawRight()
  {
    this.orientation = this.orientation.multiply(Quaternion.createFromEuler(radians(-ROTATION_SPEED), radians(0), radians(0)));
  }
  
  void goForward()
  {
    this.position.add(PVector.mult(front, Spaceship.SPEED));
  }
  
  void goBackward()
  {
    this.position.sub(PVector.mult(front, Spaceship.SPEED));
  }
  
  void shoot()
  {
    if ((System.currentTimeMillis() - timeFired) >= 1000 / FIRERATE)
    {
      PVector pos = PVector.mult(front, Spaceship.LENGTH / 2 + Projectile.RADIUS).add(spaceship.position).sub(PVector.mult(top, Spaceship.HEIGHT / 2));
      projectiles.add(new Projectile(pos, front.mult(20)));
      timeFired = System.currentTimeMillis();
    }
  }
}
