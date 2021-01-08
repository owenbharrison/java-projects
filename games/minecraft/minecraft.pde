import java.awt.Robot;
import java.awt.AWTException;
import com.jogamp.newt.opengl.GLWindow;
import com.jogamp.nativewindow.util.Rectangle;

int cameraSensitivity = 600;
int cameraTurnX = cameraSensitivity;
int cameraTurnY = cameraSensitivity/2;
PVector sketchPos;

int chunkWidth = 32,
  chunkHeight = 32,
  chunkDepth = 32;
int UNIT = 20;

PVector GRAVITY;
Player player;
Chunk chunk;

boolean mouseLock = true;

PImage grassTop;
PImage grassSide;

void setup(){
  size(720, 720, P3D);
  sketchPos = new PVector();
  player = new Player(0, 0, 0, PI/3, 3000);
  chunk = new Chunk(0, 0, 0, chunkWidth, chunkHeight, chunkDepth);
  GRAVITY = new PVector(0,0.8,0);
  thread("chunkupdate");
  grassTop = loadImage("data/dirt/top.jpg");
  grassSide = loadImage("data/dirt/side.jpg");
}

void mousePressed(){
  if(mouseButton==1){
    mouseLock = !mouseLock;
  }
}

void chunkupdate(){
  chunk.update();
}

void draw(){
  background(170);//clear
  noCursor();
  //async mouse update call cant slow down sketch
  if(mouseLock){
    thread("updateMouseControls");
  }
  keyPressed();
  
  //update player
  player.updateMovement();
  player.updateCamera(cameraTurnX, cameraTurnY, cameraSensitivity);
  player.showCamera();
  
  chunk.show();
  surface.setTitle("Minecraft: FPS: "+frameRate);
  
}

void updateMouseControls(){//NO DRAWING
  //find sketchposition
  GLWindow win = (GLWindow) surface.getNative();
  Rectangle rect = win.getBounds();
  sketchPos = new PVector(rect.getX(), rect.getY()).copy();
  //move mouse to center of sketch
  try{
    Robot bot = new Robot();
    bot.mouseMove(int(sketchPos.x+width/2), int(sketchPos.y+height/2));
  }
  catch(AWTException e){e.printStackTrace();}
  //update camera movement
  cameraTurnX+=mouseX-width/2;
  cameraTurnY+=mouseY-height/2;
  //make y movement in range
  if(cameraTurnY<0){cameraTurnY=0;}
  if(cameraTurnY>cameraSensitivity){cameraTurnY=cameraSensitivity;}
}

void keyPressed(){
  if(key=='w'){//forward
    player.walk(1);
  }
  else if(key=='s'){//backward
    player.walk(-0.4);
  }
  else if(key=='a'){//left
    player.strafe(-0.6);
  }
  else if(key=='d'){//right
    player.strafe(0.6);
  }
  if(key==' '){//jump
    player.jump();
  }
}
