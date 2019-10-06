/* David DeStephano  Assingment 1*/
/*I certify that the SAS code given is my original and exclusive work*/

/*Question 1a*/

Data day1survey;
Input Section  Class $  Sex $  Distance   Height   Handedness $  Coins   WhiteString   BlackString   Reading   TV   Pulse   Texting;
datalines;

1   Senior   F   400   62   Right   1.12   42   6   80   3   71   3
1   *   F   450   61   Left   29   45   5   100   10   78   100
1   Freshman   F   3000   61   Right   1.5   22   4   100   4   80   2
1   Freshman   M   100   72   Right   0.07   40   4   50   25   63   200
1   N/A   F   2000   69   Right   0.12   48   7   200   5   63   100
1   Senior   M   500   73   Right   8   30   8   100   0   56   1
1   Sophomore   F   1100   60   Right   0.77   50   0   200   2   72   50
1   Sophomore   M   1000   71   Right   0   45   6   100   2   66   30
1   Sophomore   M   400   70   Right   0   38   0   100   20   54   40
1   Sophomore   M   450   75   Left   0   36   12   100   20   48   25
1   Sophomore   M   400   71   Right   25   48   12   250   8   81   25
1   Senior   M   762   69   Ambidextrous   4   48   6   2000   2   66   40
1   Senior   M   300   68   Right   3   40   11   175   1   69   5
1   Sophomore   F   2300   62   Right   500   32   3   200   3   51   5
1   Junior   M   50   77   Right   0   36   2   50   4   66   5
1   Senior   F   150   62   Right   1   30   0   200   0   57   10
1   Junior   M   250   70   Right   0.25   35   2   200   6   57   25
1   Senior   M   600   73   Right   4   48   20   450   1.5   75   2
1   Senior   M   800   71   Left   0   40   15   100   0   72   2
1   Junior   M   195   70   Right   0.75   30   3   75   1.5   96   3
1   Junior   F   5000   66   Right   4   24   0   100   4   60   1
1   Freshman   M   600   66   Left   0   38   2   40   2   78   10
1   Junior   M   380   74   Right   0   43   6   300   4   63   4
1   Freshman   F   4500   70   Right   2.34   40   4   50   2   60   12
2   Freshman   M   1250   74   Right   120   40   2   50   4.5   81   40
2   Freshman   M   750   73   Right   2.75   36   3   12.5   6   57   45
2   Freshman   F   100   66   Right   3   36   42   2   3   75   10
2   Junior   M   426   70   Right   0   33   4   300   2   81   4
2   Sophomore   F   700   67   Right   2.5   43   3   200   2   72   18
2   Freshman   M   150   70   Right   20   70   1   80   10   60   100
2   Freshman   F   700   62   Right   1   38   2   20   8   75   70
2   Freshman   F   180   70   Right   0   29   4   200   7   51   250
2   Freshman   M   780   74   Right   35   43   3   250   7   72   4
2   Senior   M   800   73   Right   0.14   40   2   23   4   72   6
2   Junior   F   2000   66   Right   0   30   3   50   1   90   3
2   Junior   M   300   69   Right   10   30   2   45   0   66   1
2   Freshman   M   20000   71   Right   25   30   5   75   5   57   0
2   Junior   M   10000   73   Right   0   26   0   10   5   51   0
2   Junior   M   300   71   Right   0.62   38   2   200   2   72   5
2   Junior   F   1000   68   Right   1.28   42   4   160   2   75   28
2   Senior   F   280   65   Right   0   50   7   200   4   51   13
2   Senior   M    .  73   Right   0   32   0   150   2   54   10
2   Sophomore   F   900   62   Right   0.35   34   5   65   2.5   72   13
;
run;
proc ttest data=day1survey;   /*Test to see if means are different*/
class sex;
var reading;
run;


/*Based on the means alone we can infer men read more than women (in the sample).
However, the relevant p value is greater than .05 so we can not conclude men and women have a different mean of reading 
at the population level.
(because our null hypothesis is that the means are different, which we can not reject)*/



/*Question 2 a*/

