ods html close;
ods html;

proc format;
	value $race
		1='Caucasian (European descent)'
		2='Aboriginal'
		3='Polynesian'
		4='Vietnamese'
		5='Chinese'
		6='Indian'
		7='Other';
	value $income
		1='Less than $7,000'
		2='$7,000 - $11,999'
		3='$12,000 - $23,999'
		4='$24,000 - $35,000'
		5='$36,000 or more'
		9='Unknown';
	value $F_home
		H=With mother
		O=Somewhere else;
	value $M_SCHLVL
		0='None'
		1='Trade certificate or apprenticeship'
		2='Professional registration (non-degree)'
		3='College diploma or degree'
		4='University degree'
		5='Other';
	value $Smoke
		0=No
		1='1-5 daily'
		2='6-10 daily'
		3='11-15 daily'
		4='16-20 daily'
		5='21 or more per day';
	value $Alcohol
		1='Daily'
		2='Several times a week'
		3='Approximately once a week'
		4='Less than once a week'
		5='Never';
	picture pctfmt(round)low-high= ' 009.9)' (prefix='(');
run;



DATA work;
SET work;
M_WT1_ABOVE64 =0;
IF M_WT1>64.7963997 THEN M_WT1_ABOVE64 =1;

M_WT2_ABOVE73 =0;
IF M_WT2>73.6387122 THEN M_WT2_ABOVE73 =1;
RUN;
 


proc freq data=work /*order=formatted*/;
tables (ABORTNO ADMDAY1 ADMDAY2 ADMNO1 ADMNO2 AMNIO APH DEL_PREM DIAB_TR DIABETES
ELECT_CS EPID EPILEPSY EPILMED ESS_HT ESSPET GEN_LAB 
M_ADM M_ANAEM M_CARD M_HAEMOL M_HB1 M_HBDIAG M_UTI /*M_WT1 M_WT2*/ M_WT1_ABOVE64 M_WT2_ABOVE73
NARC_IM NARC_IV PET PREM THYRMED THYROID TIME_GA TIME_IM TIME_IV TIME_OTH
F_SCHAGE F_SCHLEV CHROM CHROM_R CORD
DEL_MODE FETUS FHR FHR_CM FHR_DEL NE_CS COLDFLU CONVULS 
MEDIC1 MH_ASTH MH_DX MH_EPI MH_HD MH_HEP MH_PIDX MH_PSYC MH_RHEM MH_THYR
AP_BRADY APGAR1 APGAR10 APGAR5
IUGR_R IVH_SEV N_CERHGE N_CEROED N_IUGR N_IVH N_weight1 
SCN_ICU SCN_ICU2 SCN_INT SCN_INT1 SCN_INT2  SEIZ_DUR SEIZ_TYP SEIZURES SEX 
DRUSE U_ALCOH1 U_ANAET U_DRUG U_SMKAVE)*GA_IV_None
/ missing nocum nopercent NOROW;
run;
/*
Smoking?
ADMDAY1 ADMNO1 M_ADM SCN_INT U_ANAET U_SMKAVE?
Weak: MEDIC1
LAB_DUR M_DIC M_HB2 MH_PIHX SEIZ_AGE SELFFEED SEP_SCR NOT IN DATA*/

PROC CONTENTS DATA=work;
RUN;



PROC FREQ DATA=work;
TABLES (ADMDAY1 ADMNO1 M_ADM SCN_INT U_ANAET U_SMKAVE)*GA_IV_None/ missing nocum nopercent NOROW;
RUN;



proc sort data=work;
*by period;
by state;
run;

options orientation=portrait;

ods html close;
ods html;


proc template;
  define style styles.demotables;
	parent=styles.minimal;
	style bodyDate from bodyDate /
		font=('Times',8pt);
	style PagesDate from PagesDate /
		font=('Times',8pt);
	style PagesTitle from PagesTitle /
		font=('Times',8pt);
	style SystemTitle from SystemTitle /
		font=('Times',12pt);
	style Data from Data /
		font=('Times, Times, Times',8pt);
	style Header from HeadersAndFooters /
		font=('Times, Times, Times',8pt);
	style RowHeader from HeadersAndFooters /
		font=('Times, Times, Times',8pt);
