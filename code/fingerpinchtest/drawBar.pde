void drawBar(int side, int barWidth, float barHeight){
  float pos = 0;
  String text = "";
  if (side == 0){
    pos = xposA;
    text = "Left Hand";
  }
  if (side == 1){
    pos = xposB;
    text = "Right Hand";
  }
  
  float ypos = height - barHeight;
  //Draw graph and display text
  fill(255);
  rect(pos,400,barWidth,height - barHeight); //Draw white rectangle
  fill(0);
  rect(pos,ypos,barWidth,barHeight); //Draw the force bar
  fill(255);
  rect(pos + 10,300,150,50);
  fill(0);
  text(text,pos + 25,350);
}