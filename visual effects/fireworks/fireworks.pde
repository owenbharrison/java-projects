ArrayList<Firework> fireworks;
PVector GRAVITY;

void setup(){
  fullScreen();
  fireworks = new ArrayList<Firework>();
  newFirework();
  GRAVITY = new PVector(0, 0.03);
  frameRate(60);
}

void draw(){
  push();
  noStroke();
  fill(0, 100);
  rect(0, 0, width, height);
  pop();
  if(random(0.75)<0.1){
    newFirework();
  }
  for(int i=0;i<fireworks.size();i++){
    Firework f = fireworks.get(i);
    f.update();
    f.show();
    if(f.particles.size()==0&&f.exploded){
      fireworks.remove(i);
      i--;
    }
  }
}

void newFirework(){
  float x = random(width);
  float y = height;
  int radius = round(random(6, 20));
  int intensity = round(random(80, 180));
  int seedSize = round(random(4, 7));
  int fireworkSize = round(seedSize*random(0.4, 0.8));
  color col = color(random(255), random(255), random(255));
  Firework firework = new Firework(x, y, radius, intensity, seedSize, fireworkSize, col);
  fireworks.add(firework);
}