end;
run;


data work;
set work;
*set temp;
*set temp4;
*set &st.allpair_useccs1_&surg._&sex;
label expose = 'Exposure';
label state = 'State';
label el_sex_cd ='Gender';
label race = 'Race';
label income1='Income';
label ip_num1= 'Inpatient';
label ot_num1= 'Outpatient';
label preterm='Preterm';
label lbw1='Low birth weight';
label lbw2='Very low birth weight';
label lbw3='Extremely low birth weight';
label C_Chrom="Chromosomal Anomalies"	;
label C_CIRC="Congenital Anomalies of the Heart and Circulatory System"	;
label C_CNS="Congenital Anomalies of the Central Nervous System"	;
label C_EYENT="Congenital Anomalies of the Eye"	;
label C_GENT="Congenital Anomalies of the Genital Organs"	;
label C_GI="Congenital Anomalies of the Digestive System"	;
label C_MUSC="Congenital Musculoskeletal Deformities"	;
label C_OTHER="Other Congenital Anomalies"	;
label C_RESP="Congenital Anomalies of the Respiratory System"	;
label C_SKIN="Congenital Anomalies of the Skin"	;
label C_URI="Congenital Anomalies of the Urinary System"	;
label P_HYPOX="Intrauterine Hypoxia"	;
label P_NOX="Intrauterine Exposure to Noxious Agent"	;
label P_PLAC="Intrauterine Placental Insufficiency"	;
label CCI1="Infectious and parastic disease (Acute)"	;
label CCI2="Neoplasms (Acute)"	;
label CCI3="Endocrine, metabolic, and immunity disorders (Acute)"	;
label CCI4="Diseases of blood and blood-forming organs (Acute)"	;
label CCI5="Mental disorders (Acute)"	;
label CCI6="Diseases of the nervous system and sense organs (Acute)"	;
label CCI7="Diseases of the circulatory system (Acute)"	;
label CCI8="Diseases of the respiratory system (Acute)"	;
label CCI9="Diseases of the digestive system (Acute)"	;
label CCI10="Diseases of the genitourinary system (Acute)"	;
label CCI11="Complications of pregnancy, childbirth and the puerperium (Acute)"	;
label CCI12="Diseases of the skin and subcutaneous tissue (Acute)"	;
label CCI13="Diseases of the musculoskeletal system (Acute)"	;
label CCI14="Congenital anomalies"	;
label CCI15="Certain conditions originating in the perinatal period (Acute)"	;
label CCI16="Symptoms, signs, and ill-defined conditions (Acute)"	;
label CCI17="Injury and poisoning (Acute)"	;
label CCI18="Factors influening health status and contact with health services (Acute)"	;
label CCI19="Infectious Disease (Chronic)"	;
label CCI20="Neoplasm (Chronic)"	;
label CCI21="Endocrine, metabolic, and immunity disorders (Chronic)"	;
label CCI22="Diseases of blood and blood-forming organs (Chronic)"	;
label CCI23="Mental disorder (Chronic)"	;
label CCI24="Diseases of the nervous system and sense organs (Chronic)"	;
label CCI25="Diseases of the circulatory system (Chronic)"	;
label CCI26="Diseases of the respiratory system (Chronic)"	;
label CCI27="Diseases of the digestive system (Chronic)"	;
label CCI28="Diseases of the genitourinary system (Chronic)"	;
label CCI29="Complications of pregnancy, childbirth, and the puerperium"	;
label CCI30="Diseases of the skin and subcutaneous tissue (Chronic)"	;
label CCI31="Diseases of the musculoskeletal system (Chronic)"	;
label CCI32="Congenital anomalies (Chronic)"	;
label CCI33="Certain conditions originating in the perinatal period (Chronic)"	;
label CCI34="Symptoms, signs, and ill-defined conditions (Chronic)"	;
label CCI35="Injury and poisoning (Chronic)"	;
label CCI36="Factors influening health status and contact with health services (Chronic)"	;
label Disability_n="Disability"	;

