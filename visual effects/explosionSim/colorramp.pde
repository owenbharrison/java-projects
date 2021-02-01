class ColorRamp{
  PImage rampImg;
  color[] ramp;
  
  public ColorRamp(String url){
    rampImg = loadImage(url);
    ramp = new color[rampImg.width];
    rampImg.loadPixels();
    for(int i=0;i<rampImg.width;i++){
      ramp[i] = rampImg.pixels[i];
    }
  }
  
  color getAtPercent(float pc){
    int index = floor(map(pc, 0, 1, 0, ramp.length));
    return ramp[index];
  }
}
