//SUMMARY: Computes numerical force values, their respective mapped values, and max forces.

void computeForce(){
  // Take care of 0 force values
  if (resist_flt == 0){
    flt = 0;
    fltdraw = map(flt, 0, forcelimit, 0, height/2 - 50);
  }
  if (resist_frt == 0){
    frt = 0;
    frtdraw = map(frt, 0, forcelimit, 0, height/2 - 50);
  }
  
  // Calculate forces
  if (resist_flt > 0){
    flt = k/(pow(resist_flt,c));
    fltdraw = map(flt, 0, forcelimit, 0, height/2 - 50);
  }
  if (resist_frt > 0){
    frt = k/(pow(resist_frt,c));
    frtdraw = map(frt, 0, forcelimit, 0, height/2 - 50);
  }
  
  // Calculate max forces
  if (flt > maxflt){
    maxflt = flt;
  }
  if (frt > maxfrt){
    maxfrt = frt;
  }
}