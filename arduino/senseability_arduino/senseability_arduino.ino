int analogPin = 0;
int s_analogPin = 1;
int t_analogPin = 2;
int drh_analogPin = 3;

double r_cutoff = 100000;
double force_left_thumb = 0;
double force_right_thumb = 0;
double distance = 0;
double distance_right = 0;
double v_in = 5;
double r_m = 1000; //4700;
double maxinput = 1023;
double voltage_flt = 0;
double voltage_frt = 0;
double voltage_dist = 0;
double voltage_drh = 0;
double r_flt = 0;
double r_frt = 0; 
double r_dist = 0;
double r_drh = 0;
String toSerial = "";

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  pinMode(analogPin,INPUT);
  pinMode(s_analogPin,INPUT);
  pinMode(t_analogPin,INPUT);
  pinMode(drh_analogPin,INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  force_left_thumb = (double) analogRead(analogPin); //Gets the voltage value from analog pin 0 (on a scale of 0 to 1023)
  force_right_thumb = (double) analogRead(s_analogPin); //Gets voltage value for second FSR
  distance = (double) analogRead(t_analogPin);
  distance_right = (double) analogRead(drh_analogPin);  
  
  voltage_flt = force_left_thumb/maxinput*v_in; //Converts val to voltage in volts
  voltage_frt = force_right_thumb/maxinput*v_in;
  voltage_dist = distance/maxinput*v_in;
  voltage_drh = distance_right/maxinput*v_in;
      
  r_flt = r_m * v_in/voltage_flt - r_m; //Calculate resistance of FSR from voltage
  r_frt = r_m * v_in/voltage_frt - r_m;
  r_dist = r_m * v_in/voltage_dist - r_m;
  r_drh = r_m * v_in/voltage_drh - r_m; 
  if ((r_flt > r_cutoff) || (r_flt < 0)) //Ignore all resistance values above 100kohm
  {
    r_flt = 0;
  }
  if ((r_frt > r_cutoff) || (r_frt < 0))
  {
    r_frt = 0;
  }
  if (r_dist < 0)
  {
    r_dist = 0;
  }
  if ((r_drh < 0) || (r_drh == -26576))
  {
    r_drh = 0;
  }
  toSerial = toSerial + "FLT" + (int) r_flt + "FRT" + (int) r_frt + "DLH" + (int) r_dist + "DRH" + (int) r_drh;
  Serial.println(toSerial);
  toSerial = "";
}
