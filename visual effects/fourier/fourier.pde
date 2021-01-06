float time = 0;
ArrayList<Float> wave;
int iterations = 1;
double timeSpeed = 0.01;

void setup(){
  size(600, 600);
  wave = new ArrayList<Float>();
}

void draw(){
  background(0);
  translate(150, 200);
  
  push();
  float x = 0;
  float y = 0;
  for(int i=0;i<iterations;i++){
    int n = i*2+1;
    float px = x;
    float py = y;
    float radius = 75 * 4/(n*PI);
    x += radius*cos(n*time);
    y += radius*sin(n*time);
    
    stroke(255, 100);
    noFill();
    ellipse(px, py, radius*2, radius*2);
    
    stroke(255);
    line(px, py, x, y);
  }
  wave.add(0, y);
  pop();
  
  drawArrow(x, y, 200, y);
  
  push();
  translate(200, 0);
  noFill();
  stroke(255);
  beginShape();
  for(int i=0;i<wave.size();i++){
    vertex(i, wave.get(i));
  }
  endShape();
  pop();
  
  time+=timeSpeed;
  if(wave.size()>250)wave.remove(wave.size()-1);
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

void keyPressed(){
  if(keyCode==UP)iterations++;
  if(keyCode==DOWN)iterations--;
  if(keyCode==LEFT)timeSpeed/=1.1;
  if(keyCode==RIGHT)timeSpeed*=1.1;
  if(iterations<1)iterations=1;
  println("Iterations: "+iterations);
  println("TimeSpeed: "+timeSpeed);
}
