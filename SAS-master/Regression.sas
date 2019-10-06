data HW4;
   input typ_neighb tot_pop prop_child prop_lunch prop_change_income crime_rate;
   datalines;
1 6.9 30.2 58.3 27.3 84.9
1 8.4 38.8 87.5 39.8 17.6
1 5.7 31.7 83.5 26 154.2
0 7.4 24.2 14.2 29.4 35.2
0 8.5 28.1 46.7 26.6 69.2
0 13.8 10.4 57.9 26.2 111
1 3.6 30 61.3 26.4 69.9
0 8.2 12.1 41 11.7 65.4
0 5 13.6 17.4 14.7 132.1
0 2.1 18.3 34.4 24.2 57.9
1 4.2 21.3 64.9 21.7 139.9
1 3.9 33.1 82 26.3 108.7
1 4.1 38.3 83.3 32.6 123.2
1 4.2 36.9 61.8 21.6 104.7
0 9.4 22.4 22.2 33.5 61.5
0 3.6 19.6 8.6 27 68.2
0 7.6 29.1 62.8 32.2 96.9
0 7.5 26.5 18.7 23.7 32
1 4.1 41.5 78.6 23.5 127
1 4.6 39 14.6 38.2 27.1
0 7.2 20.2 41.4 27.6 70.7
0 13.4 20.4 13.9 22.5 38.3
0 10.3 29.8 43.7 29.4 54
1 9.4 36 78.2 29.9 101.5
1 10.3 31.8 57.2 27.2 61.2
1 7.5 28.6 5.7 31.3 38.6
1 18.7 39.7 55.8 28.7 52.6
1 5.1 23.8 29 29.3 62.6
0 3.7 12.3 77.3 32 20.7
1 10.3 31.1 51.7 26.2 42.4
0 7.3 32.9 68.1 25.2 105.2
0 4.2 22.1 41.2 21.4 68.6
0 2.1 27.1 60 23.5 15.3
0 2.5 20.3 29.8 24.1 58.5
1 8.1 30 66.4 26 63.1
0 10.3 15.9 39.9 38.5 86.4
1 10.5 36.4 72.3 26 77.5
0 5.8 24.2 19.5 28.3 63.5
0 6.9 20.7 6.6 25.8 68.9
1 9.3 34.9 82.4 18.4 102.8
1 11.4 38.7 78.2 18.4 86.6
;
run;

proc univariate data=hw4;
var prop_change_income;
run;


proc reg data=hw4;
      model CRIME_RATE=PROP_CHANGE_INCOME / r cli clm ;
      Output out=hw4 p=Ypredicted LCL=ylowerin LCLM=ylowermean UCL=yupperin UCLM=yuppermean;
   run;
   
   
proc reg data=hw4;
      model CRIME_RATE=PROP_CHANGE_INCOME PROP_LUNCH/ r cli clm ;
run;






/*Regression 5*/
data hw5;
   input typ_neighb tot_pop prop_child prop_lunch prop_change_income crime_rate;
   datalines;
1 6.9 30.2 58.3 27.3 84.9
1 8.4 38.8 87.5 39.8 17.6
1 5.7 31.7 83.5 26 154.2
0 7.4 24.2 14.2 29.4 35.2
0 8.5 28.1 46.7 26.6 69.2
0 13.8 10.4 57.9 26.2 111
1 3.6 30 61.3 26.4 69.9
0 8.2 12.1 41 11.7 65.4
0 5 13.6 17.4 14.7 132.1
0 2.1 18.3 34.4 24.2 57.9
1 4.2 21.3 64.9 21.7 139.9
1 3.9 33.1 82 26.3 108.7
1 4.1 38.3 83.3 32.6 123.2
1 4.2 36.9 61.8 21.6 104.7
0 9.4 22.4 22.2 33.5 61.5
0 3.6 19.6 8.6 27 68.2
0 7.6 29.1 62.8 32.2 96.9
0 7.5 26.5 18.7 23.7 32
1 4.1 41.5 78.6 23.5 127
1 4.6 39 14.6 38.2 27.1
0 7.2 20.2 41.4 27.6 70.7
0 13.4 20.4 13.9 22.5 38.3
0 10.3 29.8 43.7 29.4 54
1 9.4 36 78.2 29.9 101.5
1 10.3 31.8 57.2 27.2 61.2
1 7.5 28.6 5.7 31.3 38.6
1 18.7 39.7 55.8 28.7 52.6
1 5.1 23.8 29 29.3 62.6
0 3.7 12.3 77.3 32 20.7
1 10.3 31.1 51.7 26.2 42.4
0 7.3 32.9 68.1 25.2 105.2
0 4.2 22.1 41.2 21.4 68.6
0 2.1 27.1 60 23.5 15.3
0 2.5 20.3 29.8 24.1 58.5
1 8.1 30 66.4 26 63.1
0 10.3 15.9 39.9 38.5 86.4
1 10.5 36.4 72.3 26 77.5
0 5.8 24.2 19.5 28.3 63.5
0 6.9 20.7 6.6 25.8 68.9
1 9.3 34.9 82.4 18.4 102.8
1 11.4 38.7 78.2 18.4 86.6
;
run;



