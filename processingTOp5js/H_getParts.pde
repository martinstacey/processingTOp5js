


String [] getglobalvariables(String [][] incodesep, String [] declarations, Table inwordsavoid, String separators, String [] globalfunctions) {   //getvariablesnames(String intx[], String[] declarations, String separators, Table inwordsavoid) { 
  ArrayList <String> stout = new ArrayList <String> ();
  for (int i=0; i<incodesep.length; i++) if (isdecla(incodesep[i])) {
    String toadd [];
    toadd = getvariablesnames (incodesep [i],declarations,separators,inwordsavoid,globalfunctions,null);
      for (int j=0; j<toadd.length; j++) stout.add(toadd[j]);
  }
  return stout.toArray(new String[stout.size()]);
}
String [] getglobalfunctions(String [][] incodesep, String [] declarations, Table inwordsavoid, String separators){
  //getfunctionnames(incodesep,declarations,separators,inwordsavoid);
    ArrayList <String> stout = new ArrayList <String> ();
  for (int i=0; i<incodesep.length; i++) if (isfunction(incodesep[i])) {
    String newtext = getfirstwordnotdeclarations(incodesep[i][0], declarations,separators);
    if (!newtext.contains("[]")&&!txequal(newtext,"ArrayList"))stout.add(newtext);
  }
  return stout.toArray(new String[stout.size()]);
}

String [] getlocaldeclarations(String [][]incodesep) {
  ArrayList <String> stout = new ArrayList <String> (); //getfirstwordnotclass
  for (int i=0; i<incodesep.length; i++) if (isclass(incodesep[i])) stout.add(getfirstwordnotclass(incodesep[i][0])); 
  return stout.toArray(new String[0]);
}


String getclassname (String intx) {
  StringBuffer outx = new StringBuffer(intx); 
  String clout = split(outx.substring(0, outx.indexOf("{")+1), ' ')[1]; 
  return clout;
}
String [] getclassconstruction(String intx[]) {
  ArrayList <String> po = new ArrayList <String>(); 
  boolean closeclass = false; 
  for (int i=0; i<intx.length; i++) if (!closeclass) {
    if (intx[i].contains("}")) {
      po.add(intx[i]); 
      closeclass=true;
    } else    po.add(intx[i]);
  }
  return  po.toArray(new String[po.size()]);
}
String [] getclassdeclarationandvariables(String intx[]) {
  ArrayList <String> po = new ArrayList <String>(); 
  boolean closeclass = false; 
  for (int i=1; i<intx.length; i++) if (!closeclass) {
    if (intx[i].contains("{"))  closeclass=true;
    else    po.add(intx[i]);
  }
  return  po.toArray(new String[po.size()]);
}

String [][] getclassfunctions(String intx[]) {
  ArrayList <String> po = new ArrayList <String>(); 
  boolean closeclass = false; 
  for (int i=0; i<intx.length; i++) {
    if (closeclass)po.add(intx[i]); 
    else   if (intx[i].contains("}")) closeclass=true;
  }
  String [] poarr = po.toArray(new String[po.size()]); 
  String [][] stout = separate(poarr); 
  return  stout; //bar = foo.toArray(new Integer[foo.size()]);
}
//String getvnames(){


//}


String [] getvariablesnames(String intx[], String[] declarations, String separators, Table inwordsavoid, String [] globalfunctions, String [] globalvariables) {
  String wordsavoid [] = new String [inwordsavoid.getRowCount()]; 
  for (int i=0; i<inwordsavoid.getRowCount(); i++) wordsavoid[i] = inwordsavoid.getString(i, 0); 
  ArrayList <String> po = new ArrayList <String>(Arrays.asList(intx)); 
  String [] varpart; 
  boolean closeit = false; 
  for (int i=0; i<po.size(); i++) if (po.get(i).contains("//")) {
    int numcomment = 0; 
    for (int j=0; j<po.get(i).length()-1; j++) if (po.get(i).charAt(j)=='/'&&po.get(i).charAt(j+1)=='/') numcomment = j; 
    po.set(i, po.get(i).substring(0, numcomment));
  }
  String p2 = ""; 
  for (int i=0; i<po.size(); i++) p2+= po.get(i)+" "; 
  String [] poarr2 = StringUtils.split(p2, separators); 
  for (int i=0; i<poarr2.length; i++) for (int j=0; j<declarations.length; j++) if (txequal(poarr2[i], declarations[j])) poarr2[i] =null; 
  for (int i=0; i<poarr2.length; i++) for (int j=0; j<wordsavoid.length; j++) if (txequal(poarr2[i], wordsavoid[j])) poarr2[i] =null; 
   for (int i=0; i<poarr2.length; i++) if (poarr2[i]!=null) if (globalfunctions!=null) for (int j=0; j<globalfunctions.length; j++) if (txequal(globalfunctions[j],poarr2[i])) poarr2[i] = null; 
    for (int i=0; i<poarr2.length; i++) if (poarr2[i]!=null) if (globalvariables!=null) for (int j=0; j<globalvariables.length; j++) if (txequal(globalvariables[j],poarr2[i])) poarr2[i] = null; 
  for (int i=0; i<poarr2.length; i++) if (txequal(poarr2[i], "new")) poarr2[i] =null; 
  for (int i=0; i<poarr2.length; i++) if (poarr2[i]!=null)  if ( "\"".contains(poarr2[i].charAt(0)+"")) poarr2[i] =null; 
  for (int i=0; i<poarr2.length; i++) if (poarr2[i]!=null)  if ("0123456789.[".contains(poarr2[i].charAt(0)+"")) poarr2[i] =null; 
  for (int i=0; i<poarr2.length; i++) if (poarr2[i]!=null) poarr2[i] = poarr2[i].replace("[", ""); 
  for (int i=0; i<poarr2.length; i++) if (poarr2[i]!=null) poarr2[i] = poarr2[i].replace("]", ""); 
  ArrayList <String> stout = new ArrayList <String> (); 
  for (int i=0; i<poarr2.length; i++) if (poarr2[i]!=null) stout.add(poarr2[i]); 
  return stout.toArray(new String[stout.size()]);
}
String [] getfunctionnames (String intx[][], String[] declarations, String separators, Table inwordsavoid) {
  ArrayList <String> a = new ArrayList <String>(); 
  String wordsavoid [] = new String [inwordsavoid.getRowCount()]; 
  for (int i=0; i<inwordsavoid.getRowCount(); i++) wordsavoid[i] = inwordsavoid.getString(i, 0); 
  for (int i=0; i<intx.length; i++) a.add(getfirstwordnotdeclarations(intx[i][0], declarations,separators)); 
  return a.toArray(new String[a.size()]);
}
