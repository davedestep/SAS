/*1. Refer to exercise 8.2 from Oehlert. Perform the following tasks:
a)  Draw both interaction plots for these data. (1 point)
b)  Compute the ANOVA table.  (2 points) Hint:  since you don’t have the original
data, only the means, you will need to build the ANOVA table by hand (or in
Excel or SAS).
c)  Based on the p-values obtained at b, determine which terms are needed to de-
scribe the means. (1 point)
2. Refer to problem 8.1 from Oehlert. Hint:
a)  Check for constant variance. (1 point)
b)  Use the Box-Cox method to find an appropriate transformation for the response.
(1 point)
c)  Transform the response by the transformation you found at b and re-check for
constant variance. (1 point)
d)  Check for normality on the model from c). (1 point)
e)  Which terms of the model from c) are significant at the 0.05 level? (1 point)
f)  Draw both interaction plots for the model from c). (1 point)*/


/*??????????? 2f ????????????*/

/*Question 1 a*/
data ex08_2;
 input day  temp   freeAcid  ; cards;
           1    22               39.4
           1    24               49.9
           1    26               55.1
           1    28               59.5
           2    22               56.4
           2    24               68.0
           2    26               76.4
           2    28               88.8
           3    22               70.2
           3    24               81.5
           3    26               95.6
           3    28               99.6
;
proc glm data=ex08_2;	
	class day temp;
	model freeacid=day|temp/ss3;
run;
proc glm data=ex08_2;	
	class temp day;
	model freeacid=temp|day/ss3;
run;




/*Question 1 B*/
/*******
Anova Table
Column Means
22		24		26		28
55.33  66.47  75.70  82.63
Grand Mean
70.03

The total sum of squares was 8097 
For balanced data, the SS decomposition is also easy.
SST = SSConst+ SSA+ SSB+ SSAB+ SSE

ss temp 8(55.33-70.03)^2 + 8(66.47-70.03)^2 + 8(75.70-70.03)^2 + 8(82.63-70.03)^2 = 3357.38
ss day 6(50.98-70.03)^2 + 6(72.40-70.03)^2 + 6(86.72-70.03)^2 =3882.453

SSinteraction (Ykj-Yk-Yj-Ygrand)
2(39.4- (50.98-70.03)-(55.33-70.03) -70.03)^2+ 
2(49.9- (50.98-70.03)-(66.47-70.03) -70.03)^2+  
2(55.1- (50.98-70.03)-(75.70-70.03) -70.03)^2+  
2(59.5- (50.98-70.03)-(82.64-70.03) -70.03)^2+  

2(56.4- (72.40-70.03)-(55.33-70.03) -70.03)^2+  
2(68.0- (72.40-70.03)-(66.47-70.03) -70.03)^2+  
2(76.4- (72.40-70.03)-(75.70-70.03) -70.03)^2+  
2(88.8- (72.40-70.03)-(82.64-70.03) -70.03)^2+
  
2(70.2- (86.72-70.03)-(55.33-70.03) -70.03)^2+  
2(81.5- (86.72-70.03)-(66.47-70.03) -70.03)^2+  
2(95.6- (86.72-70.03)-(75.70-70.03) -70.03)^2+  
2(99.6- (86.72-70.03)-(82.64-70.03) -70.03)^2

=142.018



Source	Df	   		ss			MS		    F   	    P
Temp 	3           3357.38     1119.13     18.7796     0.0000792287	   
day     2           3882.45     1941.23     32.5748     0.0000141607
Inter   6           142.018     23.67       0.39717     0.8669926929
error	12          715.152     59.596
total	            8097
*/

data pval;
pvaltemp = 1-cdf('F', 18.7796, 3,12);
pvalday = 1-cdf('F', 32.5748, 2,12);
pvalinter = 1-cdf('F', 0.39717, 6,12);
run;


/*Question 1 c*/
/*The P values of temperature and day are both statistically significant, while their interaction is not.
This means the nitrogen content of rice depends on both the day and temperature, because the means are significantly different.
There is also no interaction between the two*/




/*Question 2*/
/*Brewer’s malt is produced from germinating barley, so brewe
rs like to
Problem 8.1
know under what conditions they should germinate  their barl
ey.   The  fol-
lowing is part of an experiment on barley germination.  Barle
y seeds were
divided into 30 lots of 100 seeds, and each lot of 100 seeds was
germinated
under one of ten conditions chosen at random.  The conditions
are the ten
combinations of weeks after harvest (1, 3, 6, 9, or 12 weeks) a
nd amount
of water used in germination (4 ml or 8 ml).  The response is the
number of
seeds germinating. We are interested in whether timing and/
or amount of wa-
ter affect germination.  The data for this problem are in Tabl
e 8.1 (Hareland
and Madson 1989).  Analyze these data to determine how the ger
mination
rate depends on the treatments.*/


/*Question 2 a*/
/*The variance is not constant*/
data pr08_1;
 input weeks  water  seedsGerm  ; cards;
            1      4                  11
            1      8                   8
            3      4                   7
            3      8                   1
            6      4                   9
            6      8                   5
            9      4                  13
            9      8                   1
           12      4                  20
           12      8                  11
            1      4                   9
            1      8                   3
            3      4                  16
            3      8                   7
            6      4                  19
            6      8                   9
            9      4                  35
            9      8                  10
           12      4                  37
           12      8                  15
            1      4                   6
            1      8                   3
            3      4                  17
            3      8                   3
            6      4                  35
            6      8                   9
            9      4                  28
            9      8                   9
           12      4                  45
           12      8                  25
;
proc glm data=pr08_1 plot=diagnostics;
class weeks water;
model seedsGerm = weeks|water/ss3;;
run;


/*Question 2 b*/
/*With graphics on the given lambda is 0.36. Choosing the lamda without the graphics its most convenient to pick 0.5 but still best to use 0.36*/
proc transreg data=pr08_1;
model BoxCox(seedsgerm/lambda=0 to 0.7 by 0.01 alpha=0.05) = class(water weeks water*weeks);
run;


/*Question 2 c*/
/*There is now a constant variance*/
/*Question 2 D*/
/*The data is now normal*/
/*Question 2 e*/
/*Weeks and water are both significant at the 0.05 level but their interaction (weeks*water) is not*/ 
data seeds2;
	set pr08_1;
	 seedsgerm2 = seedsgerm**0.36;
run;
proc glm data=seeds2  plots=diagnostics;
	class water weeks;
	model seedsgerm2 = water|weeks/ss3;;
Run;
proc glm data=seeds2  plots=diagnostics;
	class weeks water;
	model seedsgerm2 = weeks|water/ss3;;
Run;


