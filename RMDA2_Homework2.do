
*********************************************************************************		
/*	TITLE: 		RMDA2_Homework2.do								
*	PURPOSE:	Code written for the completion of RMDA Homework 2. 				
*	AUTHOR:		Carson Crenshaw												
*	CREATED:	02/21/2024																				
*/
*********************************************************************************

*********
*	1: Creating and Storing the New Dataset
*********

glob classpath "/Users/carsoncrenshaw/Library/CloudStorage/OneDrive-UniversityofVirginia/RMDA II/HW2/"
	cd "${classpath}" 
	
use "${classpath}basic.dta", clear

*Data from Washington, Ebonya L.. 2008. "Female Socialization: How Daughters Affect Their Legislator Fathers." American Economic Review, 98 (1): 311-32.

*Familiarizing myself with the data
*browse
codebook, compact

*Information regarding the paper
* Demonstrates that conditional on total number of children, each daughter increases a congressperson's propensity to vote liberally, particularly on reproductive rights issues. 
* Washington takes the sociological evidence of parental attitudinal shift on women's issues resulting from raising daughters (versus sons) to the political arena to ask whether parenting females increases a US representative's propensity to vote liberally on bills regarding women's issues. The answer is yes. Using congressional voting record scores compiled by the American Association of University Women (AAUW) and the National Organization of Women (NOW), she finds that, conditional on total children parented, each female child parented is associated with a score increase that is approximately one-quarter of the difference in score accounted for by a legislator's own gender. 

* Primary outcome variables:  Voting record scores constructed by interest groups and patterns of voting behavior from the entire roll call of votes in each of the four Congresses.
* Explanatory variable: AAUW, a score created by the American Association of University Women (AAUW). The legislator's score is equal to the proportion of these votes made in agreement with the AAUW.

*********
*	1: Report Summary Statistics
*********

*Table with Individual Political Parties Listed
*tabulate party, generate(party)
*rename party1 democrat
*label variable democrat "democrat"
*rename party2 republican
*label variable republican "republican"
*rename party3 independent
*label variable independent "independent"

*estimates clear
*global vars democrat republican independent age white female aauw totchi ngirls

*estpost ttest $vars, by(anygirls)
*ereturn list

*esttab, wide

*texdoc init table1, replace

*esttab using "${classpath}table1.tex", replace ///
  cells("mu_1(fmt(2)) mu_2(fmt(2))  b(fmt(2) star) p(fmt(4) par)") ///
  collabels("Without Girls" "With Girls" "Mean Difference" "P-Value" ) ///
  star(* 0.10 ** 0.05 *** 0.01) ///
  label booktabs nonum gaps noobs compress ///
  scalars("Sample_Size") sfmt(0)

*Table with the Republican Political Party Listed
estimates clear
global vars repub age white female aauw totchi ngirls

estpost ttest $vars, by(anygirls)
ereturn list

esttab, wide

texdoc init table1, replace

esttab using "${classpath}table1.tex", replace ///
  cells("mu_1(fmt(2)) mu_2(fmt(2))  b(fmt(2) star) p(fmt(4) par)") ///
  collabels("Without Girls" "With Girls" "Mean Difference" "P-Value" ) ///
  star(* 0.10 ** 0.05 *** 0.01) ///
  label booktabs nonum gaps noobs compress ///
  scalars("Sample_Size") sfmt(0)
  
 **Added sample sizes via Overleaf, need to revisit to figure out how to do it via Stata

 
*********
*	4: Comparing the AAUW score between legislators with girls and legislators with no girls
*********

*b. 
summarize aauw if anygirls == 1
summarize aauw if anygirls == 0 
display 46.93473 - 51.72267
 
*d. regress Y on X
regress aauw anygirls
 
 
*********
*	5: Adding Confounders
*********

*a. 
* aauw = alpha0 + alpha1(anygirl) + e
* aauw = beta0 + beta1(anygirl) + beta2(totchi) + e
* aauw = lambda0 + lambda1(anygirl) + lambda2(totchi) + lambda3(female) + lambda4(repub) + e

