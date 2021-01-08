class Effect{
  int maxSize;
  int size;
  PVector pos;
  public color col;
  int inc = 1;
  
  public Effect(int x, int y, int sz, int mxsz, int i){
    pos = new PVector(x, y);
    size = sz;
    maxSize = mxsz;
    col = color(0);
    inc = i;
  }
  
  void grow(){
    size+=inc;
  }
  
  boolean isFinished(){
    return size>maxSize;
  }
  
  void show(){
    push();
    noFill();
    stroke(col, map(size, 0, maxSize, 255, 70));
    strokeWeight(3);
    circle(pos.x, pos.y, size);
    pop();
  }
}
