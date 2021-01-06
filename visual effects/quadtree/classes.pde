class Point{
  float x, y;
  
  public Point(float x_, float y_){
    x = x_;
    y = y_;
  }
}

class Rectangle{
  float x, y, w, h;
  
  public Rectangle(float x_, float y_, float w_, float h_){
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
  
  boolean contains(Point p){
    return p.x<=x+w&&
           p.x>=x-w&&
           p.y<=y+h&&
           p.y>=y-h;
  }
}

class QuadTree{
  Rectangle boundary;
  ArrayList<Point> points;
  int capacity;
  QuadTree northwest, northeast, southwest, southeast;
  boolean divided = false;
  
  public QuadTree(Rectangle b, int c){
    boundary = b;
    capacity = c;
    points = new ArrayList<Point>();
  }
  
  boolean insert(Point pt){
    if(!boundary.contains(pt))return false;
    
    if(points.size()<capacity){
      points.add(pt);
      return true;
    }
    else{
      if(!divided){
        subdivide();
      }
      if(northeast.insert(pt))return true;
      else if(northwest.insert(pt))return true;
      else if(southeast.insert(pt))return true;
      else if(southwest.insert(pt))return true;
      else return false;
    }
  }
  
  void subdivide(){
    float x = boundary.x;
    float y = boundary.y;
    float w = boundary.w;
    float h = boundary.h;
    northeast = new QuadTree(new Rectangle(x+w/2, y-h/2, w/2, h/2), capacity);
    northwest = new QuadTree(new Rectangle(x-w/2, y-h/2, w/2, h/2), capacity);
    southeast = new QuadTree(new Rectangle(x+w/2, y+h/2, w/2, h/2), capacity);
    southwest = new QuadTree(new Rectangle(x-w/2, y+h/2, w/2, h/2), capacity);
    divided = true;
  }
  
  void show(){
    push();
    stroke(255);
    noFill();
    rectMode(CENTER);
    rect(boundary.x, boundary.y, boundary.w*2, boundary.h*2);
    pop();
    if(divided){
      northeast.show();
      northwest.show();
      southeast.show();
      southwest.show();
    }
    push();
    stroke(255);
    strokeWeight(4);
    for(Point p:points){
      //point(p.x, p.y);
    }
    pop();
  }
}
