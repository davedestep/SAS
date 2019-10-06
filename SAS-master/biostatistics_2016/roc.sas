data roc; 
Input CMMSScore response;
      datalines;
    5 1 
    5 1 
    10 1
    15 0 
    15 0 
    15 0 
    15 1 
    15 1 
    15 1 
    15 1 
    20 1
    20 1
    20 1
    20 1
    20 1
    20 1
    20 1
    20 1
    20 1
    20 0
    20 0
    20 0
    20 0
    20 0
    25 0
	25 0
	25 0
	25 0
	25 0
	25 0
	25 0
	25 0
	25 0
	25 0
	25 0
	25 0
	25 0
	25 0
	25 0
	25 0
	25 1
	25 1
	25 1
	30 0
	30 0
	30 0
	30 0
	30 0
	30 0
	30 0
	30 0
	30 0
	30 0
	30 0
	30 0
	30 0
	30 0
	30 0
	30 0
	30 0
	30 0
	30 1
   ;
run;
data roc3;
set roc;
if CMMSScore < 21 then test =1;
else test =0;
run;
proc print data=roc3;
run;

      proc sort data=roc3;
         by descending Test descending Response;
         run;
      proc freq data=roc3 order=data;
         weight CMMSScore;
         tables Test*Response;
         run;
         
         
         proc logistic data=roc3 plots(only)=(roc(id=obs) effect) descending;
	model response (event='1') = CMMSScore;
	ROC 'CMMSScore ' CMMSScore ;   /*A labe must be included in quotes*/
Run;




     
