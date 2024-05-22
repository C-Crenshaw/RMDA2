*********************************************************************************		
/*	TITLE: 		MakingGraphsDiscussionPractice.do								
*	PURPOSE:	Code written for March 20 discussion section. 				
*	AUTHOR:		Carson Crenshaw												
*	DUE:	    03/20/2024																				
*/
*********************************************************************************

*********
*	New Dataset
*********

glob classpath "/Users/carsoncrenshaw/Library/CloudStorage/OneDrive-UniversityofVirginia/RMDA II/"
	cd "${classpath}" 
	
use "${classpath}prekTulsa.dta", clear

bro
codebook, compact

/*
Key variables 

age - days from the birthday cutoff. The cutoff value is coded as 0; negative values indicate 
days born after the cutoff; positive values indicate days born before the cutoff 

cutoff - treatment indicator (1 = born before cutoff, 0 = born after cutoff)

wjtest01 - woodcock-johnson letter-word identification test score

female - female(1 = yes, 0 = no)

black - black(1 = yes, 0 = no)

white - white(1 = yes, 0 = no)

hispanic - hispanic(1 = yes, 0 = no)

freelunch - eligible for free lunch based on low income in 2006-07 (1 = yes, 0 = no)

*/

//Let's learn how to do graphs in Stata for RDs!

***********************************************************************************
* 								Part 1: Scatterplot 
***********************************************************************************
//the first way to create graphs in STATA is via twoway scatter plots 
	//twoway is a family of plots, all of which fit on numeric y and x scales
	
//We want to start by creating a scatterplot of our running variable and outcome variable. Start by manually clicking Stata's buttons and options above and see if you can create one. What code does it generate?

*Click on graphics in the options panel, create a scatterplot (Twoway graph)

//Retype your twoway scatterplot code below, this time adding the option ",sort" at the end. The sort option orders our x-values before we graph them - this is especially important when we start adding lines 
twoway (scatter wjtest01 age, sort)


//EXTRA: Collapse on state and create a scatterplot by averages across states (43 observations)
collapse age cutoff wjtest01 female black white hispanic freelunch, by(birth_state)
twoway (scatter wjtest01 age, sort)

//Return data back to normal
use "${classpath}prekTulsa.dta", clear

***********************************************************************************
* 						Part 2: Scatterplot with fitted lines
***********************************************************************************
//with the Twoway command, you can graph multiple types of graphs  on top of each other
	//you will put each "graph" command in its own parentheses 
	
//We want to add fitted lines to our graph. we will use the command "lfit"
	//We want to do this for the portion of data above and below the cutoff 
	//How do you restrict the range of values a command applies to? What would you add to (lfit wjtest age)?

twoway(scatter wjtest01 age, sort)(lfit wjtest01 age if age<0)(lfit wjtest01 age if age>0)

twoway(scatter wjtest01 age, sort mcolor(ltblue) msize(tiny)) ///
(lfit wjtest01 age if age<0, lcolor(dkorange)) ///
(lfit wjtest01 age if age>0, lcolor(magenta) lpattern(dash)), ///
title("Having Fun with Colors and RDs!")
	
//Let's clean up the graph a little bit now. We want to restrict our graph so we only display individuals born 30 days (about 1 month) before and after the cutoff. 
//Do this by adding an if statement at the very end of your code that limits our graph to ages under 30 days and over 30 days from the cutoff 
	//Why do we add this at the very end of our command?
	
twoway(scatter wjtest01 age, sort)(lfit wjtest01 age if age<0)(lfit wjtest01 age if age>0) if age<30 & age>-30

//Using schemes
twoway(scatter wjtest01 age, sort)(lfit wjtest01 age if age<0)(lfit wjtest01 age if age>0) if age<30 & age>-30, scheme(s1mono) legend(off) title(Pre-K on Test Scores)

	
***********************************************************************************
* 						Part 3: Binscatter
***********************************************************************************
//The second way to create graphs is with binscatter 
//First install binscatter 
ssc install binscatter

//Here is the basic code: binscatter y-variable x-variable, by(cutoff). Write in the command below:

binscatter wjtest01 age, by(cutoff)

//Don't forget your options! we can add titles and tables

