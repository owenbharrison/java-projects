class Chunk{
  PVector pos;//the bottom left back coordinate of the chunk
  Block[][][] blocks;
  int w, h, d;
  PShape mainShape;
  
  public Chunk(int x_, int y_, int z_, int w_, int h_, int d_){
    pos = new PVector(x_, y_, z_);
    mainShape = createShape(GROUP);
    w = w_;
    h = h_;
    d = d_;
    blocks = new Block[w][h][d_];
    float noiseX = 0;
    for(int x=0;x<w;x++){
      float noiseY = 0;
      for(int z=0;z<d;z++){
        int XZChunkHeight = round(noise(noiseX, noiseY)*h);
        for(int y=0;y<h;y++){
          blocks[x][y][z] = new Block(int(x+pos.x), int(y+pos.y), int(z+pos.z), y>XZChunkHeight, this);
        }
        noiseY += 0.04;
      }
      noiseX += 0.04;
    }
  }
  
  void show(){
    push();
    shape(mainShape);
    pop();
  }
  
  public void update(){
    mainShape = createShape(GROUP);
    for(int x=1;x<w-1;x++){
      for(int y=1;y<h-1;y++){
        for(int z=1;z<d-1;z++){
          Block block = blocks[x][y][z];
          if(!block.isAir){
            if(blocks[int(x+1)][int(y)][int(z)].isAir){mainShape.addChild(block.getSidePlane(1, 0, 0));}
            if(blocks[int(x-1)][int(y)][int(z)].isAir){mainShape.addChild(block.getSidePlane(-1, 0, 0));}
            if(blocks[int(x)][int(y+1)][int(z)].isAir){mainShape.addChild(block.getSidePlane(0, 1, 0));}
            if(blocks[int(x)][int(y-1)][int(z)].isAir){mainShape.addChild(block.getSidePlane(0, -1, 0));}
            if(blocks[int(x)][int(y)][int(z+1)].isAir){mainShape.addChild(block.getSidePlane(0, 0, 1));}
            if(blocks[int(x)][int(y)][int(z-1)].isAir){mainShape.addChild(block.getSidePlane(0, 0, -1));}
          }
        }
      }
    }
  }
}
