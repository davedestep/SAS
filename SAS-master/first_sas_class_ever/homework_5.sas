/*David DeStephano*/
/*I certify that the SAS code given is my original and exclusive work*/


/*Question 1a*/
data spin;
do i=1 to 5000;
	x=5*ceil(20*rand('uniform'));
	if x<=55 then x1=5*ceil(20*rand('uniform'));
	else x1=0;
	sum=x+x1;       /*the sum will either be x, or x + x1 when x was 55 or below*/
	output;
end;
run;

proc freq data=spin;
	table sum;
run;
/*the total exceeded 100 and the player lost 15.92 percent of the time. 
(100%-cumulative frequency at 100)*/

/*Question 1b*/
proc sgplot data=spin;
	histogram sum;
run;
/*Not sure why there is a single column where the percent is around 15%. Other wise the edges of the table are low with an average of around 8% in the middle columns (with the single outlier column)*/


/*Question 2*/
Data States;
Input StateID $ @@;
Datalines;
AL AK AZ AR CA CO CT DE FL GA
HI ID IL IN IA KS KY LA ME MD
MA MI MN MS MO MT NE NV NH NJ
NM NY NC ND OH OK OR PA RI SC
SD TN TX UT VT VA WA WV WI WY
;
Run;
  proc surveyselect data=states
      method=srs rep=2000 n=4 out=Selections;          /*rep is used to make sure there are 2000 random samples of 4 random states.
      													This makes 8000 observations total, but each replicate can be considered a single
      													observation of four states (one obs for each replicate number)*/
run;
proc print data=selections (obs=20) noobs;             /*Because rep is being used, we get 20 random states, not 20 random groups
														of four states*/
run;





proc freq  data = selections;
tables StateID;
run;
/*Florida was selected 150 times so it had a 1.88% of being picked*/



/*Question 3*/

Proc import Datafile="/home/dmd12d0/STA3024 Data/HipThigh.csv"
out=hipthigh;

run;
proc sgplot data=hipthigh;
scatter x=hip y=thigh;
run;
/*There seems to be a positive correlation. For each increase in hip size, thigh size rises as well. From looking at the graph alone
it can be assumed that hip sizes increase faster than thigh sizes,or in the very least hip sizes are always larger*/
 

/*Question 3b*/
proc sgplot data=hipthigh;
reg x=hip y=thigh;
run;
/*It looks like half the variables are above the line and half are below, which in reality is not very important because it is the norm.
But from this we know that the regression line is the mean of the x and y variables, which makes it linear regression. Whether I think the data
looks linear or not has little importance because linear regression can still be used to make predictions. But from the looks of it,
the data does follow the regression line, so I will assume the data is more or less linear and therefore has a somewhat constant slope
 (or it wouldnt follow the regression line in the first place).*/
 
/*Question 3c*/
proc sgplot data=hipthigh;
reg x=hip y=thigh / clm;
run;
/*A 95% confidence interval does not mean that 95% of the sample data lie within the interval. It only estimates the population parameter.
I guess it can be argued that the data is not linear because there is a large degree of variance, and many of the values fall
outside the confidence interval . But I have never made these distinctions before, and my answer was based on the fact 
that the data roughly follows the regression line. However, looking at the graph with the interval, the data looks much less 
linear, and because the data is so varied, with many differences in one set of values at another fixed value (on both x and y), 
I will admit this is a valid argument, but I still think the data is linear*/





/*Question 3d*/
proc sgplot data=hipthigh;
	reg x=hip y=thigh / clm clmtransparency=0.6;
	loess x=hip y=thigh / clm clmtransparency=0.6;  
run;
/*Using loess accounts for the differences I mentioned earlier. I think more data points would be needed to know if the 
regression line is still applicable, and I think it can be used for the data we have now, but think if given the option
the loess line should be chosen*/





/*Question 3e*/ 

proc sgplot data=hipthigh;
scatter x=hip y=thigh;
ellipse x=hip y=thigh;
run;
/*Yes I think the ellipse is the best characterization of the points seen so far. It includes all but 4 (of 50). Although it still
 does not include 95% (more like 92%) of the points, it is still very visually pleasing and can be assumed to be an accurate 
 characterization of the data present, and seems to exclude the outliers*/






/*Question 4*/
data gas;
input Month:MMDDYY10. @15 Price;
Title "New York Monthly Gas Prices From 2012 to 2016";
datalines;
1/1/2012       362.5
2/1/2012       383.5
3/1/2012       398.1
4/1/2012       408.8
5/1/2012       390.8
6/1/2012       367.6
7/1/2012       365.4
8/1/2012       387.7
9/1/2012       404.3
10/1/2012       401.4
11/1/2012       386.2
12/1/2012       374.1
1/1/2013       370
2/1/2013       393.3
3/1/2013       392.2
4/1/2013       376.3
5/1/2013       369.6
6/1/2013       370.4
7/1/2013       379.9
8/1/2013       384.2
9/1/2013       378.5
10/1/2013       359.4
11/1/2013       353
12/1/2013       363.7
1/1/2014       363.6
2/1/2014       362.4
3/1/2014       374
4/1/2014       379.9
5/1/2014       386
6/1/2014       385.7
7/1/2014       384.3
8/1/2014       369.7
9/1/2014       358.9
10/1/2014       344
11/1/2014       321.9
12/1/2014       293.7
1/1/2015       251.2
2/1/2015       240.9
3/1/2015       256.2
4/1/2015       259.5
5/1/2015       279.3
6/1/2015       287.9
7/1/2015       288.3
8/1/2015       268.8
9/1/2015       244.2
10/1/2015       231.4
11/1/2015       228.4
12/1/2015       222.3
1/1/2016       210.7
2/1/2016       194.4
run;
proc sgplot data=gas;
format Month worddate.;
	band x=Month upper=Price lower=275/fillattrs=(color=red);
	band x=Month upper=275 lower=0/fillattrs=(color=lightblue);                   /*simply used the format  given on the assignment question*/
	band x=Month upper=0 lower=Price/outline lineattrs=(color=black) legendlabel="Price";  /*legendlabel alters the name on graph, upper is 0 so there is not a stray and unneeded line*/
	yaxis min=150;
	
run;