data hw5;
set hw5;
prop_lunch_cat="Lunch_A";
if prop_lunch>33 then prop_lunch_cat="Lunch_B";
if prop_lunch>66 then prop_lunch_cat="Lunch_C";
run;

proc freq data=hw5;
tables prop_lunch_cat;
run;

data hw5;
set hw5;
lunch_numeric_B=0;
if prop_lunch_cat="Lunch_B" then lunch_numeric_B=1;
lunch_numeric_A=0;
if prop_lunch_cat="Lunch_A" then lunch_numeric_A=1;
run;


proc reg data=hw5;
title "Reduced model";
      model CRIME_RATE=PROP_CHANGE_INCOME;
run;
proc reg data=hw5;
title "Full model";
      model CRIME_RATE=PROP_CHANGE_INCOME lunch_numeric_A lunch_numeric_B;
run;



data hw5;
set hw5;
drop lunch_numeric_C;
lunch_numeric_A=0;
if prop_lunch_cat="Lunch_A" then lunch_numeric_A=1;
lunch_numeric_C=0;
if prop_lunch_cat="Lunch_C" then lunch_numeric_C=1;
run;





/*HW 6*/
data HW5;
   input typ_neighb tot_pop prop_child prop_lunch prop_change_income crime_rate;
   datalines;
1 6.9 30.2 58.3 27.3 84.9
1 8.4 38.8 87.5 39.8 17.6
1 5.7 31.7 83.5 26 154.2
0 7.4 24.2 14.2 29.4 35.2
0 8.5 28.1 46.7 26.6 69.2
0 13.8 10.4 57.9 26.2 111
1 3.6 30 61.3 26.4 69.9
0 8.2 12.1 41 11.7 65.4
0 5 13.6 17.4 14.7 132.1
0 2.1 18.3 34.4 24.2 57.9
1 4.2 21.3 64.9 21.7 139.9
1 3.9 33.1 82 26.3 108.7
1 4.1 38.3 83.3 32.6 123.2
1 4.2 36.9 61.8 21.6 104.7
0 9.4 22.4 22.2 33.5 61.5
0 3.6 19.6 8.6 27 68.2
0 7.6 29.1 62.8 32.2 96.9
0 7.5 26.5 18.7 23.7 32
1 4.1 41.5 78.6 23.5 127
1 4.6 39 14.6 38.2 27.1
0 7.2 20.2 41.4 27.6 70.7
0 13.4 20.4 13.9 22.5 38.3
0 10.3 29.8 43.7 29.4 54
1 9.4 36 78.2 29.9 101.5
1 10.3 31.8 57.2 27.2 61.2
1 7.5 28.6 5.7 31.3 38.6
1 18.7 39.7 55.8 28.7 52.6
1 5.1 23.8 29 29.3 62.6
0 3.7 12.3 77.3 32 20.7
1 10.3 31.1 51.7 26.2 42.4
0 7.3 32.9 68.1 25.2 105.2
0 4.2 22.1 41.2 21.4 68.6
0 2.1 27.1 60 23.5 15.3
0 2.5 20.3 29.8 24.1 58.5
1 8.1 30 66.4 26 63.1
0 10.3 15.9 39.9 38.5 86.4
1 10.5 36.4 72.3 26 77.5
0 5.8 24.2 19.5 28.3 63.5
0 6.9 20.7 6.6 25.8 68.9
1 9.3 34.9 82.4 18.4 102.8
1 11.4 38.7 78.2 18.4 86.6
;
run;
data hw5;
set hw5;
prop_lunch_cat="Lunch_A";
if prop_lunch>33 then prop_lunch_cat="Lunch_B";
if prop_lunch>66 then prop_lunch_cat="Lunch_C";
run;


