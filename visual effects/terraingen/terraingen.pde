int cols, rows, scl = 15, w = 900, h = 900;
float inc = 0.1, cameraX = 0, cameraY = 0;
float[][] terrain;

void setup(){
  size(600, 600, P3D);
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];
  float noiseY = 0;
  for(int y=0;y<rows-1;y++){
    float noiseX = 0;
    for(int x=0;x<cols;x++){
      terrain[x][y] = map(noise(noiseX, noiseY), 0, 1, -250, 250);
      noiseX+=inc;
    }
    noiseY+=inc;
  }
}

void draw(){
  background(0);
    
  float noiseY = cameraY;
  for(int y=0;y<rows-1;y++){
    float noiseX = cameraX;
    for(int x=0;x<cols;x++){
      terrain[x][y] = map(noise(noiseX, noiseY), 0, 1, -60, 60);
      noiseX+=inc;
    }
    noiseY+=inc;
  }
  
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for(int y=0;y<rows-1;y++){
    push();
    stroke(255);
    noFill();
    beginShape(TRIANGLE_STRIP);
    for(int x=0;x<cols;x++){
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape(CLOSE);
    pop();
  }
  thread("updateMouseControls");
}

void updateMouseControls(){//NO DRAWING
  //find sketchposition
  com.jogamp.newt.opengl.GLWindow win = (com.jogamp.newt.opengl.GLWindow) surface.getNative();
  com.jogamp.nativewindow.util.Rectangle rect = win.getBounds();
  try{
    java.awt.Robot bot = new java.awt.Robot();
    bot.mouseMove(int(rect.getX()+width/2), int(rect.getY()+height/2));
  }
  catch(java.awt.AWTException e){e.printStackTrace();}
  float xc = mouseX-width/2;
  float yc = mouseY-height/2;
  if(xc>0){cameraX+=inc*0.75;}
  if(xc<0){cameraX-=inc*0.75;}
  if(yc>0){cameraY+=inc*0.75;}
  if(yc<0){cameraY-=inc*0.75;}
}
