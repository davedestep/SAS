proc import out=cancer
datafile="/home/dmd12d0/STA3024 Data/data.csv"
dbms=csv replace;
run;
proc print data=cancer;
run;

data cancer;
set cancer;
if diagnosis="M" then diagnosisI=1;
if diagnosis="B" then diagnosisI=0;
run;
proc sort data=cancer;
by diagnosisI;
run;
/*What predictors are associated with malignancy in cancer tumors*/
proc logistic data=cancer;
model diagnosisI=radius_mean	texture_mean	perimeter_mean	area_mean	
	smoothness_mean	compactness_mean	concavity_mean	"concave points_mean"n	
	symmetry_mean	fractal_dimension_mean;
run;
proc sgscatter data=cancer;
	compare  x=(radius_mean	texture_mean	perimeter_mean	area_mean	
		smoothness_mean	compactness_mean	concavity_mean	"concave points_mean"n	
		symmetry_mean	fractal_dimension_mean) y=diagnosisI / loess=(smooth=0.25);
		run;
/*very difficult to interpret plots, redid them differently to more easily 
compare loess curves*/
proc sgscatter data=cancer;
	plot diagnosisI*(radius_mean	texture_mean	perimeter_mean	area_mean	
		smoothness_mean	compactness_mean	concavity_mean	"concave points_mean"n	
		symmetry_mean	fractal_dimension_mean) / loess=(smooth=0.25);
		run;

/*determine if good fit*/	
proc reg data=cancer;
model diagnosisI=radius_mean	texture_mean	perimeter_mean	area_mean	
	smoothness_mean	compactness_mean	concavity_mean	"concave points_mean"n	
	symmetry_mean	fractal_dimension_mean;
run;
/*radius is chosen predictor*/
/*a*/
proc logistic data=cancer descending;
model diagnosisI=radius_mean/clodds=wald clparm=wald;
run;
/*parameter estimates: 0.8511, 1.2161*/
/*b-gstat*/
proc logistic data=cancer ;
model diagnosisI(event='1')=radius_mean/clodds=wald clparm=wald rsq;
run;
/*r2=0.5232*/

/*Empirical Logit Plot (format found in class notes)*/
Proc Rank data=cancer groups=5 out=out; /*Creates 5 bins */
  var radius_mean; /*X variable*/
  ranks Bin; /*Creates the variable Bin to indicate groupings*/
Run;
/*Summarize the results of each bin*/
proc means data=out nway noprint;
	class bin; /*Calulate means by each group*/
	var diagnosisI radius_mean;
	output out=Bins sum(diagnosisI)=diagnosisI mean(radius_mean)=radius_mean; 
Run;
/*Check output file*/
proc print data=Bins;
Run;

/*Empirical Logit Calculation*/
Data bins2;
	set bins;
	EmpLogit = Log((diagnosisI+.5)/(_freq_ - diagnosisI + .5)); /*Log odds with a 
	                                             continuity correction*/
Run;

proc print data=bins2;
Run;

/*Create plot to check for liinearity*/
Title "Empirical Logit Plot";
proc sgplot data=bins2;
	reg x=radius_mean y=diagnosisI ;
	loess x=radius_mean y=diagnosisI/smooth=0.4 ;
Run;
/*the empirical logit plot shows the data is linear
Because it appears linear there is no need to raise the predictor 
to a different degree.*/

proc logistic data=cancer;
model diagnosisI (event='1') = radius_mean/ iplots ;
OUTPUT OUT=SA RESCHI=resids;
run;

/*We are supposed to look at the Pierce residual, 
I used the reschi statement in output to find the pearson residuals in the 
output data tab. There are significantly more extreme residuals for malignant 
variables. Because there is so many observations, I find it unneccessary to remove 
any of these examples. If it were neccessary some of the observations with 
residuals above 6 could be removed like patient with id 9013838 */


/*odds ratio and confidence interval*/
proc logistic data=cancer descending;
	model diagnosisI (event='1') = radius_mean / clodds= wald ;
run;
/*The estimated odds ratio is 2.811 with the confidence interval (2.342, 3.374)
For each increase in radius by 1 the odds of having a malignant tumor 
inrease by 2.811. I would consider this a meaningful ratio*/

/********************************

Part 4 H:
Select a new value (x*) of interest for your predictor variable 
(preferably a value not  contained in your original data set).  
Produce a predicted probability of success using SAS.
 Based on model, also determine (by hand if convenient) what value of x 
 produces an estimated probability of 0.5

**********************************/
/*determine the range of the chosen predictor*/
proc univariate data=cancer;
var radius_mean;
run;
/*range: 6.981 to 28.11*/
/*choose 11.00 as value for x* */
data cancer;
set cancer;
keep radius_mean	texture_mean	perimeter_mean	area_mean	
	smoothness_mean	compactness_mean	concavity_mean	"concave points_mean"n	
	symmetry_mean	fractal_dimension_mean diagnosisI;

