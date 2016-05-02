VScrollbar vs1, vs2;  //names vs1 and vs2 as variables of type Vscrollbar

void setup()
{
  size(200, 200);     //size of display
  noStroke();      
  vs1 = new VScrollbar(10, 0, 20, height, 1);    //Creates new object from the class Vscrollbar. Sets parameters for scroll button
  vs2 = new VScrollbar(width-10, 0, 20, height, 1);
}

void draw()
{
  background(255);
  
  // Get the position of the left scrollbar
  // and convert to a value to display the left image 
  //float leftPos = vs1.getPos();  //-height+150;
  //fill(255);
    //image(left, 0, height/2-leftWidth/2 + leftPos*2);
  
  // Get the position of the right scrollbar
  // and convert to a value to display the right image
  //float rightPos = vs2.getPos();  //-width/2;
  //fill(255);
    //image(right, leftWidth, height/2-rightWidth/2 + rightPos*2);
 
  vs1.update();
  vs2.update();
  vs1.display();
  vs2.display();
}

class VScrollbar
{
  int swidth, sheight;    // width and height of bar
  int xpos, ypos;         // x and y position of bar
  float spos, newspos;    // x position of slider
  int sposMin, sposMax;   // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  VScrollbar (int xp, int yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int heighttowidth = sh - sw;
    ratio = (float)sh / (float)heighttowidth;
    xpos = xp-swidth/2;
    ypos = yp;
    spos = ypos + sheight/2 - swidth/2;
    newspos = spos;
    sposMin = ypos;
    sposMax = ypos + sheight - swidth;
    loose = l;
  }

  void update() {
    if(over()) {
      over = true;
    } else {
      over = false;
    }
    if(mousePressed && over) {
      locked = true;
    }
    if(!mousePressed) {
      locked = false;
    }
    if(locked) {
      newspos = constrain(mouseY-swidth/2, sposMin, sposMax);
    }
    if(abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  int constrain(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }

  boolean over() {
    if(mouseX > xpos && mouseX < xpos+swidth &&
    mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    fill(255);
    rect(xpos, ypos, swidth, sheight);
    if(over || locked) {
      fill(255, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    rect(xpos, spos, swidth, swidth);
  }

  //float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    //return spos * ratio;
  //}
}