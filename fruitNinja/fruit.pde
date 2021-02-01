class Fruit{
  PVector pos, vel;
  float rot = 0, rotVel;
  int id = floor(random(TYPES.length));
  String type;
  PImage sprite;
  ArrayList<PVector> hitbox;
  int size = 100;
  
  public Fruit(float x, float y, float vx, float vy, float rv){
    pos = new PVector(x, y);
    vel = new PVector(vx, vy);
    type = TYPES[id];
    if(type=="pineapple")size*=2;
    if(type=="banana")size*=1.5;
    if(type=="watermelon")size*=1.2;
    if(type=="tomato")size*=0.75;
    sprite = SPRITES[id];
    hitbox = new ArrayList<PVector>();
    for(String s:HITBOXES[id].split("\n")){
      String[] pos = s.split(" ");
      hitbox.add(new PVector(Float.parseFloat(pos[0])*size/2, Float.parseFloat(pos[1])*size/2));
    }
    rotVel = rv;
  }
  
  void update(){
    vel.add(GRAVITY);
    pos.add(vel);
    rot += rotVel;
    rotVel *= 0.995;
  }
  
  void show(){
    push();
    translate(pos.x, pos.y);
    rotate(rot);
    strokeWeight(5);
    beginShape();
    for(PVector h:hitbox){
      vertex(h.x, h.y);
    }
    endShape(CLOSE);
    //imageMode(CENTER);
    //image(sprite, 0, 0, size, size);
    pop();
  }
  
  boolean isOffscreen(){
    return pos.x<-size*2||pos.x>width+size*2||pos.y<-size*2||pos.y>height+size*2;
  }
}