/*if disability = "Non-disability" then disability = 0;
if disability = "Disability" then disability = 1;
disability_n = input(disability,24.);*/

*creating variable to use in proc tabulate to represent all subjects;
overall=1;

run;




ods rtf style=demotables file= "C:\Users\Dave\Documents\Results and Output\Raines\Demographic Characteristics3 Multilevel.rtf";
title2;
proc tabulate data=work missing /*order=formatted*/;
class GA_IV_None 
sex M_RACE m_race1 M_schlvl1 income1 N_weight1 CS_cat epid prem rsurg123
/*M_RACE
M_RACE1
INCOME
F_HOME
M_SCHLVL
U_SMKAVE
M_SMKAVE
M_SMKNOW
NOW_ALCT*/
overall;
/*classlev 
M_RACE
M_RACE1
INCOME
F_HOME
M_SCHLVL
U_SMKAVE
M_SMKAVE
M_SMKNOW
NOW_ALCT / style=[cellwidth=3in asis=on];*/
tables sex M_RACE m_race1 M_schlvl1 income1 N_weight1 CS_cat epid prem rsurg123
/*M_RACE
M_RACE1
INCOME
F_HOME
M_SCHLVL
U_SMKAVE
M_SMKAVE
M_SMKNOW
NOW_ALCT*/
overall, GA_IV_None=''*(n*f=7.0 colpctn='(%)'*f=pctfmt.)
overall=''*(n*f=7.0 colpctn='(%)'*f=pctfmt.);/*
expose='Exposure'*(n*f=7.0 colpctn='(%)'*f=pctfmt.)/misstext='0' rts=15;*/
/*overall=''*(n*f=7.0 colpctn='(%)'*f=pctfmt.)*/
/*GA_IV_None='GA_IV_None'*(n*f=7.0 colpctn='(%)'*f=pctfmt.)/misstext='0' rts=15;*/
/*by GA_IV_None;*/
format  m_race $race. income1 $income. F_HOME $F_HOME. M_SCHLVL1 $M_SCHLVL. U_SMKAVE M_SMKAVE M_SMKNOW $Smoke. NOW_ALCT $Alcohol.;
run;
ods listing close;
ods rtf close;









