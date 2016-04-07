void update(int x, int y){
  if (overTestButton(force_x,force_y,force_width, force_height) && isMain){
    isForce = true;
    isMain = false;
    isDist = false;
  }
  else if (overTestButton(dist_x, dist_y, dist_width, dist_height) && isMain){
    isForce = false;
    isMain = false;
    isDist = true;
  }
  else if(overTestButton(back_x, back_y, back_width, back_height) && (isForce || isDist)){
    isForce = false;
    isMain = true;
    isDist = false;
  }
  else{

  }
}