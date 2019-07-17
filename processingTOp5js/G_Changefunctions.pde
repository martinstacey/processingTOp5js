String changerules(String intx, Table inrules) {
  String outx = intx;
  String rules[][] = new String [inrules.getColumnCount()][2];
  for (int i=0; i<inrules.getColumnCount(); i++)for (int j=0; j<2; j++) rules[i][j] = inrules.getString(j, i);  
  
   for (int i=0; i<rules.length; i++) outx = outx.replace("."+rules[i][0]+" (", "."+ rules[i][0]+"... (");
  
  
  for (int i=0; i<rules.length; i++) outx =     outx.replace(rules[i][0]+" (", rules[i][1]+" (");
  for (int i=0; i<rules.length; i++) outx = outx.replace("."+ rules[i][0]+"... (", "."+ rules[i][0]+" (");
  return outx;
}
String changearrays (String txin, String[]declarations) {      //add se puede confundir con add de PVector tener cuidado                    //falta el get(i) por [i]
  String outx = txin;
  if (outx.contains(".add (")) outx = changeaddtopush(outx);
  if (outx.contains(".get (")) outx = changeget(outx);
  if (outx.contains(".set (")) outx = changeset(outx);
  
  if (outx.contains("PVector.dist (")) outx = outx.replace("PVector.dist (","p5.Vector.dist (");
   //if (outx.contains(".get ("))  outx = changeclosebraketsameline (outx,".get (","["          //changeclosebraketsameline(String txin, String opentext, String newopentext, char newclosechar) {
  
  if (outx.contains(".size ()")) for (int i=0; i<declarations.length; i++) outx = outx.replace(".size ()", ".length " );
   if (outx.contains(".length ()")) for (int i=0; i<declarations.length; i++) outx = outx.replace(".length ()", ".length " ); 
  if (outx.contains("={")) for (int i=0; i<declarations.length; i++) outx = outx.replace("}", "]" );  
  if (outx.contains("={")) for (int i=0; i<declarations.length; i++) outx = outx.replace("[]", "" );
  if (outx.contains("={")) for (int i=0; i<declarations.length; i++) outx = outx.replace("{", "[" );
  for (int i=0; i<declarations.length; i++)  if (outx.contains("= new "+ declarations[i] + " [" )&&outx.contains("];")) outx = changeclosebraketsameline(outx, "= new "+ declarations[i] + " [", " = new Array (", ')');    
  
  
  
  //if (outx.contains("= new  [")) outx = changeclosebraketsameline(outx,"= new  [","= new Array (",')');
  outx = outx.replace("[]", "");
  for (int i=0; i<declarations.length; i++) outx = outx.replace("new ArrayList < "+declarations[i]+" >", "new Array" );
  for (int i=0; i<declarations.length; i++) outx = outx.replaceAll("ArrayList < "+declarations[i]+" > ", "let ");
  
  
  return outx;
}
String changedeclarations(String intx, String[] declarations, int type) {    //0 let, 1 empty 2:function   
  String outx = intx;
  if (type ==0) for (int i=0; i<declarations.length; i++) if (txequal(getfirstword(outx), declarations[i]))  {
    String [] exceptions = {"new " +declarations[i]+" ",declarations[i]+" (","( "+declarations[i]+" )"};
    outx = changetxbutmultiplesline (outx, declarations[i]+" ","let ",exceptions);
  }
  if (type==0) for (int i=0; i<declarations.length; i++) if (outx.contains("= new "+ declarations[i] + " [")) outx = changeclosebraketsameline(outx, "= new "+ declarations[i] + " [", "= new Array ( ", ')');
  
  if (type==0||type ==2) outx = outx.replace("[]", "");



  if (type ==1) for (int i=0; i<declarations.length; i++) if (txequal(getfirstword(outx), declarations[i])) outx = outx.replace(declarations[i]+" ", " ");
  if (type ==1) outx = outx.replace("let ", " ");

  if (type ==0||type==1) for (int i=0; i<declarations.length; i++) outx = outx.replace("for ( "+declarations[i]+" ", "for ( "+"let"+" ");



  if (type ==0||type==1) if (outx.contains("for ( ")&&outx.contains(":")&&outx.contains(";")) outx = changesimplearraylistforloop(outx, declarations);


  if (type ==2) for (int i=0; i<declarations.length; i++) if (txequal(getfirstword(outx), declarations[i])) outx = outx.replace(declarations[i]+" ", "function"+" ");
  if (type ==2) for (int i=0; i<declarations.length; i++) if (txequal(getfirstword(outx), "ArrayList")) outx = outx.replace("ArrayList < " +declarations[i]+" > ", "function"+" ");
  

  return outx;
}
//String changearray(String txin, String a, String b) {
//  ////for (int i=0; i<txin.length
//  //return null;
//}



char getcloseb(char openb) {
  char outchar = ' ';
  String openbr = "{[(";
  String closebr = "}])";
  for (int i=0; i<openbr.length(); i++) if (openb == openbr.charAt(i)) outchar = closebr.charAt(i);
  return outchar;
}

