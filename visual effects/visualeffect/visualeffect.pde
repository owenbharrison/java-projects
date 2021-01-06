ArrayList<Polygon> polygons;

void setup(){
  size(600, 600);
  polygons = new ArrayList<Polygon>();
  for(int i=0;i<100;i++){
    PVector pos = new PVector(random(20, width-20), random(20, height-20));
    int sides = round(random(3, 25));
    float size = random(20, 25);
    Polygon poly = new Polygon(pos, sides, size);
    polygons.add(poly);
  }
}

void draw(){
  background(170);
  for(Polygon p : polygons){
    p.show();
  }
}





public class Polygon{
  PVector pos;
  int sides;
  float size;
  ArrayList<PVector> points;
  ArrayList<Edge> edges;
  
  public Polygon(PVector pos_, int sides_, float size_){
    this.pos = pos_;
    this.sides = sides_;
    this.size = size_;
    this.points = new ArrayList<PVector>();
    this.edges = new ArrayList<Edge>();
    for(int i=0;i<this.sides;i++){
      float theta = map(i, 0, this.sides, 0, PI*2);
      PVector pt = PVector.fromAngle(theta);
      pt.setMag(this.size+random(this.size/2));
      pt.add(this.pos);
      this.points.add(pt);
    }
    PVector prev = this.points.get(this.points.size()-1);
    for(PVector curr : this.points){
      this.edges.add(new Edge(prev, curr));
      prev = curr;
    }
  }
  
  public boolean contains(PVector point){
    int intersections = 0;
    for(Edge e : this.edges){
      if(intersects(e.p1, e.p2, point, new PVector(point.x+width, point.y))){
        intersections++;
      }
    }
    return intersections%2==1;
  }
  
  public void show(){    
    push();
    if(this.contains(new PVector(mouseX, mouseY))){
      fill(0, 255, 0);
    }
    else{
      fill(255, 0, 0);
    }
    stroke(0);
    beginShape();
    for(PVector pv : this.points){
      vertex(pv.x, pv.y);
    }
    endShape(CLOSE);
    pop();
  
    if(this.contains(new PVector(mouseX, mouseY))){
      for(PVector p : this.points){
        push();
        stroke(0);
        line(mouseX, mouseY, p.x, p.y);
        pop();
      }
    }
  }
}

public class Edge{
  PVector p1;
  PVector p2;
  
  public Edge(PVector p1, PVector p2){
    this.p1 = p1.copy();
    this.p2 = p2.copy();
  }
}

boolean intersects(PVector a, PVector b, PVector c, PVector d){
  float den = (a.x-b.x)*(c.y-d.y)-(a.y-b.y)*(c.x-d.x);
  float t = ((a.x-c.x)*(c.y-d.y)-(a.y-c.y)*(c.x-d.x))/den;
  float u = ((a.x-b.x)*(a.y-c.y)-(a.y-b.y)*(a.x-c.x))/den;
  return t>=0.0&&t<=1.0&u>=0.0&&u<=1.0;
}
