libname censor "P:\Andy Subset";

PROC IMPORT OUT= WORK.drug_categories 
            DATAFILE= "P:\Andy Subset\20170115_XM_crosswalk2.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="Sheet1$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


proc format;
	value analysis_group_to_text
		1	=	'Admitted to picu_mv hospital'
		2	=	'Admitted to PICU (no mechanical ventilation)'
		3	=	'Admitted to PICU and received mechanical ventilation'
		other	=	.
	;
Run;


proc format;
	value birth
		1	=	'Birth Cohort'
		2	=	'Non-Birth Cohort'
		other	=	.
	;
Run;

/*Getting censor dates to merge to Anyd's msis_id_list*/
proc sort data = censor.Cohorttx_bdd_general nodupkey out=censor_general;
by msis_id;
run;
proc sort data = censor.Cohorttx_bdd_picu nodupkey out=censor_picu;
by msis_id;
run;
proc sort data = censor.Cohorttx_bdd_picu_mv nodupkey out=censor_picu_mv;
by msis_id;
run;

data censor_general;
set censor_general;
keep MSIS_ID censor_dt;
run;
data censor_picu;
set censor_picu;
keep MSIS_ID censor_dt;
run;
data censor_picu_mv;
set censor_picu_mv;
keep MSIS_ID censor_dt;
run;

data censor_comb;
set censor_general censor_picu censor_picu_mv;
run;


/*Merging censor dates with Andy's msis ID list*/
PROC IMPORT OUT= WORK.msis_id_list 
            DATAFILE= "P:\Andy Subset\msis_id_list.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;


proc sql;
create table  msis_id_list2 as
select a. msis_id, a.index_date, b.censor_dt
from msis_id_list as a, Censor_comb as b
where a.msis_id = b.msis_id;
quit;





/************************************************************************************************************************************************************************
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************
************************************************************************************************************************************************************************/

/* Merge RX TX years*/
libname rxtx "C:\Users\Dave\Desktop\ALL\Medicaid RX (Andy)";


%macro rx_list_join;
%do year = 1999 %to 2012;
proc sql;
create table rx&year. as
	select a.msis_id, a.index_date, a.censor_dt, b.*
	from Msis_id_list2 as a, rxtx.rxtx&year. as b
		WHERE a.msis_id = b.msis_id;
		
quit;
%end;
%mend;

%rx_list_join;



/*DATA rx1999_2012 drop=type_clm_cd;
set Rx1999 Rx2000 Rx2001 Rx2002 Rx2003 Rx2004 Rx2005 Rx2006 Rx2007 Rx2008 Rx2009 Rx2010 Rx2011 Rx2012;
run;*/ 


proc contents data =Rx1999;
run; 
proc contents data =Rx2000;
run; 
proc contents data =Rx2001;
run; 
proc contents data =Rx2002;
run; 
proc contents data =Rx2003;
run; 
proc contents data =Rx2004;
run; 
proc contents data =Rx2005;
run; 
proc contents data =Rx2006;
run; 
proc contents data =Rx2007;
run; 
proc contents data =Rx2008;
run; 
proc contents data =Rx2009;
run; 
proc contents data =Rx2010;
run; 
proc contents data =Rx2011;
run; 
proc contents data =Rx2012;
run;

data rx2011_new; 
   set rx2011; 
   drop TYPE_CLM_CD; 
run;

data rx2012_new; 
   set rx2012; 
   drop TYPE_CLM_CD; 
run;

DATA rx1999_2012;
set Rx1999 Rx2000 Rx2001 Rx2002 Rx2003 Rx2004 Rx2005 Rx2006 Rx2007 Rx2008 Rx2009 Rx2010 Rx2011_new Rx2012_new;
run; 



/*Reformatting RX data NDC to be a numeric variable so it can be merged with category data*/
data Rx1999_2012;
set Rx1999_2012;
NDC_num=input (NDC, 12.);
/*drop NDC;
rename NDC_char=NDC;*/
run;


/*merge categories with combined RX data*/
proc sql;
create table rx1999_2012_categories as
	select a.*, b.SA, b.AM, b.AD, b.AP, b.ms, b.NDC
	from rx1999_2012 as a left join Drug_categories as b 
		on a.NDC_num = b.NDC;
/*from rx1999_2012 as a, Drug_categories as b
		WHERE a.NDC = b.NDC;*/
quit;
data rx1999_2012_categories;
set rx1999_2012_categories;
if SA = '.' then SA=0;
if AM = '.' then AM=0;
if AD = '.' then AD=0;
if AP = '.' then AP=0;
if MS = '.' then MS=0;
run;

