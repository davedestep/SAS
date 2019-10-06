PROC IMPORT DATAFILE="/home/dmd12d0/STA3024 Data/WHO.csv"/*Data read from a csv data file that has over 300 variables*/
	OUT=who4(keep=var1 var3 var5 var6 var260);/*variables imported from data file; var1=country, var3=continent, var5=Adult literacy rate, var6=Gross National Income Per Capita, var260=Life Expectancy*/
	guessingrows=1000;
	getnames=no;/*Variable names are not included while data read because some variable names are very long and have characters which are not allowed in SAS. Variable names are labeled afterwards*/
	datarow=2;/*This tells SAS to skip the frist row which is the variable names and start reading observations from second row.*/
RUN;

proc print data=who4 (obs=10) label;/*Raw data is printed*/
label var1=Country var3=Continent var260=Life Expectancy var5=Adult Literacy Rate var6=GNI Per Capita;
var var1 var3 var5 var6 var260;
run;

data worlddata4;/*New variables are defined*/
length Income $ 8 Literacy $ 19;/*Length of the variables are declared to SAS. These variables are defined in this datastep*/
set who4;
if 0<var6<10000 then Income='Low';/*The gross naitonal income per capita is categorized*/
else if 10000<var6<20000 then Income='Medium';
else if 20000<var6 then Income='High';
else Income='No Input';

if 0<var5<68 then Literacy='Low';/*Adult literacy rate is categorized*/
else if 68<var5<88 then Literacy='Medium';
else if 88<var5 then Literacy='High';
else Literacy='No Input';
run;

proc format;/*Continents are numerically coded in the raw data file. New character format is defined to be used for Continent.*/
value cont
1='Middle East'
2='Europe'
3='Africa'
4='North America'
5='South America'
6='Australia'
7='Asia'
;
run;

data newworld4;
set worlddata4;
format var3 cont.;/*Continent is converted into defined format*/
run;


proc print data=newworld4 (obs=50) label;/*Variable are labeled and ordered*/
label var1=Country var3=Continent var260=Life Expectancy var5=Adult Literacy Rate var6=GNI Per Capita;
var var1 var3 Literacy Income var5 var6 var260;
run;



proc sgplot data=newworld4;
label var1=Country var3=Continent var260=Life Expectancy var5=Adult Literacy Rate var6=GNI Per Capita;
	vbar var3/ response=var260 stat=mean
	           fillattrs=(color=red)
	           transparency=.5
	           barwidth=.3; /*bar takes up 30% of available space*/
	 vbar var3/ response=var5 stat=mean
	           fillattrs=(color=blue)
	           transparency=.5
	           barwidth=.6;  
run;


proc sgplot data=newworld4;
	vbar var3/ response=var260 stat=mean
	           fillattrs=(color=red)
	           barwidth=.4
	           discreteoffset= -.2; /*shift the bar down halfway*/
	 vbar var3/ response=var5 stat=mean
	           fillattrs=(color=blue)
	           barwidth=.4
	           discreteoffset=.2;  /*shift the bar up halfway*/
run;






proc sgplot data=newworld4;
	vbar var3/ response=var260 stat=mean
	           fillattrs=(color=green)
	           barwidth=.6;
	           xaxis label='Region';
	           yaxis label='Average Life Expectancy';
run;

proc sgplot data=newworld4;
	vbar var3/ response=var5 stat=mean
	           fillattrs=(color=blue)
	           barwidth=.6
	           transparency=.5;
	           xaxis label='Region';
	           yaxis label='Adult Literacy Rate';
run;

proc sgplot data=newworld4;
	vbar var3/ response=var6 stat=mean
	           fillattrs=(color=green);
	           xaxis label='Region';
	           yaxis label='Gross National Income per Capita';
run;

proc sgplot data=worlddata4;
where income ^= 'No Input';
	vbar income/ response=var5 stat=mean
	           fillattrs=(color=green);
	           xaxis label='Gross National Income per Capita';
	           yaxis label='Literacy Rate';
run;



proc sgplot data=newworld4;
scatter x=var5 y=var6 / markerattrs=(symbol=squarefilled color=orange);
	xaxis label='Literacy Rate';
	yaxis label='Gross National Income per Capita';
run;
proc sgplot data=newworld4;
reg x=var5 y=var260 /degree=3 markerattrs=(symbol=diamondfilled color=yellow);
	xaxis label='Literacy Rate';
	yaxis label='Life Expectancy';
run;

Proc sort data=worlddata4;
by income;
run;
Proc boxplot data=worlddata4;
	where income ^= 'No Input'; 
	plot var5*income / boxstyle=schematic; 
	label var5='Literacy Rate' income='Gross Nation Income Per Capita';
run;


proc freq data=worlddata4;
	Tables income*literacy;
Run;

proc freq data=worlddata4;
	Tables var;
Run;
