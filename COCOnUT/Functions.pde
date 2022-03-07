// Storage of functions to make development easier.
// --> Turns code into strongly typed language for development


//identiry word that has been most said across utterances
String idxgetMostCounted(Countedkewlib selected){
  String MCword = "I WASNT READY, SRRY UwU";
  int val;
  int pval = 0;
  for(int i = 0; i < selected.allwords.length; i++){
     String keW = selected.allwords[i];                                    //set KEword tb checked
     if(!selected.wordata.isNull(keW) && !blocklist(keW)){
        val = selected.wordata.getInt(keW);
         if(pval < val && !blocklist(keW)){
           MCword = keW;
           pval = val;
         } 
     }
  }
  return MCword;
}

String idxgetMaxRelatedWord(Countedkewlib selected, Wordcons projected){
  String theword = "Function not working";
  int lastval = 0;
  int thisval = 0;
   for(int i = 0; i < selected.allwords.length; i++){
     String keW = selected.allwords[i];                                   //set KEword tb checked
     
     if(!projected.wordweb.isNull(keW) && !blocklist(keW)){
       thisval = projected.wordweb.getJSONArray(keW).size();                    //check JSOAsize of KEword
       
       if(thisval > lastval){
         lastval = thisval;
         theword = keW;
       }   
     }
   }
 return theword;
}

String[] idxgetRelatingWords (String word, Wordcons projected){
  String[] relatingwords = new String[0];
  if(!projected.wordweb.isNull(word)){
  int amount = projected.wordweb.getJSONArray(word).size();
  relatingwords = new String[amount];
      for(int i = 0; i < amount; i++){
         String related = projected.wordweb.getJSONArray(word).getJSONObject(i).getString("strwrd");
         relatingwords[i] = related;
      }
  }
  return relatingwords;
}

//use with getrelatingwords
int[] idxoccurenceRelated (String word, Wordcons projected){
  int[] relatingcount = new int[0];
    if(!projected.wordweb.isNull(word)){
    int amount = projected.wordweb.getJSONArray(word).size();
    relatingcount = new int[amount];
        for(int i = 0; i < amount; i++){
           String related = projected.wordweb.getJSONArray(word).getJSONObject(i).getString("strwrd");
           int value = projected.wordweb.getJSONArray(word).getJSONObject(i).getInt(related);
           relatingcount[i] = value;
        }
    }
  return relatingcount;
}


//identiry word that has been most said across utterances
String getMostCounted(){
  String MCword = "I WASNT READY, SRRY UwU";
  int val;
  int pval = 0;
  for(int i = 0; i < kewdatlib.allwords.length; i++){
     String keW = kewdatlib.allwords[i];                                    //set KEword tb checked
     if(!kewdatlib.wordata.isNull(keW) && !blocklist(keW)){
        val = kewdatlib.wordata.getInt(keW);
         if(pval < val && !blocklist(keW)){
           MCword = keW;
           pval = val;
         } 
     }
  }
  return MCword;
}

//identify word with most words related to it         
String getMaxRelatedWord(){
  String theword = "Function not working";
  int lastval = 0;
  int thisval = 0;
   for(int i = 0; i < kewdatlib.allwords.length; i++){
     String keW = kewdatlib.allwords[i];                                   //set KEword tb checked
     
     if(!the.wordweb.isNull(keW) && !blocklist(keW)){
       thisval = the.wordweb.getJSONArray(keW).size();                    //check JSOAsize of KEword
       
       if(thisval > lastval){
         lastval = thisval;
         theword = keW;
       }   
     }
   }
 return theword;
}

//get number of times the word has been 'uttered'
int getCountOf(String thisword){
    int val = 0;
    if(!kewdatlib.wordata.isNull(thisword)){
      val = kewdatlib.wordata.getInt(thisword);
    }
    return val;
}

//get number of words relating to a word
int howManyWRelatedTo(String thisword){
  int thismuch = 0;
  if(!the.wordweb.isNull(thisword)){
    thismuch = the.wordweb.getJSONArray(thisword).size();
  }
  return thismuch;
}

//use with occurencerelated
String[] getRelatingWords (String word){
  String[] relatingwords = new String[0];
  if(!the.wordweb.isNull(word)){
  int amount = the.wordweb.getJSONArray(word).size();
  relatingwords = new String[amount];
      for(int i = 0; i < amount; i++){
         String related = the.wordweb.getJSONArray(word).getJSONObject(i).getString("strwrd");
         relatingwords[i] = related;
      }
  }
  return relatingwords;
}

//use with getrelatingwords
int[] occurenceRelated (String word){
  int[] relatingcount = new int[0];
    if(!the.wordweb.isNull(word)){
    int amount = the.wordweb.getJSONArray(word).size();
    relatingcount = new int[amount];
        for(int i = 0; i < amount; i++){
           String related = the.wordweb.getJSONArray(word).getJSONObject(i).getString("strwrd");
           int value = the.wordweb.getJSONArray(word).getJSONObject(i).getInt(related);
           relatingcount[i] = value;
        }
    }
  return relatingcount;
}

//checks if SecondDegree words are unique (i.e. not also relating to centered)
String[][] getUniqueSecondDegree(String centered, String[] firstDegree, JSONObject web){     

     int amount = firstDegree.length;                  
     int[] fDamounts = new int[amount];                                                                 //to store length of each relating
     String[][] scaled = new String[amount][0];                                                         //to store word + unique connections
     
       for(int j = 0; j < amount; j++){
         fDamounts[j] = web.getJSONArray(firstDegree[j]).size();                                        //get amount of words relating to fD, store in array
         String[] uniq = new String[0];
         int unqv = 0;
         for(int k = 0; k < fDamounts[j]; k++){
           String tc = web.getJSONArray(firstDegree[j]).getJSONObject(k).getString("strwrd");           //get a word from rel-2
           boolean unidetect = true;
             for(int l = 0; l < amount; l++){
               if(tc.equals(firstDegree[l]) == true || tc.equals(centered) == true){                    //check if equal to any rel-1 or main
                 unidetect = false;
               }
             }
           if(unidetect == true){                                                                       //if uniq, expand an add to arr
             uniq = expand(uniq, unqv + 1);                                                
             uniq[unqv] = tc;
             unqv++;
           }
         }
         scaled[j] = uniq;
       }
   return scaled;
}


boolean isEntity(String word){
  boolean isent = false;
  
  for(int i = 0; i < kewdatlib.entwords.length; i++){
    if(word.equals(kewdatlib.entwords[i])){
      isent = true;
    }
  }
  
  return isent;
}

String getCategory(String entityword){
  String cat = entityword;
  for(int i = 0; i < things.length; i++){
    for(int j = 0; j < things[i].eWords.size(); i++){
      if(cat.equals(things[i].eWords.getJSONObject(j).getString("text"))){
        cat = things[i].eWords.getJSONObject(j).getString("category");
      }
    }    
  }
  return cat;
}

float progressionSwitch(float y, int l){
  float val = 1;
  if(l > 3){
    val = (2.2 + 1/abs(y));
  }
  return val;
}
