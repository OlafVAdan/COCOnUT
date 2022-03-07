// Functions that take care of requests to localhost server
// and process it to local storage, includes functions that
// stores data of a sessions accordingly

void time(){
  s = second(); 
  m = minute();
  H = hour();
  D = day();
  M = month();
  Y = year();
}

void dataCollect(){
  JSONObject dataset = new JSONObject();
  dataset.setJSONObject("wordweeb", the.wordweb);
  dataset.setJSONObject("wordata", kewdatlib.wordata);
  
  String dateFull = str(D) + "_" + str(M) + str(Y);
  String trialhr =  str(H);
  String log = "/" + logger + "_" + m + ".json";
    
    String filename = "data/demodayv1/" + dateFull + "/" + trialhr + "/";
  //======for usertesting==============
  //String filename = "data/usertest/" + dateFull + "/" + trialhr + "/";
  //===================================
    saveJSONObject(dataset, filename + "combined" + log);
    saveJSONObject(the.wordweb, filename + "relating" + log);
    saveJSONObject(kewdatlib.wordata,filename + "counted" + log);
    saveStrings(filename + "utterances/" + logger + "_" + m + ".txt", sentences);
    saveFrame(filename + "modes" + "/" + str(mode)+ "-" + logger + "_min-s_" + m + "-" + s + ".png" );
    
  logger++;
}

//option for analysing multiple datasets
String[] dataLoad(String path){
  String[] utterances = loadStrings(path);
  return utterances;
}

//option for analysing single files
void loadData(String path){
  JSONObject receive = loadJSONObject(path);
  Countedkewlib loaded = new Countedkewlib();
  loaded.wordata = receive.getJSONObject("wordata");
  Wordcons reloaded = new Wordcons();
  reloaded.wordweb = receive.getJSONObject("wordweeb");
}

void selectFile() {
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    loadData(selection.getAbsolutePath());
  }
}

JSONObject requester(){
  GetRequest get = new GetRequest("http://localhost:3002/processing/entities");
    get.send(); // program will wait untill the request is completed
    JSONObject res = parseJSONObject(get.getContent());
    //println("response: " + get.getContent());
    //println("jsonobject: " + res);
    return res;
}

Stated librarian(JSONObject rec){
   //storage for DIY syntactic relations/analysis
      sentences = append(sentences, sentence);
      String[] fullWords = split(sentence, ' ');
        for(int i = 0; i < fullWords.length;i++){
          //println("fullwords word: " + i + " is: " + fullWords[i]);
        }
      
   //storage of predefined analysis
      //getting keyphrases COMPLETED
      String keyWords = rec.getString("keyphrases");
      String[] newWords = new String[0];
      if(keyWords.length() < 2){
        //println("keyWords is null AF: " + keyWords);
      } else {
        //println("keyWords string: " + keyWords);
        newWords = split(keyWords, ',');
        for(int i = 0; i < newWords.length;i++){
          //println("newWords word: " + i + " is: " + newWords[i]);
        }
      }
      //println(newWords);
      println(rec);
      //getting entitywords INPROGRESS
      JSONArray entityWords = rec.getJSONArray("entities");
      String[] newEjWords = new String[0];
      
     if(!rec.isNull("entities")){    
        int entsize = entityWords.size(); 
        newEjWords = new String[entsize];
        //println(entsize);
        if(entsize != 0){
            initialized = true;
            for(int i = 0; i < entsize; i++){
              JSONObject texter = entityWords.getJSONObject(i);
              String text = texter.getString("text");
              newEjWords[i] = text; 
              kewdatlib.entitycheck(text);
              //println("newEjWords word: " + i + " is: " + newEjWords[i]);
            }
            //println(entityWords);
        }
      
      }
    
    String[] actualimpW;
    String[] EKBatch = new String[0];
    actualimpW = new String[0];
    
    if(initialized == true){
      String[] impWords = concat(newEjWords,newWords);
      int implength = impWords.length;
      actualimpW = new String[0];
      int cntr = 0;
      String[] output = new String[0];
      //println(implength);

      if(implength > 1){
        impWords = sort(impWords);    //contains duplicates
        String[] duplicheck = new String[impWords.length + 1];
        arrayCopy(impWords, 0, duplicheck, 1, impWords.length);
        
        for(int i = 0; i < implength; i++){
          if(impWords[i].equals(duplicheck[i]) == false){
            output = expand(output, cntr + 1);
            output[cntr] = impWords[i].toLowerCase();
            cntr++;
          }
        }
        
        for(int j = 0; j < output.length; j++){
          kewdatlib.updater(output[j]);
        }
        
        
      //  //println(impWords);
      //  for(int j = 0; j < implength; j++){
      //    if(j < implength-1){                                      //if length=2, j=0/j=1 implength-1 = 1 --> goes once, if more goes more(implength longer) --> checks NEXT index
      //      if(impWords[j].equals(impWords[j+1]) == false){
      //        kewdatlib.updater(impWords[j]);
      //        actualimpW = expand(actualimpW, cntr);
      //        actualimpW[cntr-1] =impWords[j];
      //        cntr += 1;
      //      } 
      //    } 
      //    else if (j < implength){                                  //eg length = 9, idx 0 till 7 gets checked based on next idx (aka previous func), here arrives at j=8 --> 8 < 9
      //        if(impWords[j].equals(impWords[j-1]) == false){       // check idx 8 based on prev idx (7), if not same, add 
      //        kewdatlib.updater(impWords[j]);;
      //        actualimpW = expand(actualimpW, cntr);
      //        actualimpW[cntr-1] =impWords[j];
      //        cntr += 1;
              
      //        }
      //      }
      //  } 
      //} else {
      //  if(implength == 1){
      // kewdatlib.updater(impWords[0]);
      //      actualimpW = expand(actualimpW, cntr);
      //      actualimpW[cntr-1] = impWords[0];
      //      cntr += 1;
      //  } 
      
      }
      actualimpW = output;
      
      if(actualimpW.length != 0){
       the.connecter(actualimpW);
      }
       
    }
    
    EKBatch = actualimpW;    
    senPos += 1;
    prevSentence = sentence;
    println(actualimpW);
  Stated toinsert = new Stated(sentence,fullWords,newWords,entityWords, EKBatch);
  return toinsert;
}
