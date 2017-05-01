void mousePressed(){
  if (isPortSelect){
    if (btn_serial_up.MouseIsOver()) {
    if (serial_list_index > 0) {
      // move one position up in the list of serial ports
      serial_list_index--;
      serial_list = Serial.list()[serial_list_index];
    }
  }
  // down button clicked
  if (btn_serial_dn.MouseIsOver()) {
    if (serial_list_index < (num_serial_ports - 1)) {
      // move one position down in the list of serial ports
      serial_list_index++;
      serial_list = Serial.list()[serial_list_index];
    }
  }
  // Connect button clicked
  if (btn_serial_connect.MouseIsOver()) {
    if (port == null) {
      // connect to the selected serial port
      port = new Serial(this, Serial.list()[serial_list_index], 115200);
      isPortSelect = false;
      isMain = true;
      port.clear();
      port.bufferUntil('\n');
    }
  }
  //// Disconnect button clicked
  //if (btn_serial_disconnect.MouseIsOver()) {
  //  if (port != null) {
  //    // disconnect from the serial port
  //    port.stop();
  //    port = null;
  //  }
  //}
  // Refresh button clicked
  if (btn_serial_list_refresh.MouseIsOver()) {
    // get the serial port list and length of the list
    serial_list = Serial.list()[serial_list_index];
    num_serial_ports = Serial.list().length;
  }
  }
}