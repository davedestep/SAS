data osteo;
  input fracture;
  cards;
3
87
;
run;

proc freq data = osteo order = data;
  table fracture/binomial(p=.05);
  weight fracture;
run;





proc freq data = nuclear order = data;
  table osteo / binomial(p = 0.25) alpha = 0.05;
  weight cancer;
run;


title1
'Computing Sample Size Given Power (Unbalanced Groups)'
;
title2
'pi_1 =
0.35
, pi_2 = 
0.20
, alpha = 0.05, power = 0.85, 2 to 1 ratio new:standard'
;
proc power;
twosamplefreq test = pchi 
alpha= 0.05 
groupproportions= (0.13 0.221)
nullproportiondiff= 0
ntotal= 700
power= .;
run;




proc
power
;
twosamplefreq
test
= pchi
alpha
= 
0.05
groupproportions
= (
0.4614
0.30
)
nullproportiondiff
= 
0
groupweights
= (
1
1
)
ntotal
= 
100
150
200
250
300
power
= 
.
;
plot
;
run
;



/*5a*/
proc power;
twosamplefreq test = pchi 
alpha= 0.05 
groupproportions= (0.1476 0.07)
groupweights=(1,1)
nullproportiondiff= 0
ntotal= .
power= .75;
run;




proc power;
twosamplefreq test = pchi 
alpha= 0.05 
groupproportions= (.221 0.13)
nullproportiondiff= 0
ntotal= .
power=0.80;
run;



proc power;
twosamplefreq test = pchi 
alpha= 0.05 
groupproportions= (0.20 0.43)
nullproportiondiff= 0
ntotal= .
power= .80;
run;



/*HW6*/
data trial;
 input treatment $ dia $ events;
 cards;
yes dia 31
yes no_dia 1749
no dia 87
no no_dia 1641
;
run;

proc freq data=trial order=data;
table treatment*dia/relrisk chisq;
weight events;
run;






data trials;
 input vaccine events trials;
 cards;
0  87 1728
1 31 1780
;
run;

proc format;
 value estfmt 0 = 'placebo' 1 = 'vaccine';
run;

proc logistic data = trials; 
class vaccine(ref = 'placebo') / param = ref; model events/trials = vaccine / cl; 
format vaccine estfmt.;
 run;




FILENAME REFFILE '/home/dmd12d0/UMARUdata2018.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.UMARU;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.UMARU; RUN;



proc logistic data=UMARU descending; 
model DFREE (event='1')=treat age race site; 
run; 

proc logistic data=UMARU descending; 
class race  (ref = '0') / param = ref;
class site  (ref = '0') / param = ref;
class treat  (ref = '0') / param = ref;
model DFREE=treat age race site; 
run; 



/*design variable set to -1 and 1!! means estimates are not compared to reference, but average!*/
proc logistic data=UMARU descending; 
class treat race site/descending;
model DFREE (event='1')=treat age race site; 
run; 



proc univariate data = UMARU; 
  var age;
run;








/*Homework 8*/


data prison;
   input type $ prior $ events trials;     
   datalines;
nrb some 55 151
nrb none 17 192
other some 48 208
other none 25 412
;
run;


/*saturated*/
proc logistic data = prison; 
class type(ref = 'other') / param = ref;
class prior(ref = 'none') / param = ref;
model events/trials = type prior type*prior / cl; 
run;


/*type*/
proc logistic data = prison; 
class type(ref = 'other') / param = ref;
class prior(ref = 'none') / param = ref;
model events/trials = type / cl; 
run;

/*prior*/

proc logistic data = prison; 
class type(ref = 'other') / param = ref;
class prior(ref = 'none') / param = ref;
model events/trials = prior/ cl; 
run;


/*Type and prior*/
proc logistic data = prison; 
class type(ref = 'other') / param = ref;
class prior(ref = 'none') / param = ref;
model events/trials = type prior / cl; 
run;
