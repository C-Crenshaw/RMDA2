
*********************************************************************************		
/*	TITLE: 		RMDA2_Homework6.do								
*	PURPOSE:	Code written for the completion of RMDA Homework 6. 				
*	AUTHOR:		Carson Crenshaw												
*	CREATED:	04/30/2024																				
*/
*********************************************************************************

*********
*	1: Getting acquiescence with the data
*********

glob classpath "/Users/carsoncrenshaw/Library/CloudStorage/OneDrive-UniversityofVirginia/RMDA II/HW6/"
	cd "${classpath}" 

set more off

clear
quietly infix                ///
  int     year      1-4      ///
  long    serial    5-9      ///
  byte    month     10-11    ///
  double  hwtfinl   12-21    ///
  double  cpsid     22-35    ///
  byte    asecflag  36-36    ///
  byte    hflag     37-37    ///
  double  asecwth   38-48    ///
  byte    statefip  49-50    ///
  byte    pernum    51-52    ///
  double  wtfinl    53-66    ///
  double  cpsidv    67-81    ///
  double  cpsidp    82-95    ///
  double  asecwt    96-106   ///
  byte    age       107-108  ///
  byte    sex       109-109  ///
  int     race      110-112  ///
  byte    marst     113-113  ///
  byte    nchild    114-114  ///
  byte    empstat   115-116  ///
  byte    labforce  117-117  ///
  int     educ      118-120  ///
  byte    schlcoll  121-121  ///
  double  inctot    122-130  ///
  double  incwage   131-138  ///
  using `"cps_00003.dat"'

replace hwtfinl  = hwtfinl  / 10000
replace asecwth  = asecwth  / 10000
replace wtfinl   = wtfinl   / 10000
replace asecwt   = asecwt   / 10000

format hwtfinl  %10.4f
format cpsid    %14.0f
format asecwth  %11.4f
format wtfinl   %14.4f
format cpsidv   %15.0f
format cpsidp   %14.0f
format asecwt   %11.4f
format inctot   %9.0f
format incwage  %8.0f

label var year     `"Survey year"'
label var serial   `"Household serial number"'
label var month    `"Month"'
label var hwtfinl  `"Household weight, Basic Monthly"'
label var cpsid    `"CPSID, household record"'
label var asecflag `"Flag for ASEC"'
label var hflag    `"Flag for the 3/8 file 2014"'
label var asecwth  `"Annual Social and Economic Supplement Household weight"'
label var statefip `"State (FIPS code)"'
label var pernum   `"Person number in sample unit"'
label var wtfinl   `"Final Basic Weight"'
label var cpsidv   `"Validated Longitudinal Identifier"'
label var cpsidp   `"CPSID, person record"'
label var asecwt   `"Annual Social and Economic Supplement Weight"'
label var age      `"Age"'
label var sex      `"Sex"'
label var race     `"Race"'
label var marst    `"Marital status"'
label var nchild   `"Number of own children in household"'
label var empstat  `"Employment status"'
label var labforce `"Labor force status"'
label var educ     `"Educational attainment recode"'
label var schlcoll `"School or college attendance"'
label var inctot   `"Total personal income"'
label var incwage  `"Wage and salary income"'

label define month_lbl 01 `"January"'
label define month_lbl 02 `"February"', add
label define month_lbl 03 `"March"', add
label define month_lbl 04 `"April"', add
label define month_lbl 05 `"May"', add
label define month_lbl 06 `"June"', add
label define month_lbl 07 `"July"', add
label define month_lbl 08 `"August"', add
label define month_lbl 09 `"September"', add
label define month_lbl 10 `"October"', add
label define month_lbl 11 `"November"', add
label define month_lbl 12 `"December"', add
label values month month_lbl

label define asecflag_lbl 1 `"ASEC"'
label define asecflag_lbl 2 `"March Basic"', add
label values asecflag asecflag_lbl

