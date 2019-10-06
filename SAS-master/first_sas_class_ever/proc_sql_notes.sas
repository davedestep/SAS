/*Access already existing SAS data sets*/
libname mydata '/courses/d2d774e5ba27fe300/TaskData' access=readonly;
/*Puts data sets from mydata library to the work library*/
Data mtgoats;
	set mydata.mtgoats;
Run;
Data songs2002;
	set mydata.songs2002;
Run;

proc print data=mtgoats;
run;

proc print data=songs2002;
run;

proc sql;
	create table mg2002i as   /*New SAS data set, mg2002 created*/
		select * from mtgoats  /*SELECT * takes all columns from the data set*/
        inner join songs2002   /*Merge (join) only rows common to both tables*/
        on mtgoats.albumID = songs2002.albumID; /*Common ID is AlbumID*/
Run; 

proc print data = mg2002i;
run;

proc sql;
	create table mg2002i as
		select * from mtgoats
        inner join songs2002
        on mtgoats.albumID = songs2002.albumID 
        order by albumID; /*Add Order by to sort the output data*/
Run;

proc print data = mg2002i;
run;
/*Full Outer Join*/
proc sql;
	create table mg2002 as
		select * from mtgoats
        full join songs2002
        on mtgoats.albumID = songs2002.albumID; 
Run;
proc print data = mg2002;
run;
/*Reverse tables in the full join*/
proc sql;
	create table mg2002 as
		select * from songs2002
        full join mtgoats
        on mtgoats.albumID = songs2002.albumID; 
Run;
proc print data = mg2002;
run;

/*Left Join*/
proc sql;
	create table mg2002 as
		select * from mtgoats
        left join songs2002
        on mtgoats.albumID = songs2002.albumID; 
Run;
proc print data = mg2002;
run;

/*Right Join */
proc sql;
	create table mg2002 as
		select * from mtgoats 
        right join  songs2002
        on mtgoats.albumID = songs2002.albumID; 
Run;
proc print data = mg2002;
run;





/*summarizing*/
libname mydata '/courses/d2d774e5ba27fe300/TaskData' access=readonly;
/*Exercise: Copy Coaster50 from MyData to the work library*/
Data work.coaster50;
	set mydata.coaster50;
Run;

proc print data=coaster50;
run;

/*Pull only two variables out of the data set*/
/*Replace one of the variables by its average*/
/*Split the average by Type*/
proc sql;
	create table CoasterAvg as
		select  Type, AVG(Speed) as Average_Speed from coaster50
        Group by Type; 
Run;
proc print data = CoasterAvg;
run;

/*Using two categorical variables on which to order and group*/
proc sql;
	create table CoasterAvg2 as
		select  Type, Design, AVG(Speed) as Average_Speed from coaster50
        Group by Type, Design 
		Order by Type, Design;
Run;
proc print data = CoasterAvg2;
run;
