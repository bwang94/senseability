class CurveBar{
  float xStart;
  float yStart;
  float barwidth;
  float barheight;
  float anglestart;
  float angleend;
  
  int red;
  int green;
  int blue;
  int shade;
  
  int thickness;
  
  CurveBar(float x, float y, float h, float w, float start, float end){
    xStart = x;
    yStart = y;
    barheight = h;
    barwidth = w;
    anglestart = start;
    angleend = end;
    shade = 0;
    red = green = blue = 0;
    thickness = default_thickness;
  }
  
  CurveBar(float x, float y, float h, float w, float start, float end, int r, int g, int b){
    xStart = x;
    yStart = y;
    barheight = h;
    barwidth = w;
    anglestart = start;
    angleend = end;
    shade = 0;
    red = r;
    blue = b;
    green = g;
    thickness = default_thickness;
  }
  
  CurveBar(float x, float y, float h, float w, float start, float end, int s){
    xStart = x;
    yStart = y;
    barheight = h;
    barwidth = w;
    anglestart = start;
    angleend = end;
    red = green = blue = 0;
    shade = s;
    thickness = default_thickness;
  }
  
  void changeThickness(int t){
    thickness = t;
  }
  
  void changeShade(int s){
    shade = s;  
  }
  
  void changeColor(int r, int g, int b){
    red = r;
    blue = b;
    green = g;
  }
  
  void changeAngleStart(float newStart){
    anglestart = newStart;
  }
  
  void changeAngleEnd(float newEnd){
    angleend = newEnd;
  }
  
  void drawCurve(){
    noFill();
    strokeWeight(thickness);
    stroke(red,green,blue);
    arc(xStart,yStart,barwidth, barheight,anglestart,angleend);
  } 
  
  float getAngleStart(){
    return anglestart;
  }
  
  float getAngleEnd(){
    return angleend;
  }
}