String [] jsdeclaration(String [] incode, String separators, String [] declarations, Table inrules, Table inwordsavoid) {
  incode[0] = changerules(incode[0], inrules);
  incode[0]= changearrays(incode[0], declarations);  
  incode[0]= changedeclarations(incode[0], declarations,0);
  return incode;
}
