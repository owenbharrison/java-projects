class Metaball{
  PVector pos, vel;
  float radius;
  float mda;
  float mdl;
  
  public Metaball(float x, float y){
    pos = new PVector(x, y);
    vel = PVector.random2D().mult(2);
    radius = random(15,25);
  }
  
  void update(){
    pos.add(vel);
    if(pos.x<0||pos.x>width)vel.x *= -1;
    if(pos.y<0||pos.y>height)vel.y *= -1;
  }
  
  void checkMouse(){
    mda = dist(pos.x, pos.y, mouseX, mouseY);
    if(!mousePressed)mdl = mda;
    if(mousePressed&&mdl<radius){
      pos.x+=mouseX-pmouseX;
      pos.y+=mouseY-pmouseY;
    }
  }
}
