/* David DeStephano  Assingment 6*/
/*I certify that the SAS code given is my original and exclusive work*/

/*Question 1*/
FILENAME CSV '/home/dmd12d0/STA3024 Data/Election08.xlsx';

PROC IMPORT DATAFILE=CSV
	DBMS=XLSX
	OUT=elect
	replace;
	
RUN;

PROC PRINT DATA=elect; RUN;


proc logistic data=elect;
	model obamawin (event='1') = "dem.rep"n;
Run;

proc logistic data=elect;
	model obamawin (event='1') =  hs;
Run;

proc logistic data=elect;
	model obamawin (event='1') = income;
Run;

proc logistic data=elect;
	model obamawin (event='1') = ba;
Run;
/*****************************************
Individually income and dem.rep have similar fits and liklihood ratios, 
however when running regression models with single (each individual) variable, income has a higher chi square and therefore is 'more inclusive'.
If one were to run multiple regression dem.rep would be the most effective variable for determining if obama won a state 
because it has the most significant p value in the all inclusive model.
******************************************/


/*Empirical Logit Plot (format found in class notes)*/
Proc Rank data=elect groups=5 out=out; /*Creates 5 bins */
  var "dem.rep"n; /*X variable*/
  ranks Bin; /*Creates the variable Bin to indicate groupings*/
Run;

/*Summarize the results of each bin*/
proc means data=out nway noprint;
	class bin; /*Calulate means by each group*/
	var obamawin "dem.rep"n;
	output out=Bins sum(obamawin)=obamawin mean("dem.rep"n)="dem.rep"n; 
Run;

/*Check output file*/
proc print data=Bins;
Run;

/*Empirical Logit Calculation*/
Data bins2;
	set bins;
	EmpLogit = Log((obamawin+.5)/(_freq_ - obamawin + .5)); /*Log odds with a 
	                                             continuity correction*/
Run;

proc print data=bins2;
Run;

/*Create plot to check for liinearity*/
Title "Empirical Logit Plot";
proc sgplot data=bins2;
	reg x="dem.rep"n y=EmpLogit;
	loess x="dem.rep"n y=EmpLogit;
Run;
/****************************************************
As is the model is not linear
******************************************************/




/*Question 2*/
proc logistic data=elect;
	model obamawin (event='1') = income/clodds=wald clparm=wald;
	output out=PredProbs predicted=phat;    
Run;
proc print data=PredProbs;
run;
/*Found the probabilities for each individual state*/
/*Odds = e^0.000349	=1.000349061. 
For each dolar increase in state income, the odds of obamowin are increase to 1.0003 to 1*/

/*Question 2 b*/
/*The confidence interval is 1 to 1.001*/


/*Question 2 c*/
Data elect2;
set elect;
incometh= income/1000;
run;

proc logistic data=elect2;
model ObamaWin (event='1') = incometh/ clodds=wald clparm=wald;
run;
/*The odds increase to 1.4 which is significantly more influential when considering increased income to odds of dem vote. 
The p value also remains the same so the overall fit remains as it was,
however the equation changes to logit(pi)=-12.4251+.3494*income because the slope is multiplied by 1000*/

/*Question 2 d*/
/*odds=e^.3494=1.418216363
the confidence limits are 1.154	1.742*/






/*Question 3*/
proc import datafile="/home/dmd12d0/STA3024 Data/YouthRisk2007.xlsx" 
	out=youth 
	dbms=xlsx 
	replace;
run;

/*Question 3 a*/
proc logistic  data = youth;
model ridealcdriver(event = '1')= female / clodds= wald clparm = wald;
run;
/*The odds are 2.7 to 1, meaning it is more likely that females ride with a driver that has been drinking*/
/*Question 3 b*/
proc logistic  data = youth;
model ridealcdriver (event = '1')= driverlicense / clodds= wald clparm = wald;
run;
/*Getting a drivers license positively correlates with riding with a drunk driver. 
The slope is positive and the odds ratio is over 1*/
/*Question 3 c*/
proc logistic  data = youth;
model ridealcdriver(event = '1')= smoke / clodds= wald clparm = wald;
run;
/*The odds ratio is 3.217 and the slope is positive, 
therefore smokers are also more likely to ride with a drunk driver according to this survey*/




/*Question 4 a and b*/
proc logistic data=elect;
	model obamawin (event='1') = income hs ba "dem.rep"n;
Run;
/*As mentioned in question 1 dem.rep is has the strongest relationship with the response when doing multiple regression.
None of the other predictors are significant in this model.*/











/*Question 4c*/
data electnum;
set elect;
id=_n_;          /*Make states numerical*/
run;

proc logistic data=Elect;
model ObamaWin (event='1') = ba "dem.rep"n/ iplots ;
OUTPUT OUT=SA RESCHI=stateresids;
run;

/*We are supposed to look at the Pierce residual, 
I used the reschi statement in output to find the pearson residuals in the output data tab.
Indiana has an unusually high residual while Missouri has an unusually low residual*/
 





/*Question 4 d*/
Proc Logistic data=elect;
	model obamawin (event='1') = income hs ba "dem.rep"n/selection=score;
Run;

proc logistic data=elect;
	model obamawin (event='1') = income hs ba "dem.rep"n/selection=stepwise;
Run;
proc logistic data=elect;
	model obamawin (event='1') = income hs ba "dem.rep"n/selection=b;
Run;
/*The elimination models do not exactly match up, but I would argue from seeing the model with each variable,
and comparing the different elimination procedures, that dem.rep is the only variable that HAS to be retained.
One could make the argument for including Income or BA but I do not think they are neccessary
According to backwards elimination alone, BA should be included in the model 
and income should be excluded because of its residual chi square test*
HS is not included because it is not significant/




