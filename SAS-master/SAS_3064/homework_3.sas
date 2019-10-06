/* David DeStephano  Assingment 3*/
/*I certify that the SAS code given is my original and exclusive work*/

/*Question 1*/

FILENAME Refile '/home/dmd12d0/MyLib/NCbirths_RaceStudy.csv';
PROC IMPORT DATAFILE=refile
		    OUT=NCBIRTH
		    DBMS=CSV
		    REPLACE;
RUN;



data NCBIRTH2;/*New variables are defined*/
set NCBIRTH;
  IF (momrace='white') THEN white=1;
   else white=0;
  IF (momrace='black') THEN black=1;
   else black=0;
  IF (momrace='hispanic') THEN hispanic=1;
  else hispanic=0;
  IF (momrace='other') THEN other=1;
  else other=0;
run;


proc reg data=NCBIRTH2;
model birthweightoz=black hispanic other;
run;

/*4.12 writeup*/
/*Each coefficient is used to create a model for birthweight. 
Because we used indicator variable where the 'x values' of black hispanic and other are 0 when a baby is white,
or 1 when the baby is of its own race (when hispanic x value of hispanic =1 while rest=0 etc),
we know the average birthweight of a white baby is 117.87 ounces, while for black, hispanic and other we add or subtract
the number being multiplied to its corresponding x value of 1 (Black babies on average weigh 110.56, or 117.87-7.31)*/ 

/*4.13 writeup*/
/*interpreting the t-test for coefficients of the indicator variables, the value of R2, and the ANOVA table.*/
/*T VALUE: Black: -5.15, Hispanic :0.34, other: -0.22
Ttests are handy for comparing the means of sample populations but one of their essential functions is determining the p value 
that is created when t and the corresponding students t distribution are plugged into the p value equation.
For each example we can see the only statistically significant p value is for black babies. 
The corresponding t value is -5.15, notably lower and further from 0 than the t values for hispanics and other.
This is important because when T=0 we usually accept our null hypothesis that, in this case, would be 
our sample y mean for black babies is not equal to the sample mean for white babies. 
Because the p value is less than .05 and the t statistic is relatively far away from 0 (especially for having only 1 degree of freedom),
we know we can reject our hypothesis and conclude blacks have different average birthweights than whites (and probably being black affects birthweight)
We can conclude the opposite for hispanics and other because the t values are close to 0 with high p values.

R SQUARE:
From the r square we know that approximately 1.9% of birthweight variability is attributable to the model, (or to differences in race)

ANOVA
I'm not entirely sure we can conclude the conditions for a regression model hold in this case 
but degrees of freedom are fairly self explantory, they are determined from either the number of dependent variables (for model) or number of observations.
Both the sum of square and mean square represent some form of variance/variations.
SS represents the deviation from the mean by incorporating variation attributed to variables and error.
Mean square is the sum of squares divided by degrees of freedom. The variation between sample means is represented 
by the mean square in the model column. The variation between observations is represented by the MSE below.
Generally the mean squares are better when closer to zero.
We can conclude most of the variation comes from between groups (mean square model) and that the means are not identical.
If MSB was close to equal with MSE the null hypothesis would probably be true.
However its likely the birthweight model lacks information that would create better estimates*/



/*Question 2 (5.2) (some rounded numbers)*/


/*Part a:*/
/*meth Anova table:
Source	Df	ss		MS		F		P
type 	2	37.51	18.76	5.1		 .033055
error	9	33.09	3.676
total	11	70.60	
*/
/*part b*/
/*Ms for county type represents the variance between subjects. When this is relatively higher than MSE it means the 
means are different. If they were close the samples would have a similar or the same mean.*/

/*Part c*/
/*Finding the p value*/
data pval;
pval1 = 1-cdf('F', 5.1, 2, 9);
 
run;
/*P =.033055*/







/*Question 3 a*/
Data BP;
input SystolicBP       Smoke       Overwt;
datalines;
133       0       2
115       1       0
140       1       1
132       0       2
133       0       1
138       0       1
133       0       2
 67       0       0
