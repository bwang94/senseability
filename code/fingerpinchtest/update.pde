void update(){
  //MAIN SCREEN BUTTONS
  //Clicked the force test button on main screen --> go to force selection
  if (overTestButton(force_x,force_y,force_width, force_height) && isMain){
    isForce = false;
    isIncrement = false;
    isForceSelection = true;
    isMain = false;
    isDist = false;
    isDistInc = false;
    isDistFree = false;
    isDistIncRun = false;
  }
  //Clicked distance test button on main screen --> go to free distance 
  else if (overTestButton(dist_x, dist_y, dist_width, dist_height) && isMain){
    isForce = false;
    isIncrement = false;
    isForceSelection = false;
    isMain = false;
    isDist = true;
    isDistInc = false;
    isDistFree = false;
    isFirstRun = false;
    isDistIncRun = false;
  }
  
  //DISTANCE SELECTION BUTTONS
  else if (overTestButton(distinc_x, distinc_y, distinc_width, distinc_height) && isDist){    //DistInc
    isForce = false;
    isForceSelection = false;
    isIncrement = false;
    isMain = false;
    isDist = false;
    isFirstRun = true;
    isDistInc = true;
    isDistFree = false;
    isDistIncRun = false;
  }
  else if (overTestButton(startx, starty, startwidth, startheight) && isDistInc){    //DistIncRun
    isForce = false;
    isForceSelection = false;
    isIncrement = false;
    isMain = false;
    isDist = false;
    isFirstRun = true;
    isDistInc = false;
    isDistFree = false;
    isDistIncRun = true;
  }
  else if (overTestButton(distfree_x, distfree_y, distfree_width, distfree_height) && isDist){    //DistFree
    isForce = false;
    isForceSelection = false;
    isIncrement = false;
    isMain = false;
    isDist = false;
    isFirstRun = true;
    isDistInc = false;
    isDistFree = true;
    isDistIncRun = false;
  }
  
  //FORCE SELECTION BUTTONS
  else if (overTestButton(freeforce_x,freeforce_y,freeforce_width,freeforce_height) && isForceSelection){
    isForce = true;
    isForceSelection = false;
    isIncrement = false;
    isMain = false;
    isDist = false;
    isFirstRun = true;
    isDistInc = false;
    isDistFree = false;
    isDistIncRun = false;
  }
  else if (overTestButton(incforce_x,incforce_y,incforce_width,incforce_height) && isForceSelection){
    isForce = false;
    isIncrement = true;
    isForceSelection = false;
    isMain = false;
    isDist = false;
    isFirstRun = true;
    isDistInc = false;
    isDistFree = false;
    isDistIncRun = false;
  }
  
  else if(overTestButton(startx,starty,startwidth,startheight) && isIncrement && !force_leftinc.isActive()){
    if (!force_leftinc.isCompleted()){
      force_leftinc.startTest();
      println("Started Increment Test");
    }
    else{
      force_rightinc.startTest();  
    }
  }
  
  //BACK BUTTONS
  //Clicked back button on force selection screen --> go to main
  else if(overTestButton(back_mid_x, back_mid_y, back_width, back_height) && isForceSelection){
    isForce = false;
    isMain = true;
    isDist = false;
    isForceSelection = false;
    isFirstRun = true;
    isIncrement = false;
    isDistInc = false;
    isDistFree = false;
    isDistIncRun = false;
  }
  //Clicked back button during any force test --> go to force selection
  else if(overTestButton(back_x, back_y, back_width, back_height) && (isForce)){
    isForce = false;
    isMain = false;
    isDist = false;
    isForceSelection = true;
    isFirstRun = true;
    isIncrement = false;
    isDistInc = false;
    isDistFree = false;
    isDistIncRun = false;
  }
  //Clicked on back button on free distance --> go to main
  else if(overTestButton(back_mid_x, back_mid_y, back_width, back_height) && isDist){
    isForce = false;
    isMain = true;
    isDist = false;
    isForceSelection = false;
    isFirstRun = true;
    isIncrement = false;
    isDistInc = false;
    isDistFree = false;
    isDistIncRun = false;
  }
  else if(overTestButton(back_x, back_y, back_width, back_height) && isDistFree){
    isForce = false;
    isMain = false;
    isDist = true;
    isForceSelection = false;
    isFirstRun = true;
    isIncrement = false;
    isDistInc = false;
    isDistFree = false;
    isDistIncRun = false;
  }
  else if(overTestButton(back_right_x, back_right_y, back_width, back_height) && (isDistInc || isIncrement)){
    isForce = false;
    isMain = false;
    if (isDistInc){
      isDist = true;
    }
    if(isIncrement){
      isForceSelection = true;
    }
    isFirstRun = true;
    isIncrement = false;
    isDistInc = false;
    isDistFree = false;
    isDistIncRun = false;
  }
  else if(overTestButton(back_x, back_y, back_width, back_height) && isDistIncRun){
    isForce = false;
    isMain = false;
    isDist = false;
    isForceSelection = false;
    isFirstRun = true;
    isIncrement = false;
    isDistInc = true;
    isDistFree = false;
    isDistIncRun = false;
  }
  else if(overTestButton(back_x, back_y, back_width, back_height) && isIncrement && force_leftinc.isActive()){ //done button
    isForce = false;
    isMain = false;
    isDist = false;
    isForceSelection = false;
    isFirstRun = true;
    isIncrement = true;
    isDistInc = false;
    isDistFree = false;
    isDistIncRun = false;
    force_leftinc.endTest();
    //println("Pressed Done Button");
  }
  else if((overTestButton(back_x, back_y, back_width, back_height) && isIncrement) && force_leftinc.isCompleted()){
    //println("Pressed go back button");
    isForce = false;
    isMain = false;
    isDist = false;
    isForceSelection = false;
    isFirstRun = true;
    isIncrement = true;
    isDistInc = false;
    isDistFree = false;
    isDistIncRun = false;
    force_leftinc.resetTest();
    //println("Reset the Increment test");
  }
  
  else{

  }
}