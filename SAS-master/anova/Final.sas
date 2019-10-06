/*An experiment was conducted to determine how different soybean varieties compete
against weeds. There were sixteen varieties of soybeans and three weed treatments: no
herbicide, apply herbicide 2 weeks after planting the soybeans, and apply herbicide 4
weeks after planting the soybeans. The measured response is weed biomass in kg/ha.
The data is given in pr13_6 from Oehlert.
Note: whenever interpreting and supplying ANOVA tables, use Type III Sums of
Squares.*/


data pr13_6;
 input loc $ treat $    var $ biomass  ; cards;
           R   herb2   Parker               750
         StP   herb2   Parker              1440
           R   herb4   Parker              1630
         StP   herb4   Parker               890
           R    none   Parker              3590
         StP    none   Parker               740
           R   herb2  Lambert               870
         StP   herb2  Lambert               550
           R   herb4  Lambert              3430
         StP   herb4  Lambert              2520
           R    none  Lambert              6850
         StP    none  Lambert              1620
           R   herb2  M89-792              1090
         StP   herb2  M89-792               130
           R   herb4  M89-792              2930
         StP   herb4  M89-792               570
           R    none  M89-792              3710
         StP    none  M89-792              3600
           R   herb2   Sturdy              1110
         StP   herb2   Sturdy               400
           R   herb4   Sturdy              1310
         StP   herb4   Sturdy              2060
           R    none   Sturdy              2680
         StP    none   Sturdy              1510
           R   herb2    Ozzie              1150
         StP   herb2    Ozzie               370
           R   herb4    Ozzie              1730
         StP   herb4    Ozzie              2420
           R    none    Ozzie              4870
         StP    none    Ozzie              1700
           R   herb2 M89-1743              1210
         StP   herb2 M89-1743               430
           R   herb4 M89-1743              6070
         StP   herb4 M89-1743              2790
           R    none M89-1743              4480
         StP    none M89-1743              5070
           R   herb2  M89-794              1330
         StP   herb2  M89-794               190
           R   herb4  M89-794              1700
         StP   herb4  M89-794              1370
           R    none  M89-794              3740
         StP    none  M89-794               610
           R   herb2 M90-1682              1630
         StP   herb2 M90-1682               200
           R   herb4 M90-1682              2000
         StP   herb4 M90-1682               880
           R    none M90-1682              3330
         StP    none M90-1682              3030
           R   herb2 M89-1946              1660
         StP   herb2 M89-1946               230
           R   herb4 M89-1946              2290
         StP   herb4 M89-1946              2210
           R    none M89-1946              3180
         StP    none M89-1946              2640
           R   herb2   Archer              2210
         StP   herb2   Archer              1110
           R   herb4   Archer              3070
         StP   herb4   Archer              2120
           R    none   Archer              6980
         StP    none   Archer              2210
           R   herb2  M89-642              2290
         StP   herb2  M89-642               220
           R   herb4  M89-642              1530
         StP   herb4  M89-642               390
           R    none  M89-642              3750
         StP    none  M89-642              2590
           R   herb2  M90-317              2320
         StP   herb2  M90-317               330
           R   herb4  M90-317              1760
         StP   herb4  M90-317               680
           R    none  M90-317              2320
         StP    none  M90-317              2700
           R   herb2  M90-610              2480
         StP   herb2  M90-610               350
           R   herb4  M90-610              1360
         StP   herb4  M90-610              1680
           R    none  M90-610              5240
         StP    none  M90-610              1510
           R   herb2  M88-250              2480
         StP   herb2  M88-250               350
           R   herb4  M88-250              1810
         StP   herb4  M88-250              1020
           R    none  M88-250              6230
         StP    none  M88-250              2420
           R   herb2 M89-1006              2430
         StP   herb2 M89-1006               280
           R   herb4 M89-1006              2420
         StP   herb4 M89-1006              2350
           R    none M89-1006              5990
         StP    none M89-1006              1590
           R   herb2 M89-1926              3120
         StP   herb2 M89-1926               260
           R   herb4 M89-1926              1360
         StP   herb4 M89-1926              1840
           R    none M89-1926              5980
         StP    none M89-1926              1560
