Proc freq;
	tables exposure*disease/chisq measures;
run;
/*
Some optional arguments:
weight count: used when data is in compressed form
order=data: controls the orientation of the table
nopct, norow, nocol: omits each percentage from the output
cmh: used when you have confounders (sets of ORs)
exact or: used for small counts
*/



data tmd_gender;
	input gender $ tmd $ count;
	datalines;
	f yes 155
	f no 925
	m yes 30
	m no 708data tmd_gender;
	input gender $ tmd $ count;
	datalines;
	f yes 155
	f no 925
	m yes 30
	m no 708
;
proc freq order=data;
	weight count;
	tables gender*tmd/chisq measures;
run;

;
proc freq order=data;
	weight count;
	tables gender*tmd/chisq measures;
run;
