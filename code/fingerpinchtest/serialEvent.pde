// SUMMARY: Reads the serial, cleans the input from serial, calculates all force and distance values, and assigns them to their respective variables

void serialEvent(Serial port){
  String inData = port.readStringUntil('\n');
  inData = cleanData(inData);
  println(inData);
  
  // Find index positions that indicate where each flt/distance value starts
  // inData will have the flt/distance values in the following order: FLT, FRT, FLF, FRF, DLH, DRH
  if (inData.length() >= 8){
  flt_index = inData.indexOf("FLT"); //Force Left Thumb
  frt_index = inData.indexOf("FRT"); //Force Right Thumb
  //println("Got indices");
  
  // Get the resistances and calculate the forces
  resist_flt = float(inData.substring(flt_index + 3,frt_index)); //TODO: Blackbox this and the next line
  resist_frt = float(inData.substring(frt_index + 3));
  //println("Got resistances");
  
  // Calculate force, mapped force, and max force values
  computeForce(); 
  }
}