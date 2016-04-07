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
boolean isFirstRun = true;

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
    drawScreen("main");
  }
  
  else if (isForceSelection){
    resetScreen("forceselect");
    drawScreen("forceselect");
  }
  
  else if (isIncrement){
    if (isFirstRun){
      resetScreen("increment");
    }
    drawScreen("freeforce");
    drawScreen("increment");
  }
  else if (isForce){
    if (isFirstRun){
      resetScreen("freeforce");
    }
    drawScreen("freeforce");
  }
  
  else if (isDist){
    if (isFirstRun){  
      resetScreen("freedist");
    }
    drawScreen("freedist");
  }
  else{
    
  }
}