boolean firstlineiscomment (String [] stin){
   boolean bout = false; 
   boolean isnotspace = false;
  for (int i=0; i<stin[0].length();i++) {
    if (stin[0].charAt(i)!='/') if(!isnotspace)  bout = true;
    if (stin[0].charAt(i)!=' ') isnotspace = true;
  }
  bout = !bout;
  return bout;
}
boolean lineiscomment(String stin){
     boolean bout = false; 
   boolean isnotspace = false;
  for (int i=0; i<stin.length();i++) {
    if (stin.charAt(i)!='/') if(!isnotspace)  bout = true;
    if (stin.charAt(i)!=' ') isnotspace = true;
  }
  bout = !bout;
  return bout;
  
}
boolean isclass(String [] stin) {
  boolean bout = false;
  if (stin.length>0) if (!firstlineiscomment(stin)) if (stin[0].contains("class"))bout = true; 
  return bout;
}
boolean isfunction(String [] stin) {
  boolean bout = false;
  if (stin.length>0) if (!firstlineiscomment(stin))if (!isclass(stin))if (stin[0].contains("{")) if (!stin[0].contains("=")) bout = true; 
  return bout;
}
boolean isdecla(String [] stin) {
  boolean bout = false;
  if (!firstlineiscomment(stin)) if (!isclass(stin)&&!isfunction(stin)) bout = true;
  return bout;
}
