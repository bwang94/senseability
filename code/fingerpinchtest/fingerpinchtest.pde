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
int forcelimit = 150;

int xPos = 1;
int lastxPos = 1;
int lastheight = 0;
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
  fill(255);
  beginShape();
  noStroke();
  rect(0,0,textwidth,textheight);
  fill(0);
  endShape();
  text("Force (N)",30,50);
  force_trun = truncate(force);
  text(str(force_trun),30,80);
  text("Max Force (N)",30,110);
  maxforce_trun = truncate(maxforce);
  text(str(maxforce_trun),30,140);
  stroke(255,255,255);
  strokeWeight(2);
  
  drawBar(0,200,forcedraw);
  drawBar(1,200,forcedraw);
  
  rect(scrn_width/2,0,5,scrn_height);   //divider line
  fill(0);
  
  //line(lastxPos, lastheight, xPos, height - forcedraw);
  //lastxPos = xPos;
  //lastheight = int(height - forcedraw);
  //if (xPos >= width){
    //xPos = 0;
    //lastxPos = 0;
    //background(0);
  //}
  //else{
  //  xPos++;
  //}
  //if (forcedraw == 0){
  //  lastheight = height;
  //}
  //println(resist);
}