138       0       0
130       1       0
103       1       2
137       1       2
140       0       1
131       1       2
134       1       0
107       0       0
131       0       1
120       0       1
113       0       2
127       1       0
117       1       0
139       0       0
132       0       1
124       0       0
116       1       0
115       0       0
131       1       2
130       0       2
124       1       0
139       1       0
130       0       0
103       1       2
114       0       2
135       1       1
126       0       1
133       1       2
125       0       2
138       0       2
138       0       2
132       1       2
114       0       1
130       0       1
127       0       0
131       1       0
101       0       2
130       1       2
130       1       0
115       0       1
135       1       2
134       1       2
131       0       0
112       1       2
 86       0       0
132       0       0
134       0       0
122       1       2
122       1       0
137       0       1
137       1       1
105       1       0
136       1       0
119       1       1
139       0       2
131       1       2
125       0       0
121       1       1
114       1       2
100       0       0
135       1       0
129       1       0
120       1       0
137       0       1
132       1       1
113       0       1
135       1       1
128       0       0
135       0       1
127       1       0
133       1       2
131       0       1
135       0       0
132       1       0
137       1       0
138       0       0
116       1       2
139       0       2
137       1       2
128       0       1
134       0       1
138       1       1
134       1       0
111       1       1
139       0       1
100       1       1
135       0       2
139       1       2
125       0       0
111       0       0
113       1       2
131       1       1
104       0       0
134       1       2
109       0       0
102       1       1
130       1       1
139       1       2
 77       0       0
100       0       0
135       1       2
139       0       1
127       1       2
110       0       1
132       0       2
136       0       2
135       1       1
139       1       2
123       1       2
138       1       0
123       1       0
134       1       1
121       1       0
139       1       2
133       1       0
137       1       2
 77       0       0
105       0       0
106       0       0
102       1       0
139       1       2
130       0       0
135       0       0
135       1       2
125       0       0
134       1       2
109       1       0
132       0       2
134       0       0
125       1       2
124       1       1
125       0       2
138       0       1
138       1       2
113       0       1
111       0       0
112       0       2
130       1       0
114       0       1
108       0       0
101       1       0
134       0       1
135       1       0
109       1       2
128       0       1
137       0       2
130       1       0
135       1       2
102       0       0
137       1       1
128       1       2
112       0       2
140       0       2
138       1       2
132       0       2
130       0       0
 88       0       0
 95       0       0
130       1       1
138       1       0
138       1       0
133       1       1
122       0       1
120       0       1
135       1       2
114       0       1
133       1       1
132       0       2
137       0       0
120       0       0
137       0       2
130       1       0
 93       0       0
139       0       1
122       1       2
115       1       0
135       1       1
112       0       0
 72       0       0
104       0       2
126       0       2
100       0       0
139       1       0
112       0       0
139       1       2
128       0       0
130       0       0
109       0       0
132       0       2
136       0       1
138       0       2
113       0       1
131       1       0
133       0       2
 80       0       0
131       1       0
112       0       1
120       1       0
107       1       2
133       0       1
138       0       1
134       0       0
121       1       1
121       1       2
118       1       0
 84       0       0
117       1       0
 84       0       0
135       0       0
132       1       0
132       1       0
111       0       1
114       0       0
134       1       1
132       0       1
138       1       1
109       1       0
114       0       1
104       1       0
130       1       1
136       1       2
130       0       0
111       1       2
102       1       0
120       0       2
137       1       2
131       1       2
113       0       0
131       1       2
137       1       1
119       0       0
137       1       2
138       1       2
105       0       2
 73       0       0
126       0       0
107       1       0
124       1       0
 80       0       0
