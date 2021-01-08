class AABB{
  PVector min, max;
  
  public AABB(float x1, float y1, float x2, float y2){
    min = new PVector(x1, y1);
    max = new PVector(x2, y2);
  }
}
