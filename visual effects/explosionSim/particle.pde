class Particle{
  PVector pos, vel;
  int lifespan;
  int age = 0;
  color strokeCol;
  float radius;
  
  public Particle(float x, float y, float vx, float vy, float r, int lf){
    pos = new PVector(x, y);
    vel = new PVector(vx, vy);
    radius = r;
    lifespan = lf;
    strokeCol = color(0);
  }
  
  void setStroke(color col){
    strokeCol = col;
  }
  
  void update(){
    pos.add(vel);
    vel.mult(AIRFRICTION);
    vel.add(GRAVITY);
    age++;
  }
  
  boolean isFinished(){
    return age>=lifespan;
  }
  
  void show(){
    push();
    stroke(strokeCol);
    strokeWeight(radius);
    point(pos.x, pos.y);
    pop();
  }
}
