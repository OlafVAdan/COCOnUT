// Functions to compute averages/std's and more

         // these should be the same, but will differ once a single entity word is uttered
// tnW   =  total number of 'collected' words
// tnWR  =  total number of 'counted' words

// avnWR =  average number of Words Relating to some word 
// avnW  =  average count of Words  

// avnWRstd = p.standard deviation...
// avnWstd  = p.standard deviation...



void datAnalysis(){
  tnW = kewdatlib.allwords.length;
  tnWR = the.wordweb.size();
  float totalWCount = 0.0;
  float totalRCount = 0.0;
  
  float totalWCountSTD = 0.0;
  float totalRCountSTD = 0.0;
  
  for(int i = 0; i < tnW; i++){
    if(!kewdatlib.wordata.isNull(kewdatlib.allwords[i])){
      float n = kewdatlib.wordata.getInt(kewdatlib.allwords[i]);
      totalWCount = totalWCount + n;
    }
  }
  
  for(int j = 0; j < kewdatlib.allwords.length; j++){
    String keW = kewdatlib.allwords[j];
      if(!the.wordweb.isNull(keW)){
        float m = the.wordweb.getJSONArray(keW).size();
        totalRCount = totalRCount + m;
    }
  }
  
  avnW = totalWCount / tnW;
  avnWR = totalRCount / tnWR;
  
  for(int k = 0; k < tnW; k++){
    if(!kewdatlib.wordata.isNull(kewdatlib.allwords[k])){
      float n = kewdatlib.wordata.getInt(kewdatlib.allwords[k]);
      totalWCountSTD = totalWCountSTD + pow((avnW - n),2);
    }
  }
  
  avnWstd = sqrt(totalWCountSTD / tnW);
  
  for(int j = 0; j < kewdatlib.allwords.length; j++){
    String keW = kewdatlib.allwords[j];
      if(!the.wordweb.isNull(keW)){
        float m = the.wordweb.getJSONArray(keW).size();
        totalRCountSTD = totalRCountSTD + pow((avnWR - m),2);
    }
  }
  
  avnWRstd = sqrt(totalRCountSTD / tnWR);
  
}
