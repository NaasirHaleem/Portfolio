************************ Initial Setup ************************
cd /Users/naasirhaleem/Desktop/Econ_327/ps_2
cap log close
pause on
clear
**************************************************************

***Merge Panel Data Across Years***
 tempfile ps_3
log using ps_3, replace
 use "/Users/naasirhaleem/Desktop/Econ_327/data/Tanzania 2012 NPS3/NPSY3.PANEL.KEY.dta"
 
 rename y1_hhid hhid
 
 keep hhid 
 
 save `ps_3', replace
*******Merge SEC E Satisfaction******


 use "/Users/naasirhaleem/Desktop/Econ_327/data/Tanzania 2008 NPS1/SEC_B_C_D_E1_F_G1_U.dta"
 
 keep hhid seq49_1
 foreach v of var seq49_1 {
	drop if missing(`v')
}

bys hhid: egen sathealth = total(seq49_1)
drop seq49_1
   
duplicates drop hhid, force

 
 
 sort hhid
 
 merge 1:m hhid using `ps_3' 
 keep if _merge==3
drop _merge
 save `ps_3', replace
 
 ***************************
 
 //Generating Poor vs. Not Poor for Year 1



 use "/Users/naasirhaleem/Desktop/Econ_327/data/Tanzania 2008 NPS1/TZY1.HH.Consumption.dta"

keep hhid expmR adulteq urban 

gen cons_ae_month = (expmR/adulteq)/12


*  Rural == 1, Urban == 2
gen poor_basicy1 = (cons_ae_month <=29500 & urban==1) | (cons_ae_month <=40000 & urban==2) 

label def poor_basicy1 0 "Not poor" 1 "Poor" , replace 
label val poor_basicy1 poor_basicy1
label var poor_basicy1 "National basic poverty line"



merge 1:m hhid using `ps_3'
keep if _merge==3
drop _merge

save `ps_3', replace

**********************

*Generate Poor vs. Not Poor Year 2





 use "/Users/naasirhaleem/Desktop/Econ_327/data/Tanzania 2010 NPS2/TZY1.HH.Consumption.dta"

keep hhid expmR adulteq urban 

gen cons_ae_month = (expmR/adulteq)/12


*  Rural == 1, Urban == 2
gen poor_basicy2 = (cons_ae_month <=29500 & urban==1) | (cons_ae_month <=40000 & urban==2) 

label def poor_basicy2 0 "Not Poor" 1 "Poor" , replace
label val poor_basicy2 poor_basicy2
label var poor_basicy2 "National basic poverty line"



merge 1:m hhid using `ps_3'
keep if _merge==3
drop _merge

save `ps_3', replace

*********************

