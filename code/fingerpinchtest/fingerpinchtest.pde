import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

Serial port = null;
PFont f;
PFont F;

Button btn_serial_up;              // move up through the serial port list
Button btn_serial_dn;              // move down through the serial port list
Button btn_serial_connect;         // connect to the selected serial port
Button btn_serial_disconnect;      // disconnect from the serial port
Button btn_serial_list_refresh;    // refresh the serial port list
String serial_list;                // list of serial ports
int serial_list_index = 0;         // currently selected serial port 
int num_serial_ports = 0;          // number of serial ports in the list

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
float forcelimit = 50;

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
float mindlh = 90;
float maxdlh_trun;
float mindlh_trun;

float drh;
float drh_trun;
float drhdraw = 0;
float resist_drh;
float maxdrh = 0;
float mindrh = 90 ;
float maxdrh_trun;
float mindrh_trun;

//Set up curved bars
CurveBar distbar_left;
CurveBar distbar_right;
  
CurveBar coverbar_left;
CurveBar coverbar_right;

ScrollBar startforcebar;
ScrollBar endforcebar;

ScrollBar startdistbar;
ScrollBar enddistbar;

//Set up Tests
PinchTest fingerpinchtest;

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
float drh_xstart = 1100;
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
int drh_textx = 990;
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
boolean isMain = false;
boolean isFirstRun = true;
boolean isPortSelect = true;

//Coloring clicked on boxes
boolean colorBox10 = false;
boolean colorBox20 = false;
boolean colorBox30 = false;
boolean colorBoxLeft = false;
boolean colorBoxRight = false;
boolean colorBoxClose = false;
boolean colorBoxMiddle = false;
boolean colorBoxFar = false;
boolean colorBoxRandom = false;

boolean colorBox10d = false;
boolean colorBox20d = false;
boolean colorBox30d = false;
boolean colorBoxLeftd = false;
boolean colorBoxRightd = false;

//Variables defining button dimensions and locations
int incforce_x = 300;
int incforce_y = 275;
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
int freeforce_y = 275;
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

int distinc_x = 300;
int distinc_y = 275;
int distinc_width = 200;
int distinc_height = 100;

int distfree_x = 700;
int distfree_y = 275;
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

int random_x = 645;
int random_xdist = 795;
int random_y = 385;
int randomwidth = 200;
int randomheight = 50;

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
int leftd_x = 260;
int leftd_y = 150;
int rightd_x = 260;
int rightd_y = 325;
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
int x_10d = 575;
int y_10d = 150;
int x_20d = 575;
int y_20d = 250;
int x_30d = 575;
int y_30d = 350;
int num_height = 50;
int num_width = 50;
void setup(){
  // get the list of serial ports on the computer
  serial_list = Serial.list()[serial_list_index];
  
  //println(Serial.list());
  //println(Serial.list().length);
  
  // get the number of serial ports in the list
  num_serial_ports = Serial.list().length;
  //port = new Serial(this,Serial.list()[0],115200);
  size(1200,700);
  frameRate(120);
  f = createFont("EuphemiaUCAS",32,true);
  F = createFont("EuphemiaUCAS Bold",32,true);
  //println(arduino.list());
  background(255);
  
  distbar_left = new CurveBar(dlh_xstart, dist_ystart, distdraw_width, distdraw_height, anglestart_left, angleend_left);
  distbar_right = new CurveBar(drh_xstart, dist_ystart, distdraw_width, distdraw_height, anglestart_right, angleend_right);
  
  fingerpinchtest = new PinchTest(2000,10000);
  fingerpinchtest.setMode("Increment");
  
  startforcebar = new ScrollBar(690,150,20,200,1);
  endforcebar = new ScrollBar(800,150,20,200,1);
  startdistbar = new ScrollBar(833,150,20,200,1);
  enddistbar = new ScrollBar(950,150,20,200,1);
  btn_serial_up = new Button("^",force_x,force_y,50,30);
  btn_serial_dn = new Button("v",force_x, force_y +40, 50, 30);
  btn_serial_connect = new Button("Connect", force_x + 200, force_y-50, 150, 75);
  btn_serial_list_refresh = new Button("Refresh",force_x + 200, force_y+50, 150,75); 
}

void draw(){
  textFont(f,32);
  if (isPortSelect){
    drawScreen("portselect");  
  }
  else if (isMain){
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

class Button {
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w;    // width of button
  float h;    // height of button
  
  // constructor
  Button(String labelB, float xpos, float ypos, float widthB, float heightB) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }
  
  // draw the button in the window
  void Draw() {
    if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h){
      fill(60,144,160);
    }
    else{
      fill(70,129,105);
    }    
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(255);
    text(label, x + (w / 2), y + (h / 2));
  }
  
  // returns true if the mouse cursor is over the button
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}
void DrawTextBox(String title, String str, int x, int y, int w, int h){
    fill(255);
    rect(x, y, w, h);
    fill(0);
    textAlign(LEFT);
    textSize(14);
    text(title, x + 10, y + 10, w - 20, 20);
    textSize(12);  
    text(str, x + 10, y + 40, w - 20, h - 10);
  }