ArrayList<PVector> points;
ArrayList<PVector> edge;
int inc = 50;
float angle = 0;
float displaySize = 0;

void setup(){
  size(600, 600);
  displaySize = sqrt(pow(width, 2)+pow(height, 2));
  edge = new ArrayList<PVector>();
  push();
  textAlign(CENTER, CENTER);
  textSize(96);
  fill(0);
  text("Hello world", width/2, height/2);
  pop();
  points = edgeDetection(50);
  for(int i=0;i<inc;i++){
    float x = map(i, 0, inc, 0, width);
    float y = map(i, 0, inc, 0, height);
    edge.add(new PVector(x, 0));
    edge.add(new PVector(0, y));
    edge.add(new PVector(x, width));
    edge.add(new PVector(width, y));
  }
  edge.add(new PVector(width, height));
}

void draw(){
  background(255);
  for(PVector e:edge){
    PVector vec = PVector.fromAngle(angle).mult(displaySize);
    line(e.x, e.y, e.x+vec.x, e.y+vec.y);
  }
  angle += 0.01; 
}

ArrayList<PVector> edgeDetection(float val){
  ArrayList<PVector> res = new ArrayList<PVector>();
  loadPixels();
  color[] newPixels = new color[width*height];
  for(int i=0;i<newPixels.length;i++){
    newPixels[i] = color(170);
  }
  for(int x=1;x<width-1;x++){
    for(int y=1;y<height-1;y++){
      int index = x+y*width;
      color oc = pixels[index];
      float br = brightness(oc);
      float t = brightness(pixels[index-width]);
      float b = brightness(pixels[index+width]);
      float l = brightness(pixels[index-1]);
      float r = brightness(pixels[index+1]);
      if(br-t>val||br-b>val||br-l>val||br-r>val){//if neighboring pixels are different
        newPixels[index] = color(255);
        res.add(new PVector(x, y));
      }
    }
  }
  for(int i=0;i<pixels.length;i++){
    pixels[i] = newPixels[i];
  }
  updatePixels();
  return res;
}
