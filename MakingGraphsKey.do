
clear all
set more off

cd "/Users/eileenpowell/Desktop/RMDA2/TA/RD Practice "

use "prekTulsa.dta", clear

bro 

//Let's learn how to create graphs for RD in STATA 

***********************************************************************************
* 								Part 1: Scatterplot 
***********************************************************************************


//the first way to create graphs in STATA is via twoway scatter plots 
//twoway is a family of plots, all of which fit on numeric y and x scales

	//Here is the basic code: twoway (scatter y-variable x-variable, sort) 
	//the sort option orders our x-values before we graph them - this is especially important when we start adding lines 

//lets create the simple twoway graph with the pre-k data - don't forget that our outcome varibale is test scores 

help twoway scatter //don't underestimate the help command!
twoway (scatter wjtest01 age)
twoway (scatter wjtest01 age, sort)


***********************************************************************************
* 				Part 1 Extra: Understanding Underlying Data of Scatterplot 
***********************************************************************************

/*You didn't have to do this, it's intended to underscore that our scatterplot is 
showing our raw data. If we change our raw data (for example, if it is by state 
instead of individiual), then our scatterplot will change
*/
/*collapse to aggregate data - the mean of our of all variables of interest by STATE
	instead of individual*/
collapse age cutoff wjtest01 female black white hispanic freelunch, by(birth_state)

//If we have our data by state instead of student now, what does our graph look like?
twoway (scatter wjtest01 age, sort)

use "prekTulsa.dta", clear //revert back to old data
twoway (scatter wjtest01 age, sort)


***********************************************************************************
* 						Part 2: Scatterplot with fitted lines
***********************************************************************************
//we want to add fitted lines to our graph: we will use the command lfit
	//with twoway, you can graph multiple types of graphs (including lfit) on top of each other
	//you will put each "graph" command in its own parentheses 
	
	
	//we want to do this for the portion of data above and below the cutoff 
		//how do you restrict the range of values a command applies to?
		//what would you add to (lfit wjtest age)

twoway (scatter wjtest01 age, sort)(lfit wjtest01 age if age <0)(lfit wjtest01 age if age >0) 

//you can use "///" at the end of each line to break lines between one command, 
	///just highlight&run them all together and make sure to put a space before them

twoway (scatter wjtest01 age, sort) ///
	(lfit wjtest01 age if age <0) ///
	(lfit wjtest01 age if age >0) 


//There are a TON of options for formatting two way graphs - use the help command!!!!

	//What if I want to change the colors, patterns, or title of my graph?
twoway (scatter wjtest01 age, sort mcolor(ltblue)) ///
(lfit wjtest01 age if age <0, lcolor(dkorange)) ///
(lfit wjtest01 age if age >0, lcolor(magenta) lpattern(dash)), ///
title("Having Fun with Colors & RDs! :)")


//let us clean up the graph a little bit now. We want to restrict our graph so we only display individuals born 30 days before and after the cutoff. 

//Do this by adding an if statement at the very end limiting our graph to ages under 30 days and over 30 days from the cutoff 
	//why do we add this at the very end of our command?

twoway (scatter wjtest01 age, sort) (lfit wjtest01 age if age <0) (lfit wjtest01 age if age >0) if age<30 & age>-30

//Finally, lets format. Let's add color-blind friendly colors (plotplainblind), turn off the legend, add a title 

twoway (scatter wjtest01 age, sort) (lfit wjtest01 age if age <0) (lfit wjtest01 age if age >0) if age<30 & age>-30, scheme(plotplainblind) legend(off) title(Pre-K on Test Scores)

//scheme allows you to use a variety of themes/backgrounds - plotplainblind is easy and color-blind friendly
twoway (scatter wjtest01 age, sort) (lfit wjtest01 age if age <0) (lfit wjtest01 age if age >0) if age<30 & age>-30, scheme(economist) legend(off) title(Pre-K on Test Scores)

twoway (scatter wjtest01 age, sort) (lfit wjtest01 age if age <0) (lfit wjtest01 age if age >0) if age<30 & age>-30, scheme(s1mono) legend(off) title(Pre-K on Test Scores)

//You made a graph!! 

***********************************************************************************
* 						Part 3: Binscatter
***********************************************************************************
//The second way to create graphs is with binscatter 
//First install binscatter 
ssc install binscatter

//Now lets make a graph
	//here is the basic code: binscatter y-variable x-variable, by(cutoff) 

	binscatter wjtest01 age, by(cutoff) 
	
//don't forget your options! we can add titles and tables
binscatter wjtest01 age, by(cutoff) ytitle("Woodcock-Johnson letter-word identification test score") xtitle("Days from birthday cutoff") scheme(plotplainblind)

//Yay!! You made another graph!! 