String addthis (String txin, String [] variables, String [] functions) {
  String outx = txin;

  if (variables!=null)for (int i=0; i<variables.length; i++) outx = outx.replace(" "+variables[i]+" ", " this." + variables[i]+" ");   
  if (functions!=null)for (int i=0; i<functions.length; i++) outx = outx.replace(" "+functions[i]+" ", " this." + functions[i]+" "); 

  if (variables!=null)for (int i=0; i<variables.length; i++) outx = outx.replace(" "+variables[i]+".", " this." + variables[i]+".");   
  if (functions!=null)for (int i=0; i<functions.length; i++) outx = outx.replace(" "+functions[i]+".", " this." + functions[i]+"."); 


  outx = outx.replace("this.//", "//");
  return outx;
}
String changesimplearraylistforloop(String outx, String [] declarations) {                 //cambiar tambien declarations
  String [] outxsp = split (outx, ' ');
  String varname = "...";
  String listname= "...";
  for (int i=0; i<outxsp.length; i++) if (txequal(outxsp[i], ":")) {
    varname = outxsp[i-1];
    listname = outxsp[i+1];
  }
  for (int j=0; j<declarations.length; j++) outx = outx.replace("for ( "+declarations[j]+" "+varname+" : "+listname + " ) ", "for ( let " +"..."+varname + " = 0 ; " +"..."+ varname + " < " + listname + ".length ; " +"..."+varname + " ++ ) ");
  outx = outx.replace("for ( let "+varname+" : "+listname + " ) ", "for ( let " +"..."+varname + " = 0 ; " +"..."+ varname + " < " + listname + ".length ; " +"..."+varname + " ++ ) ");
  outx = outx.replace(" "+varname+" ", " "+listname + " [ "+varname + " ] ");
  outx = outx.replace(" "+varname+".", " "+listname + " [ "+varname + " ] .");
  outx = outx.replace("...", "");

  return outx;
}




String changeaddtopush(String outx) {
  outx = outx.replace(".add (", ".push (");
  outx = outx.replace("PVector.push (", "p5.Vector.add (");
  return outx;
}
String changeget (String txin) {
  IntList inopen = new IntList ();
  IntList inclose = new IntList ();
  if (txin.length()>5) for (int i=5; i<txin.length(); i++)if (txin.charAt(i-5)=='.'&&txin.charAt(i-4)=='g'&&txin.charAt(i-3)=='e'&&txin.charAt(i-2)=='t'&&txin.charAt(i-1)==' '&&txin.charAt(i)=='(') inopen.append(i);
  for (int i=0; i<inopen.size(); i++) inclose.append(getclosebraket(txin, inopen.get(i)));
  StringBuilder txinsb = new StringBuilder(txin);
  for (int i=0; i<inclose.size(); i++)  txinsb.setCharAt(inclose.get(i), ']');
  txin = txinsb.toString();
  txin = txin.replace(".get (", " [ ");
  return txin;
}
String changeset (String txin) {
  IntList inopen = new IntList ();
  IntList inclose = new IntList ();
   IntList incoma = new IntList (); 
  if (txin.length()>5) for (int i=5; i<txin.length(); i++)if (txin.charAt(i-5)=='.'&&txin.charAt(i-4)=='s'&&txin.charAt(i-3)=='e'&&txin.charAt(i-2)=='t'&&txin.charAt(i-1)==' '&&txin.charAt(i)=='(') inopen.append(i);
  for (int i=0; i<inopen.size(); i++) inclose.append(getclosebraket(txin, inopen.get(i)));
  for (int i=0; i<inopen.size(); i++) incoma.append(getcomabraket(txin, inopen.get(i)));
  StringBuilder txinsb = new StringBuilder(txin);
  for (int i=0; i<inclose.size(); i++)  txinsb.setCharAt(inclose.get(i), ' ');
  for (int i=0; i<incoma.size(); i++)   txinsb = replacecharat(txinsb,incoma.get(i), "]=");
  txin = txinsb.toString();
  txin = txin.replace(".set (", " [ ");
  return txin;
}
String [] changecomplexforloops(String [] incode) {
  for (int i=0; i<incode.length; i++) {
    if (incode[i].contains("for ( let") && incode[i].contains("{")) {
      int starti = i;
      int endi = 0;
      int inception =-1;
      for (int j=starti; j<incode.length; j++) {
        if (incode[j].contains("{")) inception ++;
        if (incode[j].contains("}")) if (inception==0)  endi = j;        
        if (incode[j].contains("}"))inception--;
      }
      String var = gettextbetween(incode[starti], "for ( let ", " : ");
      String arrlist = gettextbetween(incode[starti], " : ", " )");
      String varinlist = arrlist + " [ " + var + " ] " ;
      ArrayList <String> forletcode = new ArrayList <String > ();
      for (int j=starti; j<endi+1; j++) forletcode.add(incode[j]);
      String [] tsout = forletcode.toArray(new String[forletcode.size()]);
      if (!txequal(var,"")&&!txequal(varinlist,"")) for (int j = 0; j<tsout.length; j++) tsout[j] = tsout[j].replace (" " +var+ " ", " " + varinlist + " ");
      if (!txequal(var,"")) for (int j = 0; j<tsout.length; j++) tsout[j] = tsout[j].replace (" " +var+ ".", " " + varinlist + ".");
      if (!txequal(var,"")) for (int j = 0; j<tsout.length; j++) tsout[j] = tsout[j].replace ("for ( let " +varinlist+ " : " + arrlist +" )", "for ( let " + var + " = 0 ; "+var+ " < "+arrlist+".length ; " + var + "++ ) " );
      if (!txequal(var,"")) for (int j=starti; j<endi+1; j++) incode[j] = tsout [j-starti];
    }
  }

  return incode;
}
