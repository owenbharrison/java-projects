import org.jnativehook.GlobalScreen;
import org.jnativehook.NativeHookException;
import org.jnativehook.keyboard.NativeKeyEvent;
import org.jnativehook.keyboard.NativeKeyListener;
import ddf.minim.*;
import java.util.Arrays;

Minim minim;
AudioPlayer song;
AudioMetaData metaData;

int buttonSize = 40;

boolean holding = false;

void pressEvent(){
  //add new click effect
  Effect e = new Effect(mouseX, mouseY, 10, 60, 1);
  e.col = color(170);
  effects.add(e);
  //check all buttons to see if it was over it
  for(int i=0;i<buttons.size();i++){
    Button b = buttons.get(i);
    if(b.isInside(mouseX, mouseY)){buttons.remove(i);i--;}
  }
}

ArrayList<Effect> effects;
ArrayList<Button> buttons;
Trail trail;

void setup(){
  size(720, 640);
  new KeyListener().start();
  
  //choose random song
  ArrayList<String> songs = new ArrayList<String>();
  for(String s : new java.io.File(dataPath("")).list())if(s.contains("mp3"))songs.add(s);
  String songpath = "data/"+songs.get(floor(random(songs.size())));
  
  //intialize minim
  minim = new Minim(this);
  song = minim.loadFile(songpath, 2048);
  song.play();
  metaData = song.getMetaData();
  surface.setTitle("osu - "+metaData.title()+" by "+metaData.author());
    
  effects = new ArrayList<Effect>();
  buttons = new ArrayList<Button>();
  trail = new Trail(40, 9, 2);
  frameRate(120);
  noCursor();
}

void draw(){
  background(0);
  //show all effects
  for(int i=0;i<effects.size();i++){
    Effect e = effects.get(i);e.grow();e.show();
    if(e.isFinished()){effects.remove(i);i--;}
  }
  //show all buttons
  for(int i=0;i<buttons.size();i++){
    Button b = buttons.get(i);
    b.show(i);
  }
  trail.update();
  trail.show();
}
