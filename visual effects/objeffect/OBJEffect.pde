import java.io.File;
import java.io.FileReader;
import java.io.FileNotFoundException;
import java.util.Date;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.awt.Robot;
import java.awt.AWTException;
import com.jogamp.newt.opengl.GLWindow;
import com.jogamp.nativewindow.util.Rectangle;

int cameraSensitivity = 600;
int cameraZoom = 50;
int cameraTurnX = cameraSensitivity;
int cameraTurnY = cameraSensitivity/2;

String fileName;

PVector sketchPos;

PShape model;

void setup(){
  size(600, 600, P3D);
  noCursor();
  sketchPos = new PVector(0, 0);
  //add eligible files to list
  ArrayList<String> fs = new ArrayList<String>();
  for(String f:new File(dataPath("")).list()){
    if(f.contains(".obj"))fs.add(f);
  }
  //choose random file
  fileName = fs.get(floor(random(fs.size())));
  model = loadShape(fileName);
}

void draw(){
  background(170);
  // 3D code
  float alpha = map(cameraTurnY, 0, cameraSensitivity, PI/2-.01, .01-PI/2);
  float beta = map(cameraTurnX, 0, cameraSensitivity, 0, -PI);
  PVector dir = new PVector(cos(alpha)*sin(beta), sin(alpha), cos(alpha)*cos(beta));
  dir.mult(cameraZoom);
  camera(dir.x, dir.y, dir.z, 0, 0, 0, 0, -1, 0);
  stroke(0);
  shape(model, 0, 0);
  hint(DISABLE_DEPTH_TEST);
  camera();
  noLights();
  if(mousePressed)edgeDetection(1);
  hint(ENABLE_DEPTH_TEST);
  thread("updateMouseControls");
  surface.setTitle("OBJEffect: Rendering "+fileName+" at "+round(frameRate*10)/10+"fps");
}

void mouseWheel(MouseEvent e) {
  float a = e.getCount();
  cameraZoom += a/abs(a) * 5;
}

void edgeDetection(float val){
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
      }
    }
  }
  for(int i=0;i<pixels.length;i++){
    pixels[i] = newPixels[i];
  }
  updatePixels();
}

ArrayList<PVector> centerAround(ArrayList<PVector> arr, PVector center){
  ArrayList<PVector> result = new ArrayList<PVector>(arr);
  PVector avg = new PVector();
  for(PVector p:result)avg.add(p);
  avg.div(arr.size());
  PVector vec = PVector.sub(avg, center);
  for(PVector p:result)p.sub(vec);
  return result;
}

void updateMouseControls(){
  GLWindow win = (GLWindow) surface.getNative();
  Rectangle rect = win.getBounds();
  sketchPos = new PVector(rect.getX(), rect.getY()).copy();
  try{
    Robot bot = new Robot();
    bot.mouseMove(int(sketchPos.x+width/2), int(sketchPos.y+height/2));
  }
  catch(AWTException e){e.printStackTrace();}
  cameraTurnX-=mouseX-width/2;
  cameraTurnY-=mouseY-height/2;
  if(cameraTurnY<0){cameraTurnY=0;}
  if(cameraTurnY>cameraSensitivity){cameraTurnY=cameraSensitivity;}
}
