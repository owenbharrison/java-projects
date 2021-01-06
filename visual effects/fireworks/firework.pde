class Firework{
  Particle seed;
  int radius;
  int intensity;
  int seedSize;
  int fireworkSize;
  color col;
  ArrayList<Particle> particles = new ArrayList<Particle>();
  boolean exploded = false;
  
  public Firework(float x, float y, int r, int it, int ss, int fs, color c){
    seed = new Particle(x, y, c, this, true);
    radius = r;
    intensity = it;
    seedSize = ss;
    fireworkSize = fs;
    col = c;
  }
  
  void update(){
    if(!exploded){
      seed.applyForce(GRAVITY);
      seed.update();
      if(seed.vel.y>=0){
        exploded = true;
        explode();
      }
    }
    for(int i=0;i<particles.size();i++){
      Particle p = particles.get(i);
      p.applyForce(GRAVITY);
      p.update();
      if(p.lifespan<0){
        particles.remove(i);
        i--;
      }
    }
  }
  
  void explode(){
    for(int i=0;i<intensity;i++){
      Particle p = new Particle(seed.pos.x, seed.pos.y, col, this, false);
      particles.add(p);
    }
  }
  
  void show(){
    if(!exploded)seed.show();
    for(Particle p:particles)p.show();
  }
}
