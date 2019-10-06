/*I certify my SAS assignment is my original and exclusive work*/
/*David DeStephano Assignment 1*/


/*Question 1 a*/
Data class;
infile datalines missover delimiter='/';    /*delimiter used so a slash is used to seperate data*/
											/*Missover prevents sas from getting data on the next dataline*/
input SudentID $ Quiz1 Quiz2 Quiz3 Quiz4 Midterm Project Final;
Datalines;
JK/89/100/88/91/100/87/87
DS/100/95/97/69/100/88/85
SR/100/84/98/69/0//89
RL/99/0/94/0/100/77/55
MZ/100/100/92/97/100/100/98
BB/88//80/52/100/78/76
AC/100/100/100/98/100/100/98
run;
proc print;
run;

/*Question 1b*/
Data class;
infile datalines missover delimiter='/' DSD;    /*delimiter used so a slash is used to seperate data*/
input SudentID $ Quiz1 Quiz2 Quiz3 Quiz4 Midterm Project Final;     /*DSD used so two slashes distinguish that data is missing*/
Datalines;
JK/89/100/88/91/100/87/87
DS/100/95/97/69/100/88/85
SR/100/84/98/69/0//89
RL/99/0/94/0/100/77/55
MZ/100/100/92/97/100/100/98
BB/88//80/52/100/78/76
AC/100/100/100/98/100/100/98
run;
proc print;
run;

/*question 1 c*/
/*the delimiter is used so sas reads data when a character such as / or , is used to seperate data. DSD is used to skip over data when an extra slash is used*/


Data class;
infile datalines missover delimiter='/' DSD;    /*delimiter used so a slash is used to seperate data*/
input StudentID $ Quiz1 Quiz2 Quiz3 Quiz4 Midterm Project Final;     /*DSD used so two slashes distinguish that data is missing*/
courseavg = .1*Quiz1 + .1*Quiz2 + .1*Quiz3 + .1*Quiz4 + .2*Midterm + .2*Project + .2*Final;    /*new variable and formula used to determine semester averages, those with missed assignments did not have a final average due to missover*/
Datalines;
JK/89/100/88/91/100/87/87
DS/100/95/97/69/100/88/85
SR/100/84/98/69/0//89
RL/99/0/94/0/100/77/55
MZ/100/100/92/97/100/100/98
BB/88//80/52/100/78/76
AC/100/100/100/98/100/100/98
run;
proc print;
var StudentID courseavg;
run;




/*Question 2 a*/

Data schools;
Input School_ID Magnet $ Grade $ Students Score;
datalines;
1202    yes    D     42    299
1454    no     A     41    299
1613    no     C    125    295
1812    no     C     83    289
1838    yes    A    123    326
1963    yes    A     81    311
2081    yes    A    170    303
2388    no     B     90    304
2393    no     A    113    295
2543    no     C     59    294
2547    no     B     30    294
2564    yes    C     50    290
2659    no     A     15    306
2714    no     B    123    297
2942    yes    A     90    312
3125    yes    C     92    292
3208    no     A     45    293
3324    no     C     66    296
3377    no     A     53    296
3664    no     D    109    295
3681    no     A    159    298
3880    no     A     45    295
3884    no     B     66    291
3918    yes    D     62    304
3923    no     A    162    308
4190    yes    A     94    301
4451    no     A    184    310
4492    no     A    102    313
4582    no     A    142    306
4863    yes    D     53    311

run;
proc print data =schools;
run;
proc sort data=schools out=new;      /*procsort sorts data into old and new data set*/
By Grade;
run; 
proc print data=new (obs=10);        /*obs includes only first 10 observations*/
run;



/*Question 2b*/
Data schools;
Input School_ID Magnet $ Grade $ Students Score;
datalines;
1202    yes    D     42    299
1454    no     A     41    299
1613    no     C    125    295
1812    no     C     83    289
1838    yes    A    123    326
1963    yes    A     81    311
2081    yes    A    170    303
2388    no     B     90    304
2393    no     A    113    295
2543    no     C     59    294
2547    no     B     30    294
2564    yes    C     50    290
2659    no     A     15    306
2714    no     B    123    297
2942    yes    A     90    312
3125    yes    C     92    292
3208    no     A     45    293
3324    no     C     66    296
3377    no     A     53    296
3664    no     D    109    295
3681    no     A    159    298
3880    no     A     45    295
3884    no     B     66    291
3918    yes    D     62    304
3923    no     A    162    308
4190    yes    A     94    301
4451    no     A    184    310
4492    no     A    102    313
4582    no     A    142    306
4863    yes    D     53    311