data stamps;
Input year Price;
datalines;
1885 2
1917 3
1919 2
1932 3
1958 4
1963 5
1968 6
1971 8
1974 10
1975 13
1978 15
1981 18
1981 20
1985 22
1988 25
1991 29
1995 32
1999 33
2001 34
2002 37
2006 39
2007 41
2008 42
2009 44
2012 45
;
run;
proc print data = stamps;
run;

proc sgplot data=stamps;
scatter x=year y=price;
run;
/*The first four data points skew the plot significantly, likely altering the best fit line as well as the appearance of the relationship
between year and price. The first four points make it seem the data is not very correlated and it does not have a linear relationship
When it very well might*/


/*Question 2b */

data stamps2;
Input year Price;
datalines;
1958 4
1963 5
1968 6
1971 8
1974 10
1975 13
1978 15
1981 18
1981 20
1985 22
1988 25
1991 29
1995 32
1999 33
2001 34
2002 37
2006 39
2007 41
2008 42
2009 44
2012 45
;
run;
proc sgplot data= stamps2;
reg x=year y=price;
run;

proc reg data=stamps2;
	model price = year; /*Y=price X=year*/
run;

/*The equation is: Price = 0.84098*Year - 1647.17451*/

/*Question 2c*/
/*I already created a plot with a regression line from 1958 to 2012. 
The line appears to fit the data very well.*/


/*Question 2d*/

proc reg data=stamps;     /*Including each year*/
	model price = year; /*Y=price X=year*/
run;
/*When including years before 1958 there is not a constant variance whatsoever*/
/*When years before 1958 are excluded however, the variance seems to be more or less constant,
with a slight imbalance (few points above 0, and those half of those are outliers
in the first 25 years or so. 
The data is as also linear with normally distributed residuals (normal quantile graph), 
and has a more or less constant variance, as previosuly stated
Therefore, the conditions are met*/



/*Question 3*/

Data texts;
Input Pages	Price;
datalines;
600 95.00
91 19.95
200 51.50
400 128.50
521	96.00
315	48.50
800	146.75
800	92.00
600	19.50
488	85.50
150	16.95
140	9.95
194	5.95
425	58.75
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
proc sgplot data=texts;
scatter x=pages y=price;
run;

/*The plot reveals it would not hurt to get more observations but from the looks of it the students 
have a valid hypothesis. It still must be found if the apparent correlation is strong or weak*/


/*Question 3 b*/
proc reg data=texts;   
	model price = pages;
run;
/*Equation: Price = 0.14525*pages -0.48328*/


/*Question 3 c*/

/*The residuals are somewhat bunched in the beginning but not enough to discount the variance being constant.
The plot is linear and positively correlated
and the best fit line on the normal q-q graph is not prefect but lines up well enough with the residual points*/


/*Question 4*/

data retirement;
input year SRA;
datalines;
1997 787.08
1998 968.16
1999 1975.08
2000 3990.00
2001 5455.80
2002 6338.60
2003 566.25
2004 7014.90
2005 10500.00
2006 10945.06
2007 12250.80
2008 13035.45
2009 13053.15
2010 14993.60
2011 952.04
2012 17349.69
;
run;
proc reg data=retirement;
	model SRA=year;
run;

/*2003 and 2011 have unusually low SRA and their associated residual values. 
Using the distribution graph (lower left) I know the values of the residuals are approximately -12000 and -5000.
I would definately argue that the residual in 2011 is an outlier considering most of the residuals are at, or a little above 0.
My main argument for this is that it is outside the normal distribution and in the distribution plot is the only point 
not inside the distribution (line).
It is also outside the 95% prediction limits. In this case I will use 95% as a strong indicator of it being an outlier, 
if it was outside 99% it would be an outlier without any doubt

I do not consider the residual in 2003 an outlier because it does not meet these conditions*/

/*Question 4b*/
data retirement2;
input year SRA;
datalines;
1997 787.08
1998 968.16
1999 1975.08
2000 3990.00
2001 5455.80
2002 6338.60
2004 7014.90
2005 10500.00
2006 10945.06
2007 12250.80
2008 13035.45
2009 13053.15
2010 14993.60
2012 17349.69
; /*Removed sabatical years*/
run;
proc reg data=retirement2;
	model SRA=year;
run;
/*Yes, this model provides a much better fit. After removing the sabaticals there is a constant variance, a better (normal)
distribution, and higher linearity*/


