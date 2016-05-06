void drawScreen(String screen){
  if (screen.equals("main")){
    background(255);
    noStroke();
    //beginShape();
    //fill(39, 170, 138);
    //rect(0,150,1200,350);
    //endShape();
     //noFill();

  //if (axis == Y_AXIS) {  // Top to bottom gradient
    //for (int i = 50; i <= 500; i++) {
      //float inter = map(i, 50, 200, 0, 1);
      //color c = lerpColor(c1, c2, inter);
      //stroke(c);
      //line(0, i, 1200, i);
    //}
    
    //fill(225);
    //rect(0,175,150,325);
    
    //fill(225);
    //rect(1050,175,150,325);
    
    fill(70,129,105);
    rect(0,50,1200,420);
    
    //fill(255);
    //rect(225,300,675,200);
    
    //fill(c1,50);
    //rect(225,300,675,200);

    
    noStroke();
    fill(255);
    makeButton(dist_x,dist_y,dist_width,dist_height,"Distance",70,129,105,60,144,160,255);
    fill(255);
    makeButton(force_x,force_y,force_width,force_height,"Force",70,129,105,60,144,160,255);
    fill(255);
    PImage logo;
    logo = loadImage("BurkeLogo.png");
    image(logo,400,390);
    
    beginShape();
    //fill(0);
    //rect(0,0,1200,200);
    fill(255);
    rect(0,0,1200,50);
    endShape();
    
    //void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

 
  //}  
    
    stroke(0);
    textFont(F,96);
    fill(255);
    text("SENSE-ABILITY",260,200);
    //text("A Custom Device for",550,600);
    //text("Finger-Pinch Rehabilitation",550,650);
    textFont(F,26);
    fill(0);
    text("The City College of New York | Department of Biomedical Engineering",10,35);
  }
  
  if (screen.equals("forceselect")){
    background(255);
    noStroke();
    beginShape();
    fill(70,129,105);
    rect(0,50,1200,420);
    endShape();
    fill(0);
    textFont(F,26);
    text("The City College of New York | Department of Biomedical Engineering",10,35);
    textFont(F,86);
    fill(255);
    text("Force Test",390,180);
    fill(255);
    makeButton(back_mid_x,back_mid_y,back_width, back_height,"Go Back",70,129,105,60,144,160,255);
    fill(255);
    makeButton(incforce_x,incforce_y,incforce_width,incforce_height,"Custom",70,129,105,60,144,160,255);
    fill(255);
    makeButton(freeforce_x,freeforce_y,freeforce_width,freeforce_height,"Free",70,129,105,60,144,160,255);
    fill(0);  
}
  
  if (screen.equals("freeforce")){
    noStroke();
    fill(255);
    makeButton(back_x,back_y,back_width, back_height,"Go Back",70,129,105,60,144,160,255);
    
    // Display numerical force values for left hand
    fill(255);
    beginShape();
    noStroke();
    rect(0,300,textwidth,textheight);
    fill(0);
    endShape();
    textFont(F,36);
    text("Force (N)",30,350);
    flt_trun = truncate(flt);
    text(str(flt_trun),30,380);
    textFont(F,36);
    text("Max (N)",30,410);
    maxflt_trun = truncate(maxflt);
    text(str(maxflt_trun),30,440);
    
    // Display numerical force values for right hand
    fill(255);
    beginShape();
    noStroke();
    rect(600,300,textwidth,textheight);
    fill(0);
    endShape();
    text("Force (N)",630,350);
    frt_trun = truncate(frt);
    text(str(frt_trun),630,380);
    text("Max (N)",630,410);
    maxfrt_trun = truncate(maxfrt);
    text(str(maxfrt_trun),630,440);
    
    // Draws bar graphs for forces
    drawBar(0,200,fltdraw);
    drawBar(1,200,frtdraw);
    
    // Draw divider line
    fill(0);
    rect(scrn_width/2,scrn_height/2 - 50,3,scrn_height/2 + 50,5);
    fill(0);
    
    // Line Graph for left hand
    stroke(255,153,153);
    strokeWeight(2);
    line(lastxPos_lt, lastheight_lt, xPos_lt,height/2 -100 - fltdraw);
    lastxPos_lt = xPos_lt;
    lastheight_lt = int(height/2 -100 - fltdraw);
    if (xPos_lt >= width){
     xPos_lt = 0;
     lastxPos_lt = 0;
     background(255);
    }
    else{
      xPos_lt++;
    }
    if (fltdraw == 0){
      lastheight_lt = height/2 -100;
    }
    
    // Line Graph for right hand 
    stroke(153,204,205);
    strokeWeight(2);
    line(lastxPos_rt, lastheight_rt, xPos_rt,height/2 -100 - frtdraw);
    lastxPos_rt = xPos_rt;
    lastheight_rt = int(height/2 -100 - frtdraw);
    if (xPos_rt >= width){
     xPos_rt = 0;
     lastxPos_rt = 0;
     background(255);
    }
    else{
      xPos_rt++;
    }
    if (frtdraw == 0){
      lastheight_rt = height/2 -100;
    }
  }
  
  if (screen.equals("increment")){
    if (!fingerpinchtest.isActive()){
      background(255);
    noStroke();
    beginShape();
    fill(70,129,105);
    rect(0,50,1200,420);
    endShape();
    fill(0);
    textFont(F,26);
    text("The City College of New York | Department of Biomedical Engineering",10,35);
    fill(255);
    //println("Parameter selection screen");
      makeButton(back_right_x,back_right_y,back_width, back_height,"Go Back",70,129,105,60,144,160,255);
      makeButton(startx,starty,startwidth,startheight,"Start",70,129,105,60,144,160,255);
      
      //Divider Lines
    fill(255);  
    rect(360,75,3,375);
    rect(620,75,3,375);
    rect(860,75,3,375);
      
      if (colorBoxLeft==false){
      makeButton(left_x,left_y,handwidth, handheight,"Left",70,129,105,60,144,160,255);
      }
      if (colorBoxLeft==true){
      makeButton(left_x,left_y,handwidth, handheight,"Left",60,144,160,60,144,160,255);
      }
      
      if (colorBoxRight==false){
      makeButton(right_x,right_y,handwidth, handheight,"Right",70,129,105,60,144,160,255);
      }
      if (colorBoxRight==true){
      makeButton(right_x,right_y,handwidth, handheight,"Right",60,144,160,60,144,160,255);
      }
      
      if (colorBox10==false){
      makeButton(x_10,y_10,num_width, num_height,"10",70,129,105,60,144,160,255);
      }
      if (colorBox10==true){
      makeButton(x_10,y_10,num_width, num_height,"10",60,144,160,60,144,160,255);
      }
      
      if (colorBox20==false){
      makeButton(x_20,y_20,num_width, num_height,"20",70,129,105,60,144,160,255);
      }
      if (colorBox20==true){
      makeButton(x_20,y_20,num_width, num_height,"20",60,144,160,60,144,160,255);
      }
      
      if (colorBox30==false){
      makeButton(x_30,y_30,num_width, num_height,"30",70,129,105,60,144,160,255);
      }
      if (colorBox30==true){
      makeButton(x_30,y_30,num_width, num_height,"30",60,144,160,60,144,160,255);
      }
      
      if (colorBoxClose==false){
      makeButton(close_x,close_y,positionwidth, positionheight,"Close",70,129,105,60,144,160,255);
      }
      if (colorBoxClose==true){
      makeButton(close_x,close_y,positionwidth, positionheight,"Close",60,144,160,60,144,160,255);
      }
      
      if (colorBoxMiddle==false){
      makeButton(middle_x,middle_y,positionwidth, positionheight,"Middle",70,129,105,60,144,160,255);
      }
      if (colorBoxMiddle==true){
      makeButton(middle_x,middle_y,positionwidth, positionheight,"Middle",60,144,160,60,144,160,255);
      }
      
      if (colorBoxFar==false){
      makeButton(far_x,far_y,positionwidth, positionheight,"Far",70,129,105,60,144,160,255);
      }
      if (colorBoxFar==true){
      makeButton(far_x,far_y,positionwidth, positionheight,"Far",60,144,160,60,144,160,255);
      }
      
      if (!colorBoxRandom){
        makeButton(random_x, random_y, randomwidth, randomheight,"Random",70,129,105,60,144,160,255);
      }
      if (colorBoxRandom){
         makeButton(random_x, random_y, randomwidth, randomheight,"Random",60,144,160,60,144,160,255);
      }
      
      text("Hand",160,100);
      text("Rounds",420,100);
      text("Bounds",676,100);
      text("Position",908,100);
      startforcebar.updateScrollBar();
      endforcebar.updateScrollBar();
      startforcebar.updateDisplay();
      endforcebar.updateDisplay(); 
      fingerpinchtest.setBounds(startforcebar.getSliderValue(),endforcebar.getSliderValue());
      fill(255);
      if (fingerpinchtest.shouldDisplayError()){
        fingerpinchtest.displayErrorMessage();
      }
    }
    if (fingerpinchtest.isActive()){
      //println("Test active");
      if (fingerpinchtest.getCurrentRound() == 1){
        fingerpinchtest.setTargets();
      }
      //TODO - STOP BUTTON
      background(255);
      if (!fingerpinchtest.isRoundStarted()){
        fingerpinchtest.startRound();
      }
      fingerpinchtest.drawForceBar();
      fingerpinchtest.displayTimeElapsed();
      fingerpinchtest.drawCurrentTarget();
      fingerpinchtest.checkTarget();
      fill(255);
      makeButton(back_x,back_y,back_width, back_height,"Done",70,129,105,60,144,160,255);
      if (fingerpinchtest.checkRoundComplete()){
        fingerpinchtest.nextRound();
      }
      if (fingerpinchtest.shouldDisplayMessage()){
        fingerpinchtest.displayMessage();
      }
      if (fingerpinchtest.checkTestComplete()){
        fingerpinchtest.endTest();
      }
    }
    else if (fingerpinchtest.isCompleted()){
      fingerpinchtest.displaySummary();
      noStroke();
      fill(255);
      makeButton(back_x,back_y,back_width, back_height,"Go Back",70,129,105,60,144,160,255);
    }
  }
  
  if (screen.equals("dist")){
   background(255);
    noStroke();
    beginShape();
    fill(70,129,105);
    rect(0,50,1200,420);
    endShape();
    fill(0);
    textFont(F,26);
    text("The City College of New York | Department of Biomedical Engineering",10,35);
    fill(255); 
    makeButton(distinc_x,distinc_y,distinc_width,distinc_height,"Custom",70,129,105,60,144,160,255);
    makeButton(distfree_x,distfree_y,distfree_width,distfree_height,"Free",70,129,105,60,144,160,255);
    makeButton(back_mid_x,back_mid_y,back_width,back_height,"Go Back",70,129,105,60,144,160,255);
    textFont(F,86);
    fill(255);
    text("Distance Test",320,180);
  }
  
  if (screen.equals("distinc")){
    background(255);
    noStroke();
    beginShape();
    fill(70,129,105);
    rect(0,50,1200,420);
    endShape();
    fill(0);
    textFont(F,26);
    text("The City College of New York | Department of Biomedical Engineering",10,35);
    fill(255);
      makeButton(back_right_x,back_right_y,back_width, back_height,"Go Back",70,129,105,60,144,160,255);
      makeButton(startx,starty,startwidth,startheight,"Start",70,129,105,60,144,160,255);
      
      //Divider Lines
    fill(255);  
    rect(455,75,3,375);
    rect(750,75,3,375);
      
      if (colorBoxLeft==false){
      makeButton(leftd_x,leftd_y,handwidth, handheight,"Left",70,129,105,60,144,160,255);
      }
      if (colorBoxLeft==true){
      makeButton(leftd_x,leftd_y,handwidth, handheight,"Left",60,144,160,60,144,160,255);
      }
      
      if (colorBoxRight==false){
      makeButton(rightd_x,rightd_y,handwidth, handheight,"Right",70,129,105,60,144,160,255);
      }
      if (colorBoxRight==true){
      makeButton(rightd_x,rightd_y,handwidth, handheight,"Right",60,144,160,60,144,160,255);
      }
      
      if (colorBox10==false){
      makeButton(x_10d,y_10d,num_width, num_height,"10",70,129,105,60,144,160,255);
      }
      if (colorBox10==true){
      makeButton(x_10d,y_10d,num_width, num_height,"10",60,144,160,60,144,160,255);
      }
      
      if (colorBox20==false){
      makeButton(x_20d,y_20d,num_width, num_height,"20",70,129,105,60,144,160,255);
      }
      if (colorBox20==true){
      makeButton(x_20d,y_20d,num_width, num_height,"20",60,144,160,60,144,160,255);
      }
      
      if (colorBox30==false){
      makeButton(x_30d,y_30d,num_width, num_height,"30",70,129,105,60,144,160,255);
      }
      if (colorBox30==true){
      makeButton(x_30d,y_30d,num_width, num_height,"30",60,144,160,60,144,160,255);
      }
   
     
      text("Hand",270,100);
      text("Rounds",535,100);
      text("Bounds",821,100);
      startdistbar.updateScrollBar();
      enddistbar.updateScrollBar();
      startdistbar.updateDisplay();
      enddistbar.updateDisplay();
      fingerpinchtest.setBounds(startdistbar.getSliderValue(),enddistbar.getSliderValue());
      if (fingerpinchtest.shouldDisplayError()){
        fingerpinchtest.displayErrorMessage();
      }
      fill(255);
  }
  
  if (screen.equals("distincrun")){
    noStroke();
    background(255);
    if (fingerpinchtest.isActive()){
      //println("Test active");
      if (fingerpinchtest.getCurrentRound() == 1){
        fingerpinchtest.setTargets();
      }
      //TODO - STOP BUTTON
      background(255);
      if (!fingerpinchtest.isRoundStarted()){
        fingerpinchtest.startRound();
      }
      fingerpinchtest.drawDistCurve();
      fingerpinchtest.displayTimeElapsed();
      fingerpinchtest.drawCurrentTarget();
      fingerpinchtest.checkTarget();
      fill(255);
      noStroke();
      makeButton(back_x,back_y,back_width, back_height,"Done",70,129,105,60,144,160,255);
      if (fingerpinchtest.checkRoundComplete()){
        fingerpinchtest.nextRound();        
      }
      if (fingerpinchtest.shouldDisplayMessage()){
        fingerpinchtest.displayMessage();
      }
      if (fingerpinchtest.checkTestComplete()){
        fingerpinchtest.endTest();
      }
    }
    else if (fingerpinchtest.isCompleted()){
      fingerpinchtest.displaySummary();
      noStroke();
      fill(255);
      makeButton(back_x,back_y,back_width, back_height,"Go Back",70,129,105,60,144,160,255);
    }
  }
  
  if (screen.equals("freedist")){
    
    noStroke();
    fill(255);
    makeButton(back_x,back_y,back_width, back_height,"Go Back",70,129,105,60,144,160,255);
    
    // Draw divider line
    rect(scrn_width/2,scrn_height/2 - 50,3,scrn_height/2 + 50);
    fill(0);
    
    fill(255);
    rect(0,height/2-50,width, height/2+50);
    beginShape();
    noStroke();
    makeButton(dlh_textx,dist_texty,textwidth_dist,textheight_dist,"Left Hand",255,255,255,255,255,255,0);
    fill(0);
    dlh_trun = truncate(dlh);
    text(str(dlh_trun) + "\u00b0",dlh_textx + text_x_pad,dist_texty+90);
    endShape();
    
    fill(255);
    beginShape();
    noStroke();
    makeButton(drh_textx,dist_texty,textwidth_dist,textheight_dist,"Right Hand",255,255,255,255,255,255,0);
    fill(0);
    drh_trun = truncate(drh);
    text(str(drh_trun) + "\u00b0",drh_textx + text_x_pad,dist_texty+90);
    endShape();
        
    float temp_start = map(dlh,0,90,0,PI/2);
    distbar_left.changeAngleStart(2*PI - temp_start);
    distbar_left.changeColor(0,0,0);
    distbar_left.drawCurve();
    
    float temp_end = map(drh,0,90,0,PI/2);
    distbar_right.changeAngleEnd(PI + temp_end);
    distbar_right.changeColor(0,0,0);
    distbar_right.drawCurve();

    // Line Graph for left hand
    stroke(255,153,153);
    strokeWeight(2);
    line(lastxPos_dlh, lastheight_dlh, xPos_dlh,height/2 - 100 - dlhdraw);
    lastxPos_dlh = xPos_dlh;
    lastheight_dlh = int(height/2 - 100 - dlhdraw);
    if (xPos_dlh >= width){
    xPos_dlh = 0;
    lastxPos_dlh = 0;
    //background(255);
    }
    else{
    xPos_dlh++;
    }
    if (dlhdraw == 0){
     lastheight_dlh = height/2-100;
    }
  }
}