
**Spring 2025 RMDA II Tutoring

**HW7

glob classpath "/Users/carsoncrenshaw/Library/CloudStorage/OneDrive-UniversityofVirginia/RMDA II/HWHelp/"
	cd "${classpath}" 
	
*Graph 1
use "${classpath}tenncare_enrollment.dta", clear

drop if year < 2000

twoway connected enrollment ym, sort xline(2005.667) xline(2006.417) xscale(range(2000 2013)) xlabel(2000(1)2013, nogrid) xmtick(, nogrid)

*Graph 2
use "${classpath}brfss_final.dta", clear
drop if year < 2000
drop if year > 2009

gen southern_state = 0 if (_state==47)
replace southern_state = 1 if ///
(_state==1 | _state==5 | _state==10 | _state==11 | _state==12 | _state==13 | _state==21 | _state==22 | _state==24 | _state==51 | _state==45 | _state==54 | _state==28 | _state==37 | _state==40 | _state==48)

drop if southern_state==.
gen tn = 1 if _state==47
replace tn = 0 if _state !=47 & southern_state!=.

keep if age>=21 & age<=64

collapse (mean) age cover [aw=_finalwt], by (year tn)

*Example Graph
twoway(connected age year if tn==1, sort)(connected age year if tn==0, sort)

*Answer Graph
twoway(connected cover year if tn==1, sort)(connected cover year if tn==0, sort)

*DnD Study
use "${classpath}brfss_final.dta", clear
gen post3=1 if year>2005 | year==2005 & imonth>7
replace post3=0 if year<2005 | year==2005 & imonth<=7

gen southern_state = 0 if (_state==47)
replace southern_state = 1 if ///
(_state==1 | _state==5 | _state==10 | _state==11 | _state==12 | _state==13 | _state==21 | _state==22 | _state==24 | _state==51 | _state==45 | _state==54 | _state==28 | _state==37 | _state==40 | _state==48)

drop if southern_state==.
gen tn = 1 if _state==47
replace tn = 0 if _state !=47 & southern_state!=.

global controls "black hispanic_me other female education1 education2 education3 education4 education5 age maritaltype2 maritaltype3 maritaltype4 maritaltype5 maritaltype6"
global weights "[aw=_finalwt]"

*could also just drop the appriopriate ages like done above. 
gen byte age2164 = 1*(age>=21 & age<65) + 0*(age>=65)
label var age2164 "Age Group 2164"

drop if year < 2000
drop if year > 2009

estimates clear
eststo: reg cover i.tn##i.post3 $weights if age2164==1
*the double ## is like saying i.tn i.post3 i.tn#i.post3
eststo: reg cover i.tn##i.post3 if age2164==1
eststo: reg cover i.tn##i.post3 $controls $weights if age2164==1
eststo: reg cover i.tn##i.post3 i.year $controls $weights if age2164==1
eststo: reg cover i.tn##i.post3 i.year i.imonth $controls $weights if age2164==1
eststo: reg cover i.tn##i.post3 i.year i.imonth i.statefip $controls $weights if age2164==1
esttab, se keep(1.tn#1.post3)

estimates clear
eststo: reg cover i.tn##i.post3 i.year i.imonth i.statefip $controls $weights if age2164==1
eststo: reg cover i.tn##i.post3 i.year i.imonth i.statefip $controls $weights if age2164==1 & nokid ==0
eststo: reg cover i.tn##i.post3 i.year i.imonth i.statefip $controls $weights if age2164==1 & nokid ==1
esttab, se keep(1.tn#1.post3)

*Event Study

global labelcoef "1.tn#2000.year="2000" 1.tn#2001.year="2001" 1.tn#2002.year="2002" 1.tn#2003.year="2003" 1.tn#2004.year="2004" 1.tn#2005.year="2005" 1.tn#2006.year="2006" 1.tn#2007.year="2007" 1.tn#2008.year="2008" 1.tn#2009.year="2009""

global spacecoef "1.tn#1999.year 1.tn#2000.year 1.tn#2001.year 1.tn#2002.year 1.tn#2003.year 1.tn#2004.year 1.tn#2005.year 1.tn#2006.year 1.tn#2007.year 1.tn#2008.year 1.tn#2009.year 1.tn#2010.year"

fvset base 2000 year 

reg cover i.tn##i.year i.imonth i.statefip $controls $weights if age2164==1 & nokid ==1

coefplot, vertical base keep(1.tn#*.year) order($spacecoef) coeflabels($labelcoef) 

coefplot, vertical base keep(1.tn#*.year) coeflabels(1.tn#2000.year="2000" 1.tn#2001.year="2001" 1.tn#2002.year="2002" 1.tn#2003.year="2003" 1.tn#2004.year="2004" 1.tn#2005.year="2005" 1.tn#2006.year="2006" 1.tn#2007.year="2007" 1.tn#2008.year="2008" 1.tn#2009.year="2009") recast(connected) ciopts(recast(rline) lpattern(shortdash_dot))



