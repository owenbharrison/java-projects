import P5ireBase.library.*;
import org.jnativehook.GlobalScreen;
import org.jnativehook.NativeHookException;
import org.jnativehook.keyboard.NativeKeyEvent;
import org.jnativehook.keyboard.NativeKeyListener;

P5ireBase fire;

void setup() {
  size(200, 200);
  fire = new P5ireBase(this, "https://javatest-4b4a0.firebaseio.com/");
  GlobalKeyListenerExample e = new GlobalKeyListenerExample();
  e.start();
  frameRate(64);
}

void draw(){
  background(0);
}

class GlobalKeyListenerExample implements NativeKeyListener {
  @Override
  public void nativeKeyPressed(NativeKeyEvent e){fire.setValue("pressing"+e.getKeyCode(), "true");}

  public void nativeKeyReleased(NativeKeyEvent e){fire.setValue("pressing"+e.getKeyCode(), "false");}

  public void nativeKeyTyped(NativeKeyEvent e) {}

  void start() {
    try {GlobalScreen.registerNativeHook();}
    catch (NativeHookException ex) {System.exit(1);}
 
    GlobalScreen.addNativeKeyListener(new GlobalKeyListenerExample());
  }
}
