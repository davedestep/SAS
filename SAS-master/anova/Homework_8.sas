/*Part 1 a-c*/
/*a) MSE=12.0746893*/
/*b) There are 8 degrees of freedom, the f value is 12.38, and the pvalue is 0.0005. 
This pvalue tells us the treatment values affect the response.*/
/*c*/
data new;
do i=1 to 9;
do j=1 to 2;
a=i-5;
y=a+rannor(1);
output;
end;
end;
stop;
run;

proc glm data=new plots=diagnostics;
class  a;
model y=a;
run;

proc glm data=new;
class  a;
model y=a;
means a/lsd; 
run;




/*Part 1 d*/	
data new;
do i=1 to 9;
do j=1 to 10;
a=i-5;
y=a+rannor(1);
output;
end;
end;
stop;
run;


proc glm data=new plots=diagnostics;
class  a;
model y=a;
means a/lsd; 
run;

/*Part 1 f*/
data Power;
g=9;
alpha=.05;
sigma2=.15;
css=0.6386
; /* sum of squares of effects*/
do n=1 to 10
;
nu1=g-1;   /* df for numerator*/
nu2=n*g-g;    /* df for denominator*/
Fcrit=finv(1-alpha,nu1,nu2);   
/*F critical value*/
nc=n*(css)/sigma2;   /*noncentrality parameter for noncentral F*/
power=1
-probf(Fcrit,nu1,nu2,nc);
output;
end;
keep n nu1 nu2 nc power;
run
;
title Power Calculati
on in Data Step;
proc print
data=Power; 
run
;



/*2. Exercise 11.2 from Oehlert. (3 points)*/
data calves;
 input bull $ gain  ; cards;
            1           1.46
            1           1.23
            1           1.12
            1           1.23
            1           1.02
            1           1.15
            2           1.17
            2           1.08
            2           1.20
            2           1.08
            2           1.01
            2           0.86
            3           0.98
            3           1.06
            3           1.15
            3           1.11
            3           0.83
            3           0.86
            4           0.95
            4           1.10
            4           1.07
            4           1.11
            4           0.89
            4           1.12
;
run;

/*Is there sire to sire variability.*/
proc glm data=calves plot=diagnostics;
class bull;
model gain=bull;
means bull/tukey sidak lsd cldiff alpha=.1; 
run;

/*b) Find 90% confidence intervals for the error variance and the sire to sire variance.*/
