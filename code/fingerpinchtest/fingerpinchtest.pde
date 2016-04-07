import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

Serial port;
PFont f;

int flt_index;
int frt_index;
int dist_index;

float flt;
float flt_trun;
float fltdraw;
float resist_flt;
float maxflt = 0;
float maxflt_trun;

float frt;
float frt_trun;
float frtdraw;
float resist_frt;
float maxfrt = 0;
float maxfrt_trun;

float dlh;
float dlh_trun;
float dlhdraw;
float resist_dlh;
float maxdlh = 0;
float maxdlh_trun;
int textheight_dist = 100;
int textwidth_dist = 450;

float k = 54725.2;
float c = 1.2054;
int textheight = 200;
int textwidth = 250;
int forcelimit = 50;

int xPos_lt = 1;
int lastxPos_lt = 1;
int lastheight_lt = 350;

int xPos_rt = 1;
int lastxPos_rt = 1;
int lastheight_rt = 350;

int xPos_dlh = 1;
int lastxPos_dlh = 1;
int lastheight_dlh = 0;

float xposA = 200;
float xposB = 850;

int scrn_width = 1200;
int scrn_height = 700;

// Variables for screen switching
boolean isForce = false;
boolean isForceSelection = false;
boolean isIncrement = false;
boolean isDist = false;
boolean isMain = true;

int incforce_x = 180;
int incforce_y = 300;
int incforce_width = 200;
int incforce_height = 100;

int ranforce_x = 385;
int ranforce_y = 300;
int ranforce_width = 200;
int ranforce_height = 100;

int cusforce_x = 590;
int cusforce_y = 300;
int cusforce_width = 200;
int cusforce_height = 100;

int freeforce_x = 795;
int freeforce_y = 300;
int freeforce_width = 200;
int freeforce_height = 100;

int force_x = 200;
int force_y = 300;
int force_width = 200;
int force_height = 100;

int dist_x = 750;
int dist_y = 300;
int dist_width = 200;
int dist_height = 100;

int back_x = 1000;
int back_y = 0;
int back_width = 200;
int back_height = 50;

int text_x_pad = 25;
int text_y_pad = 60;

void setup(){
  port = new Serial(this,Serial.list()[0],57600);    //Computer USB Port input from Arduino
  port.clear();
  port.bufferUntil('\n');
  size(1200,700);
  //fullScreen();
  frameRate(120);
  f = createFont("Arial",32,true);
  //println(arduino.list());
  background(255);     //Makes background white
}