data predictH;
Infile datalines dsd;
input radius_mean	texture_mean	perimeter_mean	area_mean	
	smoothness_mean	compactness_mean	concavity_mean	"concave points_mean"n	
	symmetry_mean	fractal_dimension_mean diagnosisI;
datalines;
11.00,,,,,,,,,,,
;
run;
data predicting;
set predicth cancer;
run;
/*from class notes 11/10*/
proc logistic data=predicting descending;
model diagnosisI=radius_mean/expb;
output out=PredProbs Predicted=Pi_Hat;
Run;
proc print data=PredProbs (obs=5);
Run;
Data Fifty50;
B0= -15.2459; /*find on proc logistic output*/
B1 = 1.0336; 
eleven50 = -B0/B1; /*Solve log(p/(1-p)) = B0 + B1*X   for p= .5 */
Put eleven50; /*Place the result in the SAS Studio Log*/
Run;
proc print data=fifty50;run;


/*Part 4 I*/
proc reg data=cancer;
	model diagnosisI = radius_mean	texture_mean	
	perimeter_mean	area_mean	smoothness_mean	compactness_mean	
	concavity_mean	"concave points_mean"n	symmetry_mean	
	fractal_dimension_mean/vif;
run;
proc reg data=cancer;
	model diagnosisI = texture_mean	perimeter_mean	area_mean	
	smoothness_mean	compactness_mean	concavity_mean	"concave points_mean"n	
	symmetry_mean	fractal_dimension_mean/vif;
run;
/*Mean perimeter has the highest variance inflation factor. 
Radius_mean is also extremely high, having a VIF of over 1000.
For now they will be retained in order to complete a stepwise selection
Otherwise I would consider removing them and the new VIF outputs would be examined
Colinearity does not necessarily reduce the predictive power of the model, 
so further criteria must be explored*/
/******************

Any potential issues with colinearity?


***************************/

/*Determining a reduced model looking at colinearity, VIF, and selection methods*/
Proc Logistic data=cancer;
	model diagnosisI = radius_mean	texture_mean	perimeter_mean	area_mean	
	smoothness_mean	compactness_mean	concavity_mean	"concave points_mean"n	
	symmetry_mean	fractal_dimension_mean
	/selection=score;
Run;
Proc Logistic data=cancer;
	model diagnosisI = radius_mean	texture_mean	perimeter_mean	area_mean	
	smoothness_mean	compactness_mean	concavity_mean	"concave points_mean"n	
	symmetry_mean	fractal_dimension_mean
	/selection=stepwise;
Run;
Proc Logistic data=cancer;
	model diagnosisI = radius_mean	texture_mean	
	perimeter_mean	area_mean	smoothness_mean	compactness_mean	
	concavity_mean	"concave points_mean"n	symmetry_mean	fractal_dimension_mean
	/selection=b;
Run;
Proc Logistic data=cancer;
	model diagnosisI = radius_mean	texture_mean	
	perimeter_mean	area_mean	smoothness_mean	compactness_mean	
	concavity_mean	"concave points_mean"n	symmetry_mean	fractal_dimension_mean
	/selection=f;
Run;

/*Forward Selection:
texture_mean 	1 	-0.3742 	0.0617 	36.8224 	<.0001
perimeter_mean 	1 	0.3324 	0.1448 	5.2733 	0.0217
area_mean 	1 	-0.0347 	0.0111 	9.7096 	0.0018
smoothness_mean 	1 	-55.1927 	24.5146 	5.0689 	0.0244
concave points_mean

Stepwise Selection:
1 	concave points_mean 	  	1 	1 	343.1804 	  	<.0001
2 	texture_mean 	  	1 	2 	54.6754 	  	<.0001
3 	area_mean 	  	1 	3 	34.0661 	  	<.0001
4 	perimeter_mean 	  	1 	4 	5.5530 	  	0.0184
5 	smoothness_mean*/
proc reg data=cancer;
	model diagnosisI = texture_mean perimeter_mean area_mean 
	"concave points_mean"n radius_mean;
run;
proc reg data=cancer;
	model diagnosisI = texture_mean perimeter_mean area_mean 
	"concave points_mean"n radius_mean/vif;
