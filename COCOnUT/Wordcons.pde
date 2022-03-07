// Keeps track of words said in the same utterance and
// how often these are said within the same utterance.
// Creates a JSONObject of JSONArrays for which the
// key is a word itself and the  counted key is defined 
// as 'strwrd'

public class Wordcons {

  public JSONObject wordweb;
  
  public Wordcons(){
    this.wordweb = new JSONObject();
  }
  
  //TODO omit 'null'

  public void connecter(String[] impwords){
    
    
    
    
    for(int i = 0; i < impwords.length;i++){                          //FIX YO NULL KK DING
      if(impwords[i] != null){
        //impwords[i] = impwords[i].toLowerCase();
      //to know which ones to add
   //===========================CREATE NEW JSONARRAYS=========================================
        if(this.wordweb.isNull(impwords[i])){            //check if exists
          JSONArray ionwords = new JSONArray();                  //not existing, so make new array
          int idval = 0;
          for(int j = 0; j < impwords.length; j++){                
            if(j != i){
                JSONObject conwords = new JSONObject();
                conwords.setInt(impwords[j].toLowerCase(), 1);                     //set ints for relw
                conwords.setString("strwrd",impwords[j].toLowerCase());               
                ionwords.setJSONObject(idval,conwords);
                idval += 1;
            }
          }
          if(ionwords.size() > 0){    //was 1
            this.wordweb.setJSONArray(impwords[i],ionwords);        //set key of w for new a
          }
          
 //======================ACCESS EXISTING JSONARRAY==================================================
        } else {//if do exist we go into the array
          //get size of JSONArray ass w word
          int arsize = this.wordweb.getJSONArray(impwords[i]).size();
          
          boolean[] addnew = new boolean[impwords.length];
          for(int ii = 0; ii < impwords.length; ii++){
             addnew[ii] = true;
          }
          
          addnew[i] = false;
       
          //start by checking the full array of word-Objects
          for(int k = 0; k < arsize; k++){
            if(!this.wordweb.getJSONArray(impwords[i]).isNull(k)){                                           // bugfix for null array aka no links made but singular imp                               // OR --> was imp[i] already connected but not related to any? or
            
            //check within each k-object if it has a n-value for a relating word
              for(int l = 0; l < impwords.length; l++){                // check existing link, if yes add 1 to val
                    //if the n-value exists, add one to its value
                if (l != i && !this.wordweb.getJSONArray(impwords[i]).getJSONObject(k).isNull(impwords[l])){   //l!=i makes sure it doesnt check for itself // isNull checks if its related word object exists on that index
                      int nval = this.wordweb.getJSONArray(impwords[i]).getJSONObject(k).getInt(impwords[l]) + 1;  //it exists, so edit the value to value +1
                      this.wordweb.getJSONArray(impwords[i]).getJSONObject(k).setInt(impwords[l], nval);           //place new value in setInt(imp,val)
                      addnew[l] = false; //dont add the current relating word again 
                }    
              }
            }
          }
          
          for(int m = 0; m < impwords.length; m++){
             if (addnew[m] == true){                                                                                  //make sure loaded imp doest check for itself
                JSONObject conwords = new JSONObject();                                                    //create new JSON for new link
                conwords.setInt(impwords[m].toLowerCase(), 1);                                               //set word + val
                conwords.setString("strwrd",impwords[m].toLowerCase());                                                    //set word = word
                this.wordweb.getJSONArray(impwords[i]).setJSONObject(arsize,conwords);                   //add object to jsonarray
                arsize++;
              }
            }
          }
        } //1st if
      } //1st for
                                                                 //println("THIS IS THE DAMN THING NOW" + this.wordweb);
  }   //close connecter function inside class
  
}    //end of class


    // -----INPUT
    // {w,c,s}
    // {c.z.f}
    // {d,k}
    // {w,f}
    // {w,c,f}
                //-----OUTPUT ----> INPUT
                //{  w : [{c:2},{s:1},null,{f:2}] ,         
                //   c : {w:2,s:1,f:2,z:1} ,
                //   s : {w:1,c:1} ,
                //   z : {c:1,f:1} ,
                //   f : {c:2, z:1, w:2} ,
                //   d : {k:1} ,
                //   k : {d:1}  }
                
                                //------"OUTPUT"
                                //c = w2,s1,f2,z1
                                //w = c2,s1,f2
                                //f = c2,z1,w2
                                //s = w1,c1
                                //z = c1,f1
                                //d = k
                                //k = d
                                
                                
                              
                
                
                
                
                
