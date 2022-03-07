import controlP5.*;

import http.requests.*;

//Time
int interval = 2500;
int prevTime = 0;
int s,m,H,D,M,Y;
int eger;

//Indexers, Loggers
  int senPos = 0;
  int logger = 0;
  int mode = 0;
  String modeDescribed = "-";
  String sentence, prevSentence;
  int prevVal, MCval;
  
  
  
//Datatypes from which the visualiser visualises
  public String hword = "_not_enough_data_yet_" ;                    //Centered word
  public int MRval = 0;                                              //MaxRelatedValue
  public String[] relwords;                                          //first Degree words
  public int[] rwvals;                                               //counted value of fD-words
  
//Storages
  String[] sentences = {};  
  Countedkewlib kewdatlib;               //'Keyphrases & Entity' 
  Wordcons the;                          // their relations and corresponding counters
  
//Arraylibrary of all 'Stated' things (see class)
  Stated[] things;       // use to access stated things
  Stated thingstoo;      // used for extending things
  Stated[] tempthings;   // used for extending things
  
//Triggers for startup
  boolean initialized = false;
  boolean textavailable = false;
  boolean visualizedOnce = false;
  boolean visReady = false;
  
//Data analysis types
  float nW, nWR, nWRn,tnW, tnWn, tnWR, avnWR, avnW, avnWRn;
  float avnWRstd, avnWstd;

//Visualizing class
  Objectify it;
  ControlP5 cp5;

public void setup() {
	//size(1000,1000);
  size(1920,1080);
  //fullScreen();
	smooth();
  kewdatlib = new Countedkewlib();
  things = new Stated[0];
  the = new Wordcons();
  it = new Objectify(hword, MRval,relwords,rwvals,the.wordweb,kewdatlib.wordata);
  relwords = new String[0];
  rwvals = new int[0];
  
  //cp5 = new ControlP5(this);
  //cp5.addSlider("nUtterance").setPosition(20, 900).setSize(960, 20).setLabelVisible(false).setMin(1.0).setMax(5.0);
}

void draw(){
  background(230,238,255);
  noStroke();
  fill(94, 57, 39);
  ellipse(width/2,height/2, 700, 700);
  fill(162, 129, 94);
  ellipse(width/2,height/2, 660, 660);
  fill(245, 229, 152);
  ellipse(width/2,height/2, 645, 645);
  fill(255);
  ellipse(width/2,height/2, 600, 600);
  time();
  //int eger = int(cp5.getValue("nUtterance"));
  fill(0);
  textAlign(LEFT,TOP);
  textSize(14);
  text("Algorithmic approach: " + modeDescribed,20,20);
  
  
  
//Request data and store conveniently
  int time = millis();
  if(time >= prevTime + interval){
    JSONObject res = requester();
    sentence = res.getString("sentence");
    if(sentence.equals(prevSentence) == false && sentence != null && sentence != ""){
      thingstoo = librarian(res);
      tempthings = new Stated[senPos+1];
      tempthings[senPos] = thingstoo;
      arrayCopy(things, tempthings);
      things = tempthings;
      textavailable = true;
      visReady = true;
    }
        
//Timer & other prints
   println("time: " + time);
   prevTime = time;
   //println(kewdatlib.wordata);
  }
  
//Mode selector to generate mapping 
  if(textavailable == true){   
    textSize(15);
    textAlign(CENTER,TOP);
    text(sentence,  40, height-50, width-80, 50);          //Display last recorded utterance
     if(sentences.length >= 1){
       switch(mode) {                                   //EVAL: ALL MODES WAIT FOR A WORD TO BE AT LEAST COUNTED TWICE DUE TO OBJECTIFY
         case 0:
           modeDescribed = "Centered has the most words relating to it";
           MRval = 0;
           datAnalysis();
           maxRelatedV1();
           it.visualize(hword,MRval,relwords,rwvals,the.wordweb,kewdatlib.wordata);
           break;
         case 1:
           modeDescribed = "Centered has the most words relating to it and mentioned across utterances above the average";
           MRval = 0;
           datAnalysis();
           maxRelatedV2();
           it.visualize(hword,MRval,relwords,rwvals,the.wordweb,kewdatlib.wordata);
           break;
         case 2:
           modeDescribed = "The centered word is most said across utterances";
           MRval = 0;
           mostCounted(); 
           it.visualize(hword,MRval,relwords,rwvals,the.wordweb,kewdatlib.wordata);
           break;
         case 3:
           modeDescribed = "Data Analysis";
           datAnalysis();
           String[] informative = new String[10];
           informative[0] = "Word with most relating words: " + getMaxRelatedWord();
           informative[1] = "    Amount: " + howManyWRelatedTo(getMaxRelatedWord());
           informative[2] = "Word most said across utterances: " + getMostCounted();
           informative[3] = "    Amount: " + getCountOf(getMostCounted());
           informative[4] = "Amount of words collected: " + kewdatlib.allwords.length ;
           informative[5] = "Amount of words with a relating word: " + the.wordweb.size();
           informative[6] = "Average occurence of a word: " + avnW ;
           informative[7] = "    p.std of this: " + avnWstd;
           informative[8] = "Average of words relating to a word: " + avnWR;
           informative[9] = "    p.std of this: " + avnWRstd;
           
           for(int j = 0; j < 10; j++){
           text(informative[j],  100, 100+j*20);
           }
           break;
         case 4:
           modeDescribed = "Analyse Though Time; centered most said across utterances";
           MRval = 0;
           Wordcons indexed = new Wordcons();
           Countedkewlib index = new Countedkewlib();
           frameSelect(index, indexed);
           idxmostCounted(index, indexed); 
           it.visualize(hword,MRval,relwords,rwvals,indexed.wordweb,index.wordata);
           break;
       }              //endofswitchmode
     }                //endofsentenceslength
     
     if(visualizedOnce == true && visReady == true){
       dataCollect();
       visReady = false;
     }
   }                  //endofavailable
   
} //endofdraw  

