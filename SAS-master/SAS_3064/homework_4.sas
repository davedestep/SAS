/* David DeStephano  Assingment 3*/
/*I certify that the SAS code given is my original and exclusive work*/

/*Question 1*/

data teens;
input region $ gender $ percent;
datalines;
eastern male 24.17
eastern female 42.33
Northern male 51.00
northern female 51.00
continental male 24.33
continental female 33.17
;
run;
proc sgplot data=teens;	
	vline gender/ response=percent stat=mean
	group=region markers;
run;

/*There is an interaction only for southern and eastern Europe, where female teenagers were more likely to have been drunk in the past then men. 
In northern Europe, there is gender has no effect because the mean percent for drunkness between males and females was the same.
Gender and region have an effect.
There IS an interaction between gender and region because the lines touch at a point, meaning the combination of two variables do have a significant effect. 
If there was more data and we used proc glm we could determine conclusively using the pvalue. */



/*Question 2 (Calculated using the two way anova (with interactio) table guide in the powerpoint*/

/* Anova table:
Source	Df	ss		MS		F
Face 	1	12915   12915   129.15
Gender	1   2500    2500	25
inter   1   400     400     4
error   96  9600    100
Total   99  25415
*/

/*part b*/

/*Finding the p values*/
data pval;
pvalface = 1-cdf('F', 12915, 1, 96);
pvalgen =1-cdf('F', 25, 1, 96);
pvalint =1-cdf('F', 4, 1, 96);
run;
/*Pvalue Face=0	    Gender=2.5809911E-6	   interaction=0.0483256917*/




/*Question 3*/
data popcorn;
input Unpopped    Brand $ Trial;
datalines;
26    Orville    1
35    Orville    2
18    Orville    3
14    Orville    4
 8    Orville    5
 6    Orville    6
47    Seaway     1
47    Seaway     2
14    Seaway     3
34    Seaway     4
21    Seaway     5
37    Seaway     6
;
run;
proc means data=popcorn;
var unpopped;
run;

/*Question 3 part a*/
/*For the entire sample, the mean unpopped kernel value is 25.58*/
/* The means for brand are essential for calculating the effects, but were not asked for or asked to be included in the estimation (?)
a(1) would be equal to the orville mean minus the grand mean, or 17.83 - 23.58=-4.75
a(2) is 33.3-25.58=7.75*/

/*Question 3 part b*/
proc glm data=popcorn plots=diagnostics;	
	class brand trial;
	model unpopped=brand trial/ss3;
run;
/*It is hard to check the conditions without more data points but the residuals may not be constant at higher predicted values.
Otherwise it seems to be fine.*/

/*Question 3 part c*/
/*The trial does not make a difference in means between the brands because its p value is above 0.05.
Brand has a low p value aand therefore is statistically significant.*/



/*Question 4*/
data cars;
Input Noise   Size    Filter;
datalines;
810      1      1      
820      1      1      
820      1      1      
840      2      1      
840      2      1      
845      2      1      
785      3      1      
790      3      1      
785      3      1      
835      1      1      
835      1      1      
835      1      1      
845      2      1      
855      2      1      
850      2      1      
760      3      1      
760      3      1      
770      3      1      
820      1      2      
820      1      2      
820      1      2      
820      2      2      
820      2      2      
825      2      2      
775      3      2      
775      3      2      
775      3      2      
825      1      2      
825      1      2      
825      1      2      
815      2      2      
825      2      2      
825      2      2      
770      3      2      
760      3      2      
765      3      2  
;
run;
proc glm data=cars;
	class size filter;
	model noise=size filter/ss3;
run;
/*Both size and filters have an effect but not an interaction.
They are both statistically significant*/


/*Question 4 part b, c , d*/

proc glm data=cars;
	class size filter;
	model noise=size filter/ss3;
	means size/tukey LSD;
run;
/*Both tests show that the means are statistically different. 
My conclusions were not different because the only change between the two tests was with the critical value and min sig diff.
Even when I include cldiff there were no instances in which the confidence limits passed through zero.
Fishers does not provide full control of the experimentwise error rate,
Tukey's makes it more difficult to find a difference, and is preferred for this data because multiple comparisons are needed for each pairwise comparisons*/

 
 
 /*Question 4 part e*/
proc glm data=cars plots=diagnostics;
	class size filter;
	model noise=size filter/ss3;
run;
/*The model assumptions are not met. The residual analysis is very uneven/lopsided*/
	
/*Question 4 part f*/
proc glm data=cars;
	class size filter;
	model noise=size/ss3;
	means size/hovtest;
run;
	
proc glm data=cars;
	class size filter;
	model noise=filter/ss3;
	means filter/hovtest;
run;

/*Yes, the filter variable has a low (close to one) f value suggesting it has equivalent variances, and also has a high pvalue
making the null hypothesis true.*/


/*Question 4 part g*/
data cars2;/*New variables are defined*/
	set cars;
	newvar=Cat(size, filter);
run;
proc print data=cars2;
run;
proc glm data=cars2;
	class newvar filter size;
	model noise=newvar/ss3;
	means newvar/hovtest;
run;
/*The new variables do not all have equal variances because the p value is below 0.05.
If we removed some of the new data to only include new var 31 and 32 we would possibly find eual variances*/


	
