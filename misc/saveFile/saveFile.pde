import java.io.BufferedWriter;
import java.io.FileWriter;

void setup(){
  size(200, 200);
}

void draw(){
  background(170);
  textAlign(CENTER, CENTER);
  text("making file "+frameCount+".txt", 100, 100);
  makeFile(frameCount+".txt", "lel get rekt");
  if(frameCount>20000){
    noLoop();
  }
}



void makeFile(String name, String content){
  try{
    File file = new File(dataPath("")+"/"+name);
    if(!file.exists()) {
      System.out.println("creating file");
      if(file.createNewFile()) {
        System.out.println("Succesfully created file");
      } else{
        System.out.println("Failed to create file");
      }
    }
    BufferedWriter out = new BufferedWriter(new FileWriter(file));
    out.write(content);
    out.close();
  }
  catch(IOException e){e.printStackTrace();}
}
