void serialEvent(Serial port){
  String inData = port.readStringUntil('\n');
  if (inData == null){
    return;
  }
  if (inData.isEmpty()){
    return;
  }   
  inData = trim(inData);
  if(inData.length() <= 0){
    return;
  }
  if (int(inData) == 0){
    force = 0;
    forcedraw = map(force, 0, 150, 0, height - textheight);
  }
  if (float(inData) > 0){
    force = k/(pow(float(inData),c));
    forcedraw = map(force, 0, 150, 0, height - textheight);
    resist = float(inData);
  }
  if (force > maxforce){
    maxforce = force;
  }
}
