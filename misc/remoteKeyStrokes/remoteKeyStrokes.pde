import org.jnativehook.GlobalScreen;
import org.jnativehook.NativeHookException;
import org.jnativehook.keyboard.NativeKeyEvent;
import org.jnativehook.keyboard.NativeKeyListener;
import java.awt.Robot;
import java.awt.AWTException;
import java.awt.event.InputEvent;

Robot robot;

boolean pressQ = false;
boolean pressM = false;

void setup(){
  size(400, 400);
  try{
    robot = new Robot();
  }catch(AWTException e){}
  
  GlobalKeyListenerExample e = new GlobalKeyListenerExample();
  e.start();
  frameRate(64);
}

void draw(){
  background(170);
  text("pressQ"+pressQ, 200, 100);
  text("pressM"+pressM, 200, 300);
  if(pressQ){
    try{
      Robot r = new Robot();
      r.keyPress(81);
      r.keyRelease(81);
    }catch(AWTException e){}
  }
  if(pressM){
    try{
      Robot r = new Robot();
      r.keyPress(77);
      r.keyRelease(77);
    }catch(AWTException e){}
  }
}

class GlobalKeyListenerExample implements NativeKeyListener{
  @Override
  public void nativeKeyPressed(NativeKeyEvent e) {
    if(e.getKeyCode()==NativeKeyEvent.VC_SPACE)pressQ = true;
    if(e.getKeyCode()==NativeKeyEvent.VC_ENTER)pressM = true;
  }

  public void nativeKeyReleased(NativeKeyEvent e) {
    if(e.getKeyCode()==NativeKeyEvent.VC_SPACE)pressQ = false;
    if(e.getKeyCode()==NativeKeyEvent.VC_ENTER)pressM = false;
  }

  public void nativeKeyTyped(NativeKeyEvent e) {}

  void start() {
    try {GlobalScreen.registerNativeHook();}
    catch (NativeHookException ex) {System.exit(1);}
    GlobalScreen.addNativeKeyListener(new GlobalKeyListenerExample());
  }
}
