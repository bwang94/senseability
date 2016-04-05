// SUMMARY: Reads the serial, cleans the input from serial, calculates all force and distance values, and assigns them to their respective variables

void serialEvent(Serial port){
  String inData = port.readStringUntil('\n');
  inData = cleanData(inData);
  //println(inData);
  
  // Find index positions that indicate where each flt/distance value starts
  // inData will have the flt/distance values in the following order: FLT, FRT, FLF, FRF, DLH, DRH
  if (inData.length() >= 8){
  dist_index = inData.indexOf("DLH");
  resist_dist = float(inData.substring(dist_index + 3));
  distdraw = map(resist_dist,0,25000,0,height);
  }
}