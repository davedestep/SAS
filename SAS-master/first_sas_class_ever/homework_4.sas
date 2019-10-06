/* David DeStephano  Assingment 4*/
/*I certify that the SAS code given is my original and exclusive work*/

/*Question 1a*/
data flights;
input airfare airline $;
datalines;
1675 deltasum
1435 deltasum
1295 deltasum
1355 deltasum
1586 deltasum
969 deltafall
1128 deltafall
1027 deltafall
1157 deltafall
1230 deltafall
1473 icesum
1206 icesum
1273 icesum
1109 icesum
1078 icesum
1050 icefall
970 icefall
1017 icefall
997 icefall
991 icefall
1370 britsum
1252 britsum
1580 britsum
2575 britsum
2275 britsum
1287 britfall
1460 britfall
1047 britfall
1274 britfall
1195 britfall
run;
proc print data=flights;
run; 



/*Question 1b*/
data flights;
input airfare airline $;                               /*Each value is assigned to its corresponding airline and season*/
datalines;
1675 deltasum
1435 deltasum
1295 deltasum
1355 deltasum
1586 deltasum
969 deltafal
1128 deltafal
1027 deltafal
1157 deltafal
1230 deltafal
1473 icesum
1206 icesum
1273 icesum
1109 icesum
1078 icesum
1050 icefall
970 icefall
1017 icefall
997 icefall
991 icefall
1370 britsum
1252 britsum
1580 britsum
2575 britsum
2275 britsum
1287 britfall
1460 britfall
1047 britfall
1274 britfall
1195 britfall

proc format;                      /*Renames each airline to its full title and season, a dollar sign is used so the nonumeric names can be formatted*/
value $fmt 'deltasum'='Delta Summer' 'deltafal'='Delta Fall' 'icesum'='Icelandair Summer' 'icefall'='Icelandair Fall' 
			'britsum'='British Air Summer' 'britfall'='British Air Fall';
run;
proc print data=flights;
format airline $fmt.;
run; 



/*Question 1c*/
proc format;                      
value $fmt 'deltasum'='Delta Summer' 'deltafal'='Delta Fall' 'icesum'='Icelandair Summer' 'icefall'='Icelandair Fall' 
			'britsum'='British Air Summer' 'britfall'='British Air Fall';
run;
proc means data=flights mean;           /*Used to find mean price/airfare for each airline, mean is specified so it is the only value printed in the table*/
	var airfare;
	class airline;
	format airline $fmt.;
Run;

/*Question 1d*/
proc format;                      
value $fmt 'deltasum'='Delta Summer' 'deltafal'='Delta Fall' 'icesum'='Icelandair Summer' 'icefall'='Icelandair Fall' 
			'britsum'='British Air Summer' 'britfall'='British Air Fall';
proc sgplot data=flights;                                 /*used to create a vertical bar chart*/
	vbar airline/ response=airfare stat=mean           
	            fillattrs=(color=rose)
	            group=airline                            /*The direstions asked for a grouped sgplot,
	            											it will be taken out in the next question because it is redundant*/
	            groupdisplay=stack;
	            format airline $fmt.;
Run;




/*Question 1e*/
proc format;                      
value $fmt 'deltasum'='Delta Summer' 'deltafal'='Delta Fall' 'icesum'='Icelandair Summer' 'icefall'='Icelandair Fall' 
			'britsum'='British Air Summer' 'britfall'='British Air Fall';
proc sgplot data=flights;                                 /*used to create a vertical bar chart*/
	vbar airline/ response=airfare stat=mean limitstat=clm      /*limitstat=clm places the 95% confidence interval on the graph*/       
	            fillattrs=(color=tan)
	            dataskins=gloss
	           datalabel
	           datalabelpos=bottom;                             /*puts the values of the confidence interval below the bars*/
	            format airline $fmt.;
Run;



/*Question 2a*/
Data company; 
	set mylib.company; /*refers to the mylib library*/
Run;
proc print data=company ;
run;


/*Question 2b*/
proc freq data=company;
	Tables Job1 ;            /*specifies the variable*/ 
Run;

/*Question 2c*/
proc freq data=company;
	Tables Level2*Level3;
Run;
/*Of the sample, London had virtually no adminsitration (only 2). Tokyo also had much fewer observations in total. 
Tokyo was mainly comprise of administration. Technical workers were also the least represented overall*/ 



/*Question 3a*/ 
Data Rand1;
		Do i = 1 to 50000;      /*Generates 50000 random observations*/
		x1 =rand('POISSON',2.4); /*Used the POISSON command with a parameter*/
		               
		output;
	end; 
run;

proc sgplot data=Rand1;
	histogram X1 / transparency= .5;
Run;
/*The histogram looks fairly similar to a normal distribution centered around 2.4. 
However, there are a few discrepencies including the fact that there are no observations
 below 0, making the histogram lopsided*/
 
 
 
 /*Question 3b */ 
 Data Newrand2;
	Do i=1 to 100000;                /*Do loop used again to generate random values
										which are generated for 9 different variables*/
		x1 = rand('POISSON',2.4);
		x2 = rand('POISSON',2.4);
		x3 = rand('POISSON',2.4);
		x4 = rand('POISSON',2.4);
		x5 = rand('POISSON',2.4);
		x6 = rand('POISSON',2.4);
		x7 = rand('POISSON',2.4);
		x8 = rand('POISSON',2.4);
		x9 = rand('POISSON',2.4);
		Avg2 = mean(x1,x2); /*average of the first two variables*/
		Avg4 = mean(of x1-x4); /*average of the first 4 variables*/
		Avg9 = mean(of x1-x9); /*average of the all 9 variables*/
		output;
	End;
Run;

proc print data=Newrand2 (obs=10);
run;




/*Question 3c*/
/*Compare the three averages*/
proc sgplot data=Newrand2;
	histogram avg2 / transparency= .8 fillattrs=(color=black);
	histogram avg4 / transparency= .7 fillattrs=(color=red);
	histogram avg9 / transparency= .6 fillattrs=(color=green);
Run;
	

/*Question 3d*/
/*The first average (avg2) is relatively more spread out and and higher on the y axis.
As more averages are included the graphs become more and more condensed. 
At avg9 the graph becomes almost a perfect bellcurve that is normally distributed.
When more averages are included, the graph becomes less spread out, denser, and more bellshaped.
This trend is most likely due to the central limit theroem because the graphs become
more normally distributed when more observations are included and more rows are used*/ 

