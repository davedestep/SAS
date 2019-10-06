/*Question 1a*/
Data SNL;
Input @1 Host $& 17.       /*The formatted input style was used, list style could also work*/
@20 Appearances 2. 
@28 First mmddyy10.          /*mmddyy10 and date 10 are inserted to have data read as dates*/
@44 Fifth date10.;
format First Fifth mmddyy10.;      /*This formats both variables in the desired order.*/        
datalines;
Ben Affleck         5       2/19/2000      18-May-13
Alec Baldwin       16       4/21/1990      10-Dec-94
Drew Barrymore      6      11/20/1982      03-Feb-07
Candice Bergen      5      11/8/1975       19-May-90
Chevy Chase         8       2/18/1978      06-Dec-86
Danny DeVito        6       5/15/1982      09-Jan-93
John Goodman       13      12/2/1989       07-May-94
Elliott Gould       6       1/10/1976      16-Feb-80
Tom Hanks           8      12/14/1985      08-Dec-90
Buck Henry         10       1/17/1976      19-Nov-77
Steve Martin       15      10/23/1976      22-Apr-78
Bill Murray         5       3/7/1981       20-Feb-99
Justin Timberlake   5      10/11/2003      09-Mar-13
Christopher Walken  7       1/20/1990      19-May-01

run;
proc print data =SNL;
format First mmddyy8.;              /*This command is used to have the output read a month, day, then the last two numbers of the year*/
format Fifth mmddyy8.;
run;


/*Question 1b WORDDATE VAR???*/

Data SNL;
Input @1 Host $& 17.       /*The formatted input is used as well the inputs to read data as a date.*/
@20 Appearances 2. 
@28 First mmddyy10. 
@44 Fifth date10.;
datalines;
Ben Affleck         5       2/19/2000      18-May-13
Alec Baldwin       16       4/21/1990      10-Dec-94
Drew Barrymore      6      11/20/1982      03-Feb-07
Candice Bergen      5      11/8/1975       19-May-90
Chevy Chase         8       2/18/1978      06-Dec-86
Danny DeVito        6       5/15/1982      09-Jan-93
John Goodman       13      12/2/1989       07-May-94
Elliott Gould       6       1/10/1976      16-Feb-80
Tom Hanks           8      12/14/1985      08-Dec-90
Buck Henry         10       1/17/1976      19-Nov-77
Steve Martin       15      10/23/1976      22-Apr-78
Bill Murray         5       3/7/1981       20-Feb-99
Justin Timberlake   5      10/11/2003      09-Mar-13
Christopher Walken  7       1/20/1990      19-May-01

run;
proc sort data=SNL out=new;      /*procsort sorts data into old and new data set*/
By descending Appearances;       /*descending sorts the number of appearances from most to least*/
proc print data =new;
format fifth worddate.;          /*Used to format date in word form, had to remove previous format step*/
var fifth host;
run;




/*Question 1c*/


Data SNL;
Input @1 Host $& 17.       /*The formatted input is used as well the inputs to read data as a date.*/
@20 Appearances 2. 
@28 First mmddyy10. 
@44 Fifth date10.;
format First Fifth mmddyy10.;

difference = Fifth - First;                       /*First a new variable is created to find the number of days between the first and fifth appearance*/
Years = difference/365.25;                        /*Then the number of years and remaining fraction is found*/
FullYears = floor(Years);                         /*The years are then rounded down to find the full amount of years*/
RemainingDays = ceil ((Years - FullYears)*365.25) ;       /*Last the remaining days are found by subtraction total years by the full years and multiplying this number by 365.25*/

datalines;
Ben Affleck         5       2/19/2000      18-May-13
Alec Baldwin       16       4/21/1990      10-Dec-94
Drew Barrymore      6      11/20/1982      03-Feb-07
Candice Bergen      5      11/8/1975       19-May-90
Chevy Chase         8       2/18/1978      06-Dec-86
Danny DeVito        6       5/15/1982      09-Jan-93
John Goodman       13      12/2/1989       07-May-94
Elliott Gould       6       1/10/1976      16-Feb-80
Tom Hanks           8      12/14/1985      08-Dec-90
Buck Henry         10       1/17/1976      19-Nov-77
Steve Martin       15      10/23/1976      22-Apr-78
Bill Murray         5       3/7/1981       20-Feb-99
Justin Timberlake   5      10/11/2003      09-Mar-13
Christopher Walken  7       1/20/1990      19-May-01

