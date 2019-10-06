/* David DeStephano  Assingment 1*/
/*I certify that the SAS code given is my original and exclusive work*/

/*Question 1a*/
data Logit;
%Let B0a = 5;
%Let B1a = 2;
%Let B0b = 5;
%Let B1b = 1;
Do x = -10 to 10 by 0.1;
	P1a = exp(&B0a + &B1a*x);
	P2a = 1 + p1a;
	pa = p1a/p2a;
	P1b = exp(&B0b + &B1b*x);
	P2b = 1 + p1b;
	pb = p1b/p2b; 
	output;
End;
Run;

proc sgplot data=logit;
	series x=x y=pa;
	series x=x y=pb;
	/*Add reference lines*/
	refline .5 / axis=y;
	refline 0 / axis = x;
Run;
/*The logistic model graph tells us the probability (of getting a one (chance of success)) at each x value. 
Decreasing the slope to 1 increases the probability of getting an output of one at lower x values.
In comparison to Pb, Pa must reach around -5 before it begins being likely that a one will be the output.
As expected, the slope of the logistic function also decreases in Pb*/

/*Part b*/
data Logit2;
%Let B0a = 5;
%Let B1a = 2;
%Let B0b = 8;
%Let B1b = 2;
Do x = -10 to 10 by 0.1;
	P1a = exp(&B0a + &B1a*x);
	P2a = 1 + p1a;
	pa = p1a/p2a;
	P1b = exp(&B0b + &B1b*x);
	P2b = 1 + p1b;
	pb = p1b/p2b; 
	output;
End;
Run;

proc sgplot data=logit2;
	series x=x y=pa;
	series x=x y=pb;
	/*Add reference lines*/
	refline .5 / axis=y;
	refline 0 / axis = x;
Run;
/*Changing the intercept simply translates, or moves the regression line, further back/more negative*/


/*Part c*/
data Logit3;
%Let B0a = 5;
%Let B1a = 2;
%Let B0b = 5;
%Let B1b = -2;
Do x = -10 to 10 by 0.1;
	P1a = exp(&B0a + &B1a*x);
	P2a = 1 + p1a;
	pa = p1a/p2a;
	P1b = exp(&B0b + &B1b*x);
	P2b = 1 + p1b;
	pb = p1b/p2b; 
	output;
End;
Run;

proc sgplot data=logit3;
	series x=x y=pa;
	series x=x y=pb;
	/*Add reference lines*/
	refline .5 / axis=y;
	refline 0 / axis = x;
Run;
/*Unsurprisingly the regression line flips in Pb to the opposite of what it was.
Now the for almost every negative value, the proportion that the output is 1 is also 1*/





/*Question 2*/
/*a:(1,0), 
b(1,-1),
c (0,0),
d (-1,-1),
e (-1,0),
f (-1,1),
g (0,-1)
h (0,1)
i(1,1)

*/


/*Question 3*/
Data Logss;
%Let B0 = -2.086;
%Let B1 = .5117;
Do x = -10 to 10 by 0.1;
	P1 = exp(&B0 + &B1*x);
	P2 = 1 + p1;
	p = p1/p2; /*Probability form of the logistic curve e/(1+e)*/
	output;
End;
Run;

proc sgplot data=logss;
	series x=x y=p;
Run;

/*The important part of the graph follows 0. At 0 the probability is already positive and continues upwards until the tumor size=10*/




/*Question 3 a*/
Data Logss;
%Let B0 = -2.086;
%Let B1 = .5117;
Do x = -10 to 10 by 0.1;
	P1 = exp(&B0 + &B1*x);
	P2 = 1 + p1;
	p = p1/p2; /*Probability form of the logistic curve e/(1+e)*/
	output;
End;
Run;

proc sgplot data=logss;
	series x=x y=p;
Run;
/*Part a*/
/*Although we do not know the actual proportion of metastasis to total cancer cases at 6 cm, we can use the above formula to determine the odds
To find pi, I used the probability form and found pi was = to .72794 at 6
If p is a probability, then p/(1 − p) is the corresponding odds
Using the odds formula we find the odds are 2.675*/



/*Question 3 part b*/
/*From the graph, we know the probability is 73%*/
/*(If we were to use the linear equation/logit/inverse of the logistic function/log odds form using the same pi value we would get (maybe, I did not check this work) 98%, which is unlikely(*/


/*Part C*/
Data Logss2;
%Let B0 = -2.086;
%Let B1 = .5117;
Do x = 7 to 7 by 0.01;
	P1 = exp(&B0 + &B1*x);
	P2 = 1 + p1;
	p = p1/p2; /*Probability form of the logistic curve e/(1+e)*/
	output;
End;
Run;

proc sgplot data=logss2;
	series x=x y=p;
Run;

/*P=0.82 at 7, so the new odds are .82/(1-.82)= 4.5555. This is almost a change of 2.
The odds ratio from 6 cm to 7 is 2.675/4.555 which equal .587
The odds of getting metastasis is 58.7% of that when a tumor is 6 cm compared to 7.*/



/*Part d*/
/*The estimate of pi changes by about .09*/




/*Question 4*/
proc import out=titanic
datafile="/home/dmd12d0/MyLib/Titanic.xlsx"
dbms = xlsx replace;
run; 
data titanic;
set titanic;
run;

Proc sgplot data=titanic;
	loess x=age y=survived/smooth=.5; /*See if this follows a logistic function pattern
                                or "S" curve*/
Run; 

/*From this graph *alone* I do not think there is a relationship. It would be possible to do further analysis 
potentially splitting the data into bins but the loess sgplot is what was asked for.
The data is not linear*/



/*Question 4 part b*/
	
proc means data=titanic;
var age;
run;

/*Fit a logistic regression curve*/
Proc logistic data=titanic descending; /*desending allows a 0 = failure and
                                           1 = success*/
    model survived = age/expb; /*Acceptance is a binary response and the expb
                                    optioin gives the odds ratio*/
Run;

/*The p value is too high. There is no association.
If there was, the intercept would be -0.0814 and the slope -0.00879
