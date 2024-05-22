
cd "/Users/carsoncrenshaw/Library/CloudStorage/OneDrive-UniversityofVirginia/RMDA II"

use "HOPE_HW.dta", clear

//Start by summarizing/browsing your variables of interest: InCollege, Georgia, After 

	//What is the current unit of observation? 
	
	//If we are interested in the effect of Georgia HOPE scholarships on college enrollment, 
		//what do we want our unit of observation to be? 
		
	//What are the unit and time components of this panel variable?
	
	
//Run a standard difference-in-difference model with InCollege as your outcome variable 
reg InCollege Georgia##After

//Intrepret the constant 
	//40.5% of non-Georgian students before 1992 went to college 
	
//What is the share of non-Georgian students going to college after 1992? 
	//40% 

//Interpret the difference-in-difference coefficient 
	//College attendance rates increased by 8.9 percentage points more in Georgia compared to other areas after 1992. 

//Provide a conclusion about the effect of the HOPE scholarship on college attendance rates
	//The HOPE scholarship has a large and statistically signficant (at the 90% level) increase on college attendance rates. 

//Let's make some graphs! 

//Start with a line graph depicting college attendance rates for Georgian and non-Georgia students by year 
preserve
collapse InCollege, by(Georgia Year)

//long way
twoway (line InCollege Year if Georgia == 0) ///
		(line InCollege Year if Georgia == 1), ///
	legend(label(1 "Non-Georgia") label(2 "Georgia")) ///
	graphregion(color(white)) title("College Attendance in GA & Control States") ///
	ytitle("Portion In College") xline(93, lpattern(dash) lcolor(gray))


//wide way
reshape wide InCollege, i(Year) j(Georgia) 
line InCollege* Year 

line InCollege* Year, legend(label(1 "Non-Georgia") label(2 "Georgia")) ///
	graphregion(color(white)) title("College Attendance in GA & Control States") ///
	ytitle("Portion In College") xline(93, lpattern(dash) lcolor(gray))


restore 

//Now make an event study. Again use the skills we discussed last discussion! 
reg InCollege Georgia i.Year i.Georgia#i.Year 
coefplot

coefplot, keep(1.Georgia#*.Year)

coefplot, keep(1.Georgia#*.Year) vertical

coefplot, keep(1.Georgia#*.Year) vertical recast(connected) 

coefplot, keep(1.Georgia#*.Year ) vertical recast(connected) xlabel(,angle(45)) ///
	title("Event Study") graphregion(color(white)) 
	
	help coefplot
	
fvset base 93 Year 
reg InCollege Georgia i.Year i.Georgia#i.Year , cl(StateCode)
coefplot
coefplot, keep(1.Georgia#*.Year ) vertical recast(connected) xlabel(,angle(45)) ///
	title("Event Study") graphregion(color(white)) xline() scale(0.6)


//Does this event study support the parallel trends assumption? 
	//Yes. Before 1992, the difference between Georgian and non-Georgian students stradles zero and is flat meaning it meets the parallel trends assumption. 
//	
//For guidance on using regsave, please go to the "STATA: Using regsave or coefplot" worksheet