run;
proc sort data=SNL out=new;      /*procsort sorts data into old and new data set*/
By Years;
proc print data =new;
var Host FullYears RemainingDays;       /*I was not completely sure which years and days were wanted in the directions so I picked FullYears and RemainingDays*/
run;




/*Question 2 a*/

Data Bat;
infile '/home/dmd12d0/STA3024 Data/bat.txt';        /*import external file*/
Input Brand $ Standby @@;     /*The two @ symbols are used to read multiple observations per data line*/
      
Run;
proc print data=Bat (firstobs=15 obs=40);     /*Firstobs used to choose which observations are printed*/
run;


/*Question 2 b*/
proc sgplot data=Bat;                                 /*used to create a vertical bar chart*/
	vbar Brand/ response=Standby stat=mean            /*This command ensures each brand is is represented by the average standby time on the vertical axis*/
	            fillattrs=(color=steel)
	            dataskins=matte
	            barwidth=0.6;
Run;


/*Question 2c*/
Title 'Battery Life by Brand';
data Bat;
infile '/home/dmd12d0/STA3024 Data/bat.txt';        /*Just did another infile for no reason in particular, instead of only a proc print */
Input Brand $ Standby @@;
proc boxplot data=Bat;                              /*This command creates a boxplot*/
plot Standby*Brand / boxstyle=schematic;            /*Variable before the * is placed on the Y-axis, variable after is placed on the X-axis*/ 
run;

title;     /* cancel the TITLE  statement */

/*Question 2d*/
/* (This response is also on the word document)
Based on the data I would buy brand B because for all observations its batteries 
have the highest average standby times. This means it would be the best choice to ensure 
my phone stays on longer.*/




/*Question 3a*/
Proc Univariate data=Bat; /*Runs summary statistics on specified variables*/
var Standby;              /*This specifies which variable we want statistics for*/
by brand;                 /*This seperates the summary statistics by each brand, printing results for each seperately, instead of all together*/
run;


/*question 3b (also in doc*/
/*It appears we are going back to introductory statistics. In that case it is important to understand how a boxplot is formed.
A box plot includes the median (Q2), and quartiles 1 and 2, which are the middle numbers between the median and either the max or min.
Because boxplots are created using the median, Q1, Q3, the max, and the min, the boxplots in the results perfectly mirror those values found in each brand's summary statistics.
Since the observations in brand B are collectively higher than the other 3 brands, it is reasonable to conclude the box plot will be higher on the Y axis.
This is because the median is higher (at 66), as well as the other important values, like Q3, Q1, min, and max.
The fact brand b has higher standby times means it also has a higher mean, or average, than the other brands, which is why the bar graph is also higher.
The other brands have lower, and somewhat similar data sets. Meaning the bar graphs will be similar and height, and the boxplots will have similar locations (on the y axis).
A minor exception is brand d, which has values that are closer together, leading to a smaller std dev, interquartile range, and even distance between max and min.*/


/*Question 4a*/
Data Airfare;
Input Season $ Delta Icelandair British;
datalines;
Summer   1675     1473     1370
Summer   1435     1206     1252
Summer   1295     1273     1580
Summer   1355     1109     2575
Summer   1586     1078     2275
Fall      969     1050     1287
Fall     1128      970     1460
Fall     1027     1017     1047
Fall     1157      997     1274
Fall     1230      991     1195
run;
proc print data=Airfare;
run;


/*Question 4b*/

	proc sgplot data=Airfare;
	vline season/ response=Delta stat=mean
	            lineattrs=(color=red pattern=solid)
	            markers markerattrs=(color=blue symbol=squarefilled);
	vline season/ response=Icelandair stat=mean
	            lineattrs=(color=olive pattern=dot)
	            markers markerattrs=(color=orange symbol=triangle);
	vline season/ response=British stat=mean
	            lineattrs=(color=khaki pattern=dash)
	            markers markerattrs=(color=silver symbol=diamondfilled);
	            

Run;



/*Question 4C*/

/*The line graph makes the difference in airfares between the *three airlines* in summer and fall very clear.
 It is apparent that British airlines is the most expensive, followed by Delta, then Icelandair , in both seasons. 
 Therefore at any point in the year one should buy Icelandair instead of British airlines. If Icelandair is not available, Delta would be the better choice.
 For each airline, flights in the fall are on average much cheaper than flights in the summer. 
 Delta is consistently in the range of $1100 in the fall and $1400-1500 in the summer.
 British airlines is usually around 1200-1300 in fall but has a highly variable fares in summer with an average around 1800.
 Icelandair is the cheapest, having an approximate average of 1000 and 1200.*/


