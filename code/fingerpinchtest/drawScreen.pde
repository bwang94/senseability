void drawScreen(String screen){
  if (screen.equals("main")){
    background(255);
    noStroke();
    makeButton(force_x,force_y,force_width,force_height,"Force Test",200,0);
    makeButton(dist_x,dist_y,dist_width,dist_height,"Dist Test",200,0);
  }
  
  if (screen.equals("forceselect")){
    noStroke();
    makeButton(back_x,back_y,back_width, back_height,"Go Back",200,0);
    makeButton(incforce_x,incforce_y,incforce_width,incforce_height,"Increment",200,0);
    makeButton(ranforce_x,ranforce_y,ranforce_width,ranforce_height,"Random",200,0);
    makeButton(cusforce_x,cusforce_y,cusforce_width,cusforce_height,"Custom",200,0);
    makeButton(freeforce_x,freeforce_y,freeforce_width,freeforce_height,"Free",200,0);
  }
  
  if (screen.equals("freeforce")){
    noStroke();
    makeButton(back_x,back_y,back_width, back_height,"Go Back",200,0);
    
    // Display numerical force values for left hand
    fill(255);
    beginShape();
    noStroke();
    rect(0,300,textwidth,textheight);
    fill(0);
    endShape();
    text("Force (N)",30,350);
    flt_trun = truncate(flt);
    text(str(flt_trun),30,380);
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
    rect(scrn_width/2,scrn_height/2 - 50,3,scrn_height/2 + 50);
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
      makeButton(startx,starty,startwidth,startheight,"Start",200,0);
    }
    if (force_leftinc.isActive()){
      background(255);
      if (!force_leftinc.isRoundStarted()){
        force_leftinc.startRound();
      }
      force_leftinc.drawForceBar();
      force_leftinc.displayTimeElapsed();
      force_leftinc.drawCurrentTarget();
      force_leftinc.checkTarget();
      force_leftinc.displayMessage();
      if (force_leftinc.checkRoundComplete()){
        force_leftinc.nextRound();
      }
      if (force_leftinc.checkTestComplete()){
        force_leftinc.endTest();
      }
    }
    else if (force_leftinc.isCompleted()){
      force_leftinc.displaySummary();
      noStroke();
      makeButton(back_x,back_y,back_width, back_height,"Go Back",200,0);
    }
  }
  
  if (screen.equals("freedist")){
    noStroke();
    makeButton(back_x,back_y,back_width, back_height,"Go Back",200,0);
    
    // Draw divider line
    rect(scrn_width/2,scrn_height/2 - 50,3,scrn_height/2 + 50);
    fill(0);
    
    fill(255);
    rect(0,height/2-50,width/2, height/2+50);
    beginShape();
    noStroke();
    makeButton(dlh_textx,dist_texty,textwidth_dist,textheight_dist,"Left Hand",255,0);
    dlh_trun = truncate(dlh);
    text(str(dlh_trun) + " (deg)",dlh_textx + text_x_pad,dist_texty+90);
    endShape();
        
    float temp_start = map(dlh,0,90,0,PI/2);
    distbar_left.changeAngleStart(2*PI - temp_start);
    distbar_left.changeColor(0,0,0);
    distbar_left.drawCurve();

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