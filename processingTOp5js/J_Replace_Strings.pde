String changebutline(String txin, String changeit, String changeto, String exception) {
  String tempexeption = "";
  for (int i=0; i<exception.length(); i++) tempexeption+=exception.charAt(i) + "|"; 
  txin = txin.replace(exception, tempexeption);
  txin = txin.replace(changeit, changeto);
  txin = txin.replace(tempexeption, exception);
  return txin;
}
String changetxbutmultiplesline(String txin, String changeit, String changeto, String [] exceptions) {
  String [] tempexeptions = new String [exceptions.length];
  for (int e=0; e<exceptions.length; e++) for (int i=0; i<exceptions[e].length(); i++) tempexeptions[e]+=exceptions[e].charAt(i) + "|"; 
  for (int e=0; e<exceptions.length; e++) txin = txin.replace(exceptions[e], tempexeptions[e]);
  txin = txin.replace(changeit, changeto);
  for (int e=0; e<exceptions.length; e++) txin = txin.replace(tempexeptions[e], exceptions[e]);
  return txin;
}
String changeclosebraketsameline(String txin, String opentext, String newopentext, char newclose) {
  String txout  = txin;
  String [] charsclose = {"{([", "})]"};
  char charopen = opentext.charAt(opentext.length()-1);
  char charclos = ' ';
  for (int i=0; i<charsclose[0].length(); i++) if (charopen == charsclose[0].charAt(i)) charclos = charsclose[1].charAt(i);
  int intopen = -1;
  for (int i=0; i<txout.length()-opentext.length(); i++) {
    boolean textfound = true;
    for (int j=0; j<opentext.length(); j++) if (txout.charAt(i+j)!=opentext.charAt(j)) textfound = false;
    if (textfound) intopen =i+opentext.length()-1;
  }
  int intclose  = -1; 
  int inception = -1;
  if (intopen!=-1) if (charclos!=' ')  for (int i=intopen; i<txout.length(); i++) {
    if (txout.charAt(i) == charopen) inception++;
    if (txout.charAt(i) == charclos) if (inception == 0) intclose = i;
    if (txout.charAt(i) == charclos) inception--;
  }
  if (intclose!=-1)   if (intopen!=-1) if (charclos!=' ') txout = txout.substring(0, intclose)+newclose+txout.substring(intclose+1, txout.length());
  if (intclose!=-1)   if (intopen!=-1) if (charclos!=' ') txout = txout.replace(opentext, newopentext);
  return txout;
}
