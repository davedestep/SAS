/*Part 1 a*/

FILENAME TEEN '/home/dmd12d0/MyLib/Teen.csv';

PROC IMPORT DATAFILE=TEEN
	DBMS=CSV
	replace
	OUT=WORK.TEEN;
	GETNAMES=YES;
RUN;

PROC Print DATA=WORK.TEEN (obs=20); RUN;

/*Simply upload the file to a library and use the common import statements to specify how to import the data.
The only things needed tio be added were the replace statement and the amount of observations*/

/*Part 1b*/
Data Teen;
set WORK.TEEN;
run;
PROC SGSCATTER data=teen;
matrix Community		BirthRate	BelowPovLev	Crowded	Dependency	NoHSDiploma	Income	Unemployment;
run;



proc corr data=WORK.TEEN plots=matrix;
var Community	BirthRate	BelowPovLev	Crowded	Dependency	NoHSDiploma	Income	Unemployment;
run;

/*CommunityName was not included because the names are not numeric and there were no repeats. 
If there were repeats I would have formatted the data so it could be read.
I would have also liked to have removed the Community variable because it has little importance besides being used as obs numbers

From the plots it is clear that income was the only variable correlates negatively with the other variables.
Additionally, Unemployment and the rate of graduation (hsdiploma) seemed to strongly correlate with other variables.
I found it interesting the correlation between the two seemed to make two different distributions with independent slopes.
For our response variable/birthrate only unemployment rate and below pov level were highly correlated (>60) 

The proc corr scatterplot matrix is identical to sgplot but I still attempted including each variable with the var statement. It didnt work so Im not going to try any further making them look the same.*/








/*Part 2 a*/

proc reg data=teen;
model BirthRate=unemployment;
run;
/*The equation is birthrate= 2.84901*unemplyment + 12.16201

/*Part 2 b*/
/*The r square means that approximately 50% of the variance in the dependent variable/y can be explained by unemployment rates.*/

/*Part 2 c*/
/*The data has a constant variance but is underrepresented the higher unemployment get because there are few, if any, data points in the higher ranges.
The data is as also roughly linear with normally distributed residuals, */

/*Part 2d*/
proc transreg data=teen;
model boxcox(birthrate) = identity(unemployment);
run;


/*lambda=0.75 with the confidence interval reaching 1. 
Therefore, I think lambda is close enough to 1 to not warrant a transformation*/




/*Part 2 e**/

proc reg data=teen;
model BirthRate=unemployment /clb;
run;
/*The confidence interval is (2.20456,	3.49346). This means 95% of the time, the true slope falls within these parameters 
Furthermore, the interval does not include 0, which means it is unlikely the model follows the null hypothesis that the slope is 0 .
Since the slope can not be 0 the model is statistically significant and the variables are associated*/











/*********************************************************
Part 2 f
******************************************************************************/
/*creating a pseudo sample*/
Proc surveyselect data=teen out=boot seed=54321 samprate=1
                  method=urs outhits rep=1000;
Run;

proc print data=boot(obs=100);
run;


/*Running regression model by replicate*/
proc reg data=boot outest=betas noprint; /*noprint supresses regression output*/
	model birthrate = unemployment;
	by replicate;
Run;


/*Finding the new confidence interval*/
proc univariate data=boot noprint;
	var birthrate ; 
	output out=bootCI pctpts = 2.5 97.5 pctlpre = Conf_Limit_ ; ;
Run;

proc print data=bootCI;
run;


/* The new confidence interval is a staggering (2.1, 114.9). Since the interval still does not include 0 the variables are 
likely to be associated.*/






/*Part 2g*/
proc reg data=teen;
model BirthRate=unemployment;
run;
/*Anova tests for whether or not sample means are roughly equal. Due to the high f statistics we can reject the
hypothesis of the means being the same and conclude there is a variation between the samples.


















/*Part 2h*/



data teen2;     /*Doing a hidden y test*/
input Unemployment birthrate;
datalines;
1.2 .  
;               
run;



data teen3;
set teen teen2;           /*combining data*/
proc reg data=teen3;
model birthrate=unemployment/clm clb cli;    
run;

/* the predicted value of birthrate is 15.5808, The prediction interval interval is (-24.9395, 56.1012), 
meaning 95% of the time y for this particular observation at x will fall batween these two numbers.
The mean confidence interval is (6.5744, 24.5872) which tells us the mean value for y/birthrate (determined by the slope) at this x value 
will fall between this interval (for all observations that could have this x value.)*/



/*Part 2 i*/


proc reg data=teen;
model BirthRate=Community	BelowPovLev	Crowded	Dependency	NoHSDiploma	Income	Unemployment/vif;
run;

/*Although there is no formal standard for how high the value for variance inflation factors should be to remove a variable,
it is possible the data for not having a diploma contributes to the colinearity of the data due to it having the highest VIF.
The variable also has a very high p value so I will go ahead and remove it in subsequent regression models*/


/*Part 2 j*/

proc reg data=teen;
model BirthRate=Community	BelowPovLev	Crowded	Dependency	Income	Unemployment/selection=cp ;
run;

proc reg data=teen;
model BirthRate=Community	BelowPovLev	Crowded	Dependency	Income	Unemployment/selection=stepwise;
run;

/*Using the Mallows C(p) function, it seems that the best model would include the variables crowded and/or unemployment.
When combined they have an r square of 0.6303, which is a 13% increase of the rsquare of the unemployment variable.
(I would argue this is a substantial enough increase to warrant using both variables). 
The stepwise method also determined crowded and unemployment as the best predictor variables. 
Although the crowded variable had one of the higher VIFs, it was only around 6.
In models of unemployment alone it has a very high c(p), while models with crowded only, have very low r square values
Due to the better c(p) value and higher r square, I would argue the best model included both the crowded and  unemployment variables*/

/*Part 2 k*/

proc reg data=teen;
model birthrate = crowded unemployment;
run;

/*The new r square value is around 0.63. This is better than both models with only unemployment or crowding.
This means 63% of the variance in birthrate is predicted by these variables.
If I had to guess I would say that crowding may predict some birthrate trends that are not fully accounted for by unemployment,
partially due to the fact unemployment and crowding have low correlations as seen in the proc corr procedure.


/*Part 2 l*/
/*Yes all of the assumptions are met, and seem to fit even better than our previous model*/



/*Part 2 m*/



proc reg data=teen;
	model birthrate = unemployment crowded;
	test crowded=0;     /*Test for significance*/
Run;

/*Yes, the new model is better because the f value of 24.4 is far higher than any possible f distribution value. 
If I had tested a value we know is insignificant, such as community, the f value would be less than the distribution*/


/*Part 2 n*/
proc reg data=teen;
	model birthrate = crowded unemployment/r;
	ID communityname;
Run;
/*Yes, observation 37, Fuller Park, is extremely influential. Gage Park and oakland are also abnormal and removing them should be considered.
It is likely Fuller Park is the one point on the reg tables outside the acceptable parameters for both r student and leverage .
It would be justified Fuller Park but not necesarily .*/


/*Part 2 o*/
/*I think the best model is birthrate=unemployment crowded. My next step would be to remove Fuller park from the data set. */
 
