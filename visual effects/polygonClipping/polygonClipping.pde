ArrayList<PVector> polygonPoints;
Polygon polygon;
PVector l0 = null;
PVector l1 = null;
boolean drawingPoly = true;
boolean drawingClip = false;

void setup(){
  size(600, 600);
  polygonPoints = new ArrayList<PVector>();
}

void keyReleased(){
  if(key==' '){
    if(drawingPoly){
      drawingPoly = false;
      drawingClip = true;
    }
    else if(drawingClip){
      drawingClip = false;
    }
  }
}

void mousePressed(){
  if(drawingPoly){
    polygonPoints.add(new PVector(mouseX, mouseY));
    polygon = new Polygon(polygonPoints);
  }
  if(drawingClip){
    if(l0==null)l0 = new PVector(mouseX, mouseY);
    else if(l1==null)l1 = new PVector(mouseX, mouseY);
  }
}

void draw(){
  background(255);
  if(polygon!=null)polygon.show(color(0));
  push();
  stroke(0);
  if(l0!=null)circle(l0.x, l0.y, 5);
  if(l1!=null)circle(l1.x, l1.y, 5);
  pop();
  if(!drawingPoly&&!drawingClip){
    Polygon[] polys = polygon.splitByLine(l0, l1);
    polys[0].show(color(255, 0, 0));
    polys[1].show(color(0, 0, 255));
  }
}
