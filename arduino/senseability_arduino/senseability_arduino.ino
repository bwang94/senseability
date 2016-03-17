int analogPin = 0;
double r_cutoff = 100000;
double val = 0;
double v_in = 5;
double r_m = 4700;
double voltage = 0;
double r = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(57600);
  pinMode(analogPin,INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  val = (double) analogRead(analogPin); //Gets the voltage value from analog pin 0 (on a scale of 0 to 1023)
  voltage = val/1023*v_in; //Converts val to voltage in volts
  r = r_m * v_in/voltage - r_m; //Calculate resistance of FSR from voltage
  if (r > r_cutoff) //Ignore all resistance values above 100kohm
  {
    r = 0;
  }
  Serial.println(r);
}
