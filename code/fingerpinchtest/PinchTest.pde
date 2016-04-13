class PinchTest{
  String type; //Force or Angle
  String mode; //Increment, Random, or Custom
  
  String hand;
  int numrounds;
  int currentround;
  float currentroundtarget;
  int passcounter;
  boolean passround;
  int roundduration; // In milliseconds, how much time a user needs to hold the force/angle within tolerance of currentroundtarget to pass the round
  int timeoutduration; // In milliseconds, how long each round will last before moving on
  int starttime; // In ms;
  int currenttime; // In ms
  int numskips; //Number of rounds skipped;
  int skipcutoff; //Number of rounds that, when skipped, will cause test to end;
  float[] roundtargets;
  float tolerance; // What tolerance level is in decimal form
  int inthresholdstart;
  boolean testStarted = false;
  boolean testCompleted = false;
  boolean roundStarted = false;
  boolean meetingTarget = false;
  int timemet = 0;
  int timeelapsed = 0;
  int mettimestart = 0;
  int resetstarttime = 0;
  int teststarttime = 0;
  
  //TODO - PAUSE DURATION
  
  PinchTest(String t, String m){
    type = t;
    mode = m;
    currentround = 0;
    //Finish this
  }
  
  PinchTest(String t, String m, int rounds, int duration){
    type = t;
    mode = m;
    numrounds = rounds;
    roundduration = duration;
    currentround = 0;
  }
  
  PinchTest(String t, String m, String h, int rounds, int duration, float start, float increment, float tol, int tod){ //Force OR Angle and Increment
    type = t;
    mode = m;
    hand = h;
    numrounds = rounds;
    roundduration = duration;
    timeoutduration = tod;
    tolerance = tol;
    currentround = 1;
    passcounter = 0;
    numskips = 0;
    skipcutoff = -1;
    
    if (this.testType().equals("Force")){
      roundtargets = new float[rounds]; //Makes the roundtargets array of length rounds
      for (int i = 0; i < rounds; i++){
        roundtargets[i] = start + float(i) * increment;  //Sets each of the elements in the roundtargets array
      }
    }
  }
  
  void startTest(){
    testStarted = true;
    teststarttime = millis();
  }
  
  boolean isRoundStarted(){
    if (roundStarted){
      return true;
    }
    else{
      return false;
    }
  }
  
  void startRound(){
    roundStarted = true;
    currentroundtarget = roundtargets[currentround - 1];
    starttime = millis();
    resetstarttime = millis();
  }
  
  void checkTarget(){
    currenttime = millis();
    if (hand.equals("Left")){
      if (flt >= (currentroundtarget*(1-tolerance)) && flt <= (currentroundtarget*(1+tolerance))){
         meetingTarget =  true;
         timemet = currenttime - resetstarttime;
      }
      else{
        meetingTarget = false;
        timemet = 0;
        resetstarttime = currenttime;
      }          
    }
    if (hand.equals("Right")){
      if (frt >= (currentroundtarget*(1-tolerance)) && frt <= (currentroundtarget*(1+tolerance))){
         meetingTarget =  true;
         timemet = currenttime - resetstarttime;
      }
      else{
        meetingTarget = false;
        timemet = 0;
        resetstarttime = currenttime;
      }          
    }      
  }
  
  void displayMessage(){
    //TODO - Will dynamically display a message based on what the current situation is  
  }
  
  boolean checkRoundComplete(){
    boolean isRoundComplete = false;
    currenttime = millis();
    if (currenttime - starttime >= timeoutduration){
      isRoundComplete = true;
      numskips++;
      timemet = 0;
    }
    if (timemet >= roundduration){
      isRoundComplete = true;  
      passcounter++;
      timemet = 0;
    }
    return isRoundComplete;
  }
  
  void nextRound(){
    currentround++;
    roundStarted = false;
    //TODO WHAT IF NUMSKIPS > SKIPCUTOFF
  }
  
  boolean checkTestComplete(){
    if (currentround > numrounds){
      return true;
    }
    else{
      return false;
    }
  }
  
  void drawForceBar(){
    if (type.equals("Force") && hand.equals("Left")){
      fill(255);
      beginShape();
      noStroke();
      rect(0,300,textwidth,textheight);
      fill(0);
      endShape();
      text("Force (N)",30,350);
      flt_trun = truncate(flt);
      text(str(flt_trun),30,380);
      text("Target (N)",30,410);
      text(str(currentroundtarget),30,440);
      drawBar(0,200,fltdraw);
    }
    if (type.equals("Force") && hand.equals("Right")){
      fill(255);
      beginShape();
      noStroke();
      rect(600,300,textwidth,textheight);
      fill(0);
      endShape();
      text("Force (N)",630,350);
      frt_trun = truncate(frt);
      text(str(frt_trun),630,380);
      text("Max (N)",630,410);
      maxfrt_trun = truncate(maxfrt);
      text(str(maxfrt_trun),630,440);
      drawBar(1,200,frtdraw);
    }
  }
  
  void drawCurrentTarget(){
    if (type.equals("Force") && hand.equals("Left")){
      float drawtarget = map(currentroundtarget, 0, forcelimit, 0, height/2 - 50);
      fill(100);
      rect(xposA - 30, height - drawtarget, 260, 5);
    }
    else if (type.equals("Force") && hand.equals("Right")){
      float drawtarget = map(currentroundtarget, 0, forcelimit, 0, height/2 - 50);
      fill(100);
      rect(xposB - 30, height - drawtarget, 260, 5);
    }
    
  }
  
  void displayTimeElapsed(){
    timeelapsed = millis() - teststarttime;
    float timesec = truncate(float(timeelapsed/1000));
    if (type.equals("Force") && hand.equals("Left")){
      text("Time (s)",30,470);
      text(str(timesec),30,500);
    }
    //TODO: Right Hand
  }
  
  void endTest(){
    testStarted = false;
    testCompleted = true;
  }
  
  void displaySummary(){
    background(255);
    beginShape();
    noStroke();
    fill(255);
    rect(0,300,300,200);
    endShape();
    fill(0);
    text("Total Rounds:",30,300);
    text(str(numrounds),30,330);
    text("Rounds Passed:",30,360);
    text(str(passcounter),30,390);
    text("Rounds Skipped:",30,420);    
    text(str(numskips),30,450);
  }
  
  int getNumRounds(){
    return numrounds;
  }
  
  String testType(){
    return type;  
  }
  
  String whichHand(){
    return hand;
  }
  
  boolean isActive(){
    return testStarted;
  }
  boolean isCompleted(){
    return testCompleted;
  }
}