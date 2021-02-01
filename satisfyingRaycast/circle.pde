class Circle{
  PVector pos;
  float radius;
  
  public Circle(float x, float y, float r){
    pos = new PVector(x, y);
    radius = r;
  }
  
  void show(){
    push();
    circle(pos.x, pos.y, radius*2);
    pop();
  }
  
  boolean contains(PVector pt){
    float x_ = pt.x-pos.x;
    float y_ = pt.y-pos.y;
    return x_*x_+y_*y_<radius*radius;
  }
}
