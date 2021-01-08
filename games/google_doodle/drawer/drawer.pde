ArrayList<PVector> path;
int saved = 80;

void setup(){
  size(200, 200);
  path = new ArrayList<PVector>();
}

void mouseDragged(){
  path.add(new PVector(mouseX, mouseY));
}

void mouseReleased(){
  save("data/test/"+saved+".jpg");
  saved++;
  path = new ArrayList<PVector>();
}

void draw(){
  background(255);
  push();
  fill(0);
  noStroke();
  for(PVector p:path){
    circle(p.x, p.y, 8);
  }
  pop();
}