proc mixed data=hw5;
class prop_lunch_cat;
model crime_rate = prop_lunch_cat prop_change_income /solution;
run;






data HW6prob3;
   input bldclot progindx enzyme liver age gender alcuse severealc survtime logsurv progcat $ ;
   datalines;
6.7    62    81    2.59    50    0    1    0    695    6.544    med
5.1    59    66    1.7    39    0    0    0    403    5.999    med
7.4    57    83    2.16    55    0    0    0    710    6.565    low
6.5    73    41    2.01    48    0    0    0    349    5.854    med
5.8    38    72    1.42    65    1    1    0    348    5.852    low
5.7    46    63    1.91    49    1    0    1    518    6.25    low
3.7    68    81    2.57    69    1    1    0    749    6.619    med
6    67    93    2.5    58    0    1    0    1056    6.962    med
3.7    76    94    2.4    48    0    1    0    968    6.875    high
6.3    84    83    4.13    37    0    1    0    745    6.613    high
6.7    51    43    1.86    57    0    1    0    257    5.549    low
5.8    83    88    3.95    52    1    0    0    858    6.754    high
7.7    62    67    3.4    58    0    0    1    702    6.554    med
7.4    74    68    2.4    64    1    1    0    809    6.695    high
6    85    28    2.98    36    1    1    0    682    6.526    high
3.7    51    41    1.55    39    0    0    0    205    5.321    low
7.3    68    74    3.56    59    1    0    0    550    6.309    med
5.6    57    87    3.02    63    0    0    1    838    6.731    low
5.2    52    76    2.85    39    0    0    0    359    5.883    low
3.4    83    53    1.12    67    1    1    0    353    5.866    high
6.7    26    68    2.1    30    0    0    1    599    6.395    low
5.8    67    86    3.4    49    1    1    0    562    6.332    med
6.3    59    100    2.95    36    1    1    0    651    6.478    med
5.8    61    73    3.5    62    1    1    0    751    6.621    med
5.2    52    86    2.45    70    0    1    0    545    6.302    low
5.2    54    56    2.71    44    1    0    0    477    6.167    low
5.8    76    59    2.58    61    1    1    0    600    6.396    high
3.2    64    65    0.74    53    0    1    0    443    6.094    med
8.7    45    23    2.52    68    0    1    0    181    5.198    low
5    59    73    3.5    57    0    1    0    411    6.019    med
5.8    72    93    3.3    39    1    0    1    1037    6.944    med
5.4    58    70    2.64    31    1    1    0    482    6.179    med
5.3    51    99    2.6    48    0    1    0    634    6.453    low
2.6    74    86    2.05    45    0    0    0    678    6.519    high
4.3    8    119    2.85    65    1    0    0    362    5.893    low
4.8    61    76    2.45    51    1    1    0    637    6.457    med
5.4    52    88    1.81    40    1    0    0    705    6.558    low
5.2    49    72    1.84    46    0    0    0    536    6.283    low
3.6    28    99    1.3    55    0    0    1    582    6.366    low
6.5    56    77    2.85    41    0    1    0    538    6.288    low
3.4    77    93    1.48    69    0    1    0    482    6.178    high
6.5    40    84    3    54    1    1    0    611    6.416    low
4.5    73    106    3.05    47    1    1    0    960    6.867    med
5.1    67    77    2.86    66    1    0    0    581    6.365    med
3.9    82    103    4.55    50    0    1    0    1078    6.983    high
6.6    77    46    1.95    50    0    1    0    405    6.005    high
6.4    85    40    1.21    58    0    0    1    579    6.361    high
6.4    59    85    2.33    63    0    1    0    550    6.31    med
8.8    78    72    3.2    56    0    0    0    651    6.478    high
;
run;



