  void makeButton(int x, int y, int w, int h, String text, int rectshadeR, int rectshadeG, int rectshadeB, int recthighlightR, int recthighlightG, int recthighlightB, int textshade){
   rect(x-2,y-2,w+4,h+4);
   fill(255);
    if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h){
       fill(recthighlightR, recthighlightG, recthighlightB);
       rect(x,y,w,h);
   }
   else{
       fill(rectshadeR, rectshadeG, rectshadeB);
       rect(x,y,w,h);
   }
   fill(textshade);
   text(text,x + text_x_pad,y + text_y_pad);
}