String [] corregirformato(String textsep[], String separators) {
  for (int i=0; i<textsep.length; i++) textsep[i]=addspaces(textsep[i], separators);
  for (int i=0; i<textsep.length; i++) textsep[i]=elimdoblespaces(textsep[i], separators);
  for (int i=0; i<textsep.length; i++) textsep[i]=elimspacesentreseparators(textsep[i], separators);
  //for (int i=0; i<textsep.length; i++) stout +=textsep[i]+"\n";
  return textsep;
}
String addspaces (String txin, String separators) {
  StringBuffer sin = new StringBuffer(txin);
  for (int s=0; s<separators.length(); s++) if (separators.charAt(s)!=' ') if (sin.length()>1) for (int i=1; i<sin.length()-1; i++) if (sin.charAt(i)==separators.charAt(s)) {
    if      (sin.charAt(i-1)!=' '&&sin.charAt(i+1)!=' ') sin.replace(i, i+1, " "+separators.charAt(s)+" ");
    else if (sin.charAt(i-1)==' '&&sin.charAt(i+1)!=' ') sin.replace(i, i+1, separators.charAt(s)+" ");
    else if (sin.charAt(i-1)!=' '&&sin.charAt(i+1)==' ') sin.replace(i, i+1, " "+separators.charAt(s));
  }
  if (sin.length()>1) if (sin.charAt(sin.length()-1)==';')  sin.replace(sin.length()-1, sin.length(), " ;");
  return sin.toString();
}
String elimdoblespaces (String txin, String separators) {
  String txout = txin;
  txout = txout.replaceAll("  ", " ");
  return txout;
}
String elimspacesentreseparators (String txin, String separators) {
  String txout = txin;
  for (int i=0; i<separators.length(); i++)  for (int j=0; j<separators.length(); j++) {
    String a = separators.charAt(i)+" "+separators.charAt(j);
    String b = separators.charAt(i)+""+separators.charAt(j);
    txout = txout.replace(a, b);
  }
  return txout;
}
boolean txequal(String a, String b) {
  if (a==null||b==null) return false;
  else {
    int al= a.length();
    int bl= b.length();
    int minl;
    boolean bout = true;
    if (al!=bl) bout = false;
    if (al<bl) minl = al;
    else minl = bl;
    for (int i=0; i<minl; i++) if (a.charAt(i)!=b.charAt(i)) bout = false; 
    return bout;
  }
}
