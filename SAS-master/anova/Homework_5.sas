/*Homework 5, due February 15th, 11:59pm
February 9, 2017
1. Exercise 7.2 from Oehlert. (3 points)
2. We are in the conditions of exercise 7.3 from Oehlert, where there are four groups,
the sum of the squared treatment effects is 6, the error variance is 3, the group sample
sizes are 4, and
E is 0.01. Answer the following questions:
a) What is the probability of rejecting the null hypothesis when the null hypothesis
is true? (2 points)
b) What is the probability of rejecting the null hypothesis when the null hypothesis
is false? (2 points)
3. Exercise 7.4 from Oehlert. (3 points)*/


/*Exercise 7.2 We are planning an experiment comparing three fertilizers. We will have six experimental units per fertilizer and will do our test at
the 5% level. One of the fertilizers is the standard and the other two are new; 
the standard fertilizer has an average yield of 10, and we would like to be able
to detect the situation when the new fertilizers have average yield 11 each.
 We expect the error variance to be about 4.  What sample size would we need if we want
power .9?*/

/* Question1/Excercise 7.2*/
/*We need a sample size of at least 77 if we want power to be 0.9*/
data Power;
g=3;
alpha=.05;      
sigma2=4;   /*Variance*/
css=0.66666; /* sum of squares of effects  Grand mean=10.666 repeating SS=.1111+.1111+.4444*/
do n=75 to 79;
	nu1=g-1;   /* df for numerator*/
	nu2=n*g-g;    /* df for denominator*/
	Fcrit=finv(1-alpha,nu1,nu2);   
	/*F critical value*/
	nc=n*(css)/sigma2;   /*noncentrality parameter for noncentral F*/
	power=1-probf(Fcrit,nu1,nu2,nc);
	output;
end;
keep n nu1 nu2 nc power;
run;
title Power Calculation in Data Step;
proc print data=Power; 
run;




/*Use sas code to find power g=4 n=4 e=?*/
/*2. We are in the conditions of exercise 7.3 from Oehlert, where there are four groups,
the sum of the squared treatment effects is 6, the error variance is 3, the group sample
sizes are 4, and Ei is 0.01. Answer the following questions:
a) What is the probability of rejecting the null hypothesis when the null hypothesis
is true? (2 points)
b) What is the probability of rejecting the null hypothesis when the null hypothesis
is false? (2 points)

/*Question 2/Exercise 7.3*/
/*Part A: The probability of rejecting the null hypothesis when it is true is another way of saying Type 1 error rate.
The type one error rate was given in the problem, therefore the answer is 0.01 */
/*Part B: The power (and probability) is 0.22609, because power is the same as the probability of rejecting the null hypothesis when the null is false*/
data Power;
g=4;
alpha=.01;      
sigma2=3;   /*Variance*/
css=6; /* sum of squares of effects  */
do n=4;
	nu1=g-1;   /* df for numerator*/
	nu2=n*g-g;    /* df for denominator*/
	Fcrit=finv(1-alpha,nu1,nu2);   
	/*F critical value*/
	nc=n*(css)/sigma2;   /*noncentrality parameter for noncentral F*/
	power=1-probf(Fcrit,nu1,nu2,nc);
	output;
end;
keep n nu1 nu2 nc power;
run;
title Power Calculation in Data Step;
proc print data=Power; 
run;





/*Question 3/Exercise 7.4
I conduct an experiment doing fixed-level testing with E= .05; I know that for a given set of alternatives my power will be .85. True or False?
1.  The probability of rejecting the null hypothesis when the null hypothesis is false is .15.
		False, the probability of rejecting a false null (the power) is 0.85.
2.  The probability of failing to reject the null hypothesis when the null hypothesis is true is .05
		False, Failing to reject a true null is the correct decision and its probability =1 - α
		α is the same as the Type one error,, meaning the probability is 0.95 (1-.05) */ 