proc reg data=HW6prob3;
model survtime = gender enzyme ;
run;




data hw6prob3;
set hw6prob3;
gender_enzyme = gender*enzyme;
run;

proc reg data=HW6prob3;
model survtime=gender enzyme gender_enzyme;
run;


   
data HW6prob3;
set HW6prob3;
prop_lunch_cat="Lunch_A";
med = 0;
if progcat="med" then med=1;
high=0;
if progcat="high" then high=1;
enz_med=enzyme*med;
enz_high=enzyme*high;
run;



proc reg data=HW6prob3;
model survtime = enzyme med high;
run;
proc reg data=HW6prob3;
model survtime = enzyme med high enz_med enz_high;
run;




proc mixed data=HW6prob3;
class progcat;
model survtime= enzyme progcat progcat*Enzyme /solution ;
run;


/*Homework 7*/
data HW7prob2;
   input typ_neighb tot_pop prop_child prop_lunch prop_change_income crime_rate;
   datalines;
1 6.9 30.2 58.3 27.3 84.9
1 8.4 38.8 87.5 39.8 17.6
1 5.7 31.7 83.5 26 154.2
0 7.4 24.2 14.2 29.4 35.2
0 8.5 28.1 46.7 26.6 69.2
0 13.8 10.4 57.9 26.2 111
1 3.6 30 61.3 26.4 69.9
0 8.2 12.1 41 11.7 65.4
0 5 13.6 17.4 14.7 132.1
0 2.1 18.3 34.4 24.2 57.9
1 4.2 21.3 64.9 21.7 139.9
1 3.9 33.1 82 26.3 108.7
1 4.1 38.3 83.3 32.6 123.2
1 4.2 36.9 61.8 21.6 104.7
0 9.4 22.4 22.2 33.5 61.5
0 3.6 19.6 8.6 27 68.2
0 7.6 29.1 62.8 32.2 96.9
0 7.5 26.5 18.7 23.7 32
1 4.1 41.5 78.6 23.5 127
1 4.6 39 14.6 38.2 27.1
0 7.2 20.2 41.4 27.6 70.7
0 13.4 20.4 13.9 22.5 38.3
0 10.3 29.8 43.7 29.4 54
1 9.4 36 78.2 29.9 101.5
1 10.3 31.8 57.2 27.2 61.2
1 7.5 28.6 5.7 31.3 38.6
1 18.7 39.7 55.8 28.7 52.6
1 5.1 23.8 29 29.3 62.6
0 3.7 12.3 77.3 32 20.7
1 10.3 31.1 51.7 26.2 42.4
0 7.3 32.9 68.1 25.2 105.2
0 4.2 22.1 41.2 21.4 68.6
0 2.1 27.1 60 23.5 15.3
0 2.5 20.3 29.8 24.1 58.5
1 8.1 30 66.4 26 63.1
0 10.3 15.9 39.9 38.5 86.4
1 10.5 36.4 72.3 26 77.5
0 5.8 24.2 19.5 28.3 63.5
0 6.9 20.7 6.6 25.8 68.9
1 9.3 34.9 82.4 18.4 102.8
1 11.4 38.7 78.2 18.4 86.6
;
run;


data HW7prob2;
set hw7prob2;
prop_lunch_cat="Lunch_A";
if prop_lunch>33 then prop_lunch_cat="Lunch_B";
if prop_lunch>66 then prop_lunch_cat="Lunch_C";
run;

data HW7prob2;
set hw7prob2;
lunch_A=0; lunch_B=0;
if prop_lunch_cat="Lunch_A" then lunch_A=1;
if prop_lunch_cat="Lunch_B" then lunch_B=1;
run;



proc glm data=HW7prob2;
      model CRIME_RATE=PROP_CHANGE_INCOME lunch_A lunch_B lunch_A*PROP_CHANGE_INCOME lunch_B*PROP_CHANGE_INCOME TOT_POP;
run;

