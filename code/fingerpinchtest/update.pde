void update(){
  //MAIN SCREEN BUTTONS
  //Clicked the force test button on main screen --> go to force selection
  if (overTestButton(force_x,force_y,force_width, force_height) && isMain){
    isForce = false;
    isForceSelection = true;
    isMain = false;
    isDist = false;
  }
  //Clicked distance test button on main screen --> go to free distance 
  else if (overTestButton(dist_x, dist_y, dist_width, dist_height) && isMain){
    isForce = false;
    isForceSelection = false;
    isMain = false;
    isDist = true;
  }
  
  //FORCE SELECTION BUTTONS
  else if (overTestButton(freeforce_x,freeforce_y,freeforce_width,freeforce_height) && isForceSelection){
    isForce = true;
    isForceSelection = false;
    isMain = false;
    isDist = false;
  }
  
  //BACK BUTTONS
  //Clicked back button on force selection screen --> go to main
  else if(overTestButton(back_x, back_y, back_width, back_height) && isForceSelection){
    isForce = false;
    isMain = true;
    isDist = false;
    isForceSelection = false;
  }
  //Clicked back button on free force --> go to force selection
  else if(overTestButton(back_x, back_y, back_width, back_height) && isForce){
    isForce = false;
    isMain = false;
    isDist = false;
    isForceSelection = true;
  }
  //Clicked on back button on free distance --> go to main
  else if(overTestButton(back_x, back_y, back_width, back_height) && isDist){
    isForce = false;
    isMain = true;
    isDist = false;
    isForceSelection = false;
  }
  else{

  }
}