void keyPressed(){
  int[] keys = {'q','w','e','r','t','y','u','i','o','p'};
  for(int i = 0; i < 10;i++){
    if(keys[i] == key){
       mode = i;
     }
  }
}

void mouseClicked(){
  
  
  
  
  //old modeswitch
  //mode++;
  //if(mode == 4){
  //  mode = 0;
  //}
}

void frameSelect(Countedkewlib index, Wordcons indexed){
   for(int i = 0; i < things.length && i < eger; i++){
     indexed.connecter(things[i].combiEKbatch);
     for(int j = 0; j < things[i].combiEKbatch.length; j++){
       index.updater(things[i].combiEKbatch[j]);
     }
   }
}

String[] timeSlide(int idx){
  String[] partofUtterances = new String[idx];
  for(int i = 0; i < idx; i++){
    partofUtterances[i] = sentences[i];
  }
  return partofUtterances;
}

// Often occuring words that are registered but hold no valuable meaning.
boolean blocklist(String t){
  String[] list = {"now", "uhm", "ehm", "one", "bit"};
  
  boolean blocked = false;
  for(int i = 0; i < list.length; i++){
    if(list[i].equals(t)){
      blocked = true;
    }
  }
  return blocked;
}

void maxRelatedV1(){    //Long utterances break this method, but keep it for demonstration
    
   for(int i = 0; i < kewdatlib.allwords.length; i++){
     String keW = kewdatlib.allwords[i];                             //set KEword tb checked
     if(!the.wordweb.isNull(keW) && !blocklist(keW)){
       int tval = the.wordweb.getJSONArray(keW).size();              //check JSOAsize of KEword
       if(tval > MRval){
         MRval = tval;
         hword = keW;
         relwords = new String[tval];
         rwvals = new int[tval];
         
           for(int j = 0; j < tval; j++){
             String rw = the.wordweb.getJSONArray(keW).getJSONObject(j).getString("strwrd");
             int rwv = the.wordweb.getJSONArray(keW).getJSONObject(j).getInt(rw);
             relwords[j] = rw;
             rwvals[j] = rwv;
             //println(" shit should be updating, length: " + tval);
           }
        }
     }
   }
}
               
void maxRelatedV2(){    //Updated with need to exceed avgcounted to be identified as most relating
    
   for(int i = 0; i < kewdatlib.allwords.length; i++){
     String keW = kewdatlib.allwords[i];                                       //set KEword tb checked
     int counted = kewdatlib.wordata.getInt(keW);                              //check count to be validated
     if(counted > avnW && !the.wordweb.isNull(keW) && !blocklist(keW)){
       int tval = the.wordweb.getJSONArray(keW).size();                        //check JSOAsize of KEword
       if(tval > MRval){
         MRval = tval;
         hword = keW;
         relwords = new String[tval];
         rwvals = new int[tval];
         
           for(int j = 0; j < tval; j++){
             String rw = the.wordweb.getJSONArray(keW).getJSONObject(j).getString("strwrd");
             int rwv = the.wordweb.getJSONArray(keW).getJSONObject(j).getInt(rw);
             relwords[j] = rw;
             rwvals[j] = rwv;
             //println(" shit should be updating, length: " + tval);
           }
        }
     }
   }
}

