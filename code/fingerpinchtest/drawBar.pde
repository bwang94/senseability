//SUMMARY: drawBar draws a bar graph given the side of the screen it should draw, the width, and height of the bar
    
void drawBar(int side, int barWidth, float barHeight){
  float pos = 0;
  int color1;
  int color2;
  int color3;
  String text = "";
  if (side == 0){
    color1 = 137;
    color2 = 69;
    color3 = 69;
    pos = xposA;
    text = "Left Hand (red)";
    fill(255);
    rect(pos,400,barWidth,height - barHeight,5); //Draw white rectangle
    float ypos = height - barHeight;
    fill(color1,color2,color3);
    rect(pos,ypos,barWidth,barHeight,5); //Draw the force bar
  }
  if (side == 1){
    color1 = 60;
    color2 = 118;
    color3 = 150;
    pos = xposB;
    text = "Right Hand (blue)";
    fill(255);
    rect(pos,400,barWidth,height - barHeight,5); //Draw white rectangle
    float ypos = height - barHeight;
    fill(color1,color2,color3);
    rect(pos,ypos,barWidth,barHeight,5); //Draw the force bar  
}
  
  //float ypos = height - barHeight;
  //Draw graph and display text
  //beginShape();
  //fill(255);
  
  //fill(255,0,0);
  //endShape();
  fill(255);
  rect(pos + 10,300,300,70);
  fill(0);
  text(text,pos + 25,350);
}