;;;;;;

/*a) Fit a tentative two-way ANOVA model with interaction. Show appropriate ANOVA
tables and comment on what looks significant. (1 point)*/
proc glm data=pr13_6;
class treat var;
model biomass=treat | var / ss3 ;
run;


/*b) Perform a residual analysis for the above model. Show the pertinent residual
plots. Do you think the model is adequate? Briefly explain. (1 point)*/
proc glm data=pr13_6 plots=diagnostics;
class treat var;
model biomass=treat | var / ss3 ;
run;
/*While the data is normal, there is a definite megaphone effect, signifying the need for a transformation*/


/*c) Show the two interaction plots for the above model. Do these plots confirm your
finding about the significance of the interaction effect? Briefly explain. (2 points)*/
proc glm data=pr13_6;
class treat var;
model biomass=treat | var / ss3 ;
run;
proc glm data=pr13_6;
class var treat;
model biomass=treat | var / ss3 ;
run;
/*In this interaction plot the lines are not parallel, meaning there should be an interaction. This seems to contradict our pvalue which being above 0.05, suggests the interaction is not statistically signifcant*/ 


/*d) There were two replications of the experiment, one in St. Paul, MN, and one in
Rosemount, MN, and there could be variability due to the location. Modify your
SAS code to include this blocking variable. Fit another ANOVA model retaining
the original two-way structure with interaction but also including the blocking
factor (assume that the blocking factor does not interact with any other factor).
Comment on how this changes your interpretations of the ANOVA table and the
adequacy of the model. (2 points)*/
proc glm data=pr13_6;
class treat var loc;
model biomass= loc treat var treat*var / ss3 ;
run;
/*Location is highly statistically significant, meaning the replications influence our results, potentially invalidating the model.*/  



/*e) Compute the estimated average and its standard error for the weed biomass difference
between no herbicide treatment and herbicide applied after 4 weeks. (1 point)*/
proc glm data=pr13_6;
class treat var loc;
model biomass=  treat loc var treat*var / ss3 clparm;
contrast "manufacturers" treat 0 -1 1;
estimate "manufacturers" treat 0 -1 1; 
run;

proc glm data=pr13_6;
class treat var loc;
model biomass = loc treat var treat*var;
means treat / tukey cldiff ; /* average differences */
lsmeans treat / stderr;/* standard errors */
run; /*Estimated average =1432 while the standard error =322.*/


/*f) Add a MEANS statement to the SAS code you used in question d) to perform a
Dunnett multiple comparisons test for the weed treatments. Show the output of
the Dunnett procedure and interpret the results. (1 point)*/
proc glm data=pr13_6;
class treat var loc;
model biomass= loc treat var treat*var / ss3 ;
means treat / dunnett;
run;
/*none - herb2	dif btw means: 2282.
herb4 - herb2	dif btw means: 850.6*/


/*g) Add a MEANS statement to the SAS code you used in question d) to perform a
Tukey multiple comparisons test for the soybean variety. Show the output of the
Tukey procedure and interpret the results. (1 point)*/
proc glm data=pr13_6;
class treat var loc;
model biomass= loc treat var treat*var / ss3 ;
means var / tukey;
run;
/*Each treatment is statistically different using Tukeys test*/


/*h) Use the Box-Cox method to figure out an appropriate transformation of the response.(2 points)*/
proc transreg data=pr13_6;
model BoxCox(biomass/lambda=-2 to 2 by 0.1 alpha=0.05) = class(treat var treat*var loc); /*Excluding location*/
run;

/*The appropriate transformation when including both variables and the block is approx 0.4*/

/*i) Transform the response by the square root of the biomass. Rerun your analysis
in question d) using the square root response, showing your ANOVA table and
key residual plots. Has the model significance and adequacy changed? Briefly
explain. (2 points)*/
data tran;
	set pr13_6;
	biomass2 = sqrt(biomass);
run;
proc glm data=tran plots=diagnostics;
class treat var loc;
model biomass2= loc treat var treat*var / ss3 ;
run;



