//Visualiser

public class Objectify {
  //String word;
  //String cat;
  //int size;
  //int pos;
  
  public String core; 
  public String[] rlwords; 
  public int[] rlvals;
  public JSONObject web;       //the.wordweb
  public JSONObject amts;      //countedkewlib.wordata
  public int scales;
 //most often + most relating == most central place
  //public Interactable[] words;
 
  public Objectify(String core, int hval, String[] rlwords, int[]rlvals, JSONObject web, JSONObject wordata){
   this.core = core;
   this.rlwords = rlwords;
   this.rlvals = rlvals;
   this.web = web;
   this.amts = wordata;
   this.scales = hval;
   //this.words = new Interactable[rlwords.length];
   // this.pos = pos;
    visualize(core, hval, rlwords, rlvals, web, amts);
  }

  public void visualize(String main,int hval, String[] relating, int[]rlvals, JSONObject web, JSONObject wordata){
     //Main is defined as word that has most connecting words, should consider amount mentioned?
     
    //------------check if relating to relating is unique (i.e. not relating to main)
     int z = hval;                    
     int[] rlvalsec = new int[z];                //store length of each relating
     String[][] scaled = new String[z][0];       //store word + unique connections     
     
       for(int j = 0; j < z; j++){
         rlvalsec[j] = web.getJSONArray(relating[j]).size();            //get length, store in array
         int sz = rlvalsec[j];                                          //store length
         String[] uniq = new String[0];
         int unqv = 0;
         for(int k = 0; k < sz; k++){
           String tc = web.getJSONArray(relating[j]).getJSONObject(k).getString("strwrd");  //get a word from rel-2
           boolean unidetect = true;
             for(int l = 0; l < z; l++){
               if(tc.equals(relating[l]) == true || tc.equals(main) == true){               //check if equal to any rel-1 or main
                 unidetect = false;
               }
             }
           if(unidetect == true){                                                         //if uniq, expand an add to arr
             uniq = expand(uniq, unqv + 1);                                                
             uniq[unqv] = tc;
             unqv++;
           }
         }
         scaled[j] = uniq;
       }      
//--------------------end relating check
     
     
     
     ////create a list of unique secondary connections
     //String[] secscale = new String[0];
     //for(int o = 0; o < scaled.length; o++){                    //loop groups
     //  for(int q = 0; q < scaled[o].length; q++){               //loop lists
     //    secscale = expand(secscale, secscale.length + 1);
     //    secscale[secscale.length-1] = scaled[o][q];
     //  }
     //}
     //secscale = sort(secscale);
     //String[] truscale = new String[0];
     //for(int r = 0; r < secscale.length; r++){
     //  for(int s = r+1; s < secscale.length;s++){
     //    if(!secscale[r].equals(secscale[s])){
     //      truscale = expand(truscale, truscale.length +1);
     //      truscale[truscale.length-1] = secscale[r];
     //    }
     //  }
     //}
     //println(truscale);
     //for(int o = 0; o < scaled.length; o++){                    //loop groups
     //  for(int q = o+1 ; q < scaled.length; q++){               //loop lists
     //    for(int r = 0; r < scaled[o].length; r++){
     //      boolean sameness = false;
     //      for(int s = 0; s < scaled[q].length; s++){
     //        if(scaled[o][r].equals(scaled[q][s])){
     //          sameness = true;
     //        }
     //      }
     //      if(sameness){
             
     //      }
     //    }
     //  }
     //}
     
         // for(int r = 0; r < secscale.length; r++){              //loop words
         //  while(secscale.length == 1){
         //    secscale[r] = scaled[o][q];
         //    secscale = expand(secscale, secscale.length + 1);
         //  }
         //  if(!secscale[r].equals(scaled[o][q])){               //compare uniqueness
         //    secscale = expand(secscale, secscale.length + 1);  //add length
         //    secscale[secscale.length] = scaled[o][q];
         //  } 
         //}
   
   
     textSize(20);
     textAlign(CENTER, BOTTOM);
     

     translate(width/2,height/2);
     
     fill(0);
     int mainSize = main.length();
     textSize(30-(mainSize / 2));
     if(mainSize > 10){
       text(main, 0, 0);
     } else {
       text(main,0,0);
     }
     
     //==============================3rd v=================================
    
     
    // for(int i = 1; i <= hval; i++){
    //  pushMatrix(); 
    //   if(wordata.getInt(relating[i-1]) > 1){            //edit '1' to '0' disable 'more than said once' mode
    //   textSize(15);
    //   text(relating[i-1],0,90);
    //   rotate(((2*(i*PI)) / hval)    ); //* interaction
    //   }
     
    // popMatrix();
       
    //   fill(255);
    //     //uncomment to enable entity detection in first degree
    //   //for(int s = 0; s < kewdatlib.entwords.length ;s++){    
    //   //  if(kewdatlib.entwords[s].equals(relating[i-1])){
    //   //    fill(0,102,233);
    //   //  }
    //   //}
       
    //   int resize = wordata.getInt(relating[i-1]);
    //   textSize(15+resize);
       
    //   float y = cos( (2*(i*PI)) / hval);
    //   float x;
    //   if(mode == 0){
    //   x = sin( (2*(i*PI)) / hval) * (2.2 + 1/abs(y));
    //   } else {
    //   x = sin( (2*(i*PI)) / hval);
    //   }
    //   PVector direction = new PVector(x,y);
    //   PVector center = new PVector(x,y);
    //   center.normalize();
    //   center.mult(50+mainSize*2);                                      
    //   //direction.sub(center);
    //   direction.normalize();
    //   direction.mult(90);       //insert datatype increasing r length
       
    //   //if(direction.x >= 0 && direction.y >= 0){
    //   //  textAlign(LEFT,CENTER);
    //   //} else if(direction.x >= 0 && direction.y < 0){
    //   //  textAlign(LEFT,CENTER);
    //   //} else if(direction.x < 0 && direction.y < 0){
    //   //  textAlign(RIGHT,CENTER);
    //   //} else if(direction.x < 0 && direction.y >= 0){
    //   //  textAlign(RIGHT,BOTTOM);
    //   //}
    //   ////rotate()
    //   //if(relating[i-1].length() >= 25 && relating.length <= 25){
    //   //text(relating[i-1],direction.x,direction.y,150,50);
    //   //} else {
    //   //text(relating[i-1],direction.x,direction.y);
    //   //}
    //          //words[i-1] = new Interactable(relating[i-1],direction.x,direction.y);
       
       
    //   //reorder 1st scale based on shared 2nd scale
       
       
    //   textSize(15);
    //   //set position second scale
    //   translate(direction.x,direction.y);
       
       
    //    for(int m = 1; m <= scaled[i-1].length; m++){
    //      int l = scaled[i-1].length;
    //     float yy = cos( (2*((i+(m/(l*10)))*PI)) / hval);
    //     float xx;
    //      if(mode == 0){
    //        xx = sin( (2*((i+(m/(l*10)))*PI)) / hval) * (2.2 + 1/abs(yy));
    //      } else {
    //        xx = sin( (2*((i+(m/(l*10)))*PI)) / hval);           //EVALUATE NECESSITY
    //      }
         
    //     PVector directionn = new PVector(xx,yy);
    //     directionn.normalize();
    //     directionn.mult(180);
    //     fill(94, 57, 39);
         
    //     //change color for 2nd scale
    //     for(int s = 0; s < kewdatlib.entwords.length ;s++){
    //       if(kewdatlib.entwords[s].equals(scaled[i-1][m-1])){
    //         fill(150, 90, 62);
    //       }
    //     }
         
    //   if(directionn.x >= 0 && directionn.y >= 0){
    //     textAlign(LEFT, BOTTOM);
    //     text(scaled[i-1][m-1],directionn.x,directionn.y+m*10);  
    //   } else if(directionn.x >= 0 && directionn.y < 0){
    //     textAlign(LEFT, TOP);
    //     text(scaled[i-1][m-1],directionn.x,directionn.y-m*10);  
    //   } else if(directionn.x < 0 && directionn.y < 0){
    //     textAlign(RIGHT,TOP);
    //     text(scaled[i-1][m-1],directionn.x,directionn.y-m*10);  
    //   } else if(directionn.x < 0 && directionn.y >= 0){
    //     textAlign(RIGHT, BOTTOM);
    //     text(scaled[i-1][m-1],directionn.x,directionn.y+m*10);  
    //   }
    //     //place list for 2nd scale
    //     //text(scaled[i-1][m-1],directionn.x,directionn.y+m*10);        //could do with direction.x/y?
    //     //line(direction.x,direction.y,directionn.x,directionn.y);
    //   }
    //  translate(-direction.x,-direction.y);
    //  fill(255);
      
    // }
     
     //========================================1st v===========================

     
     for(int i = 1; i <= hval; i++){
       if(wordata.getInt(relating[i-1]) > 1){            //edit '1' to '0' disable 'more than said once' mode
       textSize(15);
       float y = cos( (2*(i*PI)) / hval);
       float x;
       if(mode == 0){
       x = sin( (2*(i*PI)) / hval) * progressionSwitch(y, sentences.length);
       } else {
       x = sin( (2*(i*PI)) / hval);
       }
       PVector direction = new PVector(x,y);
       PVector center = new PVector(x,y);
       center.normalize();
       center.mult(50+mainSize*2);                                      
       //direction.sub(center);
       direction.normalize();
       direction.mult(90);       //insert datatype increasing r length
       stroke(0);
       line(center.x,center.y,direction.x,direction.y);
       direction.mult(2);
       
       
       fill(0);
         //uncomment to enable entity detection in first degree
       //for(int s = 0; s < kewdatlib.entwords.length ;s++){    
       //  if(kewdatlib.entwords[s].equals(relating[i-1])){
       //    fill(0,102,233);
       //  }
       //}
       
       int resize = wordata.getInt(relating[i-1]);
       textSize(15+resize);
       
       //if(sentences.length <= 2){
       //  textAlign(CENTER,CENTER);
       //  direction.mult(1.2);
       //} else 
       if(direction.x >= 0 && direction.y >= 0){
         textAlign(LEFT,CENTER);
       } else if(direction.x >= 0 && direction.y < 0){
         textAlign(LEFT,CENTER);
       } else if(direction.x < 0 && direction.y < 0){
         textAlign(RIGHT,CENTER);
       } else if(direction.x < 0 && direction.y >= 0){
         textAlign(RIGHT,CENTER);
       }
       //rotate()
       if(relating[i-1].length() > 25 && relating.length <= 25){
       //textAlign(CENTER,CENTER);
       text(relating[i-1],direction.x,direction.y,150,50);
       
       } else {
       text(relating[i-1],direction.x,direction.y);
       }
              //words[i-1] = new Interactable(relating[i-1],direction.x,direction.y);
       
       
       //reorder 1st scale based on shared 2nd scale
       
       
       textSize(15);
       //set position second scale
       translate(direction.x,direction.y);
       
       
        for(int m = 1; m <= scaled[i-1].length; m++){
          int l = scaled[i-1].length;
         float yy = cos( (2*((i+(m/(l*10)))*PI)) / hval);
         float xx;
          if(mode == 0){
            xx = sin( (2*((i+(m/(l*10)))*PI)) / hval) * (2.2 + 1/abs(yy));
          } else {
            xx = sin( (2*((i+(m/(l*10)))*PI)) / hval);           //EVALUATE NECESSITY
          }
         
         PVector directionn = new PVector(xx,yy);
         directionn.normalize();
         directionn.mult(180);
         fill(94, 57, 39);
         
         //change color for 2nd scale
         for(int s = 0; s < kewdatlib.entwords.length ;s++){
           if(kewdatlib.entwords[s].equals(scaled[i-1][m-1])){
             fill(150, 90, 62);
           }
         }
         
       if(directionn.x >= 0 && directionn.y >= 0){
         textAlign(LEFT, BOTTOM);
         text(scaled[i-1][m-1],directionn.x,directionn.y+m*10);  
       } else if(directionn.x >= 0 && directionn.y < 0){
         textAlign(LEFT, TOP);
         text(scaled[i-1][m-1],directionn.x,directionn.y-m*10);  
       } else if(directionn.x < 0 && directionn.y < 0){
         textAlign(RIGHT,TOP);
         text(scaled[i-1][m-1],directionn.x,directionn.y-m*10);  
       } else if(directionn.x < 0 && directionn.y >= 0){
         textAlign(RIGHT, BOTTOM);
         text(scaled[i-1][m-1],directionn.x,directionn.y+m*10);  
       }
         //place list for 2nd scale
         //text(scaled[i-1][m-1],directionn.x,directionn.y+m*10);        //could do with direction.x/y?
         //line(direction.x,direction.y,directionn.x,directionn.y);
       }
      translate(-direction.x,-direction.y);
      fill(255);
      
     }
   //========================endv1==============================    
   
   //int iii = hval;
   //  String[] toview;
   //  for(int i = 1; i <= hval; i++){
   //    if(wordata.getInt(relating[i-1]) > 1 == false){
   //      iii--;
   //    }
   //  }
   //  toview = new String[iii];
   //  int cidx = 0;
   //  for(int i = 1; i <= hval; i++){
   //    if(wordata.getInt(relating[i-1]) > 1){
   //      toview[cidx] = relating[i-1];
   //      cidx++;
   //    }
   //  }
     
   //  for(int i = 1; i <= iii; i++){
   //    if(wordata.getInt(toview[i-1]) > 1){            //edit '1' to '0' disable 'more than said once' mode
   //    textSize(15);
   //    float x = sin( (2*(i*PI)) / iii); 
   //    float y = cos( (2*(i*PI)) / iii);
   //    PVector direction = new PVector(x,y);
   //    PVector center = new PVector(x,y);
   //    center.normalize();
   //    center.mult(50+mainSize*2);                                      
   //    //direction.sub(center);
   //    direction.normalize();
   //    direction.mult(85);                                   //insert datatype increasing r length
   //    stroke(255);
   //    line(center.x,center.y,direction.x,direction.y);
   //    direction.mult(2);
       
       
   //    fill(255);
   //    for(int s = 0; s < kewdatlib.entwords.length ;s++){
   //      if(kewdatlib.entwords[s].equals(toview[i-1])){ 
   //        fill(0,102,233);
   //      }
   //    }
       
   //    int resize = wordata.getInt(toview[i-1]);
   //    textSize(15+resize);
   //    if(direction.x >= 0 && direction.y >= 0){
   //      textAlign(LEFT, TOP);
   //    } else if(direction.x >= 0 && direction.y < 0){
   //      textAlign(LEFT, BOTTOM);
   //    } else if(direction.x < 0 && direction.y < 0){
   //      textAlign(RIGHT, BOTTOM);
   //    } else if(direction.x < 0 && direction.y >= 0){
   //      textAlign(RIGHT, TOP);
   //    }
   //    text(toview[i-1],direction.x,direction.y);
       
   //    scaled = getUniqueSecondDegree(main, toview, web);
       
   //    textSize(15);
   //    //set position second scale
   //    translate(direction.x,direction.y);
       
       
   //     for(int m = 1; m <= scaled[i-1].length; m++){
   //       int l = scaled[i-1].length;
   //      float xx = sin( (2*((i+(m/(l*10)))*PI)) / iii);           //EVALUATE NECESSITY
   //      float yy = cos( (2*((i+(m/(l*10)))*PI)) / iii); 
   //      PVector directionn = new PVector(xx,yy);
   //      directionn.normalize();
   //      directionn.mult(200);
   //      fill(230,102,0);
         
   //      //change color for 2nd scale
   //      for(int s = 0; s < kewdatlib.entwords.length ;s++){
   //        if(kewdatlib.entwords[s].equals(scaled[i-1][m-1])){
   //          fill(0,102,233);
   //        }
   //      }
         
   //      //place list for 2nd scale
   //      text(scaled[i-1][m-1],directionn.x,directionn.y+m*10);        //could do with direction.x/y?
   //      //line(direction.x,direction.y,directionn.x,directionn.y);
   //    }
   //   translate(-direction.x,-direction.y);
   //   fill(255);
      
   //  }
    //===============================endv2================================

          
    } //end of if ii
    visualizedOnce = true;
  } //end of visualize
  
} //endof class
     
 
     
     
     
     //            TRADITIONAL MINDMAP(CENTER INIT)
     //----------------------- scale 1 -----------------------
     //  relating has relating words in there, to appear around the main word
     //  --> closer to main when more often connected
     //  relating[] 
     //  rlvals[] && wordata.getInt(rel[]) totalX 
     //  distance from center = rlvals
     //  size/stroke/gradient = wordata.getInt(rel[])
     //
     //-------------------------------------------------------
     //
     //
     //----------------------- scale 2 -----------------------
     //  relating words have related words, but not always unique to that word 
     //  all relwords also relate to eachother + have in some common
     //  --> most common/shared == most near in radiant
     //  --> leftover words to scale 3
     //
     //  amount = web.getJSONArray(relating[]).size();
     //  web.getJSONArray(relating[word]).getJSONObject([loop 0-amount]);
     //
     //-------------------------------------------------------
     
     
     //===================== categorical items =================================
     //some words may have category already --> create class for categories, perhaps make imgs/icon.png in Illu
     //to access cat info --> kewdatlib.entwords - str[] <-- reuse check function
     
     
     //                  MINDMAP MULTIMAIN CENTER
     //--------------center = relating or 2-5 Centerwords ------------------------
     




//Category          Description
//-----------------------------------
//Person            Names of people.
//PersonType        Job types or roles held by a person.
//Location          Natural and human-made landmarks, structures, geographical features, and geopolitical entities
//Organization      Companies, political groups, musical bands, sport clubs, government bodies, and public organizations.
//Event             Historical, social, and naturally occurring events.
//Product           Physical objects of various categories.
//Skill             A capability, skill, or expertise.
  //Address           Full mailing addresses.
  //Phone number      Phone numbers.
  //Email             Email addresses.
  //URL               URLs to websites.
  //IPAddress         Network IP addresses.
//DateTime          Dates and times of day.
  //Quantity          Numerical measurements and units.
//
// SUBTYPES --> are a shitload
// https://docs.microsoft.com/en-us/azure/cognitive-services/text-analytics/named-entity-types?tabs=general
