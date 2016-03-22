//SUMMARY: truncate truncates a float to 2 decimal points

float truncate(float x){
  return round(x*100.0f)/100.0f;
}