label define hflag_lbl 0 `"5/8 file"'
label define hflag_lbl 1 `"3/8 file"', add
label values hflag hflag_lbl

label define statefip_lbl 01 `"Alabama"'
label define statefip_lbl 02 `"Alaska"', add
label define statefip_lbl 04 `"Arizona"', add
label define statefip_lbl 05 `"Arkansas"', add
label define statefip_lbl 06 `"California"', add
label define statefip_lbl 08 `"Colorado"', add
label define statefip_lbl 09 `"Connecticut"', add
label define statefip_lbl 10 `"Delaware"', add
label define statefip_lbl 11 `"District of Columbia"', add
label define statefip_lbl 12 `"Florida"', add
label define statefip_lbl 13 `"Georgia"', add
label define statefip_lbl 15 `"Hawaii"', add
label define statefip_lbl 16 `"Idaho"', add
label define statefip_lbl 17 `"Illinois"', add
label define statefip_lbl 18 `"Indiana"', add
label define statefip_lbl 19 `"Iowa"', add
label define statefip_lbl 20 `"Kansas"', add
label define statefip_lbl 21 `"Kentucky"', add
label define statefip_lbl 22 `"Louisiana"', add
label define statefip_lbl 23 `"Maine"', add
label define statefip_lbl 24 `"Maryland"', add
label define statefip_lbl 25 `"Massachusetts"', add
label define statefip_lbl 26 `"Michigan"', add
label define statefip_lbl 27 `"Minnesota"', add
label define statefip_lbl 28 `"Mississippi"', add
label define statefip_lbl 29 `"Missouri"', add
label define statefip_lbl 30 `"Montana"', add
label define statefip_lbl 31 `"Nebraska"', add
label define statefip_lbl 32 `"Nevada"', add
label define statefip_lbl 33 `"New Hampshire"', add
label define statefip_lbl 34 `"New Jersey"', add
label define statefip_lbl 35 `"New Mexico"', add
label define statefip_lbl 36 `"New York"', add
label define statefip_lbl 37 `"North Carolina"', add
label define statefip_lbl 38 `"North Dakota"', add
label define statefip_lbl 39 `"Ohio"', add
label define statefip_lbl 40 `"Oklahoma"', add
label define statefip_lbl 41 `"Oregon"', add
label define statefip_lbl 42 `"Pennsylvania"', add
label define statefip_lbl 44 `"Rhode Island"', add
label define statefip_lbl 45 `"South Carolina"', add
label define statefip_lbl 46 `"South Dakota"', add
label define statefip_lbl 47 `"Tennessee"', add
label define statefip_lbl 48 `"Texas"', add
label define statefip_lbl 49 `"Utah"', add
label define statefip_lbl 50 `"Vermont"', add
label define statefip_lbl 51 `"Virginia"', add
label define statefip_lbl 53 `"Washington"', add
label define statefip_lbl 54 `"West Virginia"', add
label define statefip_lbl 55 `"Wisconsin"', add
label define statefip_lbl 56 `"Wyoming"', add
label define statefip_lbl 61 `"Maine-New Hampshire-Vermont"', add
label define statefip_lbl 65 `"Montana-Idaho-Wyoming"', add
label define statefip_lbl 68 `"Alaska-Hawaii"', add
label define statefip_lbl 69 `"Nebraska-North Dakota-South Dakota"', add
label define statefip_lbl 70 `"Maine-Massachusetts-New Hampshire-Rhode Island-Vermont"', add
label define statefip_lbl 71 `"Michigan-Wisconsin"', add
label define statefip_lbl 72 `"Minnesota-Iowa"', add
label define statefip_lbl 73 `"Nebraska-North Dakota-South Dakota-Kansas"', add
label define statefip_lbl 74 `"Delaware-Virginia"', add
label define statefip_lbl 75 `"North Carolina-South Carolina"', add
label define statefip_lbl 76 `"Alabama-Mississippi"', add
label define statefip_lbl 77 `"Arkansas-Oklahoma"', add
label define statefip_lbl 78 `"Arizona-New Mexico-Colorado"', add
label define statefip_lbl 79 `"Idaho-Wyoming-Utah-Montana-Nevada"', add
label define statefip_lbl 80 `"Alaska-Washington-Hawaii"', add
label define statefip_lbl 81 `"New Hampshire-Maine-Vermont-Rhode Island"', add
label define statefip_lbl 83 `"South Carolina-Georgia"', add
label define statefip_lbl 84 `"Kentucky-Tennessee"', add
label define statefip_lbl 85 `"Arkansas-Louisiana-Oklahoma"', add
label define statefip_lbl 87 `"Iowa-N Dakota-S Dakota-Nebraska-Kansas-Minnesota-Missouri"', add
label define statefip_lbl 88 `"Washington-Oregon-Alaska-Hawaii"', add
label define statefip_lbl 89 `"Montana-Wyoming-Colorado-New Mexico-Utah-Nevada-Arizona"', add
label define statefip_lbl 90 `"Delaware-Maryland-Virginia-West Virginia"', add
label define statefip_lbl 99 `"State not identified"', add
label values statefip statefip_lbl

label define age_lbl 00 `"Under 1 year"'
label define age_lbl 01 `"1"', add
label define age_lbl 02 `"2"', add
label define age_lbl 03 `"3"', add
label define age_lbl 04 `"4"', add
label define age_lbl 05 `"5"', add
label define age_lbl 06 `"6"', add
label define age_lbl 07 `"7"', add
label define age_lbl 08 `"8"', add
label define age_lbl 09 `"9"', add
label define age_lbl 10 `"10"', add
label define age_lbl 11 `"11"', add
label define age_lbl 12 `"12"', add
label define age_lbl 13 `"13"', add
label define age_lbl 14 `"14"', add
label define age_lbl 15 `"15"', add
label define age_lbl 16 `"16"', add
label define age_lbl 17 `"17"', add
label define age_lbl 18 `"18"', add
label define age_lbl 19 `"19"', add
label define age_lbl 20 `"20"', add
label define age_lbl 21 `"21"', add
label define age_lbl 22 `"22"', add
label define age_lbl 23 `"23"', add
label define age_lbl 24 `"24"', add
label define age_lbl 25 `"25"', add
label define age_lbl 26 `"26"', add
label define age_lbl 27 `"27"', add
label define age_lbl 28 `"28"', add
label define age_lbl 29 `"29"', add
label define age_lbl 30 `"30"', add
label define age_lbl 31 `"31"', add
label define age_lbl 32 `"32"', add
label define age_lbl 33 `"33"', add
label define age_lbl 34 `"34"', add
label define age_lbl 35 `"35"', add
label define age_lbl 36 `"36"', add
label define age_lbl 37 `"37"', add
label define age_lbl 38 `"38"', add
label define age_lbl 39 `"39"', add
label define age_lbl 40 `"40"', add
label define age_lbl 41 `"41"', add
label define age_lbl 42 `"42"', add
label define age_lbl 43 `"43"', add
label define age_lbl 44 `"44"', add
label define age_lbl 45 `"45"', add
label define age_lbl 46 `"46"', add
label define age_lbl 47 `"47"', add
label define age_lbl 48 `"48"', add
label define age_lbl 49 `"49"', add
label define age_lbl 50 `"50"', add
label define age_lbl 51 `"51"', add
label define age_lbl 52 `"52"', add
label define age_lbl 53 `"53"', add
label define age_lbl 54 `"54"', add
label define age_lbl 55 `"55"', add
label define age_lbl 56 `"56"', add
label define age_lbl 57 `"57"', add
label define age_lbl 58 `"58"', add
label define age_lbl 59 `"59"', add
label define age_lbl 60 `"60"', add
label define age_lbl 61 `"61"', add
label define age_lbl 62 `"62"', add
label define age_lbl 63 `"63"', add
label define age_lbl 64 `"64"', add
label define age_lbl 65 `"65"', add
label define age_lbl 66 `"66"', add
label define age_lbl 67 `"67"', add
label define age_lbl 68 `"68"', add
label define age_lbl 69 `"69"', add
label define age_lbl 70 `"70"', add
label define age_lbl 71 `"71"', add
label define age_lbl 72 `"72"', add
label define age_lbl 73 `"73"', add
label define age_lbl 74 `"74"', add
label define age_lbl 75 `"75"', add
label define age_lbl 76 `"76"', add
label define age_lbl 77 `"77"', add
label define age_lbl 78 `"78"', add
label define age_lbl 79 `"79"', add
label define age_lbl 80 `"80"', add
label define age_lbl 81 `"81"', add
label define age_lbl 82 `"82"', add
label define age_lbl 83 `"83"', add
label define age_lbl 84 `"84"', add
label define age_lbl 85 `"85"', add
label define age_lbl 86 `"86"', add
label define age_lbl 87 `"87"', add
label define age_lbl 88 `"88"', add
label define age_lbl 89 `"89"', add
label define age_lbl 90 `"90 (90+, 1988-2002)"', add
label define age_lbl 91 `"91"', add
label define age_lbl 92 `"92"', add
label define age_lbl 93 `"93"', add
label define age_lbl 94 `"94"', add
label define age_lbl 95 `"95"', add
label define age_lbl 96 `"96"', add
label define age_lbl 97 `"97"', add
label define age_lbl 98 `"98"', add
label define age_lbl 99 `"99+"', add
label values age age_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label define sex_lbl 9 `"NIU"', add
label values sex sex_lbl

