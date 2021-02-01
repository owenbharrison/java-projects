class Explosion{
  PVector pos;
  ArrayList<Particle> particles;
  int duration;
  int time = 0;
  int intensity;
  int lifespan;
  
  public Explosion(float x, float y, int i, int lf, int du){
    particles = new ArrayList<Particle>();
    pos = new PVector(x, y);
    intensity = i;
    lifespan = lf;
    duration = du;
  }
  
  void update(){
    if(time<duration){
      explodeFromCenter();
    }
    for(int i=0;i<particles.size();i++){
      Particle p = particles.get(i);
      p.update();
      if(p.isFinished()){
        particles.remove(i);
        i--;
      }
    }
    time++;
  }
  
  void explodeFromCenter(){
    for(int i=0;i<intensity;i++){
      PVector v = PVector.random2D().mult(random(4.3));
      float size = random(3, 8);
      int lf = lifespan-round(random(1, 50));
      Particle p = new Particle(pos.x, pos.y, v.x, v.y, size, lf);
      particles.add(p);
    }
  }
  
  void updateParticleColors(){
    for(Particle p:particles){
      float percent = map(p.age, 0, p.lifespan, 0, 1);
      p.setStroke(explosionGradient.getAtPercent(percent));
    }
  }
  
  boolean isFinished(){
    boolean res = true;
    for(Particle p:particles){
      if(!p.isFinished())res=false;
    }
    return res;
  }
  
  void show(){
    for(Particle p:particles)p.show();
  }
}



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



class ColorRamp{
  PImage rampImg;
  color[] ramp;
  
  public ColorRamp(String url){
    rampImg = loadImage(url);
    ramp = new color[rampImg.width];
    rampImg.loadPixels();
    for(int i=0;i<rampImg.width;i++){
      ramp[i] = rampImg.pixels[i];
    }
  }
  
  color getAtPercent(float pc){
    int index = floor(map(pc, 0, 1, 0, ramp.length));
    return ramp[index];
  }
}
