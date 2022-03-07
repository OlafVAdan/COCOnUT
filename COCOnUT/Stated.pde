//Keeps track of utterances, wrongfully defined as 'sentences'

public class Stated {
  //attributes
  public String sentence;
  public String[] sWords, kWords, combiEKbatch;
  public JSONArray eWords = new JSONArray();
  
  //TODO: attributes for length knowledge
  public int senLength, sWLength, sKLength, sELength, ekLength;
  
  //constructor? --> add void to make constructor
  public Stated (String DSentence, String[] DSWords, String[] DSKtext, JSONArray DSentity, String[] EKbatch){
    this.sentence = DSentence;
    this.sWords = DSWords;
    this.kWords = DSKtext;
    this.eWords = DSentity;
    this.combiEKbatch = EKbatch;
    
    this.senLength = DSentence.length();
    this.sWLength = DSWords.length;
    this.sKLength = DSKtext.length;
 //   this.sELength = DSentity.size();
    
    //TODO: reset actual lenght --> remove 'null' values
    //this.ekLength = entandkey.length;
  };
  
  
}
