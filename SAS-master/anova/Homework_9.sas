/*random devices
machines are crossed */


/*Part A The Food is a fixed factor with three levels for each brand. The rats are nested within the food and are randomized (10 levels (10 for each brand))
If we make the assumption that their "exchangability" makes them "the same" We could maybe argue rats and food are crossed, but I would say this is too much of a stretch and the three groups of rats for each brand should be considered seperate. 

Part B The gallon cans have a random variation and is not a factor. The tint suppliers and the possibly miscalibrated devices are crossed.
The tint suppliers and devices would both be fixed but in this experiment not all devices will be used and are therefore random.
There are three levels of suppliers for each manufacturer of the tint, and 100 mixing devices (but 20 levels).
Because only 60 gallons of paint will be used to test the variation, the devices are random because only 60 can be used.
Therefore the factors are: 
1. Suppliers: Fixed, with three levels.
2. Devices: Random, with 20 levels and only 60 tests between the tree suppliers (making them crossed because each device (level) interacts with the three brands.  

Part C All three factors are random (county, hectacre and meter square)
Hectacres are nested in counties, and meter squares are nested in hectacres: County->hectacre->square meter
Counties:10 levels, meter square:100 levels

Part D Fully nested 3 factor mixed effect model for Brand, Diapers, and Boxes
Brand is fixed, boxes random, diapers random
Brand has 2 levels, box has 32 treatments (16 levels), diaper has 2 levels
Diapers are nested in boxes, boxes are nested in brand
Brand->box->diaper

64 diapers because 2 levels for brands buy 16 of each brand, from each box test 2 diapers.*/


/*Question 2*/
data ex13_2;
 input batch $ temp $ pH $ sugar $ graininess  ; cards;
             1      1  low     low                   21
             1      1 high     low                   12
             1      1  low    high                   13
             1      1 high    high                    1
             2      1  low     low                   21
             2      1 high     low                   18
             2      1  low    high                   14
             2      1 high    high                    8
             1      2  low     low                   23
             1      2 high     low                   14
             1      2  low    high                   13
             1      2 high    high                    1
             2      2  low     low                   23
             2      2 high     low                   17
             2      2  low    high                   16
             2      2 high    high                   11
             1      3  low     low                   17
             1      3 high     low                   20
             1      3  low    high                   16
             1      3 high    high                   14
             2      3  low     low                   23
             2      3 high     low                   17
             2      3  low    high                   17
             2      3 high    high                    5
;
proc glm data=ex13_2 plot=diagnostics;
class temp ph sugar;
model graininess=temp ph sugar;
run;
/*Assumptions not met*/
proc transreg data=ex13_2;
model BoxCox(graininess/lambda=-2 to 2 by 0.1 alpha=0.05) = class(temp ph sugar);
run;

data tran;
	set ex13_2;
	grain2 = graininess**1.5;
run;
proc glm data=tran plot=all;
class batch temp pH sugar;
model grain2=batch temp pH sugar temp*pH temp*sugar pH*sugar temp*pH*sugar;
run;
quit;

/*Given their small p values, ph and sugar effect graininess, while temperature does not.
We will remove all the other interactions*/


proc glm data=tran plot=all;
class ph sugar;
model grain2= batch ph sugar;
means ph/tukey;
run;

