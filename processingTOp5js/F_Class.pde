String [] jsclass(String [] incode, String separators, String [] declarations, Table inrules, Table inwordsavoid,String [] globalfunctions, String [] globalvariables) {
  String [] classconstruction = getclassconstruction(incode);      
  String [][] classfunctions = getclassfunctions(incode); 
  String [] classdeclaration = getclassdeclarationandvariables(classconstruction);

  String [] variablesnames = getvariablesnames(classdeclaration, declarations, separators, inwordsavoid,globalfunctions, globalvariables);
  String [] functionnames = getfunctionnames(classfunctions, declarations, separators, inwordsavoid); 
  //if (txequal(getclassname(incode[0]),"House")) printArray (variablesnames);
 //if (txequal(getclassname(incode[0]),"House")) printArray (declarations);
 
  String [] jsconstruct = translatejsconstruct(classconstruction, declarations, inrules, variablesnames, functionnames);
  for (int i=0; i<classfunctions.length; i++) classfunctions[i] = jsfunction(classfunctions[i], separators, declarations, inrules, inwordsavoid, variablesnames, functionnames,1);  //String [] incode, String separators, String [] declarations, Table inrules, Table inwordsavoid) {
   //for (int i=0;i<jsconstruct.length; i++) if (i>2) jsconstruct = 
    //printArray(jsconstruct);
    
   ArrayList <String> stout = new ArrayList <String> ();
  for (int i=0; i<jsconstruct.length; i++) stout.add(jsconstruct[i]);
  for (int i=0; i<classfunctions.length; i++)for (int j=0; j<classfunctions[i].length; j++) stout.add(classfunctions[i][j]); 
  
  stout.add("}");
  String  [] stoutst = stout.toArray(new String[stout.size()]);
//  if (txequal(getclassname(incode[0]),"Mueble")) stoutst = getcomplexforloops(stoutst);
  return stoutst;
}

String [] translatejsconstruct(String [] classconstruction, String [] declarations, Table inrules, String [] variables, String [] functions) {
  ArrayList <String> txout = new ArrayList <String> (); //changeconstructorfunction(String intx, String[] declarations, int type) 
  txout.add(classconstruction[0]);
  String construct = "";
  for (int i=1; i<classconstruction.length; i++) if (classconstruction[i].contains("{")) construct =classconstruction[i].replace(getclassname(classconstruction[0]), "constructor");
  construct = changeconstructorfunction(construct, declarations, 1);   // // 1 empty  //variables de class
  txout.add(construct);
  ArrayList <String> bodyin = new ArrayList <String> ();
  for (int i=1; i<classconstruction.length; i++) if (!classconstruction[i].contains("{")) bodyin.add(classconstruction[i]);
  //String [] bodyfunc = {"sdc","csdc","sdc"};
  //if (classconstruction[0].contains("Zone"))  printArray(bodyin.toArray(new String[bodyin.size()]));
  
  
  String [] bodyfunc=changebodyfunction(bodyin.toArray(new String[bodyin.size()]), declarations, inrules, variables, functions,1); 
 //if (classconstruction[0].contains("Zone")) printArray(classconstruction);
 //for (int i=0; i<classconstruction.length;i++) classconstruction[i] = changearrays(classconstruction[i],declarations);
  for (int i=0; i<bodyfunc.length; i++) txout.add(bodyfunc[i]);
   //if (classconstruction[0].contains("Zone"))  printArray(bodyfunc);
  return txout.toArray(new String[txout.size()]);
}
