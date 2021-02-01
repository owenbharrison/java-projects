class Polygon{
  ArrayList<Edge> edges;
  ArrayList<PVector> points;
  
  public Polygon(ArrayList<PVector> pts){
    edges = new ArrayList<Edge>();
    points = new ArrayList<PVector>(pts);
    PVector prev = points.get(points.size()-1);
    for(PVector p:points){
      edges.add(new Edge(prev, p));
      prev = p;
    }
  }
  
  Edge findNextEdge(Edge e){
    return edges.get((edges.indexOf(e)+1)%edges.size());
  }
  
  Polygon[] splitByLine(PVector l0, PVector l1){
    Polygon[] result = new Polygon[2];
    Edge edge0 = null;
    Edge edge1 = null;
    PVector intersect0 = null;
    PVector intersect1 = null;
    for(Edge edge:edges){
      PVector intersectPoint = edge.intersectPoint(l0, l1);
      if(intersectPoint!=null){
        if(edge0==null){
          edge0 = edge;
          intersect0 = intersectPoint;
        }
        else if(edge1==null){
          edge1 = edge;
          intersect1 = intersectPoint;
        }
      }
    }
    ArrayList<PVector> pts0 = new ArrayList<PVector>();
    ArrayList<PVector> pts1 = new ArrayList<PVector>();
    if(edge0!=null&&edge1!=null){
      pts0.add(intersect0);
      pts0.add(edge0.p1);
      for(Edge e=findNextEdge(edge0);e!=edge1;e=findNextEdge(e)){
        pts0.add(e.p1);
      }
      pts0.add(intersect1);
      
      pts1.add(intersect1);
      pts1.add(edge1.p1);
      for(Edge e=findNextEdge(edge1);e!=edge0;e=findNextEdge(e)){
        pts1.add(e.p1);
      }
      pts1.add(intersect0);
    }
    result[0] = new Polygon(pts0);
    result[1] = new Polygon(pts1);
    return result;
  }
  
  void show(color col){
    push();
    fill(col);
    noStroke();
    beginShape();
    for(PVector p:points){
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    pop();
  }
}