proc reg data=HW7prob2;
      model CRIME_RATE=PROP_CHANGE_INCOME lunch_A lunch_B tot_pop;
      plot r.*prop_change_income;
plot r.*tot_pop;
run;


data hw7prob2;
set hw7prob2;
lunchA_income = prop_change_income*lunch_A;
lunchB_income = prop_change_income*lunch_B;
run;

proc reg data=HW7prob2;
      model CRIME_RATE=PROP_CHANGE_INCOME lunch_A lunch_B lunchA_income lunchB_income tot_pop;
      plot r.*prop_change_income;
	  plot r.*tot_pop;
run;

proc reg data=HW7prob2;
      model CRIME_RATE=PROP_CHANGE_INCOME lunch_A lunch_B lunchA_income lunchB_income tot_pop;
      plot h.*prop_change_income;
run;

proc reg data=HW7prob2;
      model CRIME_RATE=PROP_CHANGE_INCOME lunch_A lunch_B lunchA_income lunchB_income tot_pop;
      plot rstudent.* p.;;
run;


proc reg data=HW7prob2;
      model CRIME_RATE=PROP_CHANGE_INCOME lunch_A lunch_B lunchA_income lunchB_income tot_pop;
      output out=HW7prob2out p=yhat r=resid h=lever student=intstud rstudent=extstud;
run;

proc univariate data=hw7prob2out;
histogram resid;
histogram intstud;
histogram extstud;
run;







/*Regression HW 8*/
data HW8;
  input SUBJECT AGE SEX HGT BONEM WGT ASTHMA FEV;
cards;
1        24         1       175       253        62         1       4.7
2        36         1       172       240      63.6         1       4.3
3        28         0       171       270      60.2         1       3.5
4        25         1       166       231      57.3         1         4
5        26         0       166       231      58.1         1       3.2
6        22         1       176       241      60.6         1       4.7
7        27         1       185       270      64.9         1       4.3
8        27         1       171       247      58.4         1       4.7
9        36         1       185       264      66.9         1       5.2
10        24         1       182       270        61         1       4.2
11        26         1       180       250      61.6         1       3.5
12        29         1       163       238      59.2         1       3.2
13        33         0       180       248      66.4         1       2.6
14        31         1       180       245      66.8         0         2
15        30         1       180       250      61.9         1         4
16        22         1       168       231      56.3         1       3.9
17        27         1       168       259        60         0         3
18        46         1       178       245      69.7         1       4.5
19        36         1       173       235      63.9         1       1.7
20        32         0       156       254      59.2         0       2.5
21        52         1       175       237      70.3         1       5.1
22        61         0       162       272      71.1         1       4.2
23        64         0       149       222      64.4         1       4.6
24        25         1       185       264      64.7         1       4.7
25        34         1       179       257        65         1       4.7
26        38         1       169       249      63.5         1       4.9
27        27         0       172       241      61.6         0       2.5
28        26         0       176       238      60.5         0       2.9
29        48         1       179       267      69.6         1       4.8
30        42         0       156       275      59.6         1       2.8
31        57         1       167       249      69.7         1       4.1
32        26         0       163       273      55.7         0       2.1
33        34         1       169       258      62.6         1       4.2
34        51         0       152       253      64.4         0       2.9
35        44         0       158       233      61.3         1       3.1
36        24         0       167       256      56.2         0         2
37        34         0       172       275        63         1         3
38        51         0       176       256      67.8         1       3.8
39        68         1       195       264      79.4         1       4.9
40        32         0       174       237      63.4         1       3.5
41        41         1       196       272      73.7         1       4.2
42        57         0       165       245      69.1         1       3.4
43        46         1       204       279      74.1         1       8.5
44        47         1       168       267      67.7         1       4.2
45        51         0       154       261        62         0       2.1
46        34         1       198       267      72.4         1       4.5
47        32         0       172       263      61.8         1       3.9
48        64         1       172       244      74.5         1       4.7
49        51         0       176       233      70.3         1       3.8
50        39         0       159       225      60.9         1       3.4
;
run;

