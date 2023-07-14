class CelestialBody
{
  float radius;
  PShape shape = null;
  
  PVector position;
  PVector orbitalAxis;
  PVector rotationalAxis;
  
  float orbitalAngle = 0;
  float orbitalAngleStep;
  float rotationalAngle = 0;
  float rotationalAngleStep;
  
  ArrayList<CelestialBody> satelites;
  
  color fillColor;
  boolean isLightSource;
  
  CelestialBody(float radius,
                float orbitalRadius,
                PVector orbitalAxis,
                float orbitalAngleStep,
                PVector rotationalAxis,
                float rotationalAngleStep,
                color fillColor,
                boolean isLightSource)
  {
    this.radius = radius;
    this.orbitalAxis = orbitalAxis;
    this.orbitalAngleStep = orbitalAngleStep;
    this.rotationalAxis = rotationalAxis;
    this.rotationalAngleStep = rotationalAngleStep;
    this.fillColor = fillColor;
    this.isLightSource = isLightSource;
    
    this.position = orbitalAxis.cross(PVector.random3D()).setMag(orbitalRadius);
    
    this.satelites = new ArrayList<CelestialBody>();
  }
  
  CelestialBody(PShape shape,
                float orbitalRadius,
                PVector orbitalAxis,
                float orbitalAngleStep,
                PVector rotationalAxis,
                float rotationalAngleStep,
                color fillColor,
                boolean isLightSource)
  {
    this(shape.height, orbitalRadius, orbitalAxis, orbitalAngleStep, rotationalAxis, rotationalAngleStep, fillColor, isLightSource);
    this.shape = shape;
  }
  
  void draw()
  {
    pushMatrix();
    
    rotate(orbitalAngle, orbitalAxis.x, orbitalAxis.y, orbitalAxis.z);
    translate(position.x, position.y, position.z);
    
    pushMatrix();

    rotate(rotationalAngle, rotationalAxis.x, rotationalAxis.y, rotationalAxis.z);
    
    noStroke();
    fill(fillColor);
    
    if (shape != null)
    {
      pushMatrix();
      translate(shape.height/2, shape.height/2, 0);
      shape(shape);
      popMatrix();
    }
    else
    {
      sphere(radius);
    }
    
    if (isLightSource)
    {
      pointLight(255, 255, 255, 0, 0, 0);
      ambientLight(40, 40, 40);
    }
    
    popMatrix();
    
    for (int i = 0; i < satelites.size(); ++i)
    {
      satelites.get(i).draw();
    }
    
    orbitalAngle += orbitalAngleStep;
    rotationalAngle += rotationalAngleStep;
    
    popMatrix();
  }
  
  void addSatelite(CelestialBody satelite)
  {
    satelites.add(satelite);
  }
}
