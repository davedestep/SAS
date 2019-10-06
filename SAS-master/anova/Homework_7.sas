/*1. Problem 9.1 from Oehlert. (3 points)
2. Exercise 10.1 from Oehlert. (4 points)
3. Exercise 10.2 from Oehlert. (3 points)
    0011 Add abcd*/

/*Problem 9.1*/
/*In both the orignal and transformed model every variable is significant except weeks*type
The significance varies when the model does not include each variable, but we are supposed to include 
each*/
    data flour;
 input acidity  extraction $ weeks  type $ ; cards;
           12.7            1      0               P
           12.3            2      0               P
           15.4            3      0               P
           13.3            4      0               P
           13.9            5      0               P
           30.3            6      0               P
          123.9            7      0               P
           53.4            8      0               P
           29.4            9      0               P
           11.4           10      0               P
           19.0           11      0               P
           11.3            1      3               P
           16.4            2      3               P
           18.1            3      3               P
           14.6            4      3               P
           10.5            5      3               P
           27.5            6      3               P
          112.3            7      3               P
           48.9            8      3               P
           31.4            9      3               P
           11.6           10      3               P
           29.1           11      3               P
           16.5            1      6               P
           24.3            2      6               P
           27.2            3      6               P
           10.9            4      6               P
           11.6            5      6               P
           34.1            6      6               P
          117.5            7      6               P
           52.9            8      6               P
           38.3            9      6               P
           15.8           10      6               P
           17.1           11      6               P
           10.9            1      9               P
           30.8            2      9               P
           24.5            3      9               P
           13.5            4      9               P
           13.2            5      9               P
           33.2            6      9               P
          107.4            7      9               P
           49.6            8      9               P
           42.9            9      9               P
           17.8           10      9               P
           15.9           11      9               P
           12.5            1     15               P
           30.6            2     15               P
           26.5            3     15               P
           15.8            4     15               P
           13.3            5     15               P
           36.2            6     15               P
          109.5            7     15               P
           51.0            8     15               P
           15.2            9     15               P
           18.2           10     15               P
           13.5           11     15               P
           15.2            1     21               P
           36.3            2     21               P
           36.8            3     21               P
           14.4            4     21               P
           13.1            5     21               P
           43.2            6     21               P
           98.6            7     21               P
           48.2            8     21               P
           58.6            9     21               P
           22.2           10     21               P
           17.6           11     21               P
           36.5            1      0              FC
           38.5            2      0              FC
           38.4            3      0              FC
           27.1            4      0              FC
           35.0            5      0              FC
           38.3            6      0              FC
          274.6            7      0              FC
          241.4            8      0              FC
           21.8            9      0              FC
           34.2           10      0              FC
           34.2           11      0              FC
           35.4            1      3              FC
           68.5            2      3              FC
           63.6            3      3              FC
           41.4            4      3              FC
           34.5            5      3              FC
           76.8            6      3              FC
          282.8            7      3              FC
          231.8            8      3              FC
           47.9            9      3              FC
           33.9           10      3              FC
           33.2           11      3              FC
           35.7            1      6              FC
           93.2            2      6              FC
           76.7            3      6              FC
           50.2            4      6              FC
           34.0            5      6              FC
           96.4            6      6              FC
          270.8            7      6              FC
          223.2            8      6              FC
           65.2            9      6              FC
           38.9           10      6              FC
           35.2           11      6              FC
           33.8            1      9              FC
           95.0            2      9              FC
          113.0            3      9              FC
           44.9            4      9              FC
           36.1            5      9              FC
           94.5            6      9              FC
          271.6            7      9              FC
          200.1            8      9              FC
           75.0            9      9              FC
           39.0           10      9              FC
           34.7           11      9              FC
           43.0            1     15              FC
          156.7            2     15              FC
          160.0            3     15              FC
           30.2            4     15              FC
           33.0            5     15              FC
           75.8            6     15              FC
          269.5            7     15              FC
          213.6            8     15              FC
           88.9            9     15              FC
           37.9           10     15              FC
           33.0           11     15              FC
           53.0            1     21              FC
          189.3            2     21              FC
          199.3            3     21              FC
           41.0            4     21              FC
           45.5            5     21              FC
          143.9            6     21              FC
          136.1            7     21              FC
          198.9            8     21              FC
          104.0            9     21              FC
           39.2           10     21              FC
           37.1           11     21              FC
;
/*Checking if we need to do a transformation*/
proc glm data=flour;
class weeks extraction type;
model acidity= weeks;
run;

proc transreg data=flour;
model BoxCox(acidity/lambda=0 to 0.7 by 0.01 alpha=0.05) = class(weeks type extraction weeks*extraction type*extraction weeks*type);
run;

data flour2;
	set flour;
	 logacidity = log(acidity);
run;


proc glm data=flour2;
class weeks extraction type;
model logacidity= weeks type extraction weeks*extraction type*extraction weeks*type;
run;




/*Exercise 10.1*/

Type 2 ANOVA






/*Exercise 10.2*/
data ex10_2;
 input resp  ; cards;
                1.106
                2.295
                7.074
                6.931
                4.132
                2.148
               10.200
               10.120
                3.337
                1.827
                8.698
                6.255
                3.755
                2.789
               10.990
               11.850
;
data ex10_2a;
i=1; do d=0 to 1; do c=0 to 1;do b=0 to 1;do a=0 to 1;
set ex10_2 point=i;
output;
i=i+1;
end; end; end; end; stop;
run;
