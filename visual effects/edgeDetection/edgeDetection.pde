PImage img;
int intensity = 1;

void setup(){
  img = loadImage("data/img.jpeg");
  surface.setSize(img.width, img.height);
}

void mouseWheel(MouseEvent e){
  float v = e.getCount();
  intensity += v/abs(v);
  if(intensity<1)intensity=1;
}

void draw(){
  background(img);
  for(int i=0;i<intensity;i++){
    edgeDetect(12);
  }
}

void edgeDetect(float val){
  loadPixels();
  color[] newPixels = new color[width*height];
  for(int i=0;i<newPixels.length;i++){
    newPixels[i] = pixels[i];
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
        newPixels[index] = color(0);
      }
    }
  }
  for(int i=0;i<pixels.length;i++){
    pixels[i] = newPixels[i];
  }
  updatePixels();
}
