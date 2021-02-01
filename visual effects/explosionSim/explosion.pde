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