label define race_lbl 100 `"White"'
label define race_lbl 200 `"Black"', add
label define race_lbl 300 `"American Indian/Aleut/Eskimo"', add
label define race_lbl 650 `"Asian or Pacific Islander"', add
label define race_lbl 651 `"Asian only"', add
label define race_lbl 652 `"Hawaiian/Pacific Islander only"', add
label define race_lbl 700 `"Other (single) race, n.e.c."', add
label define race_lbl 801 `"White-Black"', add
label define race_lbl 802 `"White-American Indian"', add
label define race_lbl 803 `"White-Asian"', add
label define race_lbl 804 `"White-Hawaiian/Pacific Islander"', add
label define race_lbl 805 `"Black-American Indian"', add
label define race_lbl 806 `"Black-Asian"', add
label define race_lbl 807 `"Black-Hawaiian/Pacific Islander"', add
label define race_lbl 808 `"American Indian-Asian"', add
label define race_lbl 809 `"Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 810 `"White-Black-American Indian"', add
label define race_lbl 811 `"White-Black-Asian"', add
label define race_lbl 812 `"White-American Indian-Asian"', add
label define race_lbl 813 `"White-Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 814 `"White-Black-American Indian-Asian"', add
label define race_lbl 815 `"American Indian-Hawaiian/Pacific Islander"', add
label define race_lbl 816 `"White-Black--Hawaiian/Pacific Islander"', add
label define race_lbl 817 `"White-American Indian-Hawaiian/Pacific Islander"', add
label define race_lbl 818 `"Black-American Indian-Asian"', add
label define race_lbl 819 `"White-American Indian-Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 820 `"Two or three races, unspecified"', add
label define race_lbl 830 `"Four or five races, unspecified"', add
label define race_lbl 999 `"Blank"', add
label values race race_lbl

