  void makeButton(int x, int y, int w, int h, String text, int rectshadeR, int rectshadeG, int rectshadeB, int recthighlightR, int recthighlightG, int recthighlightB, int textshade){
   rect(x-4,y-4,w+8,h+8,3);
   fill(255);
    if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h){
       fill(recthighlightR, recthighlightG, recthighlightB);
       rect(x,y,w,h,3);
   }
   else{
       fill(rectshadeR, rectshadeG, rectshadeB);
       rect(x,y,w,h,3);
   }
   fill(textshade);
   textFont(F,40);
   
   if (w == 130 && text.length() == 3){
      text(text,x + text_x130_3pad,y + text_y75_pad);
  }
   else if (w == 130 && text.length() == 5){
      text(text,x + text_x130_5pad,y + text_y75_pad);
  }
  else if (w == 130 && text.length() == 6){
      text(text,x + text_x130_6pad,y + text_y75_pad);
  }
  else if (w == 125 && text.length() == 4){
      text(text,x + text_x125_4pad,y + text_y_pad);
  }
  else if (w == 125 && text.length() == 5){
      text(text,x + text_x125_5pad,y + text_y_pad);
  }
  else if (text.length() >= 9){
      text(text,x + text_x9_pad,y + text_y_pad);
  }
  else if (text.length() >= 8){
    text(text,x + text_x8_pad,y + text_y_pad);
  }
  else if (text.length() >= 6){
      text(text,x + text_x6_pad,y + text_y_pad);
  }
  else if (text.length() >= 5){
      text(text,x + text_x5_pad,y + text_y_pad);
  }
  else if (text.length() >= 4){
      text(text,x + text_x4_pad,y + text_y_pad);
  }
  else if (text.length() >= 3){
      text(text,x + text_x3_pad,y + text_y_pad);
  }
  else if (text.length() >= 2){
      text(text,x + text_x2_pad,y + text_y2_pad);
  }
  else{
       text(text,x + text_x_pad,y + text_y_pad);
     }
  }