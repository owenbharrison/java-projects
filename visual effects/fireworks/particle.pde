class Particle{
  PVector pos, vel, acc;
  color col;
  Firework parent;
  boolean seed = false;
  int lifespan = 255;
  
  public Particle(float x, float y, color c, Firework p, boolean s){
    pos = new PVector(x, y);
    col = c;
    parent = p;
    seed = s;
    if(seed)vel=new PVector(0, random(-30, -5));
    else{
      vel=PVector.random2D();
      vel.mult(random(1, parent.radius));
    }
    acc = new PVector(0, 0);
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }
  
  void update(){
    if(!seed){
      vel.mult(0.85);
      lifespan -= 4;
    }
    vel.add(acc);
    pos.add(vel);
  }
  
  void show(){
    push();
    if(seed){
      strokeWeight(parent.seedSize);
      stroke(col);
    }
    else{
      strokeWeight(parent.fireworkSize);
      stroke(col, lifespan);
    }
    point(pos.x, pos.y);
    pop();
  }
}
