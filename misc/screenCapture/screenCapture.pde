// note: For Processing 2.0 replace screen.width and screen.height by screenWidth and screenHeight respectively
import java.awt.Robot;
import java.awt.Rectangle;
import java.awt.AWTException;
 
PImage screenshot;
boolean smoothOn;
int x,y;
int num = 0;
boolean started = false;

void keyPressed(){
  if(key==' ')started = true;
}
 
void setup() {
  size(192, 108);
  surface.setResizable(true);
}
 
void draw() {
  screenshot();
  image(screenshot, 0, 0, width, height);
  if(started){
    save("frame"+num+".jpg");
    num++;
  }
}
 
void screenshot() {
  try {
    Robot robot = new Robot();
    screenshot = new PImage(robot.createScreenCapture(new Rectangle(0,0,displayWidth,displayHeight)));
  } catch (AWTException e) { }
}
 
void mouseMoved(){
}
 
void mousePressed() {
  smoothOn = !smoothOn;
}
