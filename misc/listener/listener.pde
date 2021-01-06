import ddf.minim.*;
Minim minim;
AudioInput in;

void setup(){
  size(512, 200, P3D);
  minim = new Minim(this);
  surface.setAlwaysOnTop(true);  
  
  in = minim.getLineIn();
}

void draw(){
  background(0);
  
  push();
  noFill();
  stroke(255);
  beginShape();
  for(int i=0;i<in.bufferSize()-1;i++){
    vertex(i, 100+in.mix.get(i)*100);
  }
  endShape();
  pop();
}
