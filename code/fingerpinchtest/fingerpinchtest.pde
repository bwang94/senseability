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

float xposA = 200;
float xposB = 850;

int scrn_width = 1200;
int scrn_height = 700;

// Variables for screen switching
boolean isForce = false;
boolean isDist = false;
boolean isMain = true;
boolean isFirstRun = true;

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
int back_height = 100;

int text_x_pad = 25;
int text_y_pad = 60;

void setup(){
  port = new Serial(this,Serial.list()[0],57600);
  port.clear();
  port.bufferUntil('\n');
  size(1200,700);
  //fullScreen();
  frameRate(120);
  f = createFont("Arial",32,true);
  //println(arduino.list());
  background(255);
}

void draw(){
  textFont(f,32);
  
  if (isMain){
    background(255);
    fill(200);
    rect(force_x, force_y, force_width, force_height);
    fill(0);
    text("Force Test",force_x + text_x_pad, force_y + text_y_pad);
    
    fill(200);
    rect(dist_x, dist_y, dist_width, dist_height);
    fill(0);
    text("Dist Test",dist_x + text_x_pad,force_y + text_y_pad);
    isFirstRun = true;
  }
  
  if (isForce){
    if (isFirstRun){
      background(255);
      isFirstRun = false;
    }
    fill(200);
    rect(back_x, back_y, back_width, back_height);
    fill(0);
    text("Go Back", back_x + text_x_pad, back_y + text_y_pad);
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
  
  if (isDist){
    if (isFirstRun){
      background(255);
      isFirstRun = false;
    }
    fill(200);
    rect(back_x, back_y, back_width, back_height);
    fill(0);
    text("Go Back", back_x + text_x_pad, back_y + text_y_pad);
  }
}