void mostCounted(){
  hword = getMostCounted();
  relwords = getRelatingWords(hword);
  rwvals = occurenceRelated(hword);
  MRval = relwords.length;
}

void idxmostCounted(Countedkewlib index, Wordcons indexed){
  hword = idxgetMostCounted(index);
  relwords = idxgetRelatingWords(hword, indexed);
  rwvals = idxoccurenceRelated(hword, indexed);
  MRval = relwords.length;
}





void maxrelatedVone(){ // this one takes max related first and swaps hword with max counted word
                       // *edit* --> does not swap, but keeps old fD array intact, see below
                       //FIX: RELWORDS & RELVALS DONT RESET IN SECOND LOOP
                       
     for(int i = 0; i < kewdatlib.allwords.length; i++){
       String keW = kewdatlib.allwords[i];       //set KEword tb checked
       if(!the.wordweb.isNull(keW) && !blocklist(keW)){
         int tval = the.wordweb.getJSONArray(keW).size();      //check JSOAsize of KEword
         if(tval > MRval){
           MRval = tval;
           hword = keW;
           relwords = new String[MRval];
           rwvals = new int[MRval];
             for(int j = 0; j < MRval; j++){
               String rw = the.wordweb.getJSONArray(hword).getJSONObject(j).getString("strwrd");
               int rwv = the.wordweb.getJSONArray(hword).getJSONObject(j).getInt(rw);
               relwords[j] = rw;
               rwvals[j] = rwv;
               //println(" shit should be updating, length: " + MRval);
             }
             prevVal = kewdatlib.wordata.getInt(keW);
          }
       }
     }
     
           //pick "correct" one (among most related also highest nr of times said)                      FIX INFINITE UPDATELOOP --> switchybitchy
      for(int j = 0; j < MRval; j++){
         int wval = kewdatlib.wordata.getInt(relwords[j]);
         if(prevVal < wval && !blocklist(relwords[j])){
           hword = relwords[j];
           wval = the.wordweb.getJSONArray(relwords[j]).size();
             for(int k = 0; k < wval; k++){
               String w = the.wordweb.getJSONArray(relwords[j]).getJSONObject(k).getString("strwrd");
               int rwv = the.wordweb.getJSONArray(relwords[j]).getJSONObject(k).getInt(w);
               relwords[k] = w;
               rwvals[k] = rwv;
               //println(" shit should be updated, amount: " + wval );
             }
            prevVal = wval;
         }
      }
}
    // AVAILABLE QUANTATIVE PARAMS
     // - TODO:  
     //  x  nW   x ground level: amount of times a word is said
     //  x  nWR  x ground level: a words number of relating words
     //  x  nWRn x ground level: amount of times a word is related to a word
     //  x  tnW   x ground level: total number of 'collected' words
     //  x  tnWn  x ground level: total number of 'counted' words
     //     tnWR --> total number words relating
     //     avnWR  - 1st degree: average number of relating words to a word / its std                      --> to determine desired 'depth' of mapping
                                                 //   avnWR  - 1st degree: average nr of relating words (n=x) 'related' to words (all)               --> to determine desired 'depth' of mapping
     //  x  avnW   - 1st degree: average amount of times any word is said / the std of this                --> omit low occurrences to reduce redundancy
     //  x  avnWRn - 2nd degree: average nr of relating words (n=x) 'related' to a word (single)           --> omit low occurrences to reduce redundancy
     //
     //          - 3rd degree: similarity between classes => having shared connections 
     //                  -> size similarity => compared to all(avnWR), compared to most similar (nWR/nWRn) (2nd ranked main?)
     //                  -> equals similarity => compared to all(???), compared to most similar (nWR/nWRn)
     //                 
     //
     //
     //          - 4rd degree: class 'uniqueness' = 1 / 
     //          - 
     //
     // ??QUALITATIVE PARAMS / output
     // - collection of 'center' words  --> 'subject'
     // - collection of 1st scale words --> 'subject'
     // - subject of conversation?
     //
     // --> if you store this and use it as a model for improved vis of 
     //     other conversations, congrats, you do machine learning now
     //
     //      --> identify collection of words similar to other conversation
     //         --> visualize / update and retrain subject
     //
     //
