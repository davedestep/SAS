/*David DeStephano*/
/*I certify that the SAS code given is my original and exclusive work*/


/*Question 1a*/
DATA=MyLib.cars04;                                              /*This is the new file created in a library folder, its not really needed from here on but I copy and pasted everything anyways*/
run;
proc sgpanel data=mylib.cars04;
	panelby origin DriveTrain/layout=lattice;                     /*Creates a lattice layout and specifies the axes/variables*/
	hbox weight;                                                  /*Creates a horizontal boxplot for weight*/
run;

/*Question 1b*/
/*The all wheel drive trains differ between Europe and the US in the same way the other categories do: the US has heavier and more varied car weights.
The boxplot for Rear and Europe seem to be the most normally distributed, followed by rear and USA only because the tails are less even*/

/*Question 1c*/
DATA=MyLib.cars04;
run;
proc sgpanel data=mylib.cars04;
	panelby origin DriveTrain/layout=lattice;
	histogram weight;
	density weight/type=normal;                               /*density creates a normal and kernel curve for the newly created histograms*/
	density weight/type=kernel;
run;

/*Question 1d*/
/*The rearwheel drive panel for Europe is still more normally distributed than many of the other panels, but the histogram makes it clear that others are
more normal. The US examples are the most normally distributed besides the all wheel drive panel. These example and a couple others 
are distributed more normally than the one I chose*/

/*Question 1e*/
DATA=MyLib.cars04;
run;
proc sgpanel data=mylib.cars04;
	panelby origin DriveTrain/layout=lattice;
	scatter x=EngineSize y=MPG_City; /*places a scatter plot in each panel*/
    loess x=EngineSize y=MPG_City;   /*Places a loess line in each panel*/   
run;

/*Question 1f*/
/*The combination of Asia and Rear wheel drive is obviously non-linear, the USA all wheel drive combo is linear, and the all wheel drive and Asia combo 
is difficult to determine*/

/*Question 1g*/
DATA=MyLib.cars04;
run;
proc sgpanel data=mylib.cars04;
	panelby origin DriveTrain/layout=lattice;
	scatter x=EngineSize y=MPG_City; 
    loess x=EngineSize y=MPG_City;
    reg x=EngineSize y=MPG_City/ clm degree=2;          /*Creates a regression line on top of the loess line for engine and mpg with confidence limits and a degree of 2*/
run;

/*Question 1h*/
/*I think the regression line is a decent fit for each example I listed except for Asia and rear wheel drive.
By nature it seems the line fits as well as possible for each example, but for rear wheel drive cars in asia 
the data is still too spread out*/

/*Question 2a*/
proc sgscatter data=mylib.bodyfat;
	matrix Abdomen Age Chest Height Hip Thigh Weight _Fat;
run;
/*_Fat and age seem to have a fairly significant positive correlation. In the plot the dots skew further to the right (fatter) as age increases.
For some reason height doesnt change much at all (except for one outlier) while chest sizes are pretty varied, This makes the dots on the plot look like a vertical line*/


/*Question 2b*/
proc sgscatter data=mylib.bodyfat;
	matrix Abdomen Age Chest Height Hip Thigh Weight _Fat/ diagonal=(histogram kernel);
run;

/*Question 2c*/
proc ttest data=mylib.bodyfat h0=20 sides=L alpha=.05;             /*h0 is the null hypothesis, we are doing a lower bound test, with a .05 significance level*/
	var _Fat;
Run;

/*The p value is lower than .05 therefore there is enough evidence to conclude that the mean bodyfat composition is less than 20%.
and we can reject the null hypothesis that the mean is equal to 20*/

/*Question 2d*/
data age;
set mylib.bodyfat;
if age<32 then AgeGroup="young";
Else AgeGroup="old";
run;
proc print data=age (obs=20);
run;



/*Question 2e*/
proc ttest data=age alpha=0.01;
	class agegroup;	/*Specifies a two sample test since theres only two catgories*/
	var _Fat; 
run;
/*both the pooled and satterthwaite p values are under 0.01 so there is enough evidence to conclude the young and old people 
have a different mean fat percent at the population level (because we can reject the null hypothesis that the two groups have the same means (stated technically, the mean of the difference of all measures is zero).
We know the sample populations have different avergaes because older people have an average fat% of 21.5 
while younger people have an average of 13.76.*/






/*Question 3a*/
proc ttest data=mylib.cereal h0=8 sides=U alpha=.05; var sugar;
run;
/*The p value is not low therefore we cannot conclude that the mean value is greater than 8.
We also can not reject the null hypothesis that the mean is equal to 8*/

/*Question 3b*/
proc ttest data=mylib.cereal alpha=0.01;
	class mgf;	/*Specifies a two sample test since theres only two catgories*/
	var fat; 
run;
/*The p value is not below 0.01 (pooled and satterthwaite are both greater than 0.01)
so we cannot conclude that the brands have different mean fat contents.
We cannot reject the null hypothesis that the two means are the same*/



/*Question 3c*/
proc ttest data=mylib.cereal alpha=0.05;
	class mgf;	/*Specifies a two sample test since theres only two catgories*/
	var potassium; 
run;
/*Yes, they have completely different sample means, std devs, confidence limits, max and mins, etc
However the p value is greater than 0.05 so we cant conclued the population means are different.
The major differenc ebetween the two brands is that kellogs has a greater standard error and deviation making the range of data 
much larger and the data much more spread out*/


