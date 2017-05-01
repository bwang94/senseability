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
  int starttime; // In ms; Start time of the current round
  int currenttime; // In ms
  int numskips; //Number of rounds skipped;
  int skipcutoff; //Number of rounds that, when skipped, will cause test to end;
  FloatList roundtargets = new FloatList(); //Array that holds targets of each round
  StringList roundresults = new StringList();
  float tolerance; // What tolerance level is 
  float startbound;
  float endbound;
  float increment;
  int inthresholdstart; //Time in ms when the force/angle is within +/- of the threshold of currentroundtarget NOT USED
  boolean testStarted = false; //Has the test started
  boolean testCompleted = false; //Is the test complete
  boolean roundStarted = false; //Has the round started
  boolean roundPassed = false;
  boolean meetingTarget = false; //IS the target currently being met
  boolean goodtostart = false;
  int timemet = 0; ///How much time the target is being met in ms
  int timeelapsed = 0; //How much time has passed in ms since test started
  int mettimestart = 0; //What time the target started to be met in ms NOT USED
  int resetstarttime = 0; //Time of the last reset (when the force/angle fell out of threshold)
  int teststarttime = 0; //Time when test started in ms
  int lastroundcompletetime = 0;
  int timesinceroundcomplete = 0;
  int messagedisplaytime = 0;
  int errorstarttime = 0;
  int errordisplaytime = 0;
  
  int forcetestpos;
  
  Table testdata; //Columns headers: round #, target, was target met, time spent on target, total elapsed time
  //TODO - PAUSE DURATION
  
  PinchTest(String t, String m){
    type = t;
    mode = m;
    currentround = 1;
    passcounter = 0;
    numskips = 0;
    skipcutoff = -1;
    forcetestpos = -1;
    testdata = new Table();
    testdata.addColumn("Round");
    testdata.addColumn("Target");
    testdata.addColumn("PassSkip");
    testdata.addColumn("TimeOnTarget");
    testdata.addColumn("TotalTime");
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
  PinchTest(String t, String m, String h, int rounds, int duration, int tod){ 
    type = t;
    mode = m;
    hand = h;
    numrounds = rounds;
    roundduration = duration;
    timeoutduration = tod;
    currentround = 1;
    passcounter = 0;
    numskips = 0;
    skipcutoff = -1;
    forcetestpos = -1;
  }
  
  PinchTest(int duration, int tod){
    roundduration = duration;
    timeoutduration = tod;
    currentround = 1;
    passcounter = 0;
    numskips = 0;
    skipcutoff = -1;
    forcetestpos = -1;
    hand = "";
    type = "";
    mode = "";
    numrounds = 0;
    messagedisplaytime = 3000;
    errordisplaytime = 3000;
  }
  
  void setBounds(float min, float max){
    startbound = min;
    endbound = max;
  }
  
  void setTolerance(){
    if (this.testType().equals("Distance")){
      tolerance = 2.5;
    }
    else{
      tolerance = 1;
    }
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
        if (startbound > endbound){
          roundtargets.append(truncate(random(endbound,startbound)));
        }
        else{
          roundtargets.append(truncate(random(startbound,endbound)));
        }
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
    testdata.addRow();
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
    if (type.equals("Force")){
      if (hand.equals("Left")){
        if (flt >= (currentroundtarget-tolerance) && flt <= (currentroundtarget+tolerance)){
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
        if (frt >= (currentroundtarget-tolerance) && frt <= (currentroundtarget+tolerance)){
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
    else if (type.equals("Distance")){
      if (hand.equals("Left")){
        if (dlh >= (currentroundtarget-tolerance) && dlh <= (currentroundtarget+tolerance)){
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
        if (drh >= (currentroundtarget-tolerance) && drh <= (currentroundtarget+tolerance)){
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
    else{
      
    }
  }
  
  void displayMessage(){
    fill(255);
    rect(width/2-125,200-25,150,50);
    fill(0);
    if (roundresults.get(currentround-2).equals("Pass")){
      text("Round Passed!",width/2-100,200);
    }
    else if (roundresults.get(currentround-2).equals("Skip")){
      text("Round Skipped.",width/2-100,200);
    }
    else{
      
    }
  }
  
  boolean shouldDisplayMessage(){
    timesinceroundcomplete = millis() - lastroundcompletetime;
    if(currentround > 1 && timesinceroundcomplete <= messagedisplaytime){
      return true;
    }
    else{
      return false;  
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
      roundresults.append("Skip");
      //NEW 7.1.16
      testdata.setInt(currentround - 1, "Round", currentround);
      testdata.setFloat(currentround - 1, "Target", currentroundtarget);
      testdata.setString(currentround - 1, "PassSkip", "Skip");
      testdata.setInt(currentround - 1, "TimeOnTarget", timeoutduration);
      testdata.setInt(currentround - 1, "TotalTime", currenttime - teststarttime);
      //END NEW 7.1.16
      //println("Round results size " + roundresults.size());
    }
    if (timemet >= roundduration){
      isRoundComplete = true;  
      passcounter++;
      timemet = 0;
      roundPassed = true;
      roundresults.append("Pass");
      //NEW 7.1.16
      testdata.setInt(currentround - 1, "Round", currentround);
      testdata.setFloat(currentround - 1, "Target", currentroundtarget);
      testdata.setString(currentround - 1, "PassSkip", "Pass");
      testdata.setInt(currentround - 1, "TimeOnTarget", currenttime - starttime);
      testdata.setInt(currentround - 1, "TotalTime", currenttime - teststarttime);
      //NEW 7.1.16
      //println("Round results size " + roundresults.size());
    }
    if (isRoundComplete){
      lastroundcompletetime = millis();
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
      text(str(truncate(currentroundtarget)),30,440);
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
      text(str(truncate(currentroundtarget)),630,440);
      drawBar(1,200,frtdraw);
    }
  }
  
  void drawDistCurve(){
   if (type.equals("Distance") && hand.equals("Left")){
    fill(255);
    rect(0,height/2-50,width, height/2+50);
    beginShape();
    noStroke();
    makeButton(dlh_textx,dist_texty,textwidth_dist,textheight_dist,"Left Hand",255,255,255,255,255,255,0);
    fill(0);
    dlh_trun = truncate(dlh);
    text(str(dlh_trun) + "\u00b0",dlh_textx + text_x_pad,dist_texty+90);
    endShape(); 
    text("Target (\u00b0)",30,590);
    text(str(truncate(currentroundtarget)),30,625);
    float temp_start = map(dlh,0,90,0,PI/2);
    distbar_left.changeAngleStart(2*PI - temp_start);
    distbar_left.changeColor(0,0,0);
    distbar_left.drawCurve();
   }
   if (type.equals("Distance") && hand.equals("Right")){
    fill(255);
    beginShape();
    noStroke();
    makeButton(drh_textx,dist_texty,textwidth_dist,textheight_dist,"Right Hand",255,255,255,255,255,255,0);
    fill(0);
    drh_trun = truncate(drh);
    text("Target (\u00b0)",1000,590);
    text(str(drh_trun) + "\u00b0",drh_textx + text_x_pad,dist_texty+90);
    text(str(truncate(currentroundtarget)),1000,625);
    endShape(); 
    float temp_end = map(drh,0,90,0,PI/2);
    distbar_right.changeAngleEnd(PI + temp_end);
    distbar_right.changeColor(0,0,0);
    distbar_right.drawCurve();
   }
  }
  
  void drawCurrentTarget(){
    float thickness = 10;
    if (type.equals("Force") && hand.equals("Left")){
      float drawtarget = map(currentroundtarget, 0, forcelimit, 0, height/2 - 50);
      this.chooseTargetColor();
      rect(xposA - 30, height - drawtarget - thickness/2, 260, thickness);
    }
    else if (type.equals("Force") && hand.equals("Right")){
      float drawtarget = map(currentroundtarget, 0, forcelimit, 0, height/2 - 50);
      this.chooseTargetColor();
      rect(xposB - 30, height - drawtarget - thickness/2, 260, thickness);
    }
    //we know radius of the curvebar is 700 units
    //We know xpos of curvebars are 100 and 1100, respectively
    //Center of currenttarget line should be at ypos of 700*sin(angle) from bottom and xpos of 700*cos(angle) from xpos start of curvebar
    //Start of line should be at centerx - 50*sin(angle), center y - 50*cos(angle)
    //End of line is just + instead of -
    
    if (type.equals("Distance") && hand.equals("Left")){
      float targetcenter_x = dlh_xstart + distdraw_width/2*cos(radians(currentroundtarget));
      float targetcenter_y = height - distdraw_height/2*sin(radians(currentroundtarget));
      float targetstart_x = targetcenter_x - 50*cos(radians(currentroundtarget));
      float targetstart_y = targetcenter_y + 50*sin(radians(currentroundtarget));
      float targetend_x = targetcenter_x + 50*cos(radians(currentroundtarget));
      float targetend_y = targetcenter_y - 50*sin(radians(currentroundtarget)); 
      this.chooseTargetColor();
      strokeWeight(15);
      line(targetstart_x,targetstart_y,targetend_x,targetend_y);
      noStroke();
    }
    else if (type.equals("Distance") && hand.equals("Right")){
      float targetcenter_x = drh_xstart - distdraw_width/2*cos(radians(currentroundtarget));
      float targetcenter_y = height - distdraw_height/2*sin(radians(currentroundtarget));
      float targetstart_x = targetcenter_x - 50*cos(radians(currentroundtarget));
      float targetstart_y = targetcenter_y - 50*sin(radians(currentroundtarget));
      float targetend_x = targetcenter_x + 50*cos(radians(currentroundtarget));
      float targetend_y = targetcenter_y + 50*sin(radians(currentroundtarget)); 
      this.chooseTargetColor();
      strokeWeight(15);
      line(targetstart_x,targetstart_y,targetend_x,targetend_y);
      noStroke();
    }
    
  }
  
  void chooseTargetColor(){
    if (this.isMeetingTarget()){
      if (type.equals("Force")){
        fill(102,255,102);
      }
      else{
        strokeWeight(2);
        stroke(102,255,102);
      }
    }
    else{
      if (type.equals("Force")){
        fill(255,102,102);
      }
      else{
        strokeWeight(2);
        stroke(255,102,102);
      }
    }
  }
  void displayTimeElapsed(){
    timeelapsed = millis() - teststarttime;
    float timesec = truncate(float(timeelapsed/1000));
    if (hand.equals("Left")){
      int y = 0;
      if (type.equals("Force")){
        y = 470;
      }
      else{
        y = 530;
      }
      text("Time (s):",30,y);
      text(str(timesec),30,y+30);
    }
    else if (hand.equals("Right")){     
      int x = 0;
      int y = 0;
      if (type.equals("Force")){
        x = 630;
        y = 470;
      }
      else{
        x = 1000;
        y = 530;
      }
      text("Time (s):",x,y);
      text(str(timesec),x,y+30);
    }
  }
  
  void endTest(){
    testStarted = false;
    testCompleted = true;
    roundStarted = false;
    timeelapsed = millis() - teststarttime;
    if (currentround < numrounds){
      numskips++;
    }
  }
  
  void forceEndTest(){
    currenttime = millis();
    testStarted = false;
    testCompleted = true;
    roundStarted = false;
    timeelapsed = millis() - teststarttime;
    if (currentround < numrounds){
      numskips++;
    }
    //NEW 7.1.16
    testdata.setInt(currentround - 1, "Round", currentround);
    testdata.setFloat(currentround - 1, "Target", currentroundtarget);
    testdata.setString(currentround - 1, "PassSkip", "Skip");
    testdata.setInt(currentround - 1, "TimeOnTarget", currenttime - starttime);
    testdata.setInt(currentround - 1, "TotalTime", currenttime - teststarttime);
    //NEW 7.1.16
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
    if (this.testType().equals("Force")){
      forcetestpos = -1;
    }
    numrounds = 0;
    startbound = -1;
    endbound = -1;
    roundresults.clear();
    testdata.clearRows();
  }
  
  void displaySummary(){
    background(255);
    beginShape();
    noStroke();
    fill(255);
    rect(0,0,800,height);
    endShape();
    fill(0);
    text("Time Elapsed (s)",30,240);
    float timefloat = float(timeelapsed);
    float conversion = 1000.0;
    text(str(truncate(timefloat/conversion)),30,270);
    text("Total Rounds:",30,300);
    text(str(passcounter+numskips),30,330);
    text("Rounds Passed:",30,360);
    text(str(passcounter),30,390);
    text("Rounds Skipped:",30,420);    
    text(str(numskips),30,450);
    String postext = "";
    if (type.equals("Force")){
      if (forcetestpos == 1){
        postext = "Close";
      }
      else if (forcetestpos == 2){
        postext = "Middle";
      }
      else{
        postext = "Far";
      }
      text("Test Position:",30,480);    
      text(postext,30,510);
    }
    //NEW 7.1.16
    String filename;
    String fulltype;
    if (type.equals("Force")){
      fulltype = mode + type + postext;
    }
    else{
      fulltype = mode + type;
    }
    filename = String.valueOf(month()) + "_" + String.valueOf(day()) + "_" + String.valueOf(year()) + "_" + String.valueOf(hour()) + "_" + String.valueOf(minute()) + "_" + String.valueOf(second()) + "_" + fulltype + ".csv";
    saveTable(testdata, filename);
    text("Data saved to: " + filename, 30, 540);
    //END NEW 7.1.16
  }
  void displayErrorMessageOn(){
    errorstarttime = millis();  
  }
  int getErrorStartTime(){
    return errorstarttime;
  }
  boolean shouldDisplayError(){
    if (millis() - this.getErrorStartTime() <= errordisplaytime && !goodtostart){
      return true;
    }
    else{
      return false;
    }
  }
  void displayErrorMessage(){
    if (fingerpinchtest.areBoundsEqual()){
        fill(0);
        textFont(F,32);
        text("Please make sure start/stop bounds are not the same",220,507);
        fill(255);
      } 
      else{
        fill(0);
        textFont(F,32);
        text("Please select an option from each column",305,507);
        fill(255);
      }  
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
        goodtostart = true;
        return goodtostart;
      }
      else{
        goodtostart = false;
        return goodtostart;
      }
    }
    else{
      goodtostart = false;
      return goodtostart;
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