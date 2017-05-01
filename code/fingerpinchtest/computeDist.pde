void computeDist(){
  if (resist_dlh < 0){
    resist_dlh = 0;
  }
  if (resist_drh < 0){
    resist_drh = 0;
  }
  
  dlh = dist_intercept + dist_slope*(log(resist_dlh)/log(10));
  drh = dist_intercept + dist_slope*(log(resist_drh)/log(10)) + 2.5;
  
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
  drh = 90 - drh;
  if (drh < 0){
    drh = 0;
  }
  drhdraw = map(drh,0,90,0,height/2-100);
  //println(resist_dlh);
}

//void computeMinDist(int hand){
//    //1 = left, 2 = right
//    if (hand == 1){
//      if (dlh < mindlh){
//        mindlh = dlh;
//      }
//    }
//    else{
//      if (drh < mindrh){
//        mindrh = drh;
//      }
//    }
//}

void computeMaxDist(int hand){
   //1 = left, 2 = right
   if (hand == 1){
     if (dlh > mindlh){
       maxdlh = dlh;
       maxdlh_trun = truncate(maxdlh);
     }
   }
   else{
     if (drh > mindrh){
       maxdrh = drh;
       maxdrh_trun = truncate(maxdrh);
     }
   }
}

void drawMinMaxBar(int hand, float value){
  //1 = left, 2 = right
  if (hand == 1){
      float targetcenter_x = dlh_xstart + distdraw_width/2*cos(radians(value));
      float targetcenter_y = height - distdraw_height/2*sin(radians(value));
      float targetstart_x = targetcenter_x - 50*cos(radians(value));
      float targetstart_y = targetcenter_y + 50*sin(radians(value));
      float targetend_x = targetcenter_x + 50*cos(radians(value));
      float targetend_y = targetcenter_y - 50*sin(radians(value)); 
      strokeWeight(15);
      stroke(102,255,102);
      line(targetstart_x,targetstart_y,targetend_x,targetend_y);
      noStroke();
    }
    else{
      float targetcenter_x = drh_xstart - distdraw_width/2*cos(radians(value));
      float targetcenter_y = height - distdraw_height/2*sin(radians(value));
      float targetstart_x = targetcenter_x - 50*cos(radians(value));
      float targetstart_y = targetcenter_y - 50*sin(radians(value));
      float targetend_x = targetcenter_x + 50*cos(radians(value));
      float targetend_y = targetcenter_y + 50*sin(radians(value)); 
      strokeWeight(15);
      stroke(102,255,102);
      line(targetstart_x,targetstart_y,targetend_x,targetend_y);
      noStroke();
    }
  
}