* Merge Sec D Data 2008


 use "/Users/naasirhaleem/Desktop/Econ_327/data/Tanzania 2008 NPS1/SEC_B_C_D_E1_F_G1_U.dta"
 
 foreach v of var sdq5 {
	drop if missing(`v')
}

bys hhid: egen illness_spend = total(sdq5)
drop sdq5
   
duplicates drop hhid, force
***
foreach v of var sdq6 {
	drop if missing(`v')
}

bys hhid: egen prevent_spend = total(sdq6)
drop sdq6
   
duplicates drop hhid, force
****
foreach v of var sdq7 {
	drop if missing(`v')
}

bys hhid: egen med_spend = total(sdq7)
drop sdq7
   
duplicates drop hhid, force
*****

rename sdq30 vaccinated

gen illnesscost = 1 if (illness_spend > 0 & illness_spend <=20000)
replace illnesscost = 2 if (illness_spend >20000 & illness_spend <= 40000)
replace illnesscost = 3 if (illness_spend >40000 & illness_spend <= 60000)
replace illnesscost = 4 if (illness_spend >60000 & illness_spend <= 80000)
replace illnesscost = 5 if (illness_spend >80000 & illness_spend <= 100000)

label def illnesscost 0 "None" 1 "1-20000" 2 "20000-40000" 3 "40000-60000" 4 "60000-80000" 5 "80000-100000" , replace
label val illnesscost illnesscost
label var illnesscost "Total Illness Cost Per Individual (THS)"

 keep hhid illness_spend prevent_spend med_spend vaccinated illnesscost
 

 
merge 1:1 hhid using `ps_3'
keep if _merge==3
drop _merge
 
 save `ps_3', replace
 
 ********* Merge SEC D Data 2010 *******




 
 
 ********* SEC R Data Merge ********
 
  use "/Users/naasirhaleem/Desktop/Econ_327/data/Tanzania 2008 NPS1/SEC_R.dta"
 *** 
  foreach v of var srq2 {
	drop if missing(`v')
}

bys hhid: egen sacrifice = total(srq2)
drop srq2
   
duplicates drop hhid, force
****

foreach v of var srq3 {
	drop if missing(`v')
}

bys hhid: egen shockcost = total(srq3)
drop srq3
   
duplicates drop hhid, force
*****

  
  rename srcode shocks
  
 
  
  gen agrshock = (shocks==101) | (shocks==102) | (shocks==103) | (shocks==106) | (shocks==107) | (shocks==109) | (shocks==110) 
label def agrshock 0 "No" 1 "Yes" , replace
label val agrshock agrshock
label var agrshock "Agricultural Shock in Past 5 years?"

  gen nonagrshock = (shocks==104) | (shocks==105) | (shocks==107)  
  
  label def nonagrshock 0 "No" 1 "Yes" , replace
label val nonagrshock nonagrshock
label var nonagrshock "Non-Agricultural Shock in Past 5 years?"
 
 gen familyshock = (shocks==111) | (shocks==112) | (shocks==113) | (shocks==114)
 
  label def familyshock 0 "No" 1 "Yes" , replace
label val familyshock familyshock
label var familyshock "Family Related Shock in Past 5 years?"
  
  keep hhid shocks shockcost sacrifice agrshock nonagrshock familyshock
 
merge 1:m hhid using `ps_3'
keep if _merge==3
drop _merge
 save `ps_3', replace
 
 
 
 
 ********************************************************************************
* PART II: Violence Against Women for Year 2008
******************************+*************************************************

 use "/Users/naasirhaleem/Desktop/Econ_327/data/Tanzania 2008 NPS1/SEC_I.dta",clear

//Opinion towards domestic violence 


//Opinion towards domestic violence 
replace siq1=1
rename siq1 women_in_hh



//Separating justification for violence into two groups
replace siq2a=0 if siq2a==2
replace siq2b=0 if siq2b==2
replace siq2c=0 if siq2c==2
replace siq2d=0 if siq2d==2
replace siq2e=0 if siq2e==2
replace siq2f=0 if siq2f==2
replace siq2g=0 if siq2g==2
replace siq2h=0 if siq2h==2

	//Internal reasons
gen internal_yes = 1 if siq2a==1 | siq2b==1 | siq2c==1 | siq2d==1
replace internal_yes =0 if siq2a==0 & siq2b==0 & siq2c==0 & siq2d==0
gen percent_internal_yes2 = (siq2a+siq2b+siq2c+siq2d)/4

	//External reasons
gen external_yes = 1 if siq2e==1 | siq2f==1 | siq2g==1 | siq2h==1
replace external_yes =0 if siq2e==0 & siq2f==0 & siq2g==0 & siq2h==0
gen percent_external_yes2 = (siq2e+siq2f+siq2g+siq2h)/4


//Amount of domestic violence

	//Slapped or thrown something at
replace siq4a=0 if siq4a==2
replace siq5a=0 if siq5a==.

	//Pushed or shoved
replace siq4b=0 if siq4b==2
replace siq5b=0 if siq5b==.
	
	//Hit
replace siq4c=0 if siq4c==2
replace siq5c=0 if siq5c==.
	
	//Kicked, dragged, or beaten
replace siq4d=0 if siq4d==2
replace siq5d=0 if siq5d==.
	
	//Choked or burnt
replace siq4e=0 if siq4e==2
replace siq5e=0 if siq5e==.
	
	//Threatened to use weapon against
replace siq4f=0 if siq4f==2
replace siq5f=0 if siq5f==.
	
	//Forced sexual intercourse
replace siq4g=0 if siq4g==2
replace siq5g=0 if siq5g==.
	
	//Forced sexual intercourse 2
replace siq4h=0 if siq4h==2
replace siq5h=0 if siq5h==.

collapse (sum) women_in_hh internal_yes external_yes percent_internal_yes2 percent_external_yes2 siq4a siq5a siq4b siq5b siq4c siq5c siq4d siq5d siq4e siq5e siq4f siq5f siq4g siq5g siq4h siq5h, by (hhid)

//Generating percentage of women who say "yes" to at least one reason to violence 
//and percentage of women who've experienced violence in each household at least once
gen percent_internal_yes = (internal_yes/women_in_hh)
gen percent_external_yes = (external_yes/women_in_hh)
gen percent_slap = (siq4a/women_in_hh)
gen percent_push = (siq4b/women_in_hh)
gen percent_hit = (siq4c/women_in_hh)
gen percent_kick = (siq4d/women_in_hh)
gen percent_choke = (siq4e/women_in_hh)
gen percent_threat = (siq4f/women_in_hh)
gen percent_force = (siq4g/women_in_hh)
gen percent_force2 = (siq4h/women_in_hh)

//Generating avg. percentage of "yes" to reasons to violence and avg. frequency
//of violence for women in each household
gen avg_percent_internal_yes = (percent_internal_yes2/women_in_hh)
gen avg_percent_external_yes = (percent_external_yes2/women_in_hh)
gen avg_slap = (siq5a/women_in_hh)
gen avg_push = (siq5b/women_in_hh)
gen avg_hit = (siq5c/women_in_hh)
gen avg_kick = (siq5d/women_in_hh)
gen avg_choke = (siq5e/women_in_hh)
gen avg_threat = (siq5f/women_in_hh)
gen avg_force = (siq5g/women_in_hh)
gen avg_force2 = (siq5h/women_in_hh)



drop siq4a siq4b siq4c siq4d siq4e siq4f siq4g siq4h siq5a siq5b siq5c siq5d siq5e siq5f siq5g siq5h


merge 1:m hhid using `ps_3'
keep if _merge==3
drop _merge
 save `ps_3', replace





//Investingating correlation between poor/non-poor and justification of violence (at least one yes)
	//Internal reasons
sum percent_internal_yes if poor_basicy1==1
sum percent_internal_yes if poor_basicy1==0
ttest percent_internal_yes, by (poor_basicy1)

	//External reasons
sum percent_external_yes if poor_basicy1==1
sum percent_external_yes if poor_basicy1==0
ttest percent_external_yes, by (poor_basicy1)

//Investingating correlation between poor/non-poor and justification of violence (percentage of yes)
	//Internal reasons
sum avg_percent_internal_yes if poor_basicy1==1
sum avg_percent_internal_yes if poor_basicy1==0
ttest avg_percent_internal_yes, by (poor_basicy1)

	//External reasons
sum avg_percent_external_yes if poor_basicy1==1
sum avg_percent_external_yes if poor_basicy1==0
ttest avg_percent_external_yes, by (poor_basicy1)



//Investigating correlation between poor/nonp-poor and violence (occured at least once)

	//Slapped or thrown something at
sum percent_slap if poor_basicy1==1
sum percent_slap if poor_basicy1==0
ttest percent_slap, by (poor_basicy1)

	//Pushed or shoved
sum percent_push if poor_basicy1==1
sum percent_push if poor_basicy1==0
ttest percent_push, by (poor_basicy1)

	//Hit
sum percent_hit if poor_basicy1==1
sum percent_hit if poor_basicy1==0
ttest percent_hit, by (poor_basicy1)

	//Kicked, dragged, or beaten
sum percent_kick if poor_basicy1==1
sum percent_kick if poor_basicy1==0
ttest percent_kick, by (poor_basicy1)

	//Choked or burnt
sum percent_choke if poor_basicy1==1
sum percent_choke if poor_basicy1==0
ttest percent_choke, by (poor_basicy1)

	//Threatened to use weapon against
sum percent_threat if poor_basicy1==1
sum percent_threat if poor_basicy1==0
ttest percent_threat, by (poor_basicy1)

	//Forced sexual intercourse
sum percent_force if poor_basicy1==1
sum percent_force if poor_basicy1==0
ttest percent_force, by (poor_basicy1)

	//Forced sexual intercourse 2
sum percent_force2 if poor_basicy1==1
sum percent_force2 if poor_basicy1==0
ttest percent_force2, by (poor_basicy1)


//Investigating correlation between poor/nonp-poor and violence (frequency of occurrence)

	//Slapped or thrown something at
sum avg_slap if poor_basicy1==1
sum avg_slap if poor_basicy1==0
ttest avg_slap, by (poor_basicy1)

	//Pushed or shoved
sum avg_push if poor_basicy1==1
sum avg_push if poor_basicy1==0
ttest avg_push, by (poor_basicy1)

	//Hit
sum avg_hit if poor_basicy1==1
sum avg_hit if poor_basicy1==0
ttest avg_hit, by (poor_basicy1)

	//Kicked, dragged, or beaten
sum avg_kick if poor_basicy1==1
sum avg_kick if poor_basicy1==0
ttest avg_kick, by (poor_basicy1)

	//Choked or burnt
sum avg_choke if poor_basicy1==1
sum avg_choke if poor_basicy1==0
ttest avg_choke, by (poor_basicy1)

	//Threatened to use weapon against
sum avg_threat if poor_basicy1==1
sum avg_threat if poor_basicy1==0
ttest avg_threat, by (poor_basicy1)

	//Forced sexual intercourse
sum avg_force if poor_basicy1==1
sum avg_force if poor_basicy1==0
ttest avg_force, by (poor_basicy1)

	//Forced sexual intercourse 2
sum avg_force2 if poor_basicy1==1
sum avg_force2 if poor_basicy1==0
ttest avg_force2, by (poor_basicy1)

*No data on violence for year 2010 or year 2012



 
 
 
 
