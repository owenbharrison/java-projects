ArrayList<PVector> points;
ArrayList<Float> finalVals;
boolean going = false;
boolean done = false;
PVector center;

void setup(){
  size(400, 400);
  points = new ArrayList<PVector>();
  finalVals = new ArrayList<Float>();
  center = new PVector();
}

void mousePressed(){
  if(!going&&!done){
    points.add(new PVector(mouseX, mouseY));
  }
}

void keyPressed(){
  if(key==' '&&!going&&!done){
    going=true;
    
    for(PVector p:points)center.add(p);
    center.div(points.size());
    
    surface.setSize(400, 600);
  }
}

void draw(){
  background(170);
  push();
  noFill();
  beginShape();
  for(PVector p:points)vertex(p.x, p.y);
  endShape(CLOSE);
  pop();
  
  if(going||done){
    push();
    noStroke();
    fill(255);
    rect(0, 400, 400, 600);
    pop();
  }
  
  if(going&&!done){
    PVector prev = points.get(points.size()-1);
    PVector intersectPt = new PVector();
    for(PVector curr : points){
      float angle = map(finalVals.size(), 0, width, 0, PI*2);
      PVector lp = PVector.fromAngle(angle+PI).mult(width/2).add(center);
      line(center.x, center.y, lp.x, lp.y);
      PVector ip = intersectPoint(prev, curr, center, PVector.fromAngle(angle).mult(width/2).add(center));
      if(ip!=null){
        intersectPt = ip;
        circle(ip.x, ip.y, 5);
      }
      prev = curr;
    }
    float distance = PVector.dist(center, intersectPt);
    finalVals.add(distance);
    
    for(int i=0;i<finalVals.size();i++){
      float val = finalVals.get(i);
      point(i, 400+val);
    }
    
    if(finalVals.size()>=width){
      done = true;
    }
  }
  
  if(done){
    println("done!");
    println(finalVals.size());
    noLoop();
  }
}

PVector intersectPoint(PVector a, PVector b, PVector c, PVector d){
  float den = (a.x-b.x)*(c.y-d.y)-(a.y-b.y)*(c.x-d.x);
  float t = ((a.x-c.x)*(c.y-d.y)-(a.y-c.y)*(c.x-d.x))/den;
  float u = ((a.x-b.x)*(a.y-c.y)-(a.y-b.y)*(a.x-c.x))/den;
  if(t>=0&&t<=1&&u>=0&&u<=1){
    return new PVector(a.x+t*(b.x-a.x), a.y+t*(b.y-a.y));
  }
  else{
    return null;
  }
}
