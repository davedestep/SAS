/*If var=0 then delete?*/

/*Patient Surveys*/
PROC IMPORT 
	datafile= '/home/dmd12d0/MyLib/Patient survey data.xlsx'
	DBMS=XLSX
	Replace
	OUT=patient;
RUN;


proc means data=patient mean std;
Title 'Patient Response: Your Info';
 Var Sex Age	Education	MaritalStatus	Beliefs	Children	PrevProc;
run;

proc means data=patient mean std;
Title 'Patient Response: Discussion with Provider';
 Var PDiscussion1	PDiscussion2	PDiscussion3	PDiscussion4	PDiscussion5	PDiscussion6	PDiscussion7	PDiscussion8	PDiscussion9	PDiscussion10;
 label PDiscussion1='I understand why I had the medical procedure' PDiscussion2='I wanted to be informed of all of the risks and benefits of my procedure.'	PDiscussion3='My doctor did most of the counseling prior to my surgery.'	PDiscussion4='I feel that I was told about the risks involved in my procedure.'	PDiscussion5='I feel I was told about the benefits of my procedure.'	PDiscussion6= 'I feel that my health care provider has a good understanding of the risks and benefits involved in my procedure.'	PDiscussion7='I feel that my health care provider always has my best interests in mind.'	PDiscussion8='I would rather have my healthcare provider discuss the details of my diagnosis with a relative than with me in a serious medical situation.'	PDiscussion9='I would rather have my healthcare provider discuss the details of my diagnosis with me in a serious medical situation.'	PDiscussion10='I prefer that my healthcare provider makes medical decisions on my behalf instead of asking me to make the decision';
run;

proc means data=patient mean std;
Title 'Patient Response: The Way You Make Decisions (4 possible answers)';
 Var Clothes	Appliances	Vacation	VisitDr	IllFamMem;
 label clothes='When you want to buy yourself new clothes you'
Appliances='When you want to buy a major appliance/accessory for your home (i.e. oven, bed, furniture, etc) you:'
Vacation='When you want to go on a family vacation you:'
VisitDr='When you are sick and need to go to the doctor you:'
IllFamMem='When a member of your family is very ill and needs to go to the doctor you:';
run;



/*Provider Surveys*/
PROC IMPORT 
	datafile= '/home/dmd12d0/MyLib/Patient survey data.xlsx'
	DBMS=XLSX
	Replace
	OUT=provider;
	sheet='provider';
RUN;

data provider2;
   set provider;
   format Q6 Q6.;
   Qsix = input(Q6,Q6.);
   format Q8 Q8.;
   Qeight = input(Q8,Q8.);
run;

proc means data=provider2 mean std;
Title 'Provider Response: Your Info';
 Var Q1	Q2	Q3	Q4	Q5	Qsix	Q7	Qeight	Q9;
 label Q1='1. Are you MALE OR FEMALE:'
Q2='2. How old are you?'
Q3='3. What is your marital status?'
Q4='4. How would you classify your religious beliefs?'
Q5='5. Are you a physician?'
QSIX='6. Please indicate which of the following healthcare providers you are.'
Q7='7. How many years ago did you finish your medical training? '
QEIGHT='8. In what department or specialty to do you work?'
Q9='9. How many years have you been practicing in this area of medicine?'
run;


proc means data=provider mean std;
Title 'Provider Response ';
 Var P2Q1	P2Q2	P2Q3	P2Q4 P3Q1	P3Q2	P3Q3	P3Q4	P3Q5	P3Q6	P3Q7	P3Q8	P3Q9	P3Q10	P3Q11	P3Q12	P3Q13;
 label P2Q1='Do you talk to patients about medical procedures?'	P2Q2='On average, how much time do you spend talking to a patient about the risks/benefits of a procedure?'	P2Q3='In general, how many questions does a patient/the patient’s family ask about the risks and benefits of a medical procedure?'	P2Q4='When was the last time you got consent from a patient for a medical procedure?' P3Q1='It is important to discuss the risks/benefits with the patient prior to a procedure.'	P3Q2='I enjoy talking to the patient or family members about the risks and benefits of a medical procedure.'	P3Q3='I am good at talking to and counseling the patient and/or family members about the risks and benefits of a medical procedure.'	P3Q4='I think it is the responsibility of the doctor to discuss with the patient and/or family members about the risks and benefits of a medical procedure.'	P3Q5='It is a good use of my time to discuss the details of a procedure with the patient.'	P3Q6='I have had a class or training on how to talk to the patient about the risks/benefits of a medical procedure.'	P3Q7='I would like to have a class or training on how to talk to patients about the risks/benefits of a medical procedure.'	P3Q8='My patients are satisfied with their understanding of the risks and benefits of their procedure.'	P3Q9='My patients are generally well informed about their health and their medical procedures.'	P3Q10='I feel the need to discuss the details with a relative as well as the patient themselves.'	P3Q11='If the patient does not want to have a medical procedure that I recommend, I will try to convince their friends or family members to change the patient/s mind.'	P3Q12='The details of a procedure are always given to the patient and his/her family in written format.'	P3Q13=' I think my patients will like getting more information about their procedure to read at home.';
run;











proc freq data=patient;
Title 'Patient Response: Your Info';
 Var Sex Age	Education	MaritalStatus	Beliefs	Children	PrevProc;
run;

proc freq data=patient;
Title 'Patient Response: Discussion with Provider';
 Var PDiscussion1	PDiscussion2	PDiscussion3	PDiscussion4	PDiscussion5	PDiscussion6	PDiscussion7	PDiscussion8	PDiscussion9	PDiscussion10;
 label PDiscussion1='I understand why I had the medical procedure' PDiscussion2='I wanted to be informed of all of the risks and benefits of my procedure.'	PDiscussion3='My doctor did most of the counseling prior to my surgery.'	PDiscussion4='I feel that I was told about the risks involved in my procedure.'	PDiscussion5='I feel I was told about the benefits of my procedure.'	PDiscussion6= 'I feel that my health care provider has a good understanding of the risks and benefits involved in my procedure.'	PDiscussion7='I feel that my health care provider always has my best interests in mind.'	PDiscussion8='I would rather have my healthcare provider discuss the details of my diagnosis with a relative than with me in a serious medical situation.'	PDiscussion9='I would rather have my healthcare provider discuss the details of my diagnosis with me in a serious medical situation.'	PDiscussion10='I prefer that my healthcare provider makes medical decisions on my behalf instead of asking me to make the decision';
run;

proc freq data=patient;
Title 'Patient Response: The Way You Make Decisions (4 possible answers)';
 Var Clothes	Appliances	Vacation	VisitDr	IllFamMem;
 label clothes='When you want to buy yourself new clothes you'
Appliances='When you want to buy a major appliance/accessory for your home (i.e. oven, bed, furniture, etc) you:'
Vacation='When you want to go on a family vacation you:'
VisitDr='When you are sick and need to go to the doctor you:'
IllFamMem='When a member of your family is very ill and needs to go to the doctor you:';
run;

run;





PROC IMPORT 
	datafile= '/home/dmd12d0/MyLib/Patient survey data.xlsx'
	DBMS=XLSX
	Replace
	OUT=providervspatient;
	sheet='sheet1';
RUN;



proc NPAR1WAY data=soil wilcoxon;
	title "Nonparametric test to provider responses vs patient responses";
	class providerorpatient;
	var ;
	exact wilcoxon;
   run;