run;
proc logistic data=cancer descending;
	model diagnosisI = texture_mean perimeter_mean area_mean 
	"concave points_mean"n radius_mean;
	run;

/*Do we want smoothness? according to the score selection it may be unnecessary*/
proc reg data=cancer;
	model diagnosisI = texture_mean perimeter_mean area_mean 
	"concave points_mean"n smoothness_mean;
run;
proc reg data=cancer;
	model diagnosisI = texture_mean perimeter_mean area_mean 
	"concave points_mean"n smoothness_mean/vif;
run;
proc logistic data=cancer descending;
	model diagnosisI = texture_mean perimeter_mean area_mean 
	"concave points_mean"n smoothness_mean;
	run;
/*Used these three tests looking at radius and smoothness to determine 
the fit of the reduced new model and potential 5 variable models. 
because radius was not included in the stepwise selection,
has a high VIF, and is insignificant using proc logistic, it will be removed.
I also used the score selection method to  compare the five variable models 
provided by stepwise and forward elimination (they included smoothness)
to potential four variable models. The four variable model chosen has a similar 
chi square to the five variable models.
Smoothness was also insignificant in proc logistic so it was also removed. 
The new model includes texture_mean perimeter_mean area_mean "concave points_mean"n */

proc reg data=cancer;
model diagnosisI = texture_mean perimeter_mean area_mean "concave points_mean"n ;
run;
proc reg data=cancer;
model diagnosisI = texture_mean perimeter_mean area_mean "concave points_mean"n /vif;
run;
proc logistic data=cancer descending;
	model diagnosisI = texture_mean perimeter_mean area_mean "concave points_mean"n;
run;
/*The model is highly significant, the liklihood ratio, score, and wald p values are
 all less than .0001*/



/*Part 4 L, Nested F test*/
proc reg data=cancer;
	model diagnosisI= radius_mean	texture_mean	perimeter_mean	area_mean	
	smoothness_mean	compactness_mean	concavity_mean	"concave points_mean"n	
	symmetry_mean	fractal_dimension_mean;
	test texture_mean, perimeter_mean, area_mean, "concave points_mean"n;
run;
/*the liklihood ratio test provides a p value of .0001. 
Because this is significant, we know we an reject the null hypothesis 
that the original model with all predictors present should be retained.
Therefore we retain the reduced model in favor of the full one*/


/*m - Make a prediction of the probability of success for a set of values 
for your predictors in your best model.*/
data camcer;
set cancer;
keep texture_mean perimeter_mean area_mean "concave points_mean"n diagnosisI;
run;
data predictM;
/*Infile datalines dsd;*/
input texture_mean perimeter_mean area_mean "concave points_mean"n diagnosisI;
datalines;
10.49 100 654 .063 ,
;
run;
data predictingm;
set predictM camcer;
run;
proc logistic data=predictingm descending;
model diagnosisI=texture_mean perimeter_mean area_mean "concave points_mean"n /expb;
output out=PredProbs Predicted=Pi_Hat;
Run;
proc print data=PredProbs (obs=1);
Run;


/*n- Create ROC curves for your best model and one additional model of your choosing.
Interpret the difference observed between the two ROC curves.*/
/*part 4 n*/
proc logistic data=cancer plots=ROC;
	model diagnosisI (event='1') = texture_mean perimeter_mean 
									area_mean "concave points_mean"n;
Run;

/*Comparison of ROC curve for different models, format take from Sta 3064 12_01 notes*/
proc logistic data=cancer plots=ROC;
	model diagnosisI (event='1') = texture_mean perimeter_mean area_mean "concave points_mean"n;
	ROC 'Texture_mean only' texture_mean;   /*A labe must be included in quotes*/
Run;

/*Radius and smoothness included*/
proc logistic data=cancer plots=ROC;
	model diagnosisI (event='1') = texture_mean perimeter_mean area_mean "concave points_mean"n radius_mean smoothness_mean;
	ROC 'Radius Only' Radius_mean;   /*A labe must be included in quotes*/
	ROC 'Smoothness Only' smoothness_mean;
	ROC 'Radius and Smoothness' radius_mean smoothness_mean;
Run;


/*Include a contrast between models*/
proc logistic data=cancer plots=ROC;
	model diagnosisI (event='1') = texture_mean perimeter_mean area_mean "concave points_mean"n radius_mean smoothness_mean;
	ROC 'Radius Only' Radius_mean;   /*A labe must be included in quotes*/
	ROC 'Smoothness Only' smoothness_mean;
	ROC 'Radius and Smoothness' radius_mean smoothness_mean;
	ROCCONTRAST reference ('radius only')/estimate e;
Run;