run;
proc sort data=schools out=new;      /*procsort sorts data into old and new data set*/
By Grade Students;                  /*By statement ensures grade is first sorted in ascending order followed by students*/
run;
proc print data=new;
var Grade School_ID Students;
run;


/*Question 2c*/

Data schools;
Input School_ID Magnet $ Grade $ Students Score;
datalines;
1202    yes    D     42    299
1454    no     A     41    299
1613    no     C    125    295
1812    no     C     83    289
1838    yes    A    123    326
1963    yes    A     81    311
2081    yes    A    170    303
2388    no     B     90    304
2393    no     A    113    295
2543    no     C     59    294
2547    no     B     30    294
2564    yes    C     50    290
2659    no     A     15    306
2714    no     B    123    297
2942    yes    A     90    312
3125    yes    C     92    292
3208    no     A     45    293
3324    no     C     66    296
3377    no     A     53    296
3664    no     D    109    295
3681    no     A    159    298
3880    no     A     45    295
3884    no     B     66    291
3918    yes    D     62    304
3923    no     A    162    308
4190    yes    A     94    301
4451    no     A    184    310
4492    no     A    102    313
4582    no     A    142    306
4863    yes    D     53    311


run;
proc sort data=schools out=new;      /*procsort sorts data into old and new data set*/
By Grade Magnet Score;                  /*Proc sort and by statement again sort the specified data*/
run;
proc print data=new noobs;
var School_ID Magnet Score;           /*The by statement after proc print does not sort like it would after proc sort, but seperates the data tables by each grade*/
by Grade;
run;






/*Question 3*/
Data mood;
Infile '/home/dmd12d0/STA3024 Data/mood sas.txt' delimiter=',';
Input drug pretest posttest;
increase=posttest-pretest;
run;
proc print data=mood;
run;

/*Question 3b*/
Data mood;
Infile '/home/dmd12d0/STA3024 Data/mood sas.txt' delimiter=',';
Input drug pretest posttest;
increase=posttest-pretest;
If increase=>16 then improvement=1;                     /*If then formula used to create new variable and assign values to it*/
 	If 10<=increase<16 then improvement=2;
 	If increase<10 then improvement=3;
run;
proc print data=mood;
run;

/*Question 3c */
Data mood;
Infile '/home/dmd12d0/STA3024 Data/mood sas.txt' delimiter=',';
Input drug pretest posttest;
increase=posttest-pretest;
If increase=>16 then improvement=1;                     /*If then formula used to create new variable and assign values to it*/
 	If 10<=increase<16 then improvement=2;
 	If increase<10 then improvement=3;
Proc format;
value rfmt 1='excellent' 2='good' 3='fair'       /*procformat used to change output values in table, to create better descriptions of the data by assigning new names*/
run;
proc print data=mood;
format improvement rfmt.;
run;









/*Question 4*/
Data diamonds;
Filename CSV '/home/dmd12d0/STA3024 Data/diamond.csv' TERMSTR=CRLF;


PROC IMPORT DATAFILE=CSV
		    OUT=diamonds
		    DBMS=CSV
		    REPLACE;
guessingrows=1000;
run;
proc print data=diamonds (firstobs= 131 obs=179);
run;



/*Question 4b (only for if and in order (d-i))*/

Filename CSV '/home/dmd12d0/STA3024 Data/diamond.csv' TERMSTR=CRLF;


PROC IMPORT DATAFILE=CSV
		    OUT=diamonds
		    DBMS=CSV
		    REPLACE;
guessingrows=1000;
run;
data ppc;
set diamonds;
priceper=price/carat;              /*need to create new data set (with new name) using the old set (diamonds, a new variable can then be created to find price per carat)*/
run;
proc print data=ppc;
 where clarity='IF';               /*Where statement specifies conditions for the output*/

run;


/*Question 4c*/
Data diamonds;
Filename CSV '/home/dmd12d0/STA3024 Data/diamond.csv' TERMSTR=CRLF;


PROC IMPORT DATAFILE=CSV
		    OUT=diamonds
		    DBMS=CSV
		    REPLACE;
guessingrows=1000;
run;
proc print data=diamonds;
where 0.44<carat<0.55 ;                   /*where statement makes the output only include carats between .44 and .54, when claristy=VS1*/
where also clarity='VS1';
var Color Price;
run;