label define marst_lbl 1 `"Married, spouse present"'
label define marst_lbl 2 `"Married, spouse absent"', add
label define marst_lbl 3 `"Separated"', add
label define marst_lbl 4 `"Divorced"', add
label define marst_lbl 5 `"Widowed"', add
label define marst_lbl 6 `"Never married/single"', add
label define marst_lbl 7 `"Widowed or Divorced"', add
label define marst_lbl 9 `"NIU"', add
label values marst marst_lbl

label define nchild_lbl 0 `"0 children present"'
label define nchild_lbl 1 `"1 child present"', add
label define nchild_lbl 2 `"2"', add
label define nchild_lbl 3 `"3"', add
label define nchild_lbl 4 `"4"', add
label define nchild_lbl 5 `"5"', add
label define nchild_lbl 6 `"6"', add
label define nchild_lbl 7 `"7"', add
label define nchild_lbl 8 `"8"', add
label define nchild_lbl 9 `"9+"', add
label values nchild nchild_lbl

label define empstat_lbl 00 `"NIU"'
label define empstat_lbl 01 `"Armed Forces"', add
label define empstat_lbl 10 `"At work"', add
label define empstat_lbl 12 `"Has job, not at work last week"', add
label define empstat_lbl 20 `"Unemployed"', add
label define empstat_lbl 21 `"Unemployed, experienced worker"', add
label define empstat_lbl 22 `"Unemployed, new worker"', add
label define empstat_lbl 30 `"Not in labor force"', add
label define empstat_lbl 31 `"NILF, housework"', add
label define empstat_lbl 32 `"NILF, unable to work"', add
label define empstat_lbl 33 `"NILF, school"', add
label define empstat_lbl 34 `"NILF, other"', add
label define empstat_lbl 35 `"NILF, unpaid, lt 15 hours"', add
label define empstat_lbl 36 `"NILF, retired"', add
label values empstat empstat_lbl

