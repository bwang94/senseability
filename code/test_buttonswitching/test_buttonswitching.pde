PFont f;

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
boolean isMain = true;
boolean isForce = false;
boolean isDist = false;

void setup(){
  size(1200,700);
  frameRate(120);
  f = createFont("Arial",32,true);
}

void draw(){
  if (isMain){
    background(255);
    textFont(f,32);
    fill(200);
    rect(force_x, force_y, force_width, force_height);
    fill(0);
    text("Force Test",force_x + text_x_pad, force_y + text_y_pad);
    
    fill(200);
    rect(dist_x, dist_y, dist_width, dist_height);
    fill(0);
    text("Dist Test",dist_x + text_x_pad,force_y + text_y_pad);
  }
  if (isForce){
    background(255);
    fill(200);
    rect(force_x, force_y, force_width, force_height);
    fill(0);
    text("Force Test",force_x + text_x_pad, force_y + text_y_pad);
    
    fill(200);
    rect(back_x, back_y, back_width, back_height);
    fill(0);
    text("Go Back", back_x + text_x_pad, back_y + text_y_pad);
  }
  if (isDist){
    background(255);
    fill(200);
    rect(dist_x, dist_y, dist_width, dist_height);
    fill(0);
    text("Dist Test",dist_x + text_x_pad,force_y + text_y_pad);
    
    fill(200);
    rect(back_x, back_y, back_width, back_height);
    fill(0);
    text("Go Back", back_x + text_x_pad, back_y + text_y_pad);
  }
    
}

void mouseClicked(){
  update(mouseX, mouseY);
}

void update(int x, int y){
  if (overTestButton(force_x,force_y,force_width, force_height)){
    isForce = true;
    isMain = false;
    isDist = false;
  }
  else if (overTestButton(dist_x, dist_y, dist_width, dist_height)){
    isForce = false;
    isMain = false;
    isDist = true;
  }
  else if(overTestButton(back_x, back_y, back_width, back_height)){
    isForce = false;
    isMain = true;
    isDist = false;
  }
  else{
    isForce = false;
    isDist = false;
  }
}

boolean overTestButton(int x, int y, int x_width, int y_height){
  if (mouseX >= x && mouseX <= x + x_width && mouseY >= y && mouseY <= y + y_height){
    return true;
  }
  else{
    return false;
  }
}
  