void computeDist(){
  if (resist_dlh < 0){
    resist_dlh = 0;
  }
  if (resist_drh < 0){
    resist_drh = 0;
  }
  
  dlh = dist_intercept + dist_slope*(log(resist_dlh)/log(10)) + 30;
  drh = dist_intercept + dist_slope*(log(resist_drh)/log(10))
  
  if (dlh < 0){
    dlh = 0;
  }
  else if (dlh > 90){
    dlh = 90;
  }
  else{
  }
  dlhdraw = map(dlh,0,90,0,height/2-100);
  
  if (drh < 0){
    drh = 0;
  }
  else if (dlh > 90){
    drh = 90;
  }  
  else{
  }
  drhdraw = map(drh,0,90,0,height/2-100);
}