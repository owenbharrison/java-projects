class Block{
  PVector pos;
  float sz;
  boolean isAir;
  Chunk parentChunk;
  
  public Block(int x, int y, int z, boolean isAir_, Chunk parentChunk_){
    pos = new PVector(x*UNIT, y*UNIT, z*UNIT);
    sz = UNIT/2;
    isAir = isAir_;
    parentChunk = parentChunk_;
  }
  
  boolean isInside(PVector vec){
    return (vec.x>=pos.x-UNIT/2 && vec.x<=pos.x+UNIT/2)
         &&(vec.y>=pos.y-UNIT/2 && vec.y<=pos.y+UNIT/2)
         &&(vec.z>=pos.z-UNIT/2 && vec.z<=pos.z+UNIT/2);
  }
  
  PShape getSidePlane(int x_, int y_, int z_){
    PShape s = createShape();
    float v = x_+y_+z_;
    int sz = UNIT/2;
    s.beginShape();
    s.textureMode(NORMAL);
    if(x_==v){
      s.texture(grassSide);
      s.vertex(sz*v+pos.x, -sz+pos.y, -sz+pos.z, 0, 0);
      s.vertex(sz*v+pos.x, -sz+pos.y,  sz+pos.z, 0, 1);
      s.vertex(sz*v+pos.x,  sz+pos.y,  sz+pos.z, 1, 1);
      s.vertex(sz*v+pos.x,  sz+pos.y, -sz+pos.z, 1, 0);
    }
    if(y_==v){
      s.texture(grassTop);
      s.vertex(-sz+pos.x, sz*v+pos.y, -sz+pos.z, 0, 0);
      s.vertex(-sz+pos.x, sz*v+pos.y,  sz+pos.z, 0, 1);
      s.vertex( sz+pos.x, sz*v+pos.y,  sz+pos.z, 1, 1);
      s.vertex( sz+pos.x, sz*v+pos.y, -sz+pos.z, 1, 0);  
    }
    if(z_==v){
      s.texture(grassSide);
      s.vertex(-sz+pos.x, -sz+pos.y, sz*v+pos.z, 0, 0);
      s.vertex(-sz+pos.x,  sz+pos.y, sz*v+pos.z, 0, 1);
      s.vertex( sz+pos.x,  sz+pos.y, sz*v+pos.z, 1, 1);
      s.vertex( sz+pos.x, -sz+pos.y, sz*v+pos.z, 1, 0);
    }
    s.endShape(CLOSE);
    return s;
  }
}