proc reg data=HW8;
model FEV=HGT WGT AGE BONEM ASTHMA SEX;
run;
proc reg data=HW8_43;
model FEV=HGT WGT AGE BONEM ASTHMA SEX;
run;


ods graphics on;
proc reg data=hw8;
model FEV= hgt wgt age bonem asthma sex / r influence spec tol vif;
output out=hw8_output  p=yhat_i r=e_i  H=h_ii student=r_i rstudent=r_i_ext DFFITs=dffits_i cookd=D_i;
run;
quit;
ods graphics off;

proc univariate data=hw8_output;
var e_i;
qqplot e_i;
histogram e_i /normal kernel;
run; 


data hw8_43;
set hw8;
if subject = '43' then delete;
run;



ods graphics on;
proc reg data=hw8_43;
model FEV= hgt wgt age bonem asthma sex / r influence spec tol vif;
output out=hw8_43_output  p=yhat_i r=e_i  H=h_ii student=r_i rstudent=r_i_ext DFFITs=dffits_i cookd=D_i;
run;
quit;
ods graphics off;

















/*Homework 9*/
data HW8;
  input SUBJECT AGE SEX HGT BONEM WGT ASTHMA FEV;
cards;
1        24         1       175       253        62         1       4.7
2        36         1       172       240      63.6         1       4.3
3        28         0       171       270      60.2         1       3.5
4        25         1       166       231      57.3         1         4
5        26         0       166       231      58.1         1       3.2
6        22         1       176       241      60.6         1       4.7
7        27         1       185       270      64.9         1       4.3
8        27         1       171       247      58.4         1       4.7
9        36         1       185       264      66.9         1       5.2
10        24         1       182       270        61         1       4.2
11        26         1       180       250      61.6         1       3.5
12        29         1       163       238      59.2         1       3.2
13        33         0       180       248      66.4         1       2.6
14        31         1       180       245      66.8         0         2
15        30         1       180       250      61.9         1         4
16        22         1       168       231      56.3         1       3.9
17        27         1       168       259        60         0         3
18        46         1       178       245      69.7         1       4.5
19        36         1       173       235      63.9         1       1.7
20        32         0       156       254      59.2         0       2.5
21        52         1       175       237      70.3         1       5.1
22        61         0       162       272      71.1         1       4.2
23        64         0       149       222      64.4         1       4.6
24        25         1       185       264      64.7         1       4.7
25        34         1       179       257        65         1       4.7
26        38         1       169       249      63.5         1       4.9
27        27         0       172       241      61.6         0       2.5
28        26         0       176       238      60.5         0       2.9
29        48         1       179       267      69.6         1       4.8
30        42         0       156       275      59.6         1       2.8
31        57         1       167       249      69.7         1       4.1
32        26         0       163       273      55.7         0       2.1
33        34         1       169       258      62.6         1       4.2
34        51         0       152       253      64.4         0       2.9
35        44         0       158       233      61.3         1       3.1
36        24         0       167       256      56.2         0         2
37        34         0       172       275        63         1         3
38        51         0       176       256      67.8         1       3.8
39        68         1       195       264      79.4         1       4.9
40        32         0       174       237      63.4         1       3.5
41        41         1       196       272      73.7         1       4.2
42        57         0       165       245      69.1         1       3.4
43        46         1       204       279      74.1         1       8.5
44        47         1       168       267      67.7         1       4.2
45        51         0       154       261        62         0       2.1
46        34         1       198       267      72.4         1       4.5
47        32         0       172       263      61.8         1       3.9
48        64         1       172       244      74.5         1       4.7
49        51         0       176       233      70.3         1       3.8
50        39         0       159       225      60.9         1       3.4
;
run;




ods graphics on;
proc reg data=hw8;
model FEV= hgt wgt age bonem asthma sex / r influence spec tol vif;
output out=hw8_output p=yhat_i r=e_i H=h_ii student=r_i rstudent=r_i_ext DFFITS=dffits_i cookd=D_i;
run;
quit;
ods graphics off;





/*Homework 10*/


data airlinecost;
  input Airline $ length speed day_time pop_served tot_cost revenue load capacity assets funds assets_adj;
