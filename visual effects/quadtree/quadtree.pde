QuadTree qt;

void setup(){
  size(400, 400);
  Rectangle boundary = new Rectangle(200, 200, 200, 200);
  qt = new QuadTree(boundary, 4);
  //for(int i=0;i<1500;i++){
  //  Point p = new Point(random(width), random(height));
  //  qt.insert(p);
  //}
}

void draw(){
  background(0);
  qt.show();
  if(mousePressed){
    for(int i=0;i<5;i++){
      qt.insert(new Point(mouseX+random(-5, 5), mouseY+random(-5, 5)));
    }
  }
}
