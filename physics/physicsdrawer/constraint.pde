class Constraint{
  Particle p0, p1;
  float size;
  boolean highlighted = false;
  float preset = -1;
  
  public Constraint(Particle _p0, Particle _p1, float... sz){
    p0 = _p0;
    p1 = _p1;
    size = sz.length==0?getSize():sz[0];
  }
  
  float getSize(){
    return dist(p0.pos.x, p0.pos.y, p1.pos.x, p1.pos.y);
  }
  
  boolean containsPoint(float x, float y, float r){
    float angle = PVector.sub(p1.pos, p0.pos).heading();
    for(float i=getSize()/4;i<getSize()*3/4;i++){
      PVector cp = PVector.fromAngle(angle).mult(i).add(p0.pos);
      if(dist(cp.x, cp.y, x, y)<r)return true;
    }
    return false;
  }
  
  void update(){
    PVector d = PVector.sub(p1.pos, p0.pos);
    float dist = d.mag();
    float diff = size-dist;
    float percent = diff/dist/2;
    PVector o = d.mult(percent);
    if(!p0.locked)p0.pos.sub(o);
    if(!p1.locked)p1.pos.add(o);
  }
  
  void show(float sz){
    push();
    stroke(0);
    strokeWeight(sz);
    line(p0.pos.x, p0.pos.y, p1.pos.x, p1.pos.y);
    pop();
  }
}
