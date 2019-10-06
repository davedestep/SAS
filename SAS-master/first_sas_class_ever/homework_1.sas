/*I certify my SAS assignment is my original and exclusive work*/
/*David DeStephano Assignment 1*/



/*Problem 1 a-c*/
Data Cars;

infile datalines;

Input Mileage Make $ Type $ Cylinder Liter Doors;
datalines;
 8221       Buick        Sedan   6   3.1   4 
27096       Buick        Sedan   6   3.8   4
29649       Buick        Sedan   6   3.8   4
 2992       Buick        Sedan   6   3.8   4
37128       Buick        Sedan   6   3.8   4
 2202    Cadillac        Sedan   8   5.7   4
10555    Cadillac        Sedan   8   4.6   4
42691    Cadillac  Convertible   8   4.6   2
10011   Chevrolet    Hatchback   4   1.6   4
38866   Chevrolet        Sedan   4   2.2   4
 7695   Chevrolet        Sedan   4   2.2   4
28683   Chevrolet        Sedan   4   2.2   4
 3625   Chevrolet  Convertible   8     6   2
25956   Chevrolet        Sedan   6   3.5   4
 5827   Chevrolet        Coupe   6   3.8   2 
25218        SAAB        Wagon   4   2.5   4 
 2879      Saturn        Coupe   4   2.2   2 
 5826      Saturn        Sedan   6     3   4 


Run;

proc print data=Cars (obs=9);      /*(obs 9) used so only first 9 observations are included*/
var Type Doors Make Mileage;
run;





/*Problem 1 d*/
Data Cars;

infile datalines;

Input Mileage Make $ Type $ Cylinder Liter Doors;
datalines;
 8221       Buick        Sedan   6   3.1   4 
27096       Buick        Sedan   6   3.8   4
29649       Buick        Sedan   6   3.8   4
 2992       Buick        Sedan   6   3.8   4
37128       Buick        Sedan   6   3.8   4
 2202    Cadillac        Sedan   8   5.7   4
10555    Cadillac        Sedan   8   4.6   4
42691    Cadillac  Convertible   8   4.6   2
10011   Chevrolet    Hatchback   4   1.6   4
38866   Chevrolet        Sedan   4   2.2   4
 7695   Chevrolet        Sedan   4   2.2   4
28683   Chevrolet        Sedan   4   2.2   4
 3625   Chevrolet  Convertible   8     6   2
25956   Chevrolet        Sedan   6   3.5   4
 5827   Chevrolet        Coupe   6   3.8   2 
25218        SAAB        Wagon   4   2.5   4 
 2879      Saturn        Coupe   4   2.2   2 
 5826      Saturn        Sedan   6     3   4 
;


Run;

proc print data=Cars;

where Cylinder = 8;     /*only includes 8 cylinder cars in results*/

var Type Doors Make Mileage;
run;







/*Question 2*/
/*exclude the observation numbers and label the variable Cylinder as “Number of Cylinders” and Price as “Retail Price”*/

Data Cars;

infile datalines;

Input
	Type $ 20-31          /*Column Input*/
	Liter 37-41
	Price $ 48-60;
datalines;
8221       Buick        Sedan   6   3.1   4    $17,314.10 
27096       Buick        Sedan   6   3.8   4    $20,986.02 
29649       Buick        Sedan   6   3.8   4    $20,902.10 
 2992       Buick        Sedan   6   3.8   4    $20,698.08 
37128       Buick        Sedan   6   3.8   4    $21,536.74 
 2202    Cadillac        Sedan   8   5.7   4    $51,154.05 
10555    Cadillac        Sedan   8   4.6   4    $35,651.68 
42691    Cadillac  Convertible   8   4.6   2    $52,001.99 
10011   Chevrolet    Hatchback   4   1.6   4    $12,146.19 
38866   Chevrolet        Sedan   4   2.2   4    $10,546.78 
 7695   Chevrolet        Sedan   4   2.2   4    $15,553.21 
28683   Chevrolet        Sedan   4   2.2   4    $12,678.85 
 3625   Chevrolet  Convertible   8     6   2    $46,732.61 
25956   Chevrolet        Sedan   6   3.5   4    $15,680.86 
 5827   Chevrolet        Coupe   6   3.8   2    $18,800.09 
25218        SAAB        Wagon   4   2.5   4    $23,329.21 
 2879      Saturn        Coupe   4   2.2   2    $16,916.87 
 5826      Saturn        Sedan   6     3   4    $18,173.98  
;


Run;

proc print data=Cars;
run;




Data Cars;

infile datalines;

Input 
	Mileage 1-6
	Make $ 9-18
	Type $ 20-31
	Cylinder 33-35
	Liter 37-41
	Doors 43-45
	Price $ 48-60;
datalines;
8221       Buick        Sedan   6   3.1   4    $17,314.10 
27096       Buick        Sedan   6   3.8   4    $20,986.02 
29649       Buick        Sedan   6   3.8   4    $20,902.10 
 2992       Buick        Sedan   6   3.8   4    $20,698.08 
37128       Buick        Sedan   6   3.8   4    $21,536.74 
 2202    Cadillac        Sedan   8   5.7   4    $51,154.05 
10555    Cadillac        Sedan   8   4.6   4    $35,651.68 
42691    Cadillac  Convertible   8   4.6   2    $52,001.99 
10011   Chevrolet    Hatchback   4   1.6   4    $12,146.19 
38866   Chevrolet        Sedan   4   2.2   4    $10,546.78 
 7695   Chevrolet        Sedan   4   2.2   4    $15,553.21 