/*j) Suppose you decide to use the square root transformation. Rerun the analysis in
question d) with only the significant factors ( = 0.05). Explain what impact this
has, if any, on the significance of the remaining factors and residual plots. (2
points)*/
proc glm data=tran plots=diagnostics;
class treat var loc;
model biomass2= loc treat/ ss3 ;
run;


/*Question 2*/
/*Scientists wish to understand how the amount of sugar (two levels), cul- Problem 15.6
ture strain (two levels), type of fruit (blueberry or strawberry), and pH (two
levels) influence shelf life of refrigerated yogurt. In a preliminary experiment,
they produce one batch of each of the sixteen kinds of yogurt. The
yogurt is then placed in two coolers, eight batches in each cooler. The response
is the number of days till an off odor is detected from the batch.
Analyze these data to determine how the treatments affect time till off odor*/
data pr15_6;
 input cooler $ A  B  C  D  days  ; cards;
              1 -1 -1 -1 -1             34
              1  1  1 -1 -1             34
              1  1 -1  1 -1             32
              1  1 -1 -1  1             34
              1 -1  1  1 -1             34
              1 -1  1 -1  1             39
              1 -1 -1  1  1             38
              1  1  1  1  1             37
              2  1 -1 -1 -1             35
              2 -1  1 -1 -1             36
              2 -1 -1  1 -1             39
              2 -1 -1 -1  1             41
              2  1  1  1 -1             39
              2  1  1 -1  1             44
              2  1 -1  1  1             44
              2 -1  1  1  1             42
;
/*a) There are 15 interactions 
/*B*/
data new;
set pr15_6;
ab=a*b;
ac=a*c;
abc=a*b*c;
abd=a*b*d;
acd=a*c*d;
abcd=a*b*c*d;
run;
/*Fisrt eight are all the same then its defining*/

/*c) analyze the data*/
proc glm data=pr15_6;
class cooler A B C D;
model days = cooler A B C D A*B A*C A*D B*C B*D C*D;
run;
/* d) Remove the insignificant interactions and rerun the analysis */
proc glm data=pr15_6;
class cooler D;
model days = cooler D;
run;



/*Question 3 */
/*response is calcium covariate is diameter factor is pollution*/
data pr17_1;
 input group $ diam  calcium  ; cards;
       control  2.48             10.41
       control  2.81             11.82
       control  2.73             11.58
       control  2.67             11.14
       control  2.90             12.05
       control  2.45             10.45
       control  2.69             11.39
       control  2.94             12.50
            P1  3.10             12.10
            P1  2.61             10.38
            P1  2.49             10.08
            P1  2.69             10.71
            P1  2.43              9.82
            P1  2.52             10.12
            P1  2.54             10.16
            P1  2.55             10.14
            P2  2.57             10.33
            P2  2.48             10.03
            P2  2.77             11.13
            P2  2.30              8.99
            P2  2.56             10.06
            P2  2.18              8.73
            P2  2.65             10.66
            P2  2.73             11.03
            P3  2.60             10.46
            P3  2.17              8.64
            P3  2.64             10.48
            P3  2.35              9.32
            P3  2.89             11.54
            P3  2.38              9.48
            P3  2.55             10.08
            P3  2.29              9.12
;;;;;;

/*a) Analyze the data using the parallel lines model. Report the ANCOVA table, the 
type III SS ANOVA table and the Analysis of Covariance plot. (2 points)*/
proc glm data=pr17_1;
class group;
model calcium = diam group / solution ss3;
means group /tukey lines;
run;


/*b) Analyze the data using the separate slopes model with x0 = 2.5. Report the
ANCOVA table, the type III SS ANOVA table and the Analysis of Covariance
plot. (2 points)*/
data pr17;
set pr17_1;
x25=diam-2.5;
run;
proc glm data=pr17;
class group;
model calcium=x25 x25*group / solution ss3;
run;
quit;


/*c) Analyze the data using the separate lines model. Report the ANCOVA table, the
type III SS ANOVA table and the Analysis of Covariance plot. (2 points)*/
proc glm data=pr17_1;
class group;
model calcium = diam group diam*group / solution ss3;
run;





