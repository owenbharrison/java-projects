//better gui lib
import g4p_controls.*;

PVector GRAVITY;
AABB BOUNDS;
float FRICTION = 0.995;
GButton btn;

float GRAB_SIZE = 7;
float particleSize = 4;

boolean LMB = false;
boolean RMB = false;

ArrayList<Particle> particles;
ArrayList<Constraint> constraints;

void setup(){
  size(1000, 800);
  btn = new GButton(this, 0, 0, width, height);
  
  GRAVITY = new PVector(0, 1);
  BOUNDS = new AABB(10, 10, width-10, height-10);
  
  particleDrawer = new ParticleDrawer();
  //make sure this works on all displays
  pixelDensity(1);
}

void draw(){
  background(170);
  
  if(!doneDrawing){
    particleDrawer.show();
    if(drawingConstraints)constraintDrawer.show(mouseX, mouseY);
  }
  
  else{
    if(runningSim){
      //update particles movement
      for(Particle p:particles)p.update();
      for(int i=0;i<250;i++){
        //update constraints and keep particles in bounds
        for(Constraint c:constraints)c.update();
        for(Particle p:particles)p.checkBounds(); 
      }
      
      
    }
    //show each constraint and particle
    for(Constraint c:constraints)c.show(c.highlighted?3:1);//size based on if highlighted
    for(Particle p:particles)p.show();
    
    //if mouse is grabbing particle, set cursor to grabbing
    if(!mousePressed)surface.setCursor(java.awt.Cursor.DEFAULT_CURSOR);
    for(Constraint c:constraints){
      if(c.highlighted){
        //draw constraint information if it is highlighted such as width
        push();
        PVector middle = PVector.add(c.p0.pos, c.p1.pos).div(2);
        textAlign(CENTER, CENTER);
        textSize(16);
        text(round(c.size), middle.x, middle.y);
        pop();
      }
    }
  }
}





void mousePressed(){
  if(mouseButton==LEFT)LMB=true;
  if(mouseButton==RIGHT){
    RMB = true;
    if(doneDrawing){
      for(Particle p:particles){
        if(dist(p.pos.x, p.pos.y, mouseX, mouseY)<GRAB_SIZE){
          p.locked = !p.locked;
        }
      }
      for(Constraint c:constraints){
        if(c.containsPoint(mouseX, mouseY, GRAB_SIZE/2)){
          c.highlighted = !c.highlighted;
        }
      }
    }
  }
  if(mouseButton==CENTER){
    if(doneDrawing){
      for(Constraint c:constraints){
        if(c.highlighted){
          if(c.preset==-1)c.preset = c.size; 
          else c.size = c.preset;
        }
      }
    }
  }
  if(!doneDrawing)drawingMousePressed(mouseButton);
}

void mouseReleased(){
  if(mouseButton==LEFT)LMB = false;
  if(mouseButton==RIGHT)RMB = false;
  if(!doneDrawing)drawingMouseReleased(mouseButton);
}

void keyReleased(){
  if(doneDrawing&&key==' ')runningSim=!runningSim;
  else drawingKeyReleased(key);
}

void mouseWheel(MouseEvent e){
  if(runningSim){
    for(Constraint c:constraints){
      float v = c.size;
      if(c.highlighted)v -= 5*e.getCount();
      if(v<.1)v=.1;
      c.size = v;
    }
  }
}
