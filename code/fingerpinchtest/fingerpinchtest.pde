 
  import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

Serial port;
PFont f;
PFont F;

//Variables for calculating/processing forces and distances
//Force
int flt_index;
int frt_index;

color b1 = color(255);
color b2 = color(0);
color c1 = color(39, 170, 138);
color c2 = color(102, 224, 194);


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

int xPos_lt = 1;
int lastxPos_lt = 1;
int lastheight_lt = 350;

int xPos_rt = 1;
int lastxPos_rt = 1;
int lastheight_rt = 350;

float k = 54725.2;
float c = 1.2054;
int forcelimit = 50;

float xposA = 200;
float xposB = 850;

//Distance
int dist_index;
int distright_index;

float dlh;
float dlh_trun;
float dlhdraw = 0;
float resist_dlh;
float maxdlh = 0;
float maxdlh_trun;

float drh;
float drh_trun;
float drhdraw = 0;
float resist_drh;
float maxdrh = 0;
float maxdrh_trun;

//Set up curved bars
CurveBar distbar_left;
CurveBar distbar_right;
  
CurveBar coverbar_left;
CurveBar coverbar_right;

//Set up Tests
PinchTest force_leftinc;
PinchTest force_rightinc;

//Distance text boxes
int textheight_dist = 100;
int textwidth_dist = 270;

//Force text boxes
int textheight = 250;
int textwidth = 250;

int xPos_dlh = 1;
int lastxPos_dlh = 1;
int lastheight_dlh = 0;

float dlh_xstart = 100;
float drh_xstart = 300;
float dist_ystart = 700;
float distdraw_width = 700;
float distdraw_height = 700;
int default_shade = 0; //black
float angleend_left = 2*PI;
float anglestart_left = 3*PI/2;
float angleend_right = 3*PI/2;
float anglestart_right = PI;
int default_thickness = 20;

int dlh_textx = 20;
int drh_textx = 1000;
int dist_texty = 600;

float dist_intercept = -253.0379;
float dist_slope = 100.4499;

//General
int scrn_width = 1200;
int scrn_height = 700;

// Variables for screen switching
boolean isForce = false;
boolean isForceSelection = false;
boolean isIncrement = false;
boolean isDist = false;
boolean isDistIncRun = false;
boolean isDistInc = false;
boolean isDistFree = false;
boolean isMain = true;
boolean isFirstRun = true;

//Variables defining button dimensions and locations
int incforce_x = 300;
int incforce_y = 110;
int incforce_width = 200;
int incforce_height = 100;

int ranforce_x = 300;
int ranforce_y = 300;
int ranforce_width = 200;
int ranforce_height = 100;

int cusforce_x = 700;
int cusforce_y = 110;
int cusforce_width = 200;
int cusforce_height = 100;

int freeforce_x = 700;
int freeforce_y = 300;
int freeforce_width = 200;
int freeforce_height = 100;

int force_x = 300;
int force_y = 300;
int force_width = 200;
int force_height = 100;

int dist_x = 700;
int dist_y = 300;
int dist_width = 200;
int dist_height = 100;

int distinc_x = 200;
int distinc_y = 200;
int distinc_width = 200;
int distinc_height = 100;

int distfree_x = 400;
int distfree_y = 200;
int distfree_width = 200;
int distfree_height = 100;

int back_mid_x = 500;
int back_mid_y = 535;

int back_right_x = 675;
int back_right_y = 535;

int back_x = 1000;
int back_y = 0;
int back_width = 200;
int back_height = 100;

int text_x2_pad = 0;
int text_x3_pad = 60;
int text_x4_pad = 60;
int text_x5_pad = 45;
int text_x6_pad = 25;
int text_x8_pad = 20;
int text_x9_pad = 2;
int text_x125_3pad = 35;
int text_x125_4pad = 23;
int text_x125_5pad = 13;
int text_x130_3pad = 35;
int text_x130_5pad = 9;
int text_x130_6pad = 0;
int text_x_pad = 25;
int text_y_pad = 60;
int text_y2_pad = 40;
int text_y75_pad = 50;

int startx = 325;
int starty = 535;
int startwidth = 200;
int startheight = 100;

int left_x = 150;
int left_y = 150;
int right_x = 150;
int right_y = 325;
int handwidth = 125;
int handheight = 100;

int close_x = 920;
int close_y = 150;
int middle_x = 920;
int middle_y = 250;
int far_x = 920;
int far_y = 350;
int positionwidth = 130;
int positionheight = 75;

int x_10 = 460;
int y_10 = 150;
int x_20 = 460;
int y_20 = 250;
int x_30 = 460;
int y_30 = 350;
int num_height = 50;
int num_width = 50;

void setup(){
  port = new Serial(this,Serial.list()[0],115200);
  port.clear();
  port.bufferUntil('\n');
  size(1200,700);
  frameRate(120);
  f = createFont("EuphemiaUCAS",32,true);
  F = createFont("EuphemiaUCAS Bold",32,true);
  //println(arduino.list());
  background(255);
  
  distbar_left = new CurveBar(dlh_xstart, dist_ystart, distdraw_width, distdraw_height, anglestart_left, angleend_left);
  distbar_right = new CurveBar(drh_xstart, dist_ystart, distdraw_width, distdraw_height, anglestart_right, angleend_right);
  force_leftinc = new PinchTest("Force","Increment","Left",10,2000,.1,10000);
  force_leftinc.setBounds(2,20);
  force_rightinc = new PinchTest("Force","Increment","Right",10,2000,.1,10000);
  force_rightinc.setBounds(2,20);
  
  //coverbar_left = new CurveBar(dlh_xstart, dist_ystart, distdraw_width, distdraw_height, 3*PI/2, 2*PI);
  //coverbar_left.changeColor(255,255,255);
  //coverbar_right = new CurveBar(drh_xstart, dist_ystart, distdraw_width, distdraw_height, PI, 3*PI/2);
  //coverbar_right.changeColor(255,255,255);
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
    drawScreen("increment");
  }
  else if (isForce){
    if (isFirstRun){
      resetScreen("freeforce");
    }
    drawScreen("freeforce");
  }
  
  else if (isDist){
    resetScreen("dist");
    drawScreen("dist");
  }
  else if (isDistFree){
    if (isFirstRun){  
      resetScreen("freedist");
    }
    drawScreen("freedist");
  }
  else if (isDistIncRun){
    if (isFirstRun){
      resetScreen("distincrun");
    }
    drawScreen("distincrun");
  }
  else if (isDistInc){
    if (isFirstRun){
    resetScreen("distinc");
  }
  drawScreen("distinc");
  }
  else{
    println("You broke the code :(");  
  }
}