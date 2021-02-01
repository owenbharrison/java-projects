final float AIRFRICTION = 0.998;
final PVector GRAVITY = new PVector(0, 0.25);
String[] TYPES = {
  "apple",
  "banana",
  "coconut",
  "pear",
  "pineapple",
  "pomegranate",
  "tomato",
  "watermelon"
};
PImage[] SPRITES;
String[] HITBOXES;

ColorRamp explosionGradient;
ArrayList<Explosion> explosions;
ArrayList<Fruit> fruits;
Trail mouseTrail;

void mousePressed(){
  for(PVector p:mouseTrail.points){
    p.x = mouseX;
    p.y = mouseY;
  }
}

void setup(){
  size(600, 800);
  noCursor();
  SPRITES = new PImage[TYPES.length];
  for(int i=0;i<TYPES.length;i++){
    SPRITES[i] = loadImage("data/sprites/"+TYPES[i]+".png");
  }
  HITBOXES = new String[TYPES.length];
  for(int i=0;i<TYPES.length;i++){
    HITBOXES[i] = String.join("\n", loadStrings(dataPath("")+"/hitboxes/"+TYPES[i]+".hitbox"));
  }
  explosions = new ArrayList<Explosion>();
  explosionGradient = new ColorRamp("data/explosionRamp.png");
  fruits = new ArrayList<Fruit>();
  mouseTrail = new Trail(7, 6, 2);
}

void draw(){
  background(170);
  if(frameCount%60==0){
    float xvel = random(-3, 3);
    float yvel = random(-17, -11);
    float rotVel = random(-0.3, 0.3);
    Fruit fruit = new Fruit(width/2+random(-75, 75), height, xvel, yvel, rotVel);
    fruits.add(fruit);
  }
  for(int i=0;i<fruits.size();i++){
    Fruit f = fruits.get(i);
    f.update();
    
    if(f.isOffscreen()){
      fruits.remove(i);
      i--;
    }
  }
  
  for(Fruit f:fruits){
    f.show();
  }
  
  surface.setTitle("Fruit Ninja  FPS: "+round(frameRate));
  if(mousePressed){
    mouseTrail.update();
    mouseTrail.show();
  }
}

void pixellatedFilter(int intensity){
  loadPixels();
  for(int x=0;x<width;x+=intensity){
    for(int y=0;y<height;y+=intensity){
      for(int x_=0;x_<intensity;x_++){
        for(int y_=0;y_<intensity;y_++){
          int realX = x+x_;
          int realY = y+y_;
          int baseIndex = x+y*width;
          int index = realX+realY*width;
          pixels[index] = pixels[baseIndex];
        }
      }
    }
  }
  updatePixels();
}

void contrastFilter(int intensity){
  loadPixels();
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      int index = x+y*width;
      float red = round(red(pixels[index])/intensity)*intensity;
      float green = round(green(pixels[index])/intensity)*intensity;
      float blue = round(blue(pixels[index])/intensity)*intensity;
      
      pixels[index] = color(red, green, blue);
    }
  }
  updatePixels();
}
