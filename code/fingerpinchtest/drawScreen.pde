void drawScreen(String screen){
  if (screen.equals("main")){
    background(255);
    noStroke();
    fill(200);
    rect(force_x, force_y, force_width, force_height);
    fill(0);
    text("Force Test",force_x + text_x_pad, force_y + text_y_pad);
    
    fill(200);
    rect(dist_x, dist_y, dist_width, dist_height);
    fill(0);
    text("Dist Test",dist_x + text_x_pad,force_y + text_y_pad);
  }
  
  if (screen.equals("forceselect")){
    noStroke();
    fill(200);
    rect(back_x, back_y, back_width, back_height);
    fill(0);
    text("Go Back", back_x + text_x_pad, back_y + text_y_pad/2);

    noStroke();
    fill(200);
    rect(incforce_x, incforce_y, incforce_width, incforce_height);
    fill(0);
    text("Increment",incforce_x + text_x_pad, incforce_y + text_y_pad);
    
    fill(200);
    rect(ranforce_x, ranforce_y, ranforce_width, ranforce_height);
    fill(0);
    text("Random",ranforce_x + text_x_pad, ranforce_y + text_y_pad);
    
    fill(200);
    rect(cusforce_x, cusforce_y, cusforce_width, cusforce_height);
    fill(0);
    text("Custom",cusforce_x + text_x_pad, cusforce_y + text_y_pad);
    
    fill(200);
    rect(freeforce_x, freeforce_y, freeforce_width, freeforce_height);
    fill(0);
    text("Free",freeforce_x + text_x_pad, freeforce_y + text_y_pad);
  }
  
  if (screen.equals("freeforce")){
    noStroke();
    fill(200);
    rect(back_x, back_y, back_width, back_height);
    fill(0);
    text("Go Back", back_x + text_x_pad, back_y + text_y_pad/2);
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
    
  }
  
  if (screen.equals("freedist")){
    noStroke();
    fill(200);
    rect(back_x, back_y, back_width, back_height);
    fill(0);
    text("Go Back", back_x + text_x_pad, back_y + text_y_pad/2);
    
    fill(255);
    beginShape();
    noStroke();
    rect(0,300,textwidth_dist,textheight_dist);
    fill(0);
    endShape();
    text("Potentiometer Resistance (ohm)",30,350);
    dlh_trun = truncate(resist_dlh);
    text(str(resist_dlh),30,380);
    
  // Line Graph for left hand
    stroke(255,153,153);
    strokeWeight(2);
    line(lastxPos_dlh, lastheight_dlh, xPos_dlh,height - dlhdraw);
    lastxPos_dlh = xPos_dlh;
    lastheight_dlh = int(height - dlhdraw);
    if (xPos_dlh >= width){
     xPos_dlh = 0;
     lastxPos_dlh = 0;
     background(255);
    }
    else{
    xPos_dlh++;
    }
    if (dlhdraw == 0){
      lastheight_dlh = 0;
    }
  }
}