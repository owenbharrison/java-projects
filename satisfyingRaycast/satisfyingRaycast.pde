ArrayList<Circle> circles;

PVector middle;

int size = 220;
int intensity = 720;

void setup(){
  size(800, 800);
  middle = new PVector(width/2, height/2);
  circles = new ArrayList<Circle>();
  for(int i=0;i<15;i++){
    PVector vec = new PVector(random(width), random(height));
    circles.add(new Circle(vec.x, vec.y, random(15, 27)));
  }
}

void draw(){
  background(0);
  ArrayList<PVector> stopPoints = new ArrayList<PVector>();
  middle.set(mouseX, mouseY);
  for(int a=0;a<intensity;a++){
    float angle = map(a, 0, intensity, 0, PI*2);
    PVector angleVector = PVector.fromAngle(angle);
    int shadowStart = -1;
    for(int l=0;l<size;l++){
      for(int p=0;p<circles.size();p++){
        Circle poly = circles.get(p);
        if(poly.contains(PVector.mult(angleVector, l).add(middle))){
          shadowStart = l;
          l = size;
          p = circles.size();
        }
      }
    }
    if(shadowStart!=-1)stopPoints.add(PVector.mult(angleVector, shadowStart).add(middle));
    else stopPoints.add(PVector.mult(angleVector, size).add(middle));
  }
  push();
  beginShape();
  noStroke();
  for(PVector sp:stopPoints){
    vertex(sp.x, sp.y);
  }
  endShape(CLOSE);
  pop();
  loadPixels();
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      int index = x+y*width;
      if(brightness(pixels[index])>0){
        pixels[index] = color(map(dist(middle.x, middle.y, x, y), 0, size, 255, 0));
      }
    }
  }
  updatePixels();
  push();
  textAlign(CENTER, CENTER);
  text("FPS: "+round(frameRate), width/2, 10);
  pop();
}
