String [] jsfunction(String [] incode, String separators, String [] declarations, Table inrules, Table inwordsavoid, String[] classvariables, String[] classfunctions,int type) {
  incode[0] =changeconstructorfunction(incode[0], declarations, type);         // //0 let, 1 empty 2:function  
  String [] body = stringarrayexceptnum(incode, 0);  //todomenos incode[1]
  body =changebodyfunction(body, declarations, inrules, classvariables, classfunctions,0);
  for (int i=1; i<incode.length; i++) incode[i]= body[i-1]; 
  //println(incode[0]);
  //if (incode[0].contains("function calcmuebleslist")) incode = getcomplexforloops(incode);
  return incode;
}

String changeconstructorfunction(String intx, String[] declarations, int type) {   // type 0: normal function 1: class constructor function
  //println(intx);
  String[] intxsplit = split(intx, '(');
  intxsplit [0] =intxsplit [0] +"("; 
  intxsplit [0] =changedeclarations(intxsplit [0], declarations,type);     //titulo de funccion
  //intxsplit [0] = "guacamole";
  intxsplit[0]=intxsplit[0].replace("[]","");
  //if (intxsplit.length<2) print(intx);
  // if (intxsplit.length<2) print(type);
  String [] inputs = split(intxsplit[1], ',');
  
  for (int i=0; i<inputs.length-1; i++) inputs[i]+=" ,";
  for (int i=0; i<inputs.length; i++) inputs[i] = changearrays(inputs[i], declarations);    
  for (int i=0; i<inputs.length; i++) inputs[i] = changedeclarations(inputs[i], declarations,1);
  intxsplit [1] ="";
  for (int i=0; i<inputs.length; i++) intxsplit [1]+=inputs[i];
  String txout = "";
  for (int i=0; i<intxsplit.length; i++) txout+=intxsplit[i];
  return txout;
}
String [] changebodyfunction(String intx[], String[] declarations, Table inrules, String[] classvariables, String[] classfunctions,int type) {   //tipo 0 = normal 
     //printArray(intx);
    for (int i=0; i<intx.length; i++) intx[i] = changearrays(intx[i], declarations);  
  for (int i=0; i<intx.length; i++)  intx[i] = changerules(intx[i], inrules);
   
  for (int i=0; i<intx.length; i++) intx[i] = changedeclarations(intx[i], declarations,type);
  for (int i=0; i<intx.length; i++) intx[i] = addthis(intx[i], classvariables, classfunctions); 
  return intx;
}
