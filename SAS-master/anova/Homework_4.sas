/*1. Refer to exercise 6.4 from Oehlert. Perform the following tasks:
a) Plot the residual vs. predicted values and visually check for constant variance.
(1 point)
b) Run the Levene’s test for constant variance. (1 point)
c) Display the QQ plot of the residuals and visually check for normality. (1 point)
d) Run the Box-Cox method and report the 95% confidence interval for the transformation
of the response with two decimals. (1 point)
e) Based on point d), find a convenient value for the transformation of the response.
(1 point)
f) Transform the response by the log transformation and redo point a) with the
transformed response. (1 point)
2. Exercise 6.5 from Oehlert. (4 points)*/


/*Exercise 1a*/
/*The residual vs predicted plot has a megaphone effect, meaning we should expect there is not a constant variance.
However, because of the small dataset, it is difficult to know for sure.*/ 
/*Exercise 1b*/
/*For the levene test, the null hypothesis is that the variances are equal.
Since the p value is 0.2469, we cannot reject the null hypothesis*/
data delivery;
 input company $ breakage  ; cards;
               1                 17
               1                 20
               1                 15
               1                 21
               1                 28
               2                  7
               2                 11
               2                 15
               2                 10
               2                 10
               3                 11
               3                  9
               3                  5
               3                 12
               3                  6
               4                  5
               4                  4
               4                  3
               4                  7
               4                  6
;

proc glm data=delivery plot=diagnostics;
class company;
model breakage = company;
means company / hovtest;
run;


/*Exercise 1 c*/
/*Normal data can look crooked in small samples, but from what we have the plot seems slightly skewed to the right*/
proc univariate data=delivery noprint;
qqplot breakage;
run;

/*Exercise 1d*/
/*lamda=0.28 Convenient valoue is 0 or 1*/
ods graphics off;/*To find a convenient value*/
proc transreg data=delivery;
model BoxCox(breakage/lambda=-2 to 2 by 0.01 alpha=0.05) = class(company);
run;







/*Exercise 1e, 1f*/
data delivery2;
	set delivery;
	Break2 = breakage**0.3;
run;

proc glm data=delivery2  plots=diagnostics;
	class company;
	model break2 = company/ss3;
	
Run;





/*Exercise 2*/
/*Part a: The plot has a megaphone effect, suggesting the data does not have a constant variance. 
However, the fact the larger residual values are much further away on the x axis than the other residuals, means eyeballing this plot is inconclusive and we can not make any conclusions.
Part b: The Rankit plot is skewed right, and is not linear. This suggests the data is non-normal.
	****Tels us nothing
Part c: This plot suggests that some of the variation in the response is due to time. There seems to be a time trend and possibly a positive temporal dependence,
Therefore time order affects the data, meaning the data is likely not independent.
Part d:This plot does not tell us anything. The residuals seem to be constant and the fact they are seperated on the x axis means nothing.
*/
