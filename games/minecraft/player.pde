class Player{
  private PVector pos, vel, facing;
  private float fov, rot;
  private int renderDistance, speed = 4;
  public boolean onGround = true;
  
  public Player(int x, int y, int z, float fov_, int renderDistance_){
    pos = new PVector(x, y, z);
    vel = new PVector(0, 0, 0);
    facing = new PVector(0, 0, 0);
    fov = fov_;
    renderDistance = renderDistance_;
  }
  
  public void updateMovement(){
    vel.add(GRAVITY);
    pos.add(vel);
    checkCollisions();
  }
  
  public void checkCollisions(){
    if(pos.y>0){
      pos.y = 0;
      vel.y = 0;
      onGround = true;
    }
  }
  
  public void jump(){
    if(onGround){
      vel.y = -10;
    }
  }
  
  public void walk(float val){
    pos.x+=val*speed*sin(rot);
    pos.z+=val*speed*cos(rot);
  }
  
  public void strafe(float val){
    pos.x+=val*speed*sin(rot-PI/2);
    pos.z+=val*speed*cos(rot-PI/2);
  }
  
  public void updateCamera(int x, int y, int sen){
    //cameraController
    float alpha = map(y, 0, sen, PI/2, -PI/2);
    float beta = map(x, 0, sen, 0, -PI);
    rot = beta;
    PVector dir = new PVector(cos(alpha)*sin(beta), -sin(alpha), cos(alpha)*cos(beta));
    facing = PVector.add(pos, dir);
  }
  
  public void showCamera(){
    camera(pos.x, pos.y, pos.z, facing.x, facing.y, facing.z, 0, 1, 0);
    perspective(fov, width/height, 0.01, renderDistance);
  }
}