ods rtf style=demotables file= "C:\Users\Dave\Documents\Results and Output\Raines\Additional Characteristics.rtf";
title1 "Demographics tables for TX for all variables and periods";
title2;
proc tabulate data=work missing /*order=formatted*/;
class GA_IV_None 
ABORTNO ADMDAY1 ADMDAY2 ADMNO1 ADMNO2 AMNIO APH DEL_PREM DIAB_TR DIABETES
ELECT_CS EPID EPILEPSY EPILMED ESS_HT ESSPET GEN_LAB 
M_ADM M_ANAEM M_CARD M_HAEMOL M_HB1 M_HBDIAG M_UTI /*M_WT1 M_WT2*/ M_WT1_ABOVE64 M_WT2_ABOVE73
NARC_IM NARC_IV PET PREM THYRMED THYROID TIME_GA TIME_IM TIME_IV TIME_OTH
F_SCHAGE F_SCHLEV CHROM CHROM_R CORD
DEL_MODE FETUS FHR FHR_CM FHR_DEL NE_CS COLDFLU CONVULS 
MEDIC1 MH_ASTH MH_DX MH_EPI MH_HD MH_HEP MH_PIDX MH_PSYC MH_RHEM MH_THYR
AP_BRADY APGAR1 APGAR10 APGAR5
IUGR_R IVH_SEV N_CERHGE N_CEROED N_IUGR N_IVH N_weight1 
SCN_ICU SCN_ICU2 SCN_INT SCN_INT1 SCN_INT2  SEIZ_DUR SEIZ_TYP SEIZURES SEX 
DRUSE U_ALCOH1 U_ANAET U_DRUG U_SMKAVE
overall;
tables ABORTNO ADMDAY1 ADMDAY2 ADMNO1 ADMNO2 AMNIO APH DEL_PREM DIAB_TR DIABETES
ELECT_CS EPID EPILEPSY EPILMED ESS_HT ESSPET GEN_LAB 
M_ADM M_ANAEM M_CARD M_HAEMOL M_HB1 M_HBDIAG M_UTI /*M_WT1 M_WT2*/ M_WT1_ABOVE64 M_WT2_ABOVE73
NARC_IM NARC_IV PET PREM THYRMED THYROID TIME_GA TIME_IM TIME_IV TIME_OTH
F_SCHAGE F_SCHLEV CHROM CHROM_R CORD
DEL_MODE FETUS FHR FHR_CM FHR_DEL NE_CS COLDFLU CONVULS 
MEDIC1 MH_ASTH MH_DX MH_EPI MH_HD MH_HEP MH_PIDX MH_PSYC MH_RHEM MH_THYR
AP_BRADY APGAR1 APGAR10 APGAR5
IUGR_R IVH_SEV N_CERHGE N_CEROED N_IUGR N_IVH N_weight1 
SCN_ICU SCN_ICU2 SCN_INT SCN_INT1 SCN_INT2  SEIZ_DUR SEIZ_TYP SEIZURES SEX 
DRUSE U_ALCOH1 U_ANAET U_DRUG U_SMKAVE
overall, GA_IV_None=''*(n*f=7.0 colpctn='(%)'*f=pctfmt.)
overall=''*(n*f=7.0 colpctn='(%)'*f=pctfmt.);/*
expose='Exposure'*(n*f=7.0 colpctn='(%)'*f=pctfmt.)/misstext='0' rts=15;*/
/*overall=''*(n*f=7.0 colpctn='(%)'*f=pctfmt.)*/
/*GA_IV_None='GA_IV_None'*(n*f=7.0 colpctn='(%)'*f=pctfmt.)/misstext='0' rts=15;*/
/*by GA_IV_None;*/
format  M_RACE $race. INCOME $income. F_HOME $F_HOME. M_SCHLVL $M_SCHLVL. U_SMKAVE M_SMKAVE M_SMKNOW $Smoke. NOW_ALCT $Alcohol.;
run;
ods listing close;
ods rtf close;






/**************************************************************************
**************************************************************************
**************************************************************************
**************************************************************************
**************************************************************************
**************************************************************************
**************************************************************************/
/*Binary Exposure*/
ods rtf style=demotables file= "C:\Users\Dave\Documents\Results and Output\Raines\Demographic Characteristics.rtf";
title1 "Demographics tables for Prenatal General Anesthesia";
title2;
proc freq data=test /*order=formatted*/;
tables (sex M_RACE M_RACE1 INCOME F_HOME M_SCHLVL U_SMKAVE M_SMKAVE M_SMKNOW NOW_ALCT)*GA_IV_None
/ missing nocum nopercent NOROW;
format M_RACE $race. INCOME $income. F_HOME $F_HOME. M_SCHLVL $M_SCHLVL. U_SMKAVE M_SMKAVE M_SMKNOW $Smoke. NOW_ALCT $Alcohol.;
run;
ods listing close;
ods rtf close;



/*Stratified Exposure*/
ods rtf style=demotables file= "C:\Users\Dave\Documents\Results and Output\Raines\Demographic Characteristics.rtf";
title1 "Demographics tables for Prenatal General Anesthesia";
title2;
proc freq data=work /*order=formatted*/;
tables (sex M_RACE M_RACE1 INCOME F_HOME M_SCHLVL U_SMKAVE M_SMKAVE M_SMKNOW NOW_ALCT)*GA_IV_None
/ missing nocum nopercent NOROW;
format M_RACE $race. INCOME $income. F_HOME $F_HOME. M_SCHLVL $M_SCHLVL. U_SMKAVE M_SMKAVE M_SMKNOW $Smoke. NOW_ALCT $Alcohol.;
run;
ods listing close;
ods rtf close;
