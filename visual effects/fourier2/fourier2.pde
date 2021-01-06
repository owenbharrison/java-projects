float time = 0;
ArrayList<PVector> path;
ArrayList<Integer> signalX, signalY;
ArrayList<Epicycle> fourierX, fourierY;

void setup(){
  size(600, 600);
  path = new ArrayList<PVector>();
  signalX = new ArrayList<Integer>();
  signalY = new ArrayList<Integer>();
  float angle = 0;
  for(int i=0;i<100;i++){
    signalX.add(int(100*cos(angle)));
    signalY.add(int(100*sin(angle)));
    angle += 0.02;
  }
  fourierX = dft(signalX);
  fourierY = dft(signalY);
}

void draw(){
  background(0);
  PVector vx = showEpicycles(width/2, 50, 0, fourierX);
  PVector vy = showEpicycles(50, height/2, PI/2, fourierY);
  path.add(0, new PVector(vx.x, vy.y));
  
  //draw path
  push();
  translate(200, 0);
  noFill();
  stroke(255);
  beginShape();
  for(int i=0;i<path.size();i++){
    vertex(path.get(i).x, path.get(i).y);
  }
  endShape();
  pop();
  
  //update time
  time += (PI*2)/fourierX.size();
  //remove excess path elements
  if(path.size()>200)path.remove(path.size()-1);
}

void drawArrow(float x1, float y1, float x2, float y2){
  push();
  stroke(255);
  line(x1, y1, x2, y2);
  pop();
  
  push();
  translate(x2, y2);
  fill(255);
  rotate(new PVector(x2-x1, y2-y1).heading());
  triangle(0, 0, -9, 5, -9, -5);
  pop();
}
