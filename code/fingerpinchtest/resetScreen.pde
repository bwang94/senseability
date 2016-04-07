void resetScreen(String screen){
  if (screen.equals("forceselect")){
    background(255);
  }
  if (screen.equals("freeforce") || screen.equals("increment")){
    background(255);
    xPos_lt = 1;
    lastxPos_lt = 1;
    lastheight_lt = 350;
    xPos_rt = 1;
    lastxPos_rt = 1;
    lastheight_rt = 350;
    isFirstRun = false;
  }
  if (screen.equals("freedist")){
    background(255);
    xPos_dlh = 1;
    lastxPos_dlh = 1;
    lastheight_dlh = 0;
    isFirstRun = false;
  }
}