// SUMMARY: Reads the serial, cleans the input from serial, calculates all force and distance values, and assigns them to their respective variables

void serialEvent(Serial port){
  String inData = port.readStringUntil('\n');
  cleanData(inData);
  
  // Find index positions that indicate where each flt/distance value starts
  // inData will have the flt/distance values in the following order: FLT, FRT, FLF, FRF, DLH, DRH
  int flt_index = inData.indexOf("FLT"); //Force Left Thumb
  int frt_index = inData.indexOf("FRT"); //Force Right Thumb
  
  // Get the resistances and calculate the forces
  resist_flt = float(inData.substring(flt_index + 3,frt_index)); //TODO: Blackbox this and the next line
  resist_frt = float(inData.substring(frt_index + 3));
  
  // Calculate force, mapped force, and max force values
  computeForce(); 
}