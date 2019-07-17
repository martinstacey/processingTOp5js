String  [][] separate(String [] txinc) {
  int openi = -1;
  int closei = -1;
  int inception = 0;
  int numfun = 0;
  ArrayList <String> stoutside = new ArrayList <String>();
  ArrayList <String> stinside = new ArrayList <String>();
  String [][] as = new String [300][];

  for (int i=0; i<txinc.length; i++) {
    boolean haspar = false;
    //for (int j=0; j<txinc[i].length(); j++) {
    if (txinc[i].contains("{")) {
      if (inception==0) openi = i;
      inception ++;
      haspar = true;
    }
    if (txinc[i].contains("}")) {
      inception --;
      if (inception==0) closei = i;
      if (inception==0) {
        if (openi!=-1&&closei!=-1&&closei>=openi) {
          as [numfun] = new String [closei - openi+1];
          as [numfun] = new String [closei - openi+1];
          for (int m=openi; m<=closei; m++)  as [numfun][m-openi] = txinc[m];
        }
        numfun++;
        openi = -1;
        closei = -1;
      }
      haspar = true;
    }
    //}
    if (!haspar&&inception==0&&!txequal(txinc[i], "")) {
      as[numfun] = new String [1];
      as[numfun][0] = txinc[i];
      numfun++;
    }
  }
  String [][] stout = new String [numfun][];
  for (int i=0; i<stout.length; i++) stout[i] = as[i];
  //for (int i=0; i<as.length; i++) if (as[i]!=null)  printArray(as[i]);
  return stout;
}
