** Discussion #7 .do file Key** 

clear all
set more off 

cd "/Users/ellacarlson/Documents/Batten/RMDA_TA/Discussion/RD"

use "prekTulsa.dta", clear

****************************************
***Variables of interest***

	** age = days from the birthday cutoff. negative values indicate days born after the cutoff, positive values indicate days born before the cutoff 
	** cutoff = treatment (1= born before cutoff, 0 = born after cutoff)
	** wjtest01 = woodcock-johnson letter-word identification score
	

*****************************************
**Graphing and Collapsing***

	**To practice collapsing you data, collapse you data by birth state like we did in the previous discussion. Browse your data before and after collapsing
	
	collapse age cutoff wjtest01 female black white hispanic freelunch, by(birth_state)
	**restore your data back to the orriginal form, and collapse by birth city
	
	collapse age cutoff wjtest01 female black white hispanic freelunch, by(birth_city)
	
	**compare the two and write out a simplified answer of how the collapse command works
	
	**Run a twoway scatter plot of the RD, including lines of best fit before and after the cutoff 
	twoway (scatter wjtest01 age, sort)(lfit wjtest01 age if age <0)(lfit wjtest01 age if age >0) 

**before moving on to regression analysis, return your data to its orriginal form.
use "prekTulsa.dta", clear


****************************************
***Regression Interpretation***

**Run the most simple RD regression assuming that the slopes were the same before and after the cutoff. We will also assume this is a sharp discontinuity for simplicity.   
	eststo: reg wjtest01 i.cutoff c.age 
	
**Using the previous regression, what is the effect of going to preschool on reading scores? 

	// Being allowed to enroll in preschool is associated with a 3.49 point increase in reading scores.  
	
**Re-run this simple RD regression but restrict the sample to individuals born 30 days before and after the cutoff. 

		eststo: reg wjtest01 i.cutoff c.age if age<30 & age>-30

**Using the previous regression, what is the effect of going to preschool on reading scores? 

	//Being allowed to enroll in preschool is associated with a  5.84 point increase in reading scores. 
	
**Is this regression on a restricted sample different from the previous regression? Why? What could be explaining this difference? 

	//The jump is larger when we look at individuals born right around the cutoff as compared to all individuals. This means that individuals born later and earlier in the year might be different from those born right around the cutoff. One potential explanation is that children born in January are older than children born in June and therefore might have higher scores as a natural function of their age as opposed to the effects of preschool specifically. 

**Run a regression that accounts for differences in the slopes before and after the cutoff while also continuing to restrict our sample 

	eststo: reg wjtest01 i.cutoff c.age i.cutoff#c.age if age<30 & age>-30

**Using the previous regression, what is the effect of going to preschool on reading scores? 

	//Being allowed to enroll in preschool is associated with a  5.82 point increase in reading scores.	

**What is the interpretation of the coefficient on age and the coefficient on the interaction term. Use a graph to help you. 

	//For those born after September 1st, each additional day in age is assocaited with a .053 decrease in reading scores. For those born between January 1st and September 1st, each additional day in age is associated with a .1028 decrease in reading scores. 

**For the sake of argument, lets imagine you think age is non-linear and has different slops before and after the cutoff. Re-run the previous regression adding a squared term. 

	gen age_sq = age^2
	eststo: reg wjtest01 i.cutoff c.age c.age_sq i.cutoff#c.age i.cutoff#c.age_sq if age<30 & age>-30

**Using the previous regression, what is the effect of going to preschool on reading scores? 
	//being assigned to enroll in preschool is associated with a 5.83 point increase in reading scores. 
	
//Now let's now account for a fuzzy discontinuity. You will need to use one more variable lastyrpk which is coded as 1 if they did attend PreK and 0 if they did not. Use 2sls and make sure to restrict your sample to 30 days before and after. 
	//remember that the syntax for 2sls is 
	// ivregress 2sls y (D = cutoff ) RV-c controls , robust 

eststo: ivregress 2sls wjtest01 (lastyrpk = cutoff) c.age if age<30 & age>-30 , robust 

//Using the previous regression, what is the effect of going to preschool on reading scores? 

	//attending preschool results in a 5.91 point increase in reading scores for individuals that enrolled in preschool because they were born before the cutoff

//Finally make a table using esttab. Report the coefficient for the cutoff for each regression as well as the coefficient for lastyrpk for the fuzzy discontinuity. Report standard errors. 

esttab, se keep(1.cutoff lastyrpk) stats(N)
	
