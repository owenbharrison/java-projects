class Trail{
  float maxSize, minSize;
  PVector[] points;
  
  public Trail(int len, float max, float min){
    points = new PVector[len];
    java.util.Arrays.fill(points, new PVector(mouseX, mouseY));
    maxSize = max;
    minSize = min;
  }
  
  void show(){
    PVector prev = points[0];
    for(int i=1;i<points.length;i++){
      PVector c = points[i];
      push();
      stroke(240);
      strokeWeight(map(i, 0, points.length, maxSize, minSize));
      line(prev.x, prev.y, c.x, c.y);
      pop();
      prev = c;
    }
  }
  
  void update(){
    PVector prev = points[0];
    points[0] = new PVector(mouseX, mouseY);
    for(int i=1;i<points.length;i++){
      PVector next = points[i];
      points[i] = prev;
      prev = next;
    }
  }
}
