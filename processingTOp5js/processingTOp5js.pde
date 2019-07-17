import java.io.*;
import org.apache.commons.lang3.StringUtils;
import java.util.*;
import java.lang.*;
import java.io.*;
import org.apache.commons.lang3.ArrayUtils;
import java.util.Arrays;


Table inwordsavoid, inrules;
String[] incode;

void setup() {
  incode = loadStrings("incode.txt");
  inwordsavoid = loadTable("prowords.csv");
  inrules = loadTable("inrules.csv");
  String separators=" *(&)=,/+-|!{<}%;>[]";  //"[]"
  String [] defaultdec = {"void", "boolean", "int", "float", "String", "PVector", "color", "PShape"};


  incode = corregirformato(incode, separators); 
  for (int i=0;i<incode.length;i++) incode [i] = incode [i].replace(".length ()", ".length");//0:Corregir formato   
  String [][]incodesep = separate(incode);                                                //1:Separar codigo 
  String[] declarations = ArrayUtils.addAll(defaultdec, getlocaldeclarations(incodesep));            //2:Anadir declaraciones locales
  String [] globalfunctions = getglobalfunctions(incodesep, declarations, inwordsavoid, separators);
  String [] globalvariables = getglobalvariables(incodesep, declarations, inwordsavoid, separators, globalfunctions);
  //printArray( globalvariables);
  for (int i=0; i<incodesep.length; i++) if (isdecla(incodesep[i]))    incodesep [i] = jsdeclaration(incodesep[i], separators, declarations, inrules, inwordsavoid);         //3:Cambiar Declaraciones
  for (int i=0; i<incodesep.length; i++) if (isfunction(incodesep[i])) incodesep [i] = jsfunction   (incodesep[i], separators, declarations, inrules, inwordsavoid, null, null, 2); 
  for (int i=0; i<incodesep.length; i++) if (isclass(incodesep[i]))    incodesep [i] = jsclass      (incodesep[i], separators, declarations, inrules, inwordsavoid, globalfunctions, globalvariables);    //String [] incode, String separators, String [] declarations, Table inrules, Table inwordsavoid
  //for (int i=0; i<incodesep.length; i++) printArray(incodesep[i]);
  ArrayList <String> codreunido = new ArrayList <String> ();
  for (int i=0; i<incodesep.length; i++) for (int j=0; j<incodesep[i].length; j++) codreunido.add(incodesep[i][j]);
  //println(changearrays("int id [] = new int [2];",declarations));
//printArray(
  //println(changeclosebraket("012345(789)","45(",".DACS.[",']'));
  //for (int i=0;i<codreunido.size();i++) println(codreunido.get(i));
  String [] codeenarray = codreunido.toArray(new String[codreunido.size()]);

  
  
  
  //printArray(a);
  //codeenarray = changecomplexforloops(codeenarray);
  //changeclosebraketsameline("String stout [] = new String [roomDATA.length];", " = new "+ "String" + " [", " = new Array ( ", ')');
  //changetxbutmultiplesline(String txin, String changeit, String changeto, String [] exceptions)
  //String [] exce = { "abc(de","aabc("};
  //println(changetxbutmultiplesline("asdc asdc abc( asdc asd abc(de, asdc aabc(","abc(","ABC(",exce));
    for (int i=0;i<codeenarray.length;i++) codeenarray [i] = codeenarray [i].replace("][)", ")");
   //for (int i=0;i<codeenarray.length;i++) println(codeenarray[i]);

  
  saveStrings("data/outp5.txt", codeenarray);
  //printArray(codreunido.toArray(new String[codreunido.size()]));
  //println(changesimplearraylistforloop("if ( key == 'q' ) for ( Nodegene n : ng ) n.scroll ( true ) ;",declarations));
  //print(asdc);
  println("end");
}
