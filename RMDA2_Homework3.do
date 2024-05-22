
*********************************************************************************		
/*	TITLE: 		RMDA2_Homework3.do								
*	PURPOSE:	Code written for the completion of RMDA Homework 3. 				
*	AUTHOR:		Carson Crenshaw												
*	DUE:	    03/18/2024																				
*/
*********************************************************************************

*********
*	Creating and Storing the New Dataset
*********

glob classpath "/Users/carsoncrenshaw/Library/CloudStorage/OneDrive-UniversityofVirginia/RMDA II/HW3/"
	cd "${classpath}" 
	
use "${classpath}hw3_clean.dta", clear

*Notice that SentencedDays captures the days that the sentence was for, while TimeServed captures the days served by the individual.

*********
*	Replicating the results
*********

*k*
format sentence_start_date %td 
gen double sentence_end = sentence_start_date + SentencedDays
label var sentence_end "Date of the end of the sentence"
*screenshot column of raw numbers (not dates) for Gradescope

*l*
format sentence_end %td
*screenshot column of raw numbers (not dates) for Gradescope

*m*
*the instrument is the accumulation of changes on the availability of beds across the sentence spell of the individual
*since the instrument is adjusted to a per 1,000-bed rate, we would divide the number by 1,000
*changes should occur at least 90 days after the sentence date and 90 days before the sentence end date

generate CapacityShock = 0
replace CapacityShock = CapacityShock + 1000 if sentence_start_date<=d(01jun1996)-90 & sentence_end>=d(01jun1996)+90
replace CapacityShock = CapacityShock + 1000 if sentence_start_date<=d(01sep1996)-90 & sentence_end>=d(01sep1996)+90
replace CapacityShock = CapacityShock + 500 if sentence_start_date<=d(01jan1998)-90 & sentence_end>=d(01jan1998)+90
replace CapacityShock = CapacityShock + 500 if sentence_start_date<=d(01aug1998)-90 & sentence_end>=d(01aug1998)+90
replace CapacityShock = CapacityShock + 500 if sentence_start_date<=d(01apr1999)-90 & sentence_end>=d(01apr1999)+90
replace CapacityShock = CapacityShock - 1000 if sentence_start_date<=d(01oct2002)-90 & sentence_end>=d(01oct2002)+90
replace CapacityShock = CapacityShock + 1000 if sentence_start_date<=d(01nov2004)-90 & sentence_end>=d(01nov2004)+90
replace CapacityShock = CapacityShock/1000

*check to make sure summary statistics match website
sum(CapacityShock)

sum (CapacityShock), det
*provide a screenshot of the code for this variable and then show the output from the previous code

*********
*	Reduced form IV & 2SLS
*********

*n* 
*first stage regression
*Private =  ɑo + ɑ1CapacityShock
reg ever_private CapacityShock

*o*
*reduced form regression
*TimeServed = ⍴0 + ⍴1CapacityShock
reg TimeServed CapacityShock

*p*
*obtain IV estimate
*LATE = ITT (p1) / FirstStage (ɑ1) = .5962427 / .0068828
di .5962427 / .0068828

*q*
*use the ivregress command
ivregress 2sls TimeServed (ever_private = CapacityShock), first

*result: 86.628

*********
*	Getting Closer to Mukherjee's results
*********

*s*
*run regression with new controls: age, race, education level, a dummy if the inmate is single or not, a dummy for each county of conviction, a dummy for each level of care, a dummy for each classification, and a dummy for each medical classification.
*TimeServed=α0​+βPrivatei​+(Controls)+εi​

*make dummy for county of conviction
tabulate county_of_conviction, gen(county_of_conviction)

*make dummy for level of care
tabulate LevelCare, gen(LevelCare)

*make dummy for each classification
tabulate CClass, gen(CClass)

*make dummy for each medical classification
tabulate Med_CS, gen(Med_CS)

estimates clear
eststo: reg TimeServed ever_private age black leHS Single i.county_of_conviction i.LevelCare i.CClass i.Med_CS
esttab, keep(ever_private) se
*matches OLS estimate for days served with controls within study (approx.)
*result: 85.2396
*standard error: .0155915
*N: 26,593

*t*
*first stage reg
reg ever_private CapacityShock age black leHS Single i.county_of_conviction i.LevelCare i.CClass i.Med_CS

*reduced form reg
reg TimeServed CapacityShock age black leHS Single i.county_of_conviction i.LevelCare i.CClass i.Med_CS

*IV estimate
*LATE = ITT / FirstStage =  .5990539 / .0069242 
di .5990539 / .0069242 

*ivregress command (check)
estimates clear
eststo: ivregress 2sls TimeServed age black leHS Single i.county_of_conviction i.LevelCare i.CClass i.Med_CS (ever_private = CapacityShock), first
esttab, keep(ever_private) se
*result: 86.51653
*std: 1.30948
*N: 26,593

*u*
estimates clear
eststo: reg TimeServed ever_private age black leHS Single i.county_of_conviction i.LevelCare i.CClass i.Med_CS
eststo: ivregress 2sls TimeServed age black leHS Single i.county_of_conviction i.LevelCare i.CClass i.Med_CS (ever_private = CapacityShock), first
esttab, se nostar keep(ever_private) mtitles("Time Served OLS with controls" "Time Served IV with controls")