void draw(){
  textFont(f,32);
<<<<<<< HEAD
  
  if (isMain){   //determines if the main page is loaded
    background(255);
    noStroke();
    fill(200);
    rect(force_x, force_y, force_width, force_height);              //Creates textbox to select Force test 
    fill(0);
    text("Force Test",force_x + text_x_pad, force_y + text_y_pad);   //Inputs text to Force test
    
    fill(200);
    rect(dist_x, dist_y, dist_width, dist_height);     //Creates textbox to select Distance test
    fill(0);
    text("Dist Test",dist_x + text_x_pad,force_y + text_y_pad);    //Inputs text to Distance test
    isFirstRun = true;
  }
  
  if (isForce){           //determines if the Force test is selected         
    if (isFirstRun){   
      background(255);
      isFirstRun = false;     //
      xPos_lt = 1;
      lastxPos_lt = 1;
      lastheight_lt = 350;
      xPos_rt = 1;
      lastxPos_rt = 1;
      lastheight_rt = 350;
    }
    noStroke();
    fill(200);
    rect(back_x, back_y, back_width, back_height);    //textbox for Go Back button
    fill(0);
    text("Go Back", back_x + text_x_pad, back_y + text_y_pad/2);     //adds Go Back text
  
  // Display numerical force values for left hand
    fill(255);
    beginShape();
    noStroke();
    rect(0,300,textwidth,textheight);      //Textbox for displaying force values
    fill(0);
    endShape();
    text("Force (N)",30,350);     //Force label
    flt_trun = truncate(flt);
    text(str(flt_trun),30,380);    //Writes force value in textbox
    text("Max (N)",30,410);     //Max Force label 
    maxflt_trun = truncate(maxflt);
    text(str(maxflt_trun),30,440);     //Writes Max Force value in textbox
    
  // Display numerical force values for right hand
    fill(255);
    beginShape();
    noStroke();
    rect(600,300,textwidth,textheight);      //creates textbox
    fill(0);
    endShape();
    text("Force (N)",630,350);     //writes force label
    frt_trun = truncate(frt);
    text(str(frt_trun),630,380);   //writes force value
    text("Max (N)",630,410);   //writes max force label
    maxfrt_trun = truncate(maxfrt);
    text(str(maxfrt_trun),630,440);   //writes max force value
    
  // Draws bar graphs for forces
    drawBar(0,200,fltdraw);
    drawBar(1,200,frtdraw);
    
  // Draw divider line
    rect(scrn_width/2,scrn_height/2 - 50,3,scrn_height/2 + 50);
    fill(0);
    
    // Line Graph for left hand
    stroke(255,153,153);
    strokeWeight(2);
    line(lastxPos_lt, lastheight_lt, xPos_lt,height/2 -100 - fltdraw);    //draws line. starting points (x,y) then end points (x,y)
    lastxPos_lt = xPos_lt;                                                //makes current x position the last x position
    lastheight_lt = int(height/2 -100 - fltdraw);                         //makes current y position the last y position
    if (xPos_lt >= width){                             //if the current x position is greater than the screen width
     xPos_lt = 0;                  //x position resests to zero
     lastxPos_lt = 0;              //last x position resets to zero
     background(255);               //background reset to white
    }
    else{
      xPos_lt++;    //increments current x position
    }
    if (fltdraw == 0){                    //checks if left hand force is zero
      lastheight_lt = height/2 -100;      //sets last height = 0
    }
    
  // Line Graph for right hand 
    stroke(153,204,205);
    strokeWeight(2);
    line(lastxPos_rt, lastheight_rt, xPos_rt,height/2 -100 - frtdraw);     //draws line. starting points (x,y) then end points (x,y)
    lastxPos_rt = xPos_rt;                                                 //makes current x position the last x position
    lastheight_rt = int(height/2 -100 - frtdraw);                          //makes current y position the last y position
    if (xPos_rt >= width){                                                 //if the current x position is greater than the screen width
     xPos_rt = 0;                                   //x position resests to zero
     lastxPos_rt = 0;                               //last x position resets to zero
     background(255);                               //background reset to white
    }
    else{
      xPos_rt++;                      //increment x position
    }
    if (frtdraw == 0){           //checks if incremented force is zero
      lastheight_rt = height/2 -100;       //plots zero  
    }
  }
  
  if (isDist){                        //if distance is selected
    if (isFirstRun){                     //if it's the first time running this page
      background(255);                   //background is white
      isFirstRun = false;
      xPos_dlh = 1;                      //sets starting points for line graph
      lastxPos_dlh = 1;
      lastheight_dlh = 0;
    }
    noStroke();
    fill(200);
    rect(back_x, back_y, back_width, back_height);     //textbox for Go Back
    fill(0);
    text("Go Back", back_x + text_x_pad, back_y + text_y_pad/2);        //Writes text for Go Back
    
    fill(255);
    beginShape();
    noStroke();
    rect(0,300,textwidth_dist,textheight_dist);                 //textbox for Distance Reading
    fill(0);
    endShape();
    text("Potentiometer Resistance (ohm)",30,350);              //Writes Distance label
    dlh_trun = truncate(resist_dlh);
    text(str(resist_dlh),30,380);               //Writes distance values
    
  // Line Graph for left hand
    stroke(255,153,153);
    strokeWeight(2);
    line(lastxPos_dlh, lastheight_dlh, xPos_dlh,height - dlhdraw);        //draws line. starting points (x,y) then end points (x,y)
    lastxPos_dlh = xPos_dlh;                                               //makes current x position the last x position
    lastheight_dlh = int(height - dlhdraw);                                //makes current y position the last y position
    if (xPos_dlh >= width){                                                //if the current x position is greater than the screen width
     xPos_dlh = 0;                         //x position resests to zero
     lastxPos_dlh = 0;                       //last x position resets to zero
     background(255);                        //background reset to white
    }
    else{
    xPos_dlh++;                      //increment x position
    }
    if (dlhdraw == 0){             //checks if incremented force is zero
      lastheight_dlh = 0;          //plots zero
    }  
=======
  if (isMain){
    drawScreen("main");
  }
  
  else if (isForceSelection){
    resetScreen("forceselect");
    drawScreen("forceselect");
  }
  
  else if (isIncrement){
    resetScreen("increment");
    drawScreen("freeforce");
    drawScreen("increment");
  }
  else if (isForce){
    resetScreen("freeforce");
    drawScreen("freeforce");
  }
  
  else if (isDist){
    resetScreen("freedist");
    drawScreen("freedist");
  }
  else{
    
>>>>>>> refs/remotes/origin/master
  }
}