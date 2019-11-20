
%macro refine(procedure, procedurequote, dataset);
data &dataset.;
set &dataset.;
&procedure.=0;
if find(single2_label,&procedurequote.,'i') ge 1 then &procedure.=1;
run;

proc sql;
create table other as 
select id, max(&procedure.) as max&procedure., min(&procedure.) as min&procedure.
FROM &dataset.
GROUP BY ID;
quit;



proc sql;
create table &dataset. as
select a.*, b.max&procedure., b.min&procedure.
FROM &dataset. as a
LEFT JOIN other as b
ON a.ID=b.ID;
quit;

data &dataset.;
set &dataset.;
if max&procedure.=1 and min&procedure.=0 AND &procedure.=1 then delete;
run;


proc sort
     data = &dataset.
          out = duplicates
          uniqueout = singles
          nouniquekey;
     by id;
run;


data singles;
set singles;
keep ID internalcaseid classification6 classification7 multilevel2 multilevel2_label;
run;

data classify_9205_test;
set classify_9205 singles;
run;

data &dataset.;
set duplicates;
run;

%mend;

%refine(nonor, "Other non-OR", macrotest)
