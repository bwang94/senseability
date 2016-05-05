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
    fill(255);
    makeButton(back_mid_x,back_mid_y,back_width, back_height,"Go Back",70,129,105,60,144,160,255);
    fill(255);
    makeButton(incforce_x,incforce_y,incforce_width,incforce_height,"Increment",70,129,105,60,144,160,255);
    fill(255);
    makeButton(ranforce_x,ranforce_y,ranforce_width,ranforce_height,"Random",70,129,105,60,144,160,255);
    fill(255);
    makeButton(cusforce_x,cusforce_y,cusforce_width,cusforce_height,"Custom",70,129,105,60,144,160,255);
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
    if (!force_leftinc.isActive()){
      noStroke();
      fill(255);
      makeButton(startx,starty,startwidth,startheight,"Start",70,129,105,60,144,160,255);
    }
    if (force_leftinc.isActive()){
      if (force_leftinc.getCurrentRound() == 1){
        force_leftinc.setTargets();
      }
      //TODO - STOP BUTTON
      background(255);
      if (!force_leftinc.isRoundStarted()){
        force_leftinc.startRound();
      }
      force_leftinc.drawForceBar();
      force_leftinc.displayTimeElapsed();
      force_leftinc.drawCurrentTarget();
      force_leftinc.checkTarget();
      if (force_leftinc.checkRoundComplete()){
        force_leftinc.nextRound();
        force_leftinc.displayMessage();
      }
      if (force_leftinc.checkTestComplete()){
        force_leftinc.endTest();
      }
    }
    else if (force_leftinc.isCompleted()){
      force_leftinc.displaySummary();
      noStroke();
      makeButton(back_x,back_y,back_width, back_height,"Go Back",70,129,105,60,144,160,255);
      fill(255);
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
    text(str(dlh_trun) + " (deg)",dlh_textx + text_x_pad,dist_texty+90);
    endShape();
    
    beginShape();
    noStroke();
    makeButton(drh_textx,dist_texty,textwidth_dist,textheight_dist,"Right Hand",255,255,255,255,255,255,0);
    fill(0);
    drh_trun = truncate(drh);
    text(str(drh_trun) + " (deg)",drh_textx + text_x_pad,dist_texty+90);
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
    background(255);
    }
    else{
    xPos_dlh++;
    }
    if (dlhdraw == 0){
     lastheight_dlh = height/2-100;
    }
  }
}