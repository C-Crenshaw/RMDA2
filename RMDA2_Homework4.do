*********************************************************************************		
/*	TITLE: 		RMDA2_Homework4.do								
*	PURPOSE:	Code written for the completion of RMDA Homework 4. 				
*	AUTHOR:		Carson Crenshaw												
*	DUE:	    04/01/2024																				
*/
*********************************************************************************

*********
*	Creating and Storing the New Dataset
*********
glob classpath "/Users/carsoncrenshaw/Library/CloudStorage/OneDrive-UniversityofVirginia/RMDA II/HW4/"
	cd "${classpath}" 
	
use "${classpath}hw4_carpenter_dobkin.dta", clear

*Note: the "_r" stands for rate

*********
*	Estimating the results
*********

*15. Recreate Figure 1
twoway(scatter violent_r days_to_21, sort)
*Shows that for every day away from one's 21st bday, what is the rate of violent crime per 10,000 person-years. Rough discontinuity shown. 

*create 14-day bins
gen age_fortnight = 21 + (14*floor(days_to_21/14))/365
*browse
*br days_to_21 age_fortnight
*groups days until 21 into 14-day bins
collapse violent_r, by(age_fortnight)

*create Figure 1
*graph set window fontface "Times"
twoway (scatter violent_r age_fortnight if age_fortnight >=19 & age_fortnight <23)(lfit violent_r age_fortnight if age_fortnight>19 & age_fortnight<21, lpattern(solid))(lfit violent_r age_fortnight if age_fortnight<23 & age_fortnight>21, lpattern(solid)), ytitle("Violent Crime Arrest Rates") yscale(range(100 300)) ylabel(100(100)300, nogrid) ymtick(, nogrid) xtitle("Age at Time of Arrest") xscale(range(19 23)) xlabel(19(1)23, nogrid) xmtick(, nogrid) title("FIGURE 1.—ARREST RATES PER 10,000 PERSON-YEARS", size(medium)) note("", size(vsmall)) legend(off) scheme(stsj)

*16. Add Other Lines
use "hw4_carpenter_dobkin.dta", clear
gen age_fortnight = 21 + (14*floor(days_to_21/14))/365
collapse violent_r property_r alcohol_r ill_drugs_r other_r, by(age_fortnight)