28683   Chevrolet        Sedan   4   2.2   4    $12,678.85 
 3625   Chevrolet  Convertible   8     6   2    $46,732.61 
25956   Chevrolet        Sedan   6   3.5   4    $15,680.86 
 5827   Chevrolet        Coupe   6   3.8   2    $18,800.09 
25218        SAAB        Wagon   4   2.5   4    $23,329.21 
 2879      Saturn        Coupe   4   2.2   2    $16,916.87 
 5826      Saturn        Sedan   6     3   4    $18,173.98  
;


Run;

proc print data=Cars noobs label;            /*Noobs used so obs numbers not included*/
label Cylinder ='Number of Cylinders';       /*label used to change name*/
label Price ='Retail Price';
run;







/*Question 3*/
Data Cars;

infile datalines;

Input                       /*Included all variables and using "var" input to limit output 
							instead of only including needed variables in the input*/
	@1 Mileage 6.
	@9 Make $9.
	@20 Type $11.
	@34 Model $11.
	@48 Cylinder 1.
	@52 Liter 3.
	@58 Doors 1.
	@63 Price dollar10.;       /*dollar10. makes it so the price is read numerically*/
							

datalines;
 8221       Buick        Sedan       Century   6   3.1   4    $17,314.10 
27096       Buick        Sedan      Lacrosse   6   3.8   4    $20,986.02 
29649       Buick        Sedan      Lacrosse   6   3.8   4    $20,902.10 
 2992       Buick        Sedan       Lesabre   6   3.8   4    $20,698.08 
37128       Buick        Sedan   Park Avenue   6   3.8   4    $21,536.74 
 2202    Cadillac        Sedan         CST-V   8   5.7   4    $51,154.05 
10555    Cadillac        Sedan       Deville   8   4.6   4    $35,651.68 
42691    Cadillac  Convertible        XLR-V8   8   4.6   2    $52,001.99 
10011   Chevrolet    Hatchback          AVEO   4   1.6   4    $12,146.19 
38866   Chevrolet        Sedan      Cavalier   4   2.2   4    $10,546.78 
 7695   Chevrolet        Sedan       Classic   4   2.2   4    $15,553.21 
28683   Chevrolet        Sedan        Cobalt   4   2.2   4    $12,678.85 
 3625   Chevrolet  Convertible      Corvette   8     6   2    $46,732.61 
25956   Chevrolet        Sedan        Malibu   6   3.5   4    $15,680.86 
 5827   Chevrolet        Coupe   Monte Carlo   6   3.8   2    $18,800.09 
25218        SAAB        Wagon      9-2X AWD   4   2.5   4    $23,329.21 
 2879      Saturn        Coupe           Ion   4   2.2   2    $16,916.87 
 5826      Saturn        Sedan      L Series   6     3   4    $18,173.98
;


Run;

proc print data=Cars(firstobs=5 obs=10) label;      /*To print obs 5-10*/
label Cylinder ='Number of Cylinders';
label Price ='Retail Price';
var Make Model Mileage Price;
run; 




/* 3b*/
Data Cars;

infile datalines;

Input                       /*Included all variables and using "var" input to limit output 
							instead of only including needed variables in the input*/
	@1 Mileage 6.
	@9 Make $9.
	@20 Type $11.
	@34 Model $11.
	@48 Cylinder 1.
	@52 Liter 3.
	@58 Doors 1.
	@63 Price dollar10.
	@73 discount 20;       
							
If Price <20000 then discount = .1*Price;                   /*If statements used to calculate discounts*/
If 20000 <= Price <=40000 then discount = .15*Price;
If Price > 40000 then discount = .17*Price;


datalines;
 8221       Buick        Sedan       Century   6   3.1   4    $17,314.10 
27096       Buick        Sedan      Lacrosse   6   3.8   4    $20,986.02 
29649       Buick        Sedan      Lacrosse   6   3.8   4    $20,902.10 
 2992       Buick        Sedan       Lesabre   6   3.8   4    $20,698.08 
37128       Buick        Sedan   Park Avenue   6   3.8   4    $21,536.74 
 2202    Cadillac        Sedan         CST-V   8   5.7   4    $51,154.05 
10555    Cadillac        Sedan       Deville   8   4.6   4    $35,651.68 
42691    Cadillac  Convertible        XLR-V8   8   4.6   2    $52,001.99 
10011   Chevrolet    Hatchback          AVEO   4   1.6   4    $12,146.19 
38866   Chevrolet        Sedan      Cavalier   4   2.2   4    $10,546.78 
 7695   Chevrolet        Sedan       Classic   4   2.2   4    $15,553.21 
28683   Chevrolet        Sedan        Cobalt   4   2.2   4    $12,678.85 
 3625   Chevrolet  Convertible      Corvette   8     6   2    $46,732.61 
25956   Chevrolet        Sedan        Malibu   6   3.5   4    $15,680.86 
 5827   Chevrolet        Coupe   Monte Carlo   6   3.8   2    $18,800.09 
25218        SAAB        Wagon      9-2X AWD   4   2.5   4    $23,329.21 
 2879      Saturn        Coupe           Ion   4   2.2   2    $16,916.87 
 5826      Saturn        Sedan      L Series   6     3   4    $18,173.98
;





Run;

proc print data=Cars label;      
label Cylinder ='Number of Cylinders';
label Price ='Retail Price';
var Make Model Price Discount;
run; 




