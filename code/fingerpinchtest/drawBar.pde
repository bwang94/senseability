void drawBar(int side, int barWidth, float barHeight){
  float pos = 0;
  String text = "";
  if (side == 0){
    pos = xposA;
    text = "Left Side";
  }
  if (side == 1){
    pos = xposB;
    text = "Right Side";
  }
  
  float ypos = height - barHeight;
  //Draw graph and display text
  fill(255);
  rect(pos,400,barWidth,height - barHeight); //Draw white rectangle
  fill(0);
  rect(pos,ypos,barWidth,barHeight); //Draw the force bar
  text(text,pos + 25,350);
}