twoway (scatter property_r age_fortnight if age_fortnight >=19 & age_fortnight <23, yscale(range(200,600) axis(1)))(qfit property_r age_fortnight if age_fortnight>19 & age_fortnight<21, lpattern(solid) yscale(range(200,600) axis(1)))(qfit property_r age_fortnight if age_fortnight<23 & age_fortnight>21, lpattern(solid) yscale(range(200,600) axis(1))) ///
(scatter violent_r age_fortnight if age_fortnight >=19 & age_fortnight <23, yaxis(2) yscale(range(100,300) axis(2)))(qfit violent_r age_fortnight if age_fortnight>19 & age_fortnight<21, lpattern(solid) yaxis(2) yscale(range(100,300) axis(2)))(qfit violent_r age_fortnight if age_fortnight<23 & age_fortnight>21, lpattern(solid) yaxis(2) yscale(range(100,300) axis(2))) ///
(scatter alcohol_r age_fortnight if age_fortnight >=19 & age_fortnight <23, yscale(range(200,600) axis(1)))(qfit alcohol_r age_fortnight if age_fortnight>19 & age_fortnight<21, lpattern(solid) yscale(range(200,600) axis(1)))(qfit alcohol_r age_fortnight if age_fortnight<23 & age_fortnight>21, lpattern(solid) yscale(range(200,600) axis(1))) ///
(scatter ill_drugs_r age_fortnight if age_fortnight >=19 & age_fortnight <23, yaxis(2) yscale(range(100,300) axis(2)))(qfit ill_drugs_r age_fortnight if age_fortnight>19 & age_fortnight<21, lpattern(solid) yaxis(2) yscale(range(100,300) axis(2)))(qfit ill_drugs_r age_fortnight if age_fortnight<23 & age_fortnight>21, lpattern(solid) yaxis(2) yscale(range(100,300) axis(2))) ///
(scatter other_r age_fortnight if age_fortnight >=19 & age_fortnight <23, yscale(range(200,600) axis(1)))(qfit other_r age_fortnight if age_fortnight>19 & age_fortnight<21, lpattern(solid) yscale(range(200,600) axis(1)))(qfit other_r age_fortnight if age_fortnight<23 & age_fortnight>21, lpattern(solid) yscale(range(200,600) axis(1))) ///
, ylabel(#3, axis(1)) ytitle("Property, Alcohol Related, & Other", axis(1)) ylabel(#3, axis(2)) ytitle("Violent & Drug Possession or Sale" , axis(2)) ylabel(, nogrid) ymtick(, nogrid) xtitle("Age at Time of Arrest") xscale(range(19 23)) xlabel(19(1)23, nogrid) xmtick(, nogrid) ylabel(#3) title("FIGURE 1.—ARREST RATES PER 10,000 PERSON-YEARS", size(medium)) note("", size(vsmall)) legend(off) scheme(stsj)

*17. Using binscatter
use "hw4_carpenter_dobkin.dta", clear
binscatter dui_r days_to_21
gen age_fortnight = 21 + (14*floor(days_to_21/14))/365

binscatter dui_r age_fortnight if age_fortnight>=19 & age_fortnight<23, rd(21) ///
title("FIGURE 2 - DUI ARREST RATES PER 100,000 PERSON-YEARS", size(medium)) ///
ytitle("Arrest Rates") ///
xtitle("Age at Time of Arrest") ///
legend(off)

*18. Replicating Table 1
use "hw4_carpenter_dobkin.dta", clear

cap drop threshold21
gen threshold21 = 0 if days_to_21<0
replace threshold21 = 1 if days_to_21>=0
replace threshold21 = . if days_to_21==.

*Reg 1
eststo clear
eststo: reg all_r i.threshold21 c.days_to_21, robust

*Reg 2
eststo: reg all_r i.threshold21 c.days_to_21 if c.days_to_21>=-730 & c.days_to_21<730, robust

*Reg 3
eststo: reg all_r i.threshold21 c.days_to_21 i.threshold21#c.days_to_21 if c.days_to_21>=-730 & c.days_to_21<730, robust

*Reg 4
cap drop days_to_21_squared
gen days_to_21_squared = days_to_21^2
eststo: reg all_r i.threshold21 c.days_to_21 c.days_to_21_squared i.threshold21#c.days_to_21 i.threshold21#c.days_to_21_squared if c.days_to_21>=-730 & c.days_to_21<730, robust

*Reg 5
eststo: reg all_r i.threshold21 c.days_to_21 c.days_to_21_squared i.threshold21#c.days_to_21 i.threshold21#c.days_to_21_squared birthday_19 birthday_19_1 birthday_20 birthday_20_1 birthday_21 birthday_21_1 birthday_22 birthday_22_1 if c.days_to_21>=-730 & c.days_to_21<730, robust

esttab, keep(1.threshold21) se

*19 Just change outcomes, use the final regression
eststo clear
eststo: reg all_r i.threshold21 c.days_to_21 c.days_to_21_squared i.threshold21#c.days_to_21 i.threshold21#c.days_to_21_squared birthday_19 birthday_19_1 birthday_20 birthday_20_1 birthday_21 birthday_21_1 birthday_22 birthday_22_1 if c.days_to_21>=-730 & c.days_to_21<730, robust

eststo: reg violent_r i.threshold21 c.days_to_21 c.days_to_21_squared i.threshold21#c.days_to_21 i.threshold21#c.days_to_21_squared birthday_19 birthday_19_1 birthday_20 birthday_20_1 birthday_21 birthday_21_1 birthday_22 birthday_22_1 if c.days_to_21>=-730 & c.days_to_21<730, robust

eststo: reg property_r i.threshold21 c.days_to_21 c.days_to_21_squared i.threshold21#c.days_to_21 i.threshold21#c.days_to_21_squared birthday_19 birthday_19_1 birthday_20 birthday_20_1 birthday_21 birthday_21_1 birthday_22 birthday_22_1 if c.days_to_21>=-730 & c.days_to_21<730, robust

eststo: reg ill_drugs_r i.threshold21 c.days_to_21 c.days_to_21_squared i.threshold21#c.days_to_21 i.threshold21#c.days_to_21_squared birthday_19 birthday_19_1 birthday_20 birthday_20_1 birthday_21 birthday_21_1 birthday_22 birthday_22_1 if c.days_to_21>=-730 & c.days_to_21<730, robust

eststo: reg alcohol_r i.threshold21 c.days_to_21 c.days_to_21_squared i.threshold21#c.days_to_21 i.threshold21#c.days_to_21_squared birthday_19 birthday_19_1 birthday_20 birthday_20_1 birthday_21 birthday_21_1 birthday_22 birthday_22_1 if c.days_to_21>=-730 & c.days_to_21<730, robust

eststo: reg other_r i.threshold21 c.days_to_21 c.days_to_21_squared i.threshold21#c.days_to_21 i.threshold21#c.days_to_21_squared birthday_19 birthday_19_1 birthday_20 birthday_20_1 birthday_21 birthday_21_1 birthday_22 birthday_22_1 if c.days_to_21>=-730 & c.days_to_21<730, robust

esttab, keep(1.threshold21 _cons) b(1) se(1)
