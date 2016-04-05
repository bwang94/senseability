import processing.serial.*;
import cc.arduino.*;
Arduino arduino;
Serial port;
PFont f;

int dist_index;

float dist;
float dist_trun;
float distdraw;
float resist_dist;

float k = 54725.2;
float c = 1.2054;
int textheight = 200;
int textwidth = 400;

int scrn_width = 1200;
int scrn_height = 700;

int xPos = 1;
int lastxPos = 1;
int lastheight = 0;

void setup(){
  port = new Serial(this,Serial.list()[3],57600);
  port.clear();
  port.bufferUntil('\n');
  size(1200,700);
  //fullscreen();
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
  rect(0,0,textwidth,textheight);
  fill(0);
  endShape();
  text("Potentiometer Resistance (ohm)",30,350);
  dist_trun = truncate(resist_dist);
  text(str(resist_dist),30,380);
  
// Line Graph for left hand
  stroke(255,153,153);
  strokeWeight(2);
  line(lastxPos, lastheight, xPos,height - distdraw);
  lastxPos = xPos;
  lastheight = int(height - distdraw);
  if (xPos >= width){
   xPos = 0;
   lastxPos = 0;
   background(255);
  }
  else{
  xPos++;
  }
  if (distdraw == 0){
  lastheight = 0;
  }
}