cards;
AllAmerican              57     133    6.10   20200   116.3    0.96   0.400   2.400   21.13    3.21   17.92
American                 270     216    6.93   56928    43.0    3.98   0.689   5.776 1436.53  165.22 1271.31
Bonanza                  100     140    4.45     183   141.5    0.79   0.358   2.207    6.65    0.01    6.64
Braniff                  176     182    6.60   11869    50.6    2.57   0.557   4.614  160.30    5.81  154.49
Capital                  142     167    7.47   41097    51.0    2.68   0.510   5.255  195.02    6.06  188.96
Central                   51     134    4.67    1757   318.5    0.35   0.167   2.096   14.02    0.01   14.01
CS                      175     175    8.60   18000    59.2    2.17   0.558   3.889  114.16    3.11  111.05
Colonial                 112     150    6.87   13500    77.0    1.68   0.505   3.327   35.34    0.79   34.55
Continental              131     179    6.50    3831    62.3    1.70   0.537   3.166   49.74    3.49   46.25
Delta                    174     191    7.60   13119    45.3    2.74   0.598   4.582  174.32    3.87  170.45
Eastern                  182     187    9.50   44000    42.6    3.07   0.528   5.814 1042.58  187.84  854.74
Empire                    59     143    4.83     451   112.4    0.69   0.313   2.204    4.71    0.02    4.69
Frontier                  81     141    7.47    2500   125.2    0.72   0.398   1.809   17.66    0.12   17.54
LakeCentral              73     142    3.85    5405   169.3    0.48   0.212   2.264    6.32    0.01    6.31
MidContinent            144     167    6.20    6725    64.8    1.53   0.565   2.708   76.12    2.44   73.68
Mohawk                    79     137    5.88    9250   100.5    1.02   0.476   2.143   14.54    0.09   14.45
National                 199     207    8.28   23431    42.9    3.12   0.567   5.503  181.27   16.14  165.13
Northeast                 94     150    6.77   16000    81.1    1.19   0.597   1.988   49.38    2.11   47.27
Northwest                271     202    6.88   27000    56.7    4.30   0.570   7.544  471.50    7.98  463.52
Piedmont                  90     153    8.13    3362    75.4    1.08   0.449   2.405   21.60    3.10   18.50
Pioneer                   89     150    7.05    2050    71.3    1.16   0.483   2.402   19.11    0.01   19.10
Southern                  67     147    6.15    2337   150.1    0.60   0.317   1.893   12.44    0.01   12.43
Southwest                 54     127    5.85    5143    78.9    1.18   0.491   2.403   16.06    0.08   15.98
TransTexas               78     147    6.08    2600   130.3    0.65   0.372   1.747   11.10    0.42   10.68
TWA                      293     193    6.40   51500    46.2    3.62   0.670   5.403 1217.98  120.07 1097.91
United                   270     207    6.63   48913    42.3    3.75   0.630   5.952 1127.25   79.98 1047.27
WestCoast                58     135    4.50    1850   103.3    0.82   0.421   1.948   10.98    0.01   10.97
Western                  172     181    6.67    6250    44.2    2.68   0.656   4.085  137.39   17.02  120.37
Inland                   147     158    9.38    1000    64.7    1.54   0.575   2.678   16.61    0.03   16.58
Wiggins                   45     116    2.35    2500   820.9    0.07   0.166   0.422    2.03    0.62    1.41
Wisconsin                 69     142    5.72    6500   130.9    0.81   0.430   1.884   10.80    0.01   10.79
;
run;

ods graphics on;
proc reg data=airlinecost;
model REVENUE = length speed day_time pop_served  tot_cost load capacity assets funds / SELECTION=FORWARD SLENTRY=.25;
run;
quit;
ods graphics off;


ods graphics on;
proc glmselect data=airlinecost plot=CriterionPanel;
   model REVENUE = length speed day_time pop_served  tot_cost load capacity assets funds 
                / selection=forward(select=AdjRSq) stats=all;
ods select SelectionSummary CriterionPanel;
quit;



ods graphics on;
proc reg data=airlinecost;
model REVENUE = length speed day_time pop_served  tot_cost load capacity assets funds  / SELECTION=BACKWARD SLSTAY=.25;
run;
quit;
ods graphics off;



