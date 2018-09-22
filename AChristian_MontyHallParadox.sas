* Code by Andrew Christian, stored here for reference purposes (see README).;
* Source: https://blogs.sas.com/content/sgf/2016/10/12/the-monty-hall-paradox-sas-vs-python/ ;

data choices (drop=max);
do i = 1 to 10000;
	u=ranuni(1);
	u2=ranuni(2);
	max=3;
	prize = ceil(max*u);
	choice = ceil(max*u2);
	output;
end;
run;

data results;
set choices;
by i;
 
if prize in (1,2) and choice in (1,2) then reveal=3;
else if prize in (1,3) and choice in (1,3) then reveal=2;
else if prize in (2,3) and choice in (2,3) then reveal=1;

if reveal in (1,3) and choice in (1,3) then do;
        switch = 2; neverswitch = choice; 
end;
else if reveal in (2,3) and choice in (2,3) then do;
	switch = 1; neverswitch = choice; 
end;
else if reveal in (1,2) and choice in (1,2) then do;
	switch = 3; neverswitch = choice; 
end;
	switchwin = (switch=prize);
	neverswitchwin = (neverswitch=prize);
run;

data cumstats;
set results;
format cumswitch cumnever comma8.;
format pctswitch pctnever percent8.2;
retain cumswitch cumnever;
if _N_ = 1 then do;
	cumswitch = 0; cumnever = 0;
end;
else do;
cumswitch = cumswitch+switchwin;
cumnever = cumnever+neverswitchwin;
end;
 
pctswitch = cumswitch/i;
pctnever = cumnever/i;
run;
 
proc means data=results n mean std;
var switchwin neverswitchwin;
run;
legend1
frame	;
symbol1 interpol=splines;
pattern1 value=ms;
axis1
	style=1
	width=1
	minor=none ;
axis2
	style=1
	width=1
	major=none
	minor=none ;
axis3
	style=1
	width=1
	minor=none ;
title;
title1 " Cumulative chances of winning on Let's Make a Deal ";
 
proc gplot data=work.cumstats;
	plot pctnever * i  /
	areas=1
frame	vaxis=axis1
	haxis=axis2
	lvref=1
	cvref=black
	vzero
	legend=legend1;
plot2 pctswitch * i  = 2 /
  	areas=1
	vaxis=axis3
	vzero
overlay 
 	legend=legend1 ;
run; quit; 