proc freq data = Rx1999_2012_categories;
tables SA AM AD AP MS;
run;

/*ADDING CRITERIA HERE BECAUSE DID NOT IN THE PREVIOUS PROC SQL CODE*/
data Rx1999_2012_categories_2;
set Rx1999_2012_categories;
where PRSCRPTN_FILL_DT<censor_dt AND DAYS_SUPPLY>30;
RUN;




/*Macro code*/

%macro rx(drug);
proc sort data=rx1999_2012_categories_2 out=rx1999_2012_&drug; 
by msis_id PRSCRPTN_FILL_DT descending &drug;
run;
proc sort data=rx1999_2012_&drug nodupkey; 
by msis_id PRSCRPTN_FILL_DT;
run;
proc sql;
create table rx1999_2012_&drug._2 as 
select msis_id, index_date, sum(&drug.) as count_&drug.
from rx1999_2012_&drug.
group by msis_id, index_date;
quit;

data rx1999_2012_&drug._2;
set rx1999_2012_&drug._2;
count_&drug._2=0;
if count_&drug. >=2 then count_&drug._2=1;
run;
%mend;
%rx(SA);
%rx(AM);
%rx(AD);
%rx(AP);
%rx(MS);





%macro first_fill(drug);
data test_&drug.;
set Rx1999_2012_&drug.;
if &drug=1;
run;

proc sort data=test_&drug. out=test2_&drug.;
by msis_id PRSCRPTN_FILL_DT;
run;
proc sort data=test2_&drug. nodupkey;
by msis_id;
run;

proc sql;
create table test_3_Rx1999_2012_&drug. as
select a.*, b.PRSCRPTN_FILL_DT as first_fill_date_&drug.
from Rx1999_2012_&drug._2 as a left join test2_&drug. as b
on a.msis_id = b.msis_id;
quit;
%mend;
%first_fill(SA);
%first_fill(AM);
%first_fill(AD);
%first_fill(AP);
%first_fill(MS);




proc sql;
create table rx_all_with_dates as
select * 
from Msis_id_list as a
left join  Test_3_rx1999_2012_ad as b
	on a.MSIS_ID = b.MSIS_ID and a.index_date = b.index_date
left join Test_3_rx1999_2012_am as c
	on a.MSIS_ID = c.MSIS_ID and a.index_date = c.index_date
left join Test_3_rx1999_2012_ap as d
	on a.MSIS_ID = d.MSIS_ID and a.index_date = d.index_date
left join Test_3_rx1999_2012_ms as e
	on a.MSIS_ID = e.MSIS_ID and a.index_date = e.index_date
left join Test_3_rx1999_2012_sa as f
	on a.MSIS_ID = f.MSIS_ID and a.index_date = f.index_date;
quit;


data rx_all_with_dates_test;
set rx_all_with_dates;
array drug(*) count_AD count_AD_2 count_AM count_AM_2 count_AP count_AP_2 count_MS count_MS_2 count_SA count_SA_2;
do i=1 to dim(drug);
if drug(i) = '.' then drug(i)=0;
end;
drug_count=0;
if count_AD_2 =1 OR count_AM_2 =1 OR count_AP_2 =1 OR count_MS_2 =1 OR count_SA_2 =1 then drug_count=1;
drop i;
run;


data rx_all_final;
set rx_all_with_dates_test; 
drop count_AD count_AM count_AP count_MS count_SA;
/*coalesced_first_fill = COALESCE(first_fill_date_AD, first_fill_date_AM, first_fill_date_AP, first_fill_date_MS, first_fill_date_SA);
put coalesced_first_fill=;*/
run;




data rx_all_final;
set rx_all_final;
date_of_first=min(first_fill_date_AD, first_fill_date_AM, first_fill_date_AP, first_fill_date_MS, first_fill_date_SA);
format date_of_first YYMMDDN8.;
if count_AD_2=0 then first_fill_date_AD ='.';
if count_AM_2=0 then first_fill_date_AM ='.';
if count_AP_2=0 then first_fill_date_AP ='.';
if count_MS_2=0 then first_fill_date_MS ='.';
if count_SA_2=0 then first_fill_date_SA ='.';
run;
data rx_all_reduced;
set rx_all_final;
if drug_count=0 then delete;
run;



proc sort data=Rx_all_final nodupkey;
by msis_id index_date;
run;

proc sort data=Rx_all_reduced nodupkey;
by msis_id index_date;
run;



libname davedata 'P:\Andy Subset';


proc freq data= rx_all_final;
table count_AD_2 count_AM_2 count_AP_2 count_MS_2 count_SA_2 drug_count;
run;
