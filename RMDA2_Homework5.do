*********************************************************************************		
/*	TITLE: 		RMDA2_Homework5.do								
*	PURPOSE:	Code written for the completion of RMDA Homework 5. 				
*	AUTHOR:		Carson Crenshaw												
*	DUE:	    04/15/2024																				
*/
*********************************************************************************

*********
*	Creating and Storing the New Dataset
*********
glob classpath "/Users/carsoncrenshaw/Library/CloudStorage/OneDrive-UniversityofVirginia/RMDA II/HW5/"
	cd "${classpath}" 
	
use "${classpath}hw5.dta", clear

*browse

*what type of panel is this? what could be my two dimensions?
*panel dataset of individuals (teachers) across academic years 
*could also be grouped by course

*variable definitions:
*apct indicates the percentage of As in the class. 
*eval indicates the average teaching evaluation score the instructor got for that particular class. one (1) indicates the lowest score (not great evals), and 5 indicates the highest score (great evals). 
*year variable indicates the academic year instead of the calendar year.
*race variable indicates the instructor's race. we only know that the value of 0 indicates "white." 

*********
*	Understanding the Panel
*********

*1a. Who gets higher evaluations, male or female instructors?
*Manual calculations:
*collapse eval, by(female)
*female	eval
*0	4.59864
*1	4.48507
*Difference: 0.11357
*Percent Change: 2.47%
*In terms of the percentage change/difference for the treatment group, female instructors get lower evaluations (significant) than male instructors.
eststo clear
eststo: reg eval female, robust
esttab, p noobs
*add noconstant

*1b. Who gets higher evaluations, white or non-white instructors?
*Manual calculations:
*collapse eval, by(race)
*race	eval
*0	4.55514
*1	4.52597
*2	4.54769
*separate out by white vs. non-white
recode race(2=1)
*race	eval
*0	4.55514
*1	4.53645
*Difference: 0.01869
*Percent Change: 0.41%
*Non-white instructors get lower evaluations (not significant) than white instructors. 
eststo clear
eststo: reg eval race, robust
esttab, p noobs

*1c. Which classes get higher evaluations, in the spring or fall semester?
*Manual calculations:
*collapse eval, by(spring)
*spring	eval
*0	4.54757
*1	4.53649
*Difference: 0.01108
*Percent Change: 0.24%
*Spring classes get lower evaluations (not significant) than fall classes. 
eststo clear
eststo: reg eval spring, robust
esttab, p noobs

*1d. Which classes get higher evaluations, required classes or non-required classes?
*Manual calculations:
*collapse eval, by(required)
*required	eval
*0	4.57892
*1	4.35288
*Difference: 0.226
*Percent Change: 4.936%
*Required classes get lower evaluations (significant) than non-required classes. 
eststo clear
eststo: reg eval required, robust
esttab, p noobs

*1e. Which classes get higher evaluations, classes that use math or don't?
*Manual calculations:
*collapse eval, by(math)
*math	eval
*0	4.64178
*1	4.50552
*Difference: 0.136
*Percent Change: 2.935%
*Classes that use math get lower evaluations (significant) than those that do not use math. 
eststo clear
eststo: reg eval math, robust
esttab, p noobs

*2. Which classes get higher evaluations, classes with a large number of students or a small number of students?
eststo clear
eststo: reg eval enrollment, robust
esttab, p noobs

*4. Understanding how students' performance in the class is related to instructor's evaluations.
eststo clear
*Model 1
eststo: reg eval apct
*Model 2
eststo: reg eval apct year required enrollment spring math
*Model 3
eststo: reg eval apct year required enrollment spring math female race
*Model 4
eststo: reg eval apct i.courseid
*Model 5
eststo: reg eval apct i.instrid 
*Model 6
eststo: reg eval apct i.courseid i.instrid
esttab, keep(apct) p noobs

*6. Model 6 + enrollment
eststo clear
eststo: reg eval apct enrollment i.courseid i.instrid
esttab, keep(apct _cons) p noobs noconstant

