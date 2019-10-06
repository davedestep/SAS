/*An experimenter randomly allocated 125 male turkeys to five treatment
groups: control and treatments A, B, C, and D. There were 25 birds in each
group, and the mean results were 2.16, 2.45, 2.91, 3.00, and 2.71, respec-
tively.  The sum of squares for experimental error was 153.4.

Test the null hypothesis that the five group means are the same against the alternative that
one or more of the treatments differs from the control*/


/*Do by hand*/
/*Contrast: (-4, 1, 1, 1, 1)
/*At first I wasnt entirely sure how to find the SSw for this since only SSe was given.
To find the SSw you find the overall mean .2646 and then subtract it from each group's mean.
I then squared each result and multiplied this number by 25.
The SSb is the sum of these numbers which is then divided by 4 to find the MSb.
Then divide the MSb by the MSe to find the F value which is translated to a pvalue in sas.
 The p value is 0.0611, which is just above the cutoff of 0.05.
I believed initially that the null hypothesis would be rejected, but the p value says otherwise.
After this surprise I calculated the standard error, which was 1.01129, so I suppose this is a large
enough value to not reject the null*/ 
/*Anova table:
Source	Df	ss		MS		    F		   P
type 	4	11.843  2.96075     2.31616   0.0611493452	
error	120	153.4	1.2783
total	124	 +	
*/
/*Ms for county type represents the variance between subjects. When this is relatively higher than MSE it means the 
means are different. If they were close the samples would have a similar or the same mean.*/
/*Find p value*/
data pval;
pval1 = 1-cdf('F', 2.31616, 4, 120);
 
run;
/*p value = 0.0611493452	*/





/*Exercise 4.2
Use the data from Exercise 3.3.  Compute a 99% confidence interval for
the difference in response between the average of the three treatment groups
(acid, pulp, and salt) and the control group.*/

data oranges;
Input group value;
datalines;
1 76.7
1 77.2
1 78.6
2 80.5
2 79.0
2 79.3
3 89.1
3 75.7
3 81.2
4 77.8
4 79.5
4 77.0
; 
proc glm data=oranges;
class group;
model value=group / clparm ;/*CL Parm was added*/
means group/ tukey cldiff  alpha=0.01;
contrast "Treatment" group -3 1 1 1; /*put group instead of control*/
estimate "Treatment" group -3 1 1 1; 
run
;

/*Using tukeys test, the 99% confidence intervals between 1 (control) and 3 were (-16.984, 7.984), 	 
between 1 and 2 were (-14.584, 10.384), 	 
and 1 and 4 were (-13.084, 11.884).
Each of these intervals include a zero, meaning we can not reject the null hypothesis
that the means between the treatments are the same.*/







/*Exercise 4.3
Refer to the data in  Problem 3.1.   Workers 1 and 2 were experienced,
whereas workers 3 and 4 were novices. Find a contrast to compare the experienced 
and novice workers and test the null hypothesis that experienced and
novice works produce the same average shear strength*/


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
proc glm data=operators;
class worker;
model strength=worker;
/*means worker/ tukey cldiff alpha=0.01;*/
contrast "Treatment" worker -0.5 -0.5 0.5 0.5;
estimate "Treatment" worker -0.5 -0.5 0.5 0.5; 
run
;

/*When comparing both inexperienced workers to both experienced workers,
 it is not possible to reject the null hypothesis. 
 For this reason we can not conclude experienced and inexperienced workers
 produce different averages of shear strength.
 However we can conclude the inexperienced worker 2 makes shears with lower average strength
 than the more experienced worker 4. This is important to note
 even if it is not what the question asked */ 
  








