/*David DeStephano, Homework 3*/

/*1. Exercise 5.3 from Oehlert. (4 points)
2. Exercise 5.4 from Oehlert. (3 points)
3. Exercise 6.1 from Oehlert. (3 points)*/


/*Exercise 5.3
Refer to the data in Problem 3.1.  Test the null hypothesis that
all pairs of workers produce solder joints with the same average strength
against the alternative that some workers produce different average 
strengths.  Control the strong familywise error rate at .05.*/
data operators;
Input worker strength substrate $;
datalines;
1 5.60 a
1 6.80 a
1 8.32 a
1 8.70 a
1 7.64 b
1 7.44 b
1 7.48 b
1 7.80 b
1 7.72 c
1 8.40 c
1 6.98 c
1 8.00 c
2 5.04 a
2 7.38 a
2 5.56 a
2 6.96 a
2 8.30 b
2 6.86 b
2 5.62 b
2 7.22 b
2 5.72 c
2 6.40 c
2 7.54 c
2 7.50 c
3 8.36 a
3 7.04 a
3 6.92 a
3 8.18 a
3 6.20 b
3 6.10 b
3 2.75 b
3 8.14 b
3 9.00 c
3 8.64 c
3 6.60 c
3 8.18 c
4 8.30 a
4 8.54 a
4 7.68 a
4 8.92 a
4 8.46 b
4 7.38 b
4 8.08 b
4 8.12 b
4 8.68 c
4 8.24 c
4 8.09 c
4 8.06 c
; 
/*proc univariate data=operators;
class substrate;
by worker;
run; */     /*I used proc univariate to find the mean strength of each worker sorted by the type of substrate*/
/*proc univariate data=operators;
by worker;
run; */
proc glm data=operators;
class worker;
model strength=worker ;
means worker/ /*scheffe lsd snk dunnett*/ REGWQ /*tukey*/;
run;
/*We use REGWQ to determine if we can reject the null hypthesis that some of the workers produce
different average strengths. From the powerpoint, I found the Ryan-Einot-Gabriel-Welsch protects for the SFER.
The REGWR output shows that workers 2 and 4 have different mean values due to the fact their mean differences
are greater than the significant difference (this would be calculated by hand if SAS were not available).
Each of the other tests, besides LSD, have the same outcome, meaning that it makes sense to reject the null hypothesis
as we did with the REGWR because it gives a p value below 0.05.*/ 






/*Exercise 5.4
Refer to the data in Exercise 3.1. Test the null hypothesis that 
all pairs of diets produce the same average weight liver against the 
alternative that some diets produce different average weights. Control the FDR at .05.*/

data diets;
 input liverWt  diet $ ; 
 datalines;
           3.52               1
           3.36               1
           3.57               1
           4.19               1
           3.88               1
           3.76               1
           3.94               1
           3.47               2
           3.73               2
           3.38               2
           3.87               2
           3.69               2
           3.51               2
           3.35               2
           3.64               2
           3.54               3
           3.52               3
           3.61               3
           3.76               3
           3.65               3
           3.51               3
           3.74               4
           3.83               4
           3.87               4
           4.08               4
           4.31               4
           3.98               4
           3.86               4
           3.71               4
;
run;
ods graphics on;
proc glm data=diets /*plot=diagnostics*/;
class diet;
model liverWt = diet;
means diet / SNK;
run;
ods graphics off;
/*SNK controls for the FDR. From this test we can see diet four has a significantly different mean value
than diets two and three. This means that diet four leads to larger liver weights.
The p value is also below 0.05 for this model so we can officially reject the null hypothesis.
I conducted a residual analysis just to check the model assumptions.
Despite having slightly skewed tails, the model meets the three required assumptions, 
so we can trust the model
*/





/*Exercise 6.1
As part of a larger experiment, 32 male hamsters were assigned to four treatments 
in a completely randomized fashion, eight hamsters per treatment.
The treatments were 0, 1, 10, and 100 nmole of melatonin daily, 1 hour prior
to lights out for 12 weeks.  The response was paired testes weight (in mg).
Below are the means and standard deviations for each treatment group (data
from Rollag 1982).  What is the problem with these data and what needs to be done to fix it?*/

/*The standard deviation is extremely high in the larger nmole concentrations.
This probably means the residuals are abnormal and at least one of the model assumptions is not met
(1 independent, 2) normally distributed, 3) have constant variance)
Out of the three assumptions we can conclude the data from the experiment does not have a constant variance.*/
/*
Melatonin 	Mean 	SD
0 nmole		3296    90
1 nmole		2574	153
10 nmole	1466	207
100 nmole	692		332

proc glm 
class treatment;
model

run;
ods graphics off;
*/




