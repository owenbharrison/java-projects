import java.util.Date;

final float AIRFRICTION = 0.998;
final PVector GRAVITY = new PVector(0, 0.25);
ArrayList<Explosion> explosions;
ColorRamp explosionGradient;

void setup(){
  size(800, 800);
  explosions = new ArrayList<Explosion>();
  explosionGradient = new ColorRamp("data/explosionRamp3.png");
}

void mousePressed(){
  explosions.add(new Explosion(mouseX, mouseY, 270, 55, 3));
}

void draw(){
  Date start = new Date();
  background(170);
  for(int i=0;i<explosions.size();i++){
    Explosion exp = explosions.get(i);
    exp.update();
    exp.updateParticleColors();
    
    if(exp.isFinished()){
      explosions.remove(i);
      i--;
    }
  }
  for(Explosion e:explosions)e.show();
  push();
  textAlign(CENTER, CENTER);
  text("FPS: "+round(frameRate), width/2, 20);
  pop();
  println(1000/(new Date().getTime()-start.getTime()+1));
}
