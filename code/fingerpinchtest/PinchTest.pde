class PinchTest{
  String type; //Force or Angle
  String mode; //Increment, Random, or Custom
  String hand; //Which hand
  
  int numrounds; //How many rounds in the test
  int currentround; //Which round you currently are on
  float currentroundtarget; //Target of current round
  int passcounter; //Number of rounds passed
  boolean passround; //Has the current round passed
  int roundduration; // In milliseconds, how much time a user needs to hold the force/angle within tolerance of currentroundtarget to pass the round
  int timeoutduration; // In milliseconds, how long each round will last before moving on
  int starttime; // In ms;
  int currenttime; // In ms
  int numskips; //Number of rounds skipped;
  int skipcutoff; //Number of rounds that, when skipped, will cause test to end;
  FloatList roundtargets = new FloatList(); //Array that holds targets of each round
  float tolerance; // What tolerance level is in decimal form
  float startbound;
  float endbound;
  float increment;
  int inthresholdstart; //Time in ms when the force/angle is within +/- of the threshold of currentroundtarget NOT USED
  boolean testStarted = false; //Has the test started
  boolean testCompleted = false; //Is the test complete
  boolean roundStarted = false; //Has the round started
  boolean roundPassed = false;
  boolean meetingTarget = false; //IS the target currently being met
  int timemet = 0; ///How much time the target is being met in ms
  int timeelapsed = 0; //How much time has passed in ms since test started
  int mettimestart = 0; //What time the target started to be met in ms NOT USED
  int resetstarttime = 0; //Time of the last reset (when the force/angle fell out of threshold)
  int teststarttime = 0; //Time when test started in ms
  
  int forcetestpos;
  
  //TODO - PAUSE DURATION
  
  PinchTest(String t, String m){
    type = t;
    mode = m;
    currentround = 1;
    passcounter = 0;
    numskips = 0;
    skipcutoff = -1;
    forcetestpos = -1;
  }
  
  PinchTest(String t, String m, int rounds, int duration){
    type = t;
    mode = m;
    numrounds = rounds;
    roundduration = duration;
    currentround = 1;
    passcounter = 0;
    numskips = 0;
    skipcutoff = -1;
    forcetestpos = -1;
  }
  
  //Force OR Angle Test
  PinchTest(String t, String m, String h, int rounds, int duration, float tol, int tod){ 
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
    forcetestpos = -1;
  }
  
  PinchTest(int duration, float tol, int tod){
    roundduration = duration;
    timeoutduration = tod;
    tolerance = tol;
    currentround = 1;
    passcounter = 0;
    numskips = 0;
    skipcutoff = -1;
    forcetestpos = -1;
    hand = "";
    type = "";
    mode = "";
    numrounds = 0;
  }
  
  void setBounds(float min, float max){
    startbound = min;
    endbound = max;
  }
  
  void setTargets(){
    if (this.testMode().equals("Increment")){
      increment = (endbound - startbound)/(numrounds-1);
      for (int i = 0; i < numrounds; i++){
        roundtargets.append(startbound + float(i) * increment);  //Sets each of the elements in the roundtargets array
      }
    }
    if (this.testMode().equals("Random")){
      for (int i = 0; i < numrounds; i++){
        roundtargets.append(truncate(random(startbound,endbound)));
      }
    }
  }
  
  void setHand(String h){
    hand = h;
  }
  
  void  setType(String t){
    type = t;
  }
  
  void setMode(String m){
    mode = m;
  }
  
  void setForceTestPosition(int p){
    forcetestpos = p;
  }
  
  void setNumRounds(int r){
    numrounds = r;
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
    currentroundtarget = roundtargets.get(currentround - 1);
    starttime = millis();
    resetstarttime = millis();
    roundPassed = false;
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
    fill(255);
    rect(width/2-25,300-25,150,50);
    if (this.didRoundPass()){
      text("Round Passed!",width/2,300);
    }
    else{
      text("Round Skipped.",width/2,300);
    }
  }
  
  boolean checkRoundComplete(){
    boolean isRoundComplete = false;
    currenttime = millis();
    if (currenttime - starttime >= timeoutduration){
      isRoundComplete = true;
      numskips++;
      timemet = 0;
      roundPassed = false;
    }
    if (timemet >= roundduration){
      isRoundComplete = true;  
      passcounter++;
      timemet = 0;
      roundPassed = true;
    }
    return isRoundComplete;
  }
  
  void nextRound(){
    currentround++;
    roundStarted = false;
  }
  
  boolean checkTestComplete(){
    if (currentround > numrounds){
      return true;
    }
    else if (numskips > skipcutoff && skipcutoff != -1){
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
      text("Target (N)",630,410);
      text(str(currentroundtarget),630,440);
      drawBar(1,200,frtdraw);
    }
  }
  
  void drawDistCurve(){
   if (type.equals("Distance") && hand.equals("Left")){
    float temp_start = map(dlh,0,90,0,PI/2);
    distbar_left.changeAngleStart(2*PI - temp_start);
    distbar_left.changeColor(0,0,0);
    distbar_left.drawCurve();
   }
   if (type.equals("Distance") && hand.equals("Right")){
    float temp_end = map(drh,0,90,0,PI/2);
    distbar_right.changeAngleEnd(PI + temp_end);
    distbar_right.changeColor(0,0,0);
    distbar_right.drawCurve();
   }
  }
  
  void drawCurrentTarget(){
    if (type.equals("Force") && hand.equals("Left")){
      float drawtarget = map(currentroundtarget, 0, forcelimit, 0, height/2 - 50);
      if (this.isMeetingTarget()){
        fill(102,255,102);
      }
      else{
        fill(255,102,102);
      }
      rect(xposA - 30, height - drawtarget, 260, 2);
    }
    else if (type.equals("Force") && hand.equals("Right")){
      float drawtarget = map(currentroundtarget, 0, forcelimit, 0, height/2 - 50);
      if (this.isMeetingTarget()){
        fill(102,255,102);
      }
      else{
        fill(255,102,102);
      }
      rect(xposB - 30, height - drawtarget, 260, 2);
    }
    
  }
  
  void displayTimeElapsed(){
    timeelapsed = millis() - teststarttime;
    float timesec = truncate(float(timeelapsed/1000));
    if (type.equals("Force") && hand.equals("Left")){
      text("Time (s):",30,470);
      text(str(timesec),30,500);
    }
    else if (type.equals("Force") && hand.equals("Right")){
      text("Time (s):",630,470);
      text(str(timesec),630,500);
    }
  }
  
  void endTest(){
    testStarted = false;
    testCompleted = true;
    roundStarted = false;
  }
  
  void resetTest(){
    roundtargets.clear();
    testCompleted = false;
    testStarted = false;
    roundStarted = false;
    currentround = 1;
    passcounter = 0;
    numskips = 0;
    hand = "";
    mode = "";
    forcetestpos = -1;
    numrounds = 0;
    startbound = -1;
    endbound = -1;
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
  
  int getCurrentRound(){
    return currentround;
  }
  int getNumRounds(){
    return numrounds;
  }
  
  String testType(){
    return type;  
  }
  
  String testMode(){
    return mode;
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
  boolean isMeetingTarget(){
    return meetingTarget;
  }
  boolean didRoundPass(){
    return roundPassed;
  }
  boolean isReadyToStart(){
    if (numrounds > 0 && hand.length() > 0 && type.length() > 0 && mode.length() > 0 && startbound > -1 && endbound > -1 && !this.areBoundsEqual()){
      if ((type.equals("Force") && forcetestpos > 0) || type.equals("Distance")){ 
        return true;
      }
      else{
        return false;
      }
    }
    else{
      return false;
    }
  }
  boolean areBoundsEqual(){
    if (startbound == endbound){
      return true;
    }
    else{
      return false;
    }
  }
}