import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

Serial port;
PFont f;

float force;
float force_trun;
float forcedraw;
float resist;
float maxforce = 0;
float maxforce_trun;

float k = 54725.2;
float c = 1.2054;
int textheight = 200;
int textwidth = 250;
int forcelimit = 100;

int xPos = 1;
int lastxPos = 1;
int lastheight = 350;
float xposA = 200;
float xposB = 850;

int scrn_width = 1200;
int scrn_height = 700;


void setup(){
  port = new Serial(this,Serial.list()[3],57600);
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
  
  fill(255);
  beginShape();
  noStroke();
  rect(0,300,textwidth,textheight);
  fill(0);
  endShape();
  text("Force (N)",30,350);
  force_trun = truncate(force);
  text(str(force_trun),30,380);
  text("Max (N)",30,410);
  maxforce_trun = truncate(maxforce);
  text(str(maxforce_trun),30,440);
  
  fill(255);
  beginShape();
  noStroke();
  rect(600,300,textwidth,textheight);
  fill(0);
  endShape();
  text("Force (N)",630,350);
  force_trun = truncate(force);
  text(str(force_trun),630,380);
  text("Max (N)",630,410);
  maxforce_trun = truncate(maxforce);
  text(str(maxforce_trun),630,440);
  
  drawBar(0,200,forcedraw);
  drawBar(1,200,forcedraw);
  
  rect(scrn_width/2,scrn_height/2 - 50,5,scrn_height/2 + 50);   //divider line
  fill(0);
  
  //**Line Graph*************//
  
  stroke(0,0,0);
  strokeWeight(2);
  line(lastxPos, lastheight, xPos,height/2 -100 - forcedraw);
  lastxPos = xPos;
  lastheight = int(height/2 -100 - forcedraw);
  if (xPos >= width){
   xPos = 0;
   lastxPos = 0;
   background(255);
  }
  else{
  xPos++;
  }
  if (forcedraw == 0){
  lastheight = height/2 -100;
  }
  println(forcedraw);
}