// SUMMARY: Reads the serial, cleans the input from serial, calculates all force and distance values, and assigns them to their respective variables

void serialEvent(Serial port){
  String inData = port.readStringUntil('\n');
  inData = cleanData(inData);
  //println(inData);
  
  // Find index positions that indicate where each flt/distance value starts
  // inData will have the flt/distance values in the following order: FLT, FRT, FLF, FRF, DLH, DRH
  if (inData.length() >= 8){
  flt_index = inData.indexOf("FLT"); //Force Left Thumb
  frt_index = inData.indexOf("FRT"); //Force Right Thumb
  dist_index = inData.indexOf("DLH");
  distright_index = inData.indexOf("DRH");
  
  // Get the resistances and calculate the forces
  // Calculate force, mapped force, and max force values
  if (isForce || isIncrement){
    resist_flt = float(inData.substring(flt_index + 3,frt_index));
    resist_frt = float(inData.substring(frt_index + 3,dist_index));
    computeForce(); 
  }
  if (isDist){
    resist_dlh = float(inData.substring(dist_index + 3,distright_index));
    float temp_dlh = resist_dlh;
    if (Float.isNaN(temp_dlh)){
      resist_dlh = 0;
    }
    resist_drh = float(inData.substring(distright_index + 3));
    float temp_drh = resist_drh;
    if (Float.isNaN(temp_drh)){
      resist_drh = 0;
    }
    computeDist();
  }
  }
}