class Particle{
  PVector pos, oldpos;
  AABB aabb;
  float radius;
  float mouseDistAlways = Float.POSITIVE_INFINITY;
  float mouseDistLocked = Float.POSITIVE_INFINITY;
  boolean locked = false;
  
  public Particle(float x, float y, float _radius, AABB _aabb){
    pos = new PVector(x, y);
    oldpos = pos.copy();
    radius =  _radius;
    aabb = _aabb;
  }
  
  void update(){
    PVector v = PVector.sub(pos, oldpos).mult(FRICTION);
    oldpos = pos.copy();
    if(!locked){
      pos.add(v);
      pos.add(GRAVITY);
    }
    
    mouseDistAlways = dist(mouseX, mouseY, pos.x, pos.y);
    if(!LMB)mouseDistLocked = mouseDistAlways;
    if(mouseDistLocked<GRAB_SIZE&&LMB){
      mouseConstraint();
    }
  }
  
  void mouseConstraint(){
    mouseDistAlways = dist(mouseX, mouseY, pos.x, pos.y);
    if(!LMB)mouseDistLocked = mouseDistAlways;
    if(mouseDistLocked<GRAB_SIZE&&LMB){
      surface.setCursor(java.awt.Cursor.HAND_CURSOR);
      PVector v = PVector.sub(this.pos,new PVector(mouseX,mouseY)).mult(-.5);
      pos.x+=v.x;
      pos.y+=v.y;
    }
  }
  
  void checkBounds(){
    PVector v = PVector.sub(pos, oldpos).mult(FRICTION);
    if(pos.x<aabb.min.x+radius){
      pos.x = aabb.min.x+radius;
      oldpos.x = pos.x+v.x;
    }
    if(pos.x>aabb.max.x-radius){
      pos.x = aabb.max.x-radius;
      oldpos.x = pos.x+v.x;
    }
    if(pos.y<aabb.min.y+radius){
      pos.y = aabb.min.y+radius;
      oldpos.y = pos.y+v.y;
    }
    if(pos.y>aabb.max.y-radius){
      pos.y = aabb.max.y-radius;
      oldpos.y = pos.y+v.y;
    }
  }
  
  void show(){
    push();
    stroke(0);
    if(locked)noFill();
    else fill(0);
    circle(pos.x, pos.y, radius*2);
    pop();
  }
}
