/*1. Exercise 2.2 from Oehlert, but use a paired t-test instead of randomization. (5 points)
2. Exercise 2.3 from Oehlert. (5 points)*/

/*2 herds of 100 cows each (14 herds total)*/


/* -1, 6, 4, 6, 2, -3, 5*/

data herddif;
input difference;
datalines;
-1 
6
4
6 
2
-3
5
;
run;
/*Sample mean = 2.71428571 
13 degrees of freedom??
Assume pairwise ttest has a only 6 degrees of freedom because 
we are only using the differences:*/


proc ttest sides=u data=herddif;
var difference;
run;




 /* Alternative if givern more data:
  Doesnt work because dont know how many are pregnant:
 
 data herddif;
         input pregtreated preguntreated @@;
         datalines;
   100 128   124 131   130 131   118 127
   140 132   128 125   140 141   135 137
   126 118   130 132   126 129   127 135
   ;
run;
   

ods graphics on;
proc ttest
data=herddif 
plots(showh0) sides=u alpha=0.05;
paired pregtreated *preguntreated;
run;
ods graphics off;*/







/*Excercise 2.3*/
/*Diet 1 vs diet 2:
1. Let them choose.
	Obviously letting the children choose would be the most flawed method of assignment.
	If the children already have a predetermined preference the results would be highly suspect and likely compromised.
2. Take the first 10 for A, the second 10 for B.
	This would be randomized if the children were chosen at random initially. 
	The fact the first and last half are assigned differently means there could be 
	confounding or alternative explanations based on the order the children arrived.
	If there is no pattern or explanation for their arrival time this design could be valid.
3. Alternate A, B, A, B.
	This method is similar to the second in that it does not account for the order of the children. 
	If the first ten children are actually different than the last 10,
	it would help split the groups up but it would not be randomized.  
4. Toss a coin for each child in the study: heads → A, tails → B.
	This is a better method for assigning diets to the children. It is a valid randomization unlike the other examples. 
	However, it may result in different sized groups, which is a notable limitation compared to the other examples.
5. Get 20 children; choose 10 at random for A, the rest for B.
	This method prevents the chance there will be different sized samples and also creates valid randomized groups.
	Must make sure the children are actually chosen randomly, if so, this is likely the best and most reliable method.   
