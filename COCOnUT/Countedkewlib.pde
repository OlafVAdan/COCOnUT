//'keywords' & 'entitywords' library that keeps 
// track of the amount of times either is said.

public class Countedkewlib {
  
  //KE words and how many times
  public JSONObject wordata;
  public String[] allwords;
  public String[] entwords;
  
  public Countedkewlib(){
    this.wordata = new JSONObject();
    this.allwords = new String[0];
    this.entwords = new String[0];
  }
  
  public void entitycheck(String eword){
    eword.toLowerCase();
    int ewi = entwords.length;
    boolean existing = false;
    
    for(int i = 0; i < ewi; i++){
      if(entwords[i].equals(eword)){
        existing = true;
      }
    }
    
    if(!existing){
        entwords = expand(entwords, ewi + 1);
        entwords[ewi] = eword;
    }
  }
  
  public void updater(String word){
    word = word.toLowerCase();
    int awi = allwords.length;

         if (this.wordata.isNull(word)){
             this.wordata.setInt(word, 1);
             allwords = expand(allwords,awi+1);
             allwords[awi] = word;
         } else {
           int nval = this.wordata.getInt(word) + 1 ;
           this.wordata.setInt(word, nval); 
         }
  }
}
