class KeyListener implements NativeKeyListener{
  @Override
  public void nativeKeyPressed(NativeKeyEvent e) {
    if(e.getKeyCode()==NativeKeyEvent.VC_S)holding = true;
  }

  public void nativeKeyReleased(NativeKeyEvent e) {
    if(e.getKeyCode()==NativeKeyEvent.VC_S)holding = false;
    if(e.getKeyCode()==NativeKeyEvent.VC_A)pressEvent();
  }

  public void nativeKeyTyped(NativeKeyEvent e) {}

  void start() {
    try {GlobalScreen.registerNativeHook();}
    catch (NativeHookException ex) {System.exit(1);}
    GlobalScreen.addNativeKeyListener(new KeyListener());
  }
}
