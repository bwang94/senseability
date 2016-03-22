// SUMMARY: cleanData makes sure the input is not null, not empty, non-zero, and readable.

void cleanData(String data){
  if (data == null){
    return;
  }
  if (data.isEmpty()){
    return;
  }   
  data = trim(data);
  if(data.length() <= 0){
    return;
  } 
}