class ScrollBar{
  int barwidth, barheight; //width/height of bar
  int barx, bary; //x and y position of bar
  float slidery, newslidery; //x position of slider
  int sliderMin, sliderMax; //max/min values of slider
  int howloose; //how loose/heavy
  boolean isOver; // is mouse over slider
  boolean isLocked; //is slider locked
  int barthickness;
  float ratio;
  
  ScrollBar (int xpos, int ypos, int barw, int barh, int loose){
    barwidth = barw;
    barheight = barh;
    int heighttowidth = barh - barw;
    ratio = (float) barh / (float) heighttowidth;
    barx = xpos - barw/2;
    bary = ypos;
    slidery = bary + barheight/2 - barwidth/2;
    newslidery = slidery;
    sliderMin = bary;
    sliderMax = bary + barheight - barwidth;
    howloose = loose;
    barthickness = 1;
  }
  
  void updateScrollBar(){
    if(isOverSlider()){
      isOver = true;
    }
    else{
      isOver = false;
    }
    if(mousePressed && isOver){
      isLocked = true;
    }
    if(!mousePressed){
      isLocked = false;
    }
    if(isLocked){
      newslidery = constrain(mouseY - barwidth/2, sliderMin, sliderMax);
    }
    if(abs(newslidery - slidery) > 1){
      slidery = slidery + (newslidery - slidery)/howloose;  
    }
  }
  
  int constrain(int val, int minval, int maxval){
    return min(max(val,minval),maxval);  
  }
  
  boolean isOverSlider(){
    if (mouseX > barx && mouseX < barx + barwidth && mouseY > bary && mouseY < bary + barheight){
      return true;
    }
    else{
      return false;
    }
  }
  
  void updateDisplay(){
    fill(255);
    stroke(255);
    strokeWeight(1);
    rect(barx, bary, barwidth + barthickness, barheight,3);
    noStroke();
    fill(255);
    textFont(F,26);
    text(String.valueOf(round((-slidery+330)*.111111))+"N",barx-5,bary + 225);
    if (isOver || isLocked){
      fill(60, 144, 160);
    }
    else{
      fill(70,129,105);
    }
    rect(barx + barthickness, slidery, barwidth, barwidth,3);
  }
}