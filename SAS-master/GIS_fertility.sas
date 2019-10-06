FILENAME REFFILE '/home/dmd12d0/MyLib/dgrgeddr.xlsx';
PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=WORK.IMPORT1;
	GETNAMES=YES;
RUN;


 Data fert2;
 label FEFRTRWTFR=fertility_rate;
 	set WORK.IMPORT1;
 	/*categorizing value*/
 	If 4<= FPNADMWUNT <=15 then unmet = 1;     /*Moderate is the longest value*/
 	If 15<FPNADMWUNT<=26  then Unmet = 2;
 	If FPNADMWUNT>26 then unmet=3; /*Only option that remains*/
 /*More efficient  approach*/
 run;



proc glm data=fert2 plots=diagnostics;
class unmet;
MODEL FEFRTRWTFR=unmet;
means unmet/tukey;
RUN;
