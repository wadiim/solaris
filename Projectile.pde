class Projectile
{
  final static float RADIUS = 0.8;
  
  PVector position;
  PVector velocity;
  
  Projectile(PVector initPos, PVector velocity)
  {
    this.position = initPos;
    this.velocity = velocity;
  }
  
  void draw()
  {
    noStroke();
    fill(#ff0000);
    specular(255, 255, 255);
    shininess(5.0);
    
    pushMatrix();
    translate(position.x, position.y, position.z);
    sphere(RADIUS);
    popMatrix();
    
    position.add(velocity);
  }
}