label define labforce_lbl 0 `"NIU"'
label define labforce_lbl 1 `"No, not in the labor force"', add
label define labforce_lbl 2 `"Yes, in the labor force"', add
label values labforce labforce_lbl

label define educ_lbl 000 `"NIU or no schooling"'
label define educ_lbl 001 `"NIU or blank"', add
label define educ_lbl 002 `"None or preschool"', add
label define educ_lbl 010 `"Grades 1, 2, 3, or 4"', add
label define educ_lbl 011 `"Grade 1"', add
label define educ_lbl 012 `"Grade 2"', add
label define educ_lbl 013 `"Grade 3"', add
label define educ_lbl 014 `"Grade 4"', add
label define educ_lbl 020 `"Grades 5 or 6"', add
label define educ_lbl 021 `"Grade 5"', add
label define educ_lbl 022 `"Grade 6"', add
label define educ_lbl 030 `"Grades 7 or 8"', add
label define educ_lbl 031 `"Grade 7"', add
label define educ_lbl 032 `"Grade 8"', add
label define educ_lbl 040 `"Grade 9"', add
label define educ_lbl 050 `"Grade 10"', add
label define educ_lbl 060 `"Grade 11"', add
label define educ_lbl 070 `"Grade 12"', add
label define educ_lbl 071 `"12th grade, no diploma"', add
label define educ_lbl 072 `"12th grade, diploma unclear"', add
label define educ_lbl 073 `"High school diploma or equivalent"', add
label define educ_lbl 080 `"1 year of college"', add
label define educ_lbl 081 `"Some college but no degree"', add
label define educ_lbl 090 `"2 years of college"', add
label define educ_lbl 091 `"Associate's degree, occupational/vocational program"', add
label define educ_lbl 092 `"Associate's degree, academic program"', add
label define educ_lbl 100 `"3 years of college"', add
label define educ_lbl 110 `"4 years of college"', add
label define educ_lbl 111 `"Bachelor's degree"', add
label define educ_lbl 120 `"5+ years of college"', add
label define educ_lbl 121 `"5 years of college"', add
label define educ_lbl 122 `"6+ years of college"', add
label define educ_lbl 123 `"Master's degree"', add
label define educ_lbl 124 `"Professional school degree"', add
label define educ_lbl 125 `"Doctorate degree"', add
label define educ_lbl 999 `"Missing/Unknown"', add
label values educ educ_lbl

label define schlcoll_lbl 0 `"NIU"'
label define schlcoll_lbl 1 `"High school full time"', add
label define schlcoll_lbl 2 `"High school part time"', add
label define schlcoll_lbl 3 `"College or university full time"', add
label define schlcoll_lbl 4 `"College or university part time"', add
label define schlcoll_lbl 5 `"Does not attend school, college or university"', add
label values schlcoll schlcoll_lbl

save "${classpath}hw6.dta", replace

drop asecflag hflag wtfinl cpsidv asecwt

drop if inctot == .

*Check to make sure the number of observations is correct
describe, short

*Change years
replace year = year - 1

save "${classpath}hw6.dta", replace

*Import CPI data
import excel cpi.xlsx, clear
save cpi.dta, replace
rename A year
rename B cpi
save cpi.dta, replace

*Merge data
use "${classpath}cpi.dta", clear
merge 1:m year using "${classpath}hw6.dta"
drop if _merge == 1
drop if _merge == 2
drop _merge

*Clean data
*Already dropped "." values
drop if incwage == 99999999
drop if year == 1979 //values between 1980 and 2015, should make no changes because 1979 values were not merged together
drop if marst == 1 //drop married
drop if marst == 2 //drop married
keep if sex == 2 //female
keep if age>=25 //25 or older
keep if age<=45 //45 or younger
keep if educ<= 73 //educational attainment was a high school diploma, GED, or less

*Convert nominal earnings (incwage) to 2015 real dollars
replace cpi = cpi/237
replace incwage = incwage/cpi
sum incwage
*note: there is more than one way to calculate these values. ex:
*replace cpi = 237/cpi
*replace incwage = cpi*incwage 
*sum incwage

*Employed binary variable
gen employed = 0
replace employed = 1 if incwage>0

*Children binary variable
//Women with zero children
gen zerochild = 0
replace zerochild = 1 if nchild == 0

//Women with 1 child
gen onechild = 0
replace onechild = 1 if nchild ==1

//Women with 2 or more children
gen twoormorechild = 0
replace twoormorechild = 1 if nchild>=2

*Summary statistics of cleaned dataset
sum year serial asecwth cpsid statefip  pernum cpsidp  age cpi employed

save cpi.dta, replace

*********
*	2: Graphing the Big Picture
*********

*Create a graph that shows how female employment rates varied with family size from 1980-2015.

collapse employed [pw=asecwth], by(year zerochild onechild twoormorechild) //weighted

twoway (line employed year if zerochild == 1) ///
(line employed year if onechild == 1) ///
(line employed year if twoormorechild == 1), ///
xline(1993, lpattern(dash) lcolor(black)) ///
legend(label(1 "Zero Children") label(2 "One Child") label(3 "Two or More Children")) ///
graphregion(color(white)) title("Female Employment Rates by Family Size from 1980-2015", size(medium)) ///
ytitle("Employment Rate") xtitle("Year") xscale(range(1980 2015)) xlabel(1980(5)2015, nogrid) scheme(plotplainblind)

*Create a similar graph that shows how women's average earnings varied with family size from 1980-2015. Income should range from $0 to $25,000
clear
use "${classpath}cpi.dta", clear

collapse incwage [pw=asecwth], by(year zerochild onechild twoormorechild)

twoway (line incwage year if zerochild == 1) ///
(line incwage year if onechild == 1) ///
(line incwage year if twoormorechild == 1), ///
xline(1993, lpattern(dash) lcolor(black)) ///
legend(label(1 "Zero Children") label(2 "One Child") label(3 "Two or More Children")) ///
graphregion(color(white)) title("Average Income for Females by Family Size from 1980-2015", size(medium)) ///
ytitle("Average Income ($)") yscale(range(0 25000)) ylabel(0(5000)25000, labsize(small) nogrid) xtitle("Year") xscale(range(1980 2015)) xlabel(1980(5)2015, labsize(small) nogrid) scheme(plotplainblind)

clear
use "${classpath}cpi.dta", clear


*********
*	3: Doing Difference-in-Difference
*********
*Remove observations with only one child
drop onechild
drop if nchild == 1
*Remove observations that occur during or after 2008
drop if year >= 2008
*Exclude years 1994-1999
drop if year == 1994
drop if year == 1995
drop if year == 1996
drop if year == 1997
drop if year == 1998
drop if year == 1999

*1. Run the DD regression in (1) using the employment dummy as your outcome variable.
*Create a dummy variable to indicate the time when the treatment started. 
gen post = 0
replace post = 1 if year>1993

gen did = post*twoormorechild

eststo clear
eststo: reg employed post twoormorechild did [pw=asecwth]

*check
*reg employed twoormorechild##time [pw=asecwth]
*diff employed [pw=asecwth], t(twoormorechild) p(time)

//Intrepret the constant (α)
	//The employment rate for women with no children before 1993 is 78.3%. This finding is statistically significant at the 99% significance level.
	
//Interpret the coefficient (β)
	//The difference in employment rate between women with two or more children and women with no children before 1993 is -18.9 percentage points. Women with no children had an employment rate that was 18.9 percentage points higher than the treatment group (women with two or more children) before 1993. This finding is statistically significant at the 99% significance level.
	
//Interpret the coefficient (γ)
	//The difference between the employment rate for women with no children before and after 1993 is -8.8 percentage points. This finding is statistically significant at the 99% significance level.

//Interpret the difference-in-difference coefficient (δ)
	//The difference-in-difference coefficient represents the difference in the effect of the post-period on treatment and control. In this sense, the female employment rate increased by 21 percentage points more for women with two or more children compared to women with no children after 1993. In other words, the employment rate increases 21 percentage points more than it would have without having two or more children. This finding is statistically significant at the 99% significance level.

//Conclusion
	//The EITC had a large and statistically signficant (at the 99% level) increase on female employment rates. The third coefficient (δ) captures the causal effect of the EITC expansion on mothers' employment. 
	
*2. Replace the Post dummy in regression (1) with a full set of year fixed effects
eststo: reg employed twoormorechild i.year did [pw=asecwth]

*3. Add the age of the respondent as a control variable in your regression
eststo: reg employed age twoormorechild i.year did [pw=asecwth]

*4. Add state fixed effects to your model in step 3
eststo: reg employed age twoormorechild i.statefip i.year did [pw=asecwth]

*5. Make table
esttab, keep(did post twoormorechild age _cons) title("Employment Rates") mtitle("Simple" "Time FE" "Age" "State FE") b(3) se(3)

*6. Repeat steps 1-4 using annual earnings as the outcome variable instead of employment.
eststo: reg incwage post twoormorechild did [pw=asecwth]

eststo: reg incwage twoormorechild i.year did [pw=asecwth]

eststo: reg incwage age twoormorechild i.year did [pw=asecwth]

eststo: reg incwage age twoormorechild i.statefip i.year did [pw=asecwth]

esttab, keep(did post twoormorechild age _cons) title("Employment Rates and Income") mtitle("Simple" "Time FE" "Age" "State FE" "Simple" "Time FE" "Age" "State FE") b(3) se(3)

*7. Event Study
fvset base 1992 year 
reg employed twoormorechild i.year i.statefip age twoormorechild#i.year [pw=asecwth]
coefplot, vertical keep(*#*) xlabel(,angle(90)) coeflabels(*1980* = "1980" *1981* = "1981" *1982* = "1982" *1983* = "1983" *1984* = "1984" *1985* = "1985" *1986* = "1986" *1987* = "1987" *1988* = "1988" *1989* = "1989" *1990* = "1990" *1991* = "1991" *1992* = "1992" *1993* = "1993" *2000* = "2000" *2001* = "2001" *2002* = "2002" *2003* = "2003" *2004* = "2004" *2005* = "2005" *2006* = "2006" *2007* = "2007") title("Female Employment Rate Event Study", size(medium)) xtitle("Year")
