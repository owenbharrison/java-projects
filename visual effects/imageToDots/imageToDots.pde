PImage img;

ArrayList<PVector> points;

void setup(){
  size(600, 600);
  img = loadImage("data/taxi.png");
  background(0);
  image(img, 0, 0, width, height);
  points = edgeDetection(30);
  background(0);
  points = reduceArray(points, 3);
  points = sortByClosest(points);
  frameRate(120);
}

void draw(){
  background(255);
  //image(baseImg, 0, 0, width, height);
  push();
  noFill();
  stroke(0);
  beginShape();
  for(int i=0;i<frameCount;i++){
    vertex(points.get(i).x, points.get(i).y);
  }
  endShape();
  pop();
  if(frameCount==points.size()){
    image(img, 0, 0, width, height);
    noLoop();
  }
}

void contrast(int val){//1 being very small palette from 255 to all colors
  loadPixels();
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      int index = x+y*width;
      color oc = pixels[index];
      int r = (int)round(red(oc)/(255/val))*(255/val);
      int g = (int)round(green(oc)/(255/val))*(255/val);
      int b = (int)round(blue(oc)/(255/val))*(255/val);
      pixels[index] = color(r, g, b);
    }
  }
  updatePixels();
}

ArrayList<PVector> edgeDetection(float val){
  ArrayList<PVector> arr = new ArrayList<PVector>();
  loadPixels();
  color[] newPixels = new color[width*height];
  for(int i=0;i<newPixels.length;i++){
    newPixels[i] = color(0);
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
        arr.add(new PVector(x, y));
      }
    }
  }
  for(int i=0;i<pixels.length;i++){
    pixels[i] = newPixels[i];
  }
  updatePixels();
  return arr;
}

ArrayList<PVector> reduceArray(ArrayList<PVector> arr, int delim){
  ArrayList<PVector> newArr = new ArrayList<PVector>();
  for(int i=0;i<arr.size();i+=delim){
    newArr.add(arr.get(i));
  }
  return newArr;
}

ArrayList<PVector> sortByClosest(ArrayList<PVector> arrayIn){
  ArrayList<PVector> eligible = new ArrayList<PVector>(arrayIn);
  ArrayList<PVector> result = new ArrayList<PVector>();
  PVector prev = new PVector(width/2, height/2);
  for(int i=0;i<arrayIn.size();i++){
    float recordDist = width*height;
    int recordIndex = 0;
    for(int j=0;j<eligible.size();j++){
      PVector check = eligible.get(j);
      float distance = dist(prev.x, prev.y, check.x, check.y);
      if(distance<recordDist){
        recordDist = distance;
        recordIndex = j;
      }
    }
    prev = eligible.get(recordIndex);
    result.add(prev);
    eligible.remove(recordIndex);
  }
  return result;
}
