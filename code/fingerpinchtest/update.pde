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
    fingerpinchtest.setType("Force");
    fingerpinchtest.setTolerance();
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
    fingerpinchtest.setType("Distance");
    fingerpinchtest.setForceTestPosition(-1);  
    fingerpinchtest.setTolerance();
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
    if (!fingerpinchtest.isCompleted() && fingerpinchtest.isReadyToStart()){
      fingerpinchtest.startTest();
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
    else{
      fingerpinchtest.displayErrorMessageOn();
    }
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
  
  else if(overTestButton(startx,starty,startwidth,startheight) && isIncrement && !fingerpinchtest.isActive()){
    if (!fingerpinchtest.isCompleted() && fingerpinchtest.isReadyToStart()){
      fingerpinchtest.startTest();
    }
    else{
      fingerpinchtest.displayErrorMessageOn();
    }
  }
  
  //Increment Parameter Selection
  else if (overTestButton(x_10,y_10,num_width,num_height) && (isIncrement || isDistInc)){
    colorBox10 = !colorBox10;
    colorBox20 = false;
    colorBox30 = false;
    fingerpinchtest.setNumRounds(10);
  }
  else if (overTestButton(x_20,y_20,num_width,num_height) && (isIncrement || isDistInc)){
    colorBox10 = false;
    colorBox20 = !colorBox20;
    colorBox30 = false;
    fingerpinchtest.setNumRounds(20);
  }
  else if (overTestButton(x_30,y_30,num_width,num_height) && (isIncrement || isDistInc)){
    colorBox10 = false;
    colorBox20 = false;
    colorBox30 = !colorBox30;
    fingerpinchtest.setNumRounds(30);
  }
  else if (overTestButton(left_x,left_y,positionwidth,positionheight) && (isIncrement || isDistInc)){
    colorBoxLeft = !colorBoxLeft;
    colorBoxRight = false;
    fingerpinchtest.setHand("Left");
  }
  else if (overTestButton(right_x,right_y,positionwidth,positionheight) && (isIncrement || isDistInc)){
    colorBoxLeft = false;
    colorBoxRight = !colorBoxRight;
    fingerpinchtest.setHand("Right");
  }
  else if (overTestButton(close_x,close_y,positionwidth,positionheight) && (isIncrement)){
    colorBoxClose = !colorBoxClose;
    colorBoxMiddle = false;
    colorBoxFar = false;
    fingerpinchtest.setForceTestPosition(1);  
  }
  else if (overTestButton(middle_x,middle_y,positionwidth,positionheight) && (isIncrement)){
    colorBoxClose = false;
    colorBoxMiddle = !colorBoxMiddle;
    colorBoxFar = false;
    fingerpinchtest.setForceTestPosition(2);  
  }
  else if (overTestButton(far_x,far_y,positionwidth,positionheight) && (isIncrement)){
    colorBoxClose = false;
    colorBoxMiddle = false;
    colorBoxFar = !colorBoxFar;
    fingerpinchtest.setForceTestPosition(3);  
  }
  else if (overTestButton(random_x, random_y, randomwidth,randomheight) && (isIncrement)){
    if (colorBoxRandom){
      colorBoxRandom = false;
      fingerpinchtest.setMode("Increment");
    }
    else{
      colorBoxRandom = true;
      fingerpinchtest.setMode("Random");
    }
  }
  else if (overTestButton(random_xdist, random_y, randomwidth,randomheight) && (isDistInc)){
    if (colorBoxRandom){
      colorBoxRandom = false;
      fingerpinchtest.setMode("Increment");
    }
    else{
      colorBoxRandom = true;
      fingerpinchtest.setMode("Random");
    }
  }
  
  
  //text == "10" || text == "20" text == "30" || text == "Left" || text == "Right" || text == "Close" || text == "Middle" || text == "Far"){
  //   if (overTestButton(x,y,w,h){
       
  // }
  
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
    colorBox10 = false;
    colorBox20 = false;
    colorBox30 = false;
    colorBoxLeft = false;
    colorBoxRight = false;
    colorBoxClose = false;
    colorBoxMiddle = false;
    colorBoxFar = false;
    fingerpinchtest.resetTest();
  }
  else if(overTestButton(back_x, back_y, back_width, back_height) && isIncrement && fingerpinchtest.isActive()){ //done button for Force
    isForce = false;
    isMain = false;
    isDist = false;
    isForceSelection = false;
    isFirstRun = true;
    isIncrement = true;
    isDistInc = false;
    isDistFree = false;
    isDistIncRun = false;
    fingerpinchtest.endTest();
    //println("Pressed Done Button");
  }
  else if(overTestButton(back_x, back_y, back_width, back_height) && isDistIncRun && fingerpinchtest.isActive()){ //done button for Dist
    isForce = false;
    isMain = false;
    isDist = false;
    isForceSelection = false;
    isFirstRun = true;
    isIncrement = false;
    isDistInc = true;
    isDistFree = false;
    isDistIncRun = false;
    fingerpinchtest.endTest();
    //println("Pressed Done Button");
  }
  else if((overTestButton(back_x, back_y, back_width, back_height) && isIncrement) && fingerpinchtest.isCompleted()){
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
    colorBox10 = false;
    colorBox20 = false;
    colorBox30 = false;
    colorBoxLeft = false;
    colorBoxRight = false;
    colorBoxClose = false;
    colorBoxMiddle = false;
    colorBoxFar = false;
    colorBoxRandom = false;
    fingerpinchtest.resetTest();
    fingerpinchtest.setMode("Increment");
    //println("Reset the Increment test");
  }
  else if((overTestButton(back_x, back_y, back_width, back_height) && isDistIncRun) && fingerpinchtest.isCompleted()){
    //println("Pressed go back button");
    isForce = false;
    isMain = false;
    isDist = false;
    isForceSelection = false;
    isFirstRun = true;
    isIncrement = false;
    isDistInc = true;
    isDistFree = false;
    isDistIncRun = false;
    colorBox10 = false;
    colorBox20 = false;
    colorBox30 = false;
    colorBoxLeft = false;
    colorBoxRight = false;
    fingerpinchtest.resetTest();
    fingerpinchtest.setMode("Increment");
    //println("Reset the Increment test");
  }
  
  else{

  }
}