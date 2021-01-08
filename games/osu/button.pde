class Button{
  PVector pos;
  int size;
  
  public Button(int x, int y, int sz){
    pos = new PVector(x, y);
    size = sz;
  }
  
  boolean isInside(int x, int y){
    return dist(x, y, pos.x, pos.y)<size/2;
  }
  
  void show(int val){
    push();
    stroke(255);
    fill(50);
    circle(pos.x, pos.y, size);
    pop();
    push();
    textAlign(CENTER, CENTER);
    text(val, pos.x, pos.y);
    pop();
  }
}
