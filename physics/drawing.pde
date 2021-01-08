ParticleDrawer particleDrawer;
ConstraintDrawer constraintDrawer;
boolean drawingParticles = true;
boolean drawingConstraints = false;
boolean doneDrawing = false;
boolean runningSim = false;

void drawingMousePressed(int button){
  if(button==LEFT){
    if(drawingParticles)particleDrawer.update(mouseX, mouseY);
    if(drawingConstraints)constraintDrawer.begin(mouseX, mouseY);
  }
  if(button==RIGHT){
    if(drawingParticles)particleDrawer.updateLock(mouseX, mouseY);
  }
}

void drawingMouseReleased(int button){
  if(button==LEFT){
    if(drawingConstraints)constraintDrawer.end(mouseX, mouseY);
  }
}

void drawingKeyReleased(int _key){
  if(_key==' '){
    if(drawingParticles){
      drawingParticles = false;
      particles = particleDrawer.retrieve();
      drawingConstraints = true;
      constraintDrawer = new ConstraintDrawer(particles);
    }
    else if(drawingConstraints){
      drawingConstraints = false;
      constraints = constraintDrawer.retrieve();
      doneDrawing = true;
      runningSim = true;
    }
  }
}

public class ParticleDrawer{
  ArrayList<Particle> particles;
  
  public ParticleDrawer(){
    particles = new ArrayList<Particle>();
  }
  
  void update(float x, float y){
    particles.add(new Particle(x, y, particleSize, BOUNDS));
  }
  
  void updateLock(float x, float y){
    for(Particle p:particles){
      if(dist(x, y, p.pos.x, p.pos.y)<GRAB_SIZE)p.locked = !p.locked;
    }
  }
    
  ArrayList<Particle> retrieve(){
    return particles;
  }
    
  void show(){
    for(Particle p:particles)p.show();
  }
}

class ConstraintDrawer{
  ArrayList<Constraint> constraints;
  Particle previous = null;
  ArrayList<Particle> particles;
    
  public ConstraintDrawer(ArrayList<Particle> _particles){
    particles = _particles;
    constraints = new ArrayList<Constraint>();
  }
    
  void begin(float x, float y){
    for(Particle p:particles){
      if(dist(p.pos.x, p.pos.y, x, y)<GRAB_SIZE){
        if(previous==null)previous = p;
      }
    }
  }
    
  void end(float x, float y){
    for(Particle p:particles){
      if(dist(p.pos.x, p.pos.y, x, y)<GRAB_SIZE){
        if(previous!=null&&p!=previous){
          constraints.add(new Constraint(previous, p));
          previous = null;
        }
      }
    }
  }
    
  ArrayList<Constraint> retrieve(){
    return constraints;
  }
    
  void show(float x, float y){
    for(Constraint c:constraints)c.show(1);
    for(Particle p:particles){
      if(dist(p.pos.x, p.pos.y, x, y)<GRAB_SIZE){
        push();
        noFill();
        stroke(255);
        circle(p.pos.x, p.pos.y, GRAB_SIZE*2);
        pop();
      }
    }
    if(previous!=null&&LMB){
      push();
      stroke(0);
      strokeWeight(2);    
      line(previous.pos.x, previous.pos.y, x, y);
      pop();
    }
  }
}
