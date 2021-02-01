ArrayList<PVector> clipper, subject;
int stage = 0;

void setup(){
  size(600, 600);
  subject = new ArrayList<PVector>();
  clipper = new ArrayList<PVector>();
}

void mousePressed(){
  if(stage==0){
    subject.add(new PVector(mouseX, mouseY));
  }
  if(stage==1){
    clipper.add(new PVector(mouseX, mouseY));
  }
}

void keyReleased(){
  if(key==' '){
    if(stage<2)stage++;
  }
}

void draw(){
  background(170);
  push();
  noFill();
  stroke(0, 0, 255);
  beginShape();
  for(PVector p:subject)vertex(p.x, p.y);
  endShape(CLOSE);
  pop();
  
  push();
  noFill();
  stroke(255, 0, 0);
  beginShape();
  for(PVector p:clipper)vertex(p.x, p.y);
  endShape(CLOSE);
  pop();
  
  if(stage==2){
    push();
    noFill();
    stroke(0, 255, 0);
    beginShape();
    for(PVector p:clipPolygon(clipper, subject))vertex(p.x, p.y);
    endShape(CLOSE);
    pop();
  }
}

ArrayList<PVector> clipPolygon(ArrayList<PVector> clp, ArrayList<PVector> sbj) {
  ArrayList<PVector> result = new ArrayList<PVector>(sbj);
  int len = clp.size();
  for(int i=0;i<len;i++){
 
    int len2 = result.size();
    ArrayList<PVector> input = result;
    result = new ArrayList<PVector>(len2);
 
    PVector A = clp.get((i+len-1)%len);
    PVector B = clp.get(i);
 
    for(int j=0;j<len2;j++){    
      PVector P = input.get((j+len2-1)%len2);
      PVector Q = input.get(j);
      if (isInside(A, B, Q)){
        if (!isInside(A, B, P)){
          result.add(intersection(A,B,P,Q));
        }
        result.add(Q);
      }
      else if(isInside(A, B, P)){
        result.add(intersection(A,B,P,Q));
      }
    }
  }
  return result;
}
 
boolean isInside(PVector a, PVector b, PVector c){
  return (a.x-c.x)*(b.y-c.y)>(a.y-c.y)*(b.x-c.x);
}
 
PVector intersection(PVector a, PVector b, PVector p, PVector q){
  float A1 = b.y-a.y;
  float B1 = a.x-b.x;
  float C1 = A1*a.x+B1*a.y;
 
  float A2 = q.y-p.y;
  float B2 = p.x-q.x;
  float C2 = A2*p.x+B2*p.y;
 
  float det = A1*B2-A2*B1;
  float x = (B2*C1-B1*C2)/det;
  float y = (A1*C2-A2*C1)/det;
 
  return new PVector(x, y);
}
