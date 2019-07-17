String getfirstword(String stin) {
  String []allwords = stin.split(" "); 
  String wordselect = ""; 
  boolean wordselected = false; 
  for (int i=0; i<allwords.length; i++) {
    if (!txequal(allwords[i], "")) if (!wordselected) {
      wordselected = true; 
      wordselect = allwords[i];
    }
  }
  return wordselect;
}
String getfirstwordnotclass(String stin) {
  String []allwords = stin.split(" "); 
  String wordselect = ""; 
  boolean wordselected = false; 
  for (int i=0; i<allwords.length; i++) {
    if (!txequal(allwords[i], "")&&!txequal(allwords[i], "class")) if (!wordselected) {
      wordselected = true; 
      wordselect = allwords[i];
    }
  }
  return wordselect;
}
String getfirstwordnotdeclarations(String stin, String [] declarations,String separators) {
  separators+="[]";
  String []allwords = StringUtils.split(stin, separators); 
  String wordselect = ""; 
  boolean wordselected = false; 
  for (int i=0; i<allwords.length; i++) {
    boolean isdeclaration = false; 
    for (int j=0; j<declarations.length; j++) if (txequal(allwords[i], declarations[j])) isdeclaration = true; 
    if (!isdeclaration) if (!txequal(allwords[i], "")) if (!wordselected) {
      wordselected = true; 
      wordselect = allwords[i];
    }
  }
  return wordselect;
}


String replacetextbetween (String txin, String begg, String end, String newreplace) {
  int begchar = 0;
  int endchar = 0;
  int big = end.length();
  if (begg.length()>end.length()) big = begg.length();
  if (txin.contains(begg)&&txin.contains(end)) for (int i=0; i<txin.length()-big+1; i++) {
    boolean beggi = true;
    for (int j=0; j<begg.length(); j++) if (begg.charAt(j)!=txin.charAt(i+j)) beggi = false;
    if (beggi) begchar = i+begg.length();
    boolean endi = true;
    for (int j=0; j<end.length(); j++) if (end.charAt(j)!=txin.charAt(i+j)) endi = false;
    if (endi) endchar = i;
  }
  String txout =txin.substring(0, begchar) + newreplace+ txin.substring(endchar); 
  return txout;
}
String gettextbetween (String txin, String begg, String end) {
  int begchar = 0;
  int endchar = 0;
  int big = end.length();
  if (begg.length()>end.length()) big = begg.length();
  if (txin.contains(begg)&&txin.contains(end)) for (int i=0; i<txin.length()-big+1; i++) {
    boolean beggi = true;
    for (int j=0; j<begg.length(); j++) if (begg.charAt(j)!=txin.charAt(i+j)) beggi = false;
    if (beggi) begchar = i+begg.length();
    boolean endi = true;
    for (int j=0; j<end.length(); j++) if (end.charAt(j)!=txin.charAt(i+j)) endi = false;
    if (endi) endchar = i;
  }
  String txout="";
  if (begchar<endchar) txout = txin.substring(begchar, endchar); 
  else println("no encontrado");
  return txout;
}



int getclosebraket(String txin, int openbraket) {
  int inception = -1;
  int intout = -1;
  for (int i=openbraket; i<txin.length(); i++) {
    if (txin.charAt(i) == '(') inception ++;
    if (txin.charAt(i) == ')') {
      if (inception==0) if (intout==-1)intout = i;
      inception --;
    }
  }
  return intout;
}

int getcomabraket(String txin, int openbraket) {
  int inception = -1;
  int intout = -1;
  for (int i=openbraket; i<txin.length(); i++) {
    if (txin.charAt(i) == '(') inception ++;
    if (txin.charAt(i) == ',') if (inception==0) if (intout==-1) intout = i;
    if (txin.charAt(i) == ')') inception --;    
  }
  return intout;
}




String gettextinbraketsline (String txin, String open,char openc, char closec){
  int openbrak = 0;
  int closebrak= 0;
  for (int i=0; i<txin.length()-open.length()+1; i++) {
    boolean isequal = true;
    for (int j=0; j<open.length();j++) if (open.charAt(j)!=txin.charAt(j+i)) isequal = false;
    if (isequal) openbrak = i;
  }
  int inception = -1;
  for (int i = openbrak; i< txin.length(); i++) {
  if (txin.charAt(i) ==openc) inception ++;
  if (txin.charAt(i)==closec) if (inception==0) closebrak = i;
  if (txin.charAt(i)==closec) inception --;
  }
  return txin.substring(openbrak,closebrak+1);
}
String [] gettextinbraketslines (String [] txin, String open,char openc, char closec){
  int openbrak = 0;
  int closebrak= 0;
  for (int i=0; i<txin.length; i++) if (txin[i].contains(open)) openbrak = i;
  int inception = -1;
  for (int i = openbrak; i< txin.length; i++) for (int j = 0; j< txin[i].length(); j++) {
    if (txin[i].charAt(j)==openc) inception ++;
    if (txin[i].charAt(j)==closec) if (inception==0) closebrak = i;
    if (txin[i].charAt(j)==closec) inception --;
  }
  String [] stout = new String [closebrak+1-openbrak];
  for (int i=0; i<stout.length;i++) stout[i] = txin [openbrak+i];
  return stout;
}
StringBuilder replacecharat(StringBuilder txin, int chari, String substext){
 String txout = "";
 txout = txin.substring(0,chari) + substext + txin.substring(chari+1,txin.length()) ;
   StringBuilder txoutb = new StringBuilder(txout);
  return txoutb;
}

//String changetextbetweenchar(){
  
//}
String [] stringarrayexceptnum(String [] intx, int num) {
  ArrayList <String> a = new ArrayList <String> (); 
  for (int i=0; i<intx.length; i++) if (i!=num) a.add(intx[i]); 
  return a.toArray(new String[a.size()]);
}
String [] stringarrayfromto(String [] intx, int from, int to) {
  ArrayList <String> a = new ArrayList <String> (); 
  if (from<=to&&to<intx.length) for (int i=from; i<=to; i++)  a.add(intx[i]); 
  return a.toArray(new String[a.size()]);
}
