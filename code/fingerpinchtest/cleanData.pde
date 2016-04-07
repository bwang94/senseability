// SUMMARY: cleanData makes sure the input is not null, not empty, non-zero, and readable.

String cleanData(String data){
  if (data == null){
    return "";
  }
  if (data.isEmpty()){
    return "";
  }   
  data = trim(data);
  if(data.length() <= 0){
    return "";
  }
  if(data.indexOf("FLT") == -1 || data.indexOf("FRT") == -1 || data.indexOf("DLH") == -1){
    return "";
  }
  //println("Cleaned");
  return data;
}