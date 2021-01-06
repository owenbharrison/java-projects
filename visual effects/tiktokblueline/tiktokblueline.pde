import processing.video.*;

int liney = 0;

boolean started = false;
boolean ended = false;

int[][] grid;

Capture cam;

void setup(){
  size(640, 480);
  
  surface.setTitle("TikTok Blue Line Thing");
  
  grid = new int[width][height];
  
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      grid[x][y] = color(0, 0, 0, 0);
    }
  }
  cam = new Capture(this, width, height, 30);
  cam.start();
}

void draw(){
  if(cam.available()){
    cam.read();
  }
  background(0);
  image(cam, 0, 0, width, height);
  if(started){
    loadPixels();
    for(int x=0;x<width;x++){
      int index = x+liney*width;
      grid[x][liney] = pixels[index];
    }
    for(int x=0;x<width;x++){
      for(int y=0;y<liney;y++){
        int index = x+y*width;
        pixels[index] = grid[x][y];
      }
    }
    updatePixels();
    push();
    stroke(0, 200, 255);
    line(0, liney, width, liney);
    pop();
    if(!ended){
      liney++;
    }
    if(liney>=height-1){
      ended = true;
      println("ended");
    }
  }
}

void mousePressed(){
  started = true;
  println("started");
}