est clear
eststo: regress aauw anygirls
eststo: regress aauw anygirls totchi
eststo: regress aauw anygirls totchi female repub
esttab

*b. Controlling for the Republican variable is not an issue here. This variable is a necessary control that is correlated with legislative voting behavior and the explanatory variable of focus. Additionally, the regression results match what one would expect from the AAUW scores. As described by Washington, for the 105th Congress the AAUW had a mean of 86 for Democrats and 12 for Republicans. 

*c. As seen through the difference between the coefficients on anygirls, without the inclusion of the total children variable, the true effect of daughters on the AAUW was understated. To resolve this, the total children variable was pulled out of the error term of equation 1 in order to capture more of the true causal effect. The objective of this action was to reduce the correlation between D (female children) and the error term. 

*d. The use of only one variable cannot account for all of reality. There are potentially many other factors that could affect the relationship between having daughters and voting. By not accounting for these components, one might draw incorrect conclusions. Instead, adding the number of total children to the equation helps reveal the truth. 
*Character Count: 340 (less than 1000)

*e. While the change from equation 2 to equation 3 demonstrates an overestimate of the true causal effect within the former equation, my qualitative conclusion remains largely the same: as more variables are added to the regression, the variation within the error term is reduced and the analysis moves closer to capturing what occurs in reality. The totchi variable is particularly significant within the context of these equations because of its weight over the anygirl coefficient: when totchi is not in the model, the marginal effect of having a daughter (all other things constant) is negative and indicates that not having daughters leads to a higher aauw score. 

*f. Conditional on the number of children and other variables, anygirls could possibly be exogenous. This is because the sex of children is randomly assigned. The identifying assumption necessary for anygirl to be interpreted as a causal estimate would be the exclusion restriction (the instrument should only affect the outcome through the treatment, or the instrument should be randomly assigned). Washington writes extensively on how the number of female children is a random variable within the section of her paper titled "Identifying Assumptions." This section defends this assumption by refuting the claim that representatives could follow a fertility stopping rule to essentially choose the sex of their children.  

*********
*	6: Nonlinear Regressions/Regressions with Interaction Terms
*********
gen age2 = age*age
gen whitefemale = white*female
gen anygirlsfemale = anygirls*female

est clear
eststo: regress aauw anygirls totchi female age age2
eststo: regress aauw anygirls totchi female white whitefemale
eststo: regress aauw anygirls totchi female anygirlsfemale
esttab

*a. In order to isolate the relationship between age and aauw, one must take the derivative of the regression equation with respect to age. Once that has been done, you are left with the equation 2.768 + -0.0414age. Setting this equation equal to zero, the slope of this curve is zero at an age of 66.9. In order to find whether this age is a maximum or minimum, the second derivative is taken. As the second derivative is negative, it indicates a local maximum point. All together, a congressperson's aauw score will increase with age up until 66.9 years, in which the aauw score will start to decrease. 

*b. The marginal effect of being white for non-females relative to non-white is -44.48, holding all else constant. This is found by taking the derivative of the second equation with respect to the variable white. 

*c. The marginal effect of being female for a white person relative to non-females is 25.589, holding all else constant. This is found by taking the derivative of the second equation with respect to the variable female.
 
*d. The predicted aauw scores for a male who has a daughter, as well as the average number of children that male legislators have, is approximately 46 (46% of votes align with the AAUW). 
*aauw = 55.36 + 6.240anygirls +  -6.155totchi +  24.71female +  5.451anygirlfemale 
*aauw = 55.36 + 6.240(1) +  -6.155(2.5) +  24.71(0) +  5.451(0) 
*aauw = 46.21

*e. The difference in the effect of having a girl between men and women is 5.451, holding all other variables constant. In other words, congresswomen have an average aauw score 5.451 percentage points higher than men. This means that the effect of having a daughter is stronger for female legislators and pulls them more liberal. 
*[WOMEN] daauw/danygirls = aauw = 6.240 +  5.451female = 11.691
*[MEN] daauw/danygirls = aauw = 6.240 +  5.451female(0) = 6.240 
















 
 

