data new;
do i=1 to 5;  /*5 random samples with N(0, σ^2α), with σα = 2.*/
a=2*rannor(1);
do j=1 to 10;
y=a+rannor(1);
output;
end;
end;
stop;
run;

/*Part A*/
/*The variance for i (σα^2) is . The variance is attained with either proc varcomp or in the paramater estimate table from proc mixed.
Covariance parameter estimates: lower: 	-1.3503 	upper 7.6406 	
σ^2 is 0.9838  with intervals 0.6768  to 1.5608*/
proc mixed data=new method=type1 cl;
class a;
model y=;
random a;
run;
quit;



/*Part B*/
/*While the variance for i (σα^2) remains unchanged in the REML method at 3.1452 ,
the covariance confidence limit estimates change significantly. The new CL is 1.1028  to 28.6973
For the residual, σ^2 also stays at 0.9838 	 and the CL stays the same (0.6768, 1.5608)*/
proc mixed data=new method=reml cl;
class a;
model y=;
random a;
run;
quit;


/*Part C*/
/*The true σα^2 of 4 (σα=2)^2 is included within the estimated covariance paramters for part A and part B.
The true σ^2 of 1 is also included within the residual CLs which is the same in part A and B*/

/*Part D*/
/*The old school method attained a much smaller confidence interval*/


/*Part 2 a*/
/* x=2 y=11 u=2 v=3*/

/*Part 2 b*/
data test;
   do i=1 to 3;
   a=i-2;
      do j=1 to 5;
      b=(j*j)-11;  
      ab=((i-2)*(j-3))/5;  
         do k=1 to 2;
            y=a + B + aB + rannor(1);
            output;
         end;
      end;
   end;
run;
proc glm data=test plots=diagnostics;
class a b;
model y=a b a*b;
run;



/*Part 2 c*/
data test2;
   do i=1 to 3;
   a=i-2;
      do j=1 to 5;
      b=(j*j)-11;  
      ab=((i-2)*(j-3))/5;  
         do k=1 to 10;
            y=a + b + aB + rannor(1);
            output;
         end;
      end;
   end;
run;
proc glm data=test2 plots=diagnostics;
class a b;
model y=a b a*b;
run;

/*other interaction plots*/
proc glm data=test2;
class b a;
model y=b a b*a;
run;

/*Part 2 f*/
/*Levenes test*/
proc glm data=test2 plots=diagnostics;
class a b;
model y=a b a*b;
means a/hovtest;
run;






/*Question 3 Part a*/
data q3;
   do j=1 to 5;
   b=5*rannor(1);
   	do i=1 to 3;
   	a=2*i-4;  
      ab=2*rannor(1);  /*includes i and j*/ /*STD dev=2*/ 
         do k=1 to 10;
            y=a + b + ab + rannor(1);
            output;
         end;
      end;
   end;
run;

proc mixed data=q3 method=type1 cl;
class a b;
model y=a;
random b a*b;
run;
quit;

/*Part 3 b*/
proc mixed data=q3 method=REML cl;
class a b;
model y=a;
random b a*b;
run;
quit;

/*Part 3 c*/
/*The true varinces were given in the problem: σ = 1 σβ^2 = 25,σαβ^2 = 4*/

/*Part 3 F*/
proc mixed data=q3 method=REML cl;
class a b;
model y=a;
random b ;
run;
quit;





