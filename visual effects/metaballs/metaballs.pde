ArrayList<Metaball> metaballs;
boolean running = true;
PVector mp;
int inc = 62;

void keyReleased(){
  if(key==' '){
    running = !running;
  }
}

void setup(){
  size(600, 600);
  metaballs = new ArrayList<Metaball>();
  for(int i=0;i<10;i++){
    metaballs.add(new Metaball(random(width), random(height)));
  }
  frameRate(60);
  colorMode(HSB, 255);
}

void draw(){
  background(0);
  if(!mousePressed)mp = new PVector(mouseX, mouseY);
  if(running){
    for(Metaball m:metaballs)m.update();
  }
  for(Metaball m:metaballs)m.checkMouse();
  loadPixels();
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      float sum = 0;
      for(Metaball m:metaballs){
        sum += 100*m.radius/dist(m.pos.x, m.pos.y, x, y);
      }
      
      int index = x+y*width;
      float val = round(sum/inc)*inc;
      if(val<0)val = 0;
      if(val>255)val = 255;
      pixels[index] = color(val);
    }
  }
  updatePixels();
  edgeDetection(50);
}

void edgeDetection(float val){
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
      }
    }
  }
  for(int i=0;i<pixels.length;i++){
    pixels[i] = newPixels[i];
  }
  updatePixels();
}
