** Discussion #7 .do file Student** 

clear all
set more off 

glob classpath "/Users/carsoncrenshaw/Library/CloudStorage/OneDrive-UniversityofVirginia/RMDA II/"
	cd "${classpath}" 
	
use "${classpath}prekTulsa.dta", clear

****************************************
***Variables of interest***

	** age = days from the birthday cutoff. negative values indicate days born after the cutoff, positive values indicate days born before the cutoff 
	** cutoff = treatment (1= born before cutoff, 0 = born after cutoff)
	** wjtest01 = woodcock-johnson letter-word identification score
	
****************************************
***Graphing and Collapsing***

	**To practice collapsing you data, collapse you data by birth state like we did in the previous discussion. Browse your data before and after collapsing
	
	
	**restore your data back to the orriginal form, and collapse by birth city
	
	
	
	**compare the two and write out a simplified answer of how the collapse command works
	
	**Run a twoway scatter plot of the RD, including lines of best fit before and after the cutoff 
	

**before moving on to regression analysis, return your data to its original form.
use "${classpath}prekTulsa.dta", clear

****************************************	
***Regression Interpretation***

**Run the most simple RD regression assuming that the slopes were the same before and after the cutoff. We will also assume this is a sharp discontinuity for simplicity.   
	* Equation = TestScore = alpha + delta(cutoff) + beta1(age)
	eststo: reg wjtest01 i.cutoff c.age
	*3.4 interpretation = cutoff variable, corresponds to the delta in a regression equation; 
	
**Using the previous regression, what is the effect of going to preschool on reading scores? 

	 
	
**Re-run this simple RD regression but restrict the sample to individuals born 30 days before and after the cutoff. 

		

**Using the previous regression, what is the effect of going to preschool on reading scores? 

	
	
**Is this regression on a restricted sample different from the previous regression? Why? What could be explaining this difference? 

	

**Run a regression that accounts for differences in the slopes before and after the cutoff while also continuing to restrict our sample 
	eststo: reg wjtest01 i.cutoff c.age i.cutoff#c.age if age<30 & age>-30
	

**Using the previous regression, what is the effect of going to preschool on reading scores? 

	

**What is the interpretation of the coefficient on age and the coefficient on the interaction term. Use a graph to help you. 



**For the sake of argument, lets imagine you think age is non-linear and has different slops before and after the cutoff. Re-run the previous regression adding a squared term. 

	

**Using the previous regression, what is the effect of going to preschool on reading scores? 
	
	
**Now let's now account for a fuzzy discontinuity. You will need to use one more variable lastyrpk which is coded as 1 if they did attend PreK and 0 if they did not. Use 2sls and make sure to restrict your sample to 30 days before and after. 
	//remember that the syntax for 2sls is 
	// ivregress 2sls y (D = cutoff ) RV-c controls , robust 

 

**Using the previous regression, what is the effect of going to preschool on reading scores? 

	
**Finally make a table using esttab. Report the coefficient for the cutoff for each regression as well as the coefficient for lastyrpk for the fuzzy discontinuity. Report standard errors. 


	
