import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

Serial port;
PFont f;

int flt_index;
int frt_index;

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

float k = 54725.2;
float c = 1.2054;
int textheight = 200;
int textwidth = 250;
int forcelimit = 100;

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


void setup(){
  port = new Serial(this,Serial.list()[0],57600);
  port.clear();
  port.bufferUntil('\n');
  size(1200,700);
  //fullScreen();
  frameRate(120);
  f = createFont("Arial",32,true);
  background(255);
  //println(arduino.list());
}

void draw(){
  textFont(f,32);
  
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
  rect(scrn_width/2,scrn_height/2 - 50,5,scrn_height/2 + 50);
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