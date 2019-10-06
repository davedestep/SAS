/*This code was written starting on 10/27. Datasets were taken from
charts available online and pasted into excel to upload the files, as
the original data was not available for download. .xslx files were 
uploaded on the dates of 10/27 and 10/28 */

/*uploading and cleaning up the assorted data sets.*/
proc import out=CO2
datafile="/home/dmd12d0/3064/midterm/CO2Emissions.xlsx"
dbms = xlsx replace;
run; /*import the file*/
/*get rid of extra datalines and observations*/
data CO2;
set CO2 (firstobs=4);
if Jurisdiction='District of Columbia' then delete; /*get rid of extra dataline*/
run;
/*sort the data for future merging*/
proc sort data=co2;
by Jurisdiction;
run;
/*do some renaming*/
data CO2;
set co2 (rename=(Rank=EmissionsRank));
run;
data CO2emissions;
set CO2 (rename=(Jurisdiction=State));
run;
proc print data=co2emissions;run;
/*import the next file*/
proc import out=education
datafile="/home/dmd12d0/3064/midterm/StateEducation.xlsx"
dbms = xlsx replace;
run;
/*rename some of the variables and remove the unneeded datalines*/
data education;
set education (rename=(Rank=HSRank)rename=(Rank_1=BARank)rename=(Rank_2=ADvanceRank) );
if state='United States' then delete;
if state='District of Columbia' then delete;
run;   /*remove extra datalines*/
proc print data=education;
run;
/*sort by state for future merging*/
proc sort daTa=education;
by state;
run;
proc import out=PopulationDensity
datafile="/home/dmd12d0/3064/midterm/PopulationDensity (2).xlsx"
dbms = xlsx replace;
run;     /*import final file*/
proc print data=populationdensity;run;
/*drop an excess column*/
data populationdensity;
set PopulationDensity;
drop rank;
run;
/*sort by state for merging*/
proc sort data=populationdensity;
by state;
run;
/*merage all 3 data setsm by what they have in common (state)*/
data mergebystate;
merge education CO2emissions PopulationDensity;
by state; 
drop HSRank BARank ADvanceRank EmissionsRank 
   EstimatedPopulation Landareasqmi;     /*drop excess variables*/
run;
proc print data=mergebystate;run;
/*print the data set to make sure it all works*/

/*get 3 quantiles for the predictor variables to make them categorical*/
proc univariate data=education;
var Highschoolgraduate; 
output out=percentiles pctlpts=33, 66 pctlpre=P;
run;
proc print data=percentiles;run; 
proc univariate data=education;
var Bachelorsdegree;
output out=Bpercentiles pctlpts=33, 66 pctlpre=P;
proc print data=Bpercentiles;run;
proc univariate data=co2emissions;
var CO2emissionspercapita;
output out=COpercentiles pctlpts=33, 66 pctlpre=P;
run; 
proc print data=COpercentiles;run;
proc univariate data=mergebystate;
var Denssqmi;
output out=COpercentile pctlpts=33, 66 pctlpre=P;
run;
proc print data=COpercentile;run;
/*1 is low, 2 is medium, 3 is high*/
data Renaming; 
set mergebystate;
if CO2emissionspercapita <=12.82 then empc=1;
if CO2emissionspercapita >=21.9 then empc=3;
if 12.82<CO2emissionspercapita<21.9 then empc=2;
if Highschoolgraduate<=0.847 then HSgrad=1;
if 0.847<Highschoolgraduate<0.892 then HSgrad=2;
if Highschoolgraduate>=0.892 then HSgrad=3;
if  Bachelorsdegree<0.251 then BDegree=1;
if 0.251<=Bachelorsdegree<= 0.2895 then BDegree=2;
if Bachelorsdegree>0.2895 then BDegree=3;
if Denssqmi<56.9 then Density=1;
if 56.9<=Denssqmi<=  174.35 then Density=2;
if Denssqmi>174.35 then Density=3;
run;
proc print data=renaming;run;
/*setting everything to categorical but numerical values*/
/*check for collinearity*/
proc reg data=renaming;
model CO2emissionspercapita=density HSgrad BDegree/VIF;
run;
proc corr data=renaming;
var CO2emissionspercapita density HSgrad BDegree;
run;
/*basic anova*/
proc glm data=renaming;
model CO2emissionspercapita=density HSgrad BDegree;
run;
/*make sure the hypothesis is right. h0=no change*/
/*check interaction*/
/*2 way anova*/
proc glm data=renaming;
class density BDegree;
model CO2emissionspercapita=density HSgrad BDegree /ss3;
means density BDegree/tukey lsd;
run;
/*I took out the craziest outlier because it was having such a pull*/
data nooutlier;
set renaming;
if state='Wyoming' then delete;
run;
/*I need to resort the data because I played around with it earlier*/
proc sort data=nooutlier;
by state;
run;
/*re-do the anova without the outlier*/
proc glm data=nooutlier;
class density BDegree;
model CO2emissionspercapita=density BDegree /ss3;
means density BDegree/tukey lsd;
run;
/*remove the second craziest outlier*/
data nout2;
set nooutlier;
if state='North Dakota' then delete;
run;
/*redo the anova again*/
proc glm data=nout2;
class density BDegree;
model CO2emissionspercapita=density BDegree /ss3;
means density BDegree/tukey lsd;
run;