135       1       2
136       1       0
134       1       2
154       1       2
151       0       2
174       1       2
146       1       2
148       1       0
172       1       2
153       0       2
172       0       2
171       1       0
146       0       0
174       1       0
180       0       2
165       0       0
154       0       2
142       1       0
177       0       1
152       1       0
213       1       1
191       0       1
150       0       0
159       1       2
144       0       0
146       0       0
145       0       0
196       0       1
172       1       2
178       1       0
150       0       0
222       1       2
161       1       2
144       0       1
148       1       0
166       0       1
154       1       0
141       1       0
148       1       0
205       1       1
144       1       0
143       0       1
203       1       2
156       1       0
176       0       1
174       1       0
161       1       2
152       0       0
169       1       0
209       1       2
201       0       2
148       0       2
194       1       2
155       0       0
176       0       0
145       0       0
142       0       0
182       1       0
168       1       2
165       1       0
141       1       0
197       1       1
191       1       2
196       0       2
149       0       1
180       0       0
174       0       2
160       0       1
169       0       1
147       1       2
149       0       0
178       0       2
155       0       1
143       0       2
203       1       2
187       1       1
168       1       0
179       1       1
169       1       1
153       0       1
173       1       1
188       1       0
153       1       2
163       1       0
142       1       2
170       0       0
179       0       1
160       1       2
176       0       0
143       1       1
162       0       1
221       1       2
142       1       0
169       1       0
212       0       1
201       0       0
175       1       2
149       0       2
141       0       0
149       1       2
154       0       0
147       0       1
141       0       2
175       1       2
164       1       0
168       1       2
148       1       2
224       1       2
210       1       2
148       1       0
198       1       2
144       1       2
159       0       1
206       1       2
154       1       1
144       1       1
149       0       0
142       0       2
207       1       0
192       1       2
182       0       2
183       0       0
148       1       2
147       1       2
146       0       2
151       1       2
144       0       2
211       0       2
141       0       0
147       0       2
164       0       1
193       1       1
169       0       2
172       1       0
187       0       0
142       0       0
194       0       2
149       1       2
143       0       2
184       0       2
198       1       1
143       1       0
161       1       0
188       0       2
148       0       2
167       0       0
181       0       1
144       0       1
150       0       2
157       1       0
165       1       2
175       1       0
162       1       2
199       1       2
192       1       2
216       1       2
199       1       2
174       1       2
141       1       2
146       1       1
192       0       2
164       1       1
162       0       2
178       1       2
168       1       0
141       0       2
186       1       2
145       0       0
142       1       2
175       1       1
145       1       1
147       1       2
179       0       2
191       1       2
184       1       2
144       1       2
178       0       2
182       1       2
168       0       0
214       1       2
148       0       2
181       1       0
142       0       0
163       1       2
173       1       2
181       1       1
184       1       0
147       0       0
176       1       2
151       1       2
142       0       2
147       0       2
185       1       2
203       1       2
142       0       2
168       0       0
147       1       1
148       1       2
198       1       0
158       1       2
165       1       2
145       1       1
148       1       2
172       1       1
162       1       2
182       1       1
148       0       2
148       1       2
150       0       0
143       1       1
209       1       2
151       1       2
152       0       0
163       1       0
212       0       2
159       1       2
188       0       0
169       1       0
145       0       0
188       1       2
142       0       2
197       1       2
142       0       2
175       1       0
141       1       0
148       1       0
215       0       2
151       0       2
159       0       2
160       1       2
167       0       2
142       1       0
144       1       1
143       0       2
173       0       2
148       0       0
142       0       1
144       0       2
188       1       0
147       0       0
158       1       0
179       1       2
167       0       0
148       0       2
162       1       2
165       0       0
181       1       2
142       0       1
146       0       0
181       1       1
145       1       2
180       1       2
174       1       2
;
run;
proc ttest data=BP;
class smoke;
var SystolicBP;
Run;

/*Variances are equal so we use the pooled method.
Pooled method gives a significant p value, meaning we can conclude there is a significant difference in mean BP between smokers and nonsmokers*/

/*Question 3 b*/
proc anova data=BP;
	class smoke;
	model SystolicBP=Smoke;
run;

/*The model F/P test is significant, meaning the model itself accounts for much of the variability in systolic BP.
The test for smoke is the same, being it is the only dependent variable, but it shows the difference in means for smokers and nonsmokers is not zero
However, this test (when tukey and mean statements arent used) does not tell us the nature of the differences.*/



/*Question 3 c, d and e (5.34 a, b and c)*/

/*Two sample t tests are not useful and can be mistaken when there are more than two independent variables.
A proc glm or anova would be better suited to this task*/

proc anova data=BP;
	class overwt;
	model SystolicBP=overwt;
	means overwt/ tukey;
run;
/*Same result as in part b, the p value tells us there is at least one difference in means, 
not to metion the additional tukey statement that did not have any confidence limits pass though zero (but close)*/


 proc glm data=BP plots(unpack) = diagnostics;
	class overwt;
	model systolicBP=overwt /ss3;
	means overwt/lsd lines cldiff;
run;

/*Depending on the variable, between the three groups there are mean difference equaling 8,-8, 16, and -16 with no confidence interval passing through zero.
In another table, the means are given to be 153, 144, and 136 with no identical t groups. This means it is unlikely any have the same mean.*/