ods graphics on;
proc reg data=airlinecost;
model REVENUE = length speed day_time pop_served  tot_cost load capacity assets funds /SELECTION=RSQUARE;
run;
quit;
ods graphics off;

ods graphics on;
proc reg data=airlinecost;
model REVENUE = length speed day_time pop_served  tot_cost load capacity assets funds;
run;
quit;
ods graphics off;


ods graphics on;
proc reg data=airlinecost;
model REVENUE = capacity;
run;
quit;
ods graphics off;



ods graphics on;
proc reg data=airlinecost;
model REVENUE = length speed day_time pop_served  tot_cost load capacity assets funds /SELECTION=ADJRSQ;
run;
quit;
ods graphics off;

ods graphics on;
proc reg data=airlinecost;
model REVENUE = speed day_time pop_served tot_cost load capacity assets funds;
run;
quit;
ods graphics off;




/*1f*/
ods graphics on;
proc reg data=airlinecost;
model tot_cost = length speed day_time pop_served  revenue load capacity assets funds / SELECTION=FORWARD SLENTRY=.3;
run;
quit;
ods graphics off;

ods graphics on;
proc glmselect data=airlinecost plot=CriterionPanel;
   model tot_cost = length speed day_time pop_served  revenue load capacity assets funds
                / selection=forward(select=AdjRSq) stats=all;
ods select SelectionSummary CriterionPanel;
quit;



ods graphics on;
proc reg data=airlinecost;
model tot_cost = length speed day_time pop_served  revenue load capacity assets funds / SELECTION=BACKWARD SLSTAY=.3;
run;
quit;
ods graphics off;





ods graphics on;
proc reg data=airlinecost;
model tot_cost = length speed pop_served revenue load capacity assets funds;
run;
quit;
ods graphics off;



/*1h*/
ods graphics on;
proc reg data=airlinecost;
model tot_cost = length speed day_time pop_served  revenue load capacity assets funds /SELECTION=RSQUARE;
run;
quit;
ods graphics off;

ods graphics on;
proc reg data=airlinecost;
model tot_cost = length speed day_time pop_served  revenue load capacity assets funds;
run;
quit;
ods graphics off;



/*1i*/
ods graphics on;
proc reg data=airlinecost;
model tot_cost = length speed day_time pop_served  revenue load capacity assets funds /SELECTION=ADJRSQ;
run;
quit;
ods graphics off;



/*model selection*/
ods graphics on;
proc reg data=airlinecost;
model tot_cost = length speed day_time pop_served  revenue load capacity assets funds /VIF TOL;
run;
quit;
ods graphics off;

ods graphics on;
proc corr data=airlinecost plots=scatter;
run;
ods graphics off;


proc sgscatter data=airlinecost;
  compare y=tot_cost
          x=( length speed day_time pop_served  revenue load capacity assets funds);
run;
proc reg data=airlinecost;
model tot_cost = length speed day_time pop_served  revenue load capacity assets funds;
run;
quit;
ods graphics off;

proc reg data=airlinecost;
model tot_cost = length speed day_time pop_served  revenue load capacity assets;
run;
quit;
ods graphics off;

/*take out day time*/
proc reg data=airlinecost;
model tot_cost = length speed pop_served  revenue load capacity assets;
run;
quit;
ods graphics off;

/*funds*/
proc reg data=airlinecost;
model tot_cost = length speed funds pop_served  revenue load capacity assets/VIF;
run;
quit;
ods graphics off;

/*remove length*/
proc reg data=airlinecost;
model tot_cost = speed funds pop_served  revenue load capacity assets/VIF;
run;
quit;
ods graphics off;

proc reg data=airlinecost;
model tot_cost = pop_served funds  revenue load capacity assets/VIF;
run;
quit;

/*Question 2*/
data prob2;
  input years subj subj_ast;
  cards;
2 121 1
3 99 1
6 86 4
8 75 9
10 68 18
11 73 27
13 53 33
15 137 112
20 34 33
;
run;


data prob2; set prob2;
prop=subj_ast/subj;
run;

proc logistic data = prob2;
model subj_ast/subj = years / cl;
run;



