import P5ireBase.library.*;
import java.awt.AWTException;
import java.awt.Robot;

P5ireBase fire;
int x = 0;
int y = 0;
boolean gettingData = false;

void setup(){
  size(240, 135);
  fire = new P5ireBase(this, "https://javatest-4b4a0.firebaseio.com/");
}

void draw(){
  background(0);
  thread("getMouse");
  circle(map(x, 0, 1920, 0, width), map(y, 0, 1080, 0, height), 5);
}

void getMouse(){
  if(!gettingData){
    gettingData = true;
    try{
      String[] xandy = fire.getValue("xandy").split(",");
      x = Integer.parseInt(xandy[0], 10);
      y = Integer.parseInt(xandy[1], 10);
    }
    catch(NumberFormatException e){e.printStackTrace();}
    catch(NullPointerException e){e.printStackTrace();}
    gettingData = false;
  }
}
