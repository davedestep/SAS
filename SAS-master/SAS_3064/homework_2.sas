/* David DeStephano  Assingment 1*/
/*I certify that the SAS code given is my original and exclusive work*/

/*Question 1a*/


Data texts;
Input Pages Price;
datalines;
600 95.00
91 19.95
200 51.50
400 128.50
521 96.00
315 48.50
800 146.75
800 92.00
600 19.50
488 85.50
150 16.95
140 9.95
194 5.95
425 58.75
51 6.50
930 70.75
57 4.25
900 115.25
746 158.00
104 6.50
696 130.50
294 7.00
526 41.25
1060 169.75
502 71.25
590 82.25
336 12.95
816 127.00
356 41.50
248 31.00
;
run;
proc reg data=texts;
model price=pages;
run;

/*The hypothesis is that the price will influence the number of pages, it will likely have a positive correlation.*/
/*The t value is 7.65 (not important) and the p value is <.0001
Because the p value is so low we can conclude the correlation is statically significant and the number of pages will influence the price*/


/*Question 1 b*/
/*The population slope is 0.14733 with the data given
The slope helps us predict the "expected" Y, or price, for each value of x, or pages */




/*Question 1.1 (2.15) a*/
/*At first I did not understand the difference between a "particular 450 page text" asked in part b vs a regular old "450 page text" asked here,
because only the 95% CL prediction was appearing in my table. 
The population mean of the price of all data on a scale from 0 to 900 was 65.01667. 
The interval of the mean is 51.730 to 74.0202
*/	



/*Question 1.1 (2.15) b*/
/*In this question I found the actual predicted price of a 450 page text, not the population mean, using a hidden y test*/ 

data texts2;     /*Doing a hidden y test*/
input pages price;
datalines;
450 .    
;                /*only using 450 to estimate the price*/
run;



data texts3;
set texts texts2;           /*combining data*/
proc reg data=texts3;
model price=pages /clm cli ;    /*cli creates the predictions*/
id pages;
run;

/*The predicted y variable, or price, when a book has 450 pages is 62.8755
The predicted confidence interval was 0.9036	124.8474  */


/*Question 1.1 c*/
/*I think the midpoints are about the same in the low 60s.
It makes since they are similar, if not the same, because the prediction interval is only trying to predict the likely parameter of y
the mean interval is predicting the mean, which will be a much narrower interval.
Confidence intervals (CL mean) take into account the different possible slopes of the regression line (95% best fit lies within interval) (or the dependent variable (mean)).
Prediction intervals (CL predict) are for the value of y (95% chance y lies within interval)

However the predicted y value and the mean y value determined from the likely best fit line often line up, 
making it likely the two intervals have the same median. 
(Rather hard to explain confidence vs prediction intervals, but the data should correlate despite them predicting different things)*/




/*Question 1.1 d*/
/*CLM prediction is much wider.
Prediction intervals (CLI) include more factors and account for every possible y value 95% of the time.
Confidence intervals only predict the mean/dependent variable 95% of the time, making it narrower because the dependent variable varies less than individual y values*/



/*Question 1.1 e*/
proc univariate data=texts;
var pages;
run;
proc print data= texts;
run;
/*Predicition intervals dont change very much, but the narrowest interval should be around the mean of x (464)
where there is minimal standard error*/  




/*Question 1.1 f*/
data textsf;     /*Doing a hidden y test*/
input pages price;
datalines;
1500 .    
;                /*only using 1500 to estimate the price*/
run;



data texts3;
set texts textsf;           /*combining data*/
proc reg data=texts3;
model price=pages /clm cli ;    /*cli creates the predictions*/
id pages;
run;
/*The interval would be (143.3587, 291.7820)
This interval may not be accurate because there is no data in the 1500 page range, 
therefore we dont know if the trend would continue or not*/




/*Question 2a*/
data enroll;
input Ayear Fall Spring;
datalines;
2001     259     246
2002     301     206

2004     307     215
2005     286     230
2006     273     247
2007     248     308
2008     292     271
2009     250     285
2010     278     286
2011     303     254
;
run;
proc reg data=enroll;
model spring=fall;
run;
/*There is not a constant variance. The residuals stay unusually far from 0 and do not approach it except in 2011.
The data is not very linear and stay far away on both sides from the best fit line.
The residuals are also not normally distributed, having a s like pattern on the quantile plot*/

/*Question 2b*/
/*48.68 percent of variability in spring is explained by fall*/

/*Question 2c*/
/*Anova is provide in the results*/

/*Question 2d*/
/*Because p<.05, we can dismiss the null hypothesis that the mean =0 and conclude there is an association between spring and fall enrollment*/

/*Question 2e*/
data enroll;
input Ayear Fall Spring;
datalines;
2001     259     246
2002     301     206

2004     307     215
2005     286     230
2006     273     247
2007     248     308
2008     292     271
2009     250     285
2010     278     286
2011     303     254
;
run;
proc reg data=enroll;
model spring=fall/clb;
run;
/*The interval is (-1.92578, -0.17082) which doesnt contain 0 meaning the slope cant be 0 
which means the null hypothesis is not true meaning the variables could be statistically associated*/


/*Question 2.1 a b c and d*/
data enroll2;     /*Doing a hidden y test*/
input Ayear Fall Spring;
datalines;
. 290 . 
;               
run;



data enroll3;
set enroll enroll2;           /*combining data*/
proc reg data=enroll3;
model spring=fall/clm clb cli;    
run;

/*I would predict enrollment to be 244
With CL mean between 223.6930 and 264.3120 
CL prediction is between 183.0076 and 304.9974
I would suggest the interval from part C be used because we are predicting a single semester, not an average, so there is more potential for variation*/


/*Question 3*/

data infant;
input mortality year;
datalines;
85.8       1920
64.6       1930
47         1940
29.2       1950
26         1960
20         1970
12.6       1980
9.2        1990
6.9        2000
;
run;
proc print data = infant;
run;

proc sgplot data=infant;
scatter x=year y=mortality;
run;

/*There is a downward trend as years go by. If associated there would be a negative correlation*/

/*Question 3 B*/
data infant;
input mortality year;
datalines;
85.8 1920
64.6 1930
47 1940
29.2 1950
26 1960
20 1970
12.6 1980
9.2 1990
6.9 2000
;
run;
proc reg data = infant;
model mortality=year;
run;
/*The residuals do not seem constant because they make a U shape.
The data is more or less linear and the residuals are probably not distributed normally,
the residuals are somewhat high and do not fit perfectly on the quantile graph
There is not really enough data to be sure but if there was I would expect it to fit
but I cant say it fits with the present data*/

/*Question 3c*/
proc transreg data=infant;
model boxcox(mortality) = identity(year);
run;
/*Use log because boxcox gives us 0 on the numberline*/
data infant2;
set infant;
/*Create transformed y variables*/
Loginf = log(mortality);

Run;

/*Run regressions with transformed Y's*/
proc reg data=infant2;
Log: Model Loginf = year;

Run;
/*Question 3d and e*/
/*The p value is also below 0.5 so there is some kind of relationship*/
/*Infant mortality has decreased significantly since 1920 and there is significant data that points towards
there being a correlation between lower mortality rates but it is unlikely to decrease as much from 2010 onwards.
(The rate of decreasing mortality rates is itself, decreasing*/

