************************ Initial Setup ************************
cd /Users/naasirhaleem/Desktop/Econ_327/ps_2
cap log close
pause on
clear

********** Merge Gender and Age below 16 using Household Dataset B**************
tempfile ps_2
log using ps_2, replace
use "/Users/naasirhaleem/Desktop/Econ_327/data/dataset/hh_sec_b.dta"

rename hh_b04 age

gen teen_below = 4 if (age <= 16 & age >12)
replace teen_below = 3 if age <=12 & age > 8
replace teen_below = 2 if age <= 8 & age >4
replace teen_below = 1 if age <=4 & age >=0

label def teen_below 1 "Infant" 2 "Child" 3 "Pre-Teen" 4 "Teen" , replace
label val teen_below teen_below
label var teen_below "age distribution"

rename hh_b02 gender


keep y4_hhid indidy4 age gender teen_below

sort y4_hhid indidy4
save `ps_2', replace

******* Check Relation to Stunting Among 4 and Younger using Dataset NPSY Anthropometrics ********

 *use "/Users/naasirhaleem/Desktop/Econ_327/data/dataset/npsy4.child.anthro.dta"
 
 *keep y4_hhid indidy4 zwxa zhxa zwxh under stunt waste
 
 *merge 1:1 y4_hhid indidy4 using `ps_2'
 
 *keep if _merge==3
 
 *drop _merge
 
 *save `ps_2', replace
 
 *Note: There was no relation between stunting, wasting, etc. between genders from 0-4 age range, also had omit for future parts because it could not merge with rest of data
 
 ******* Literacy Rate of Boys and Girls using HH Dataset C**********
 
 . use "/Users/naasirhaleem/Desktop/Econ_327/ps_1/data/hh_sec_c.dta"
 
 keep y4_hhid indidy4 hh_c02 hh_c19 hh_c28_8
 

 
 rename hh_c02 literacy
 
 rename hh_c19 textbook
 
 rename hh_c28_8 total_educ
 
  
gen educ_cost = 1 if (total_educ > 0 & total_educ <=20000)
replace educ_cost = 2 if (total_educ >20000 & total_educ <= 40000)
replace educ_cost = 3 if (total_educ >40000 & total_educ <= 60000)
replace educ_cost = 4 if (total_educ >60000 & total_educ <= 80000)
replace educ_cost = 5 if (total_educ >80000 & total_educ <= 100000)

label def educ_cost 0 "None" 1 "1-20000" 2 "20000-40000" 3 "40000-60000" 4 "60000-80000" 5 "80000-100000" , replace
label val educ_cost educ_cost
label var educ_cost "Total Education Cost Per Individual (THS)"
 
 merge 1:1 y4_hhid indidy4 using `ps_2'
 
 keep if _merge==3
 
 drop _merge
 
  save `ps_2', replace
  
  
  *********** Check if any relation to poor using consumptionnps4 dataset ********
  

*use ../data/dataset/consumptionnps4.dta

**keep y4_hhid expmR adulteq mainland

*gen cons_ae_month = (expmR/adulteq)/12

 *Mainland == 1, Zanzibar == 2
*gen poor_basic = (cons_ae_month <= 45070 & mainland==1) | (cons_ae_month <= 53377 & mainland==2)


*label def poor_basic 0 "Not poor" 1 "Poor"
*label val poor_basic poor_basic
**label var poor_basic "National basic poverty line"


*merge 1:m y4_hhid using `ps_2'
 
 *keep if _merge==3
 
 *drop _merge
 
 *save `ps_2', replace

 *Note: Poor is checking by household so maybe not terribly useful (Did not use this analysis but keeping it here for best practices)
 
 *****Health using Dataset D*******
 
  use "/Users/naasirhaleem/Desktop/Econ_327/data/dataset/hh_sec_d.dta"
  
  keep y4_hhid indidy4 hh_d02 hh_d07 hh_d12_1 hh_d13 
  
  rename hh_d02 healthcare_visit
  
  rename hh_d07 illnesscost
  
  rename hh_d13 moneytreatment
  
  rename hh_d12_1 treatmentcause
  
   gen money_spent = 0 if moneytreatment ==0
replace money_spent = 1 if (moneytreatment > 0 & moneytreatment <=50000)
replace money_spent = 2 if (moneytreatment >50000 & moneytreatment <= 100000)
replace money_spent = 3 if (moneytreatment >100000 & moneytreatment <= 150000)
replace money_spent = 4 if (moneytreatment >150000 & moneytreatment <= 200000)
replace money_spent = 5 if (moneytreatment >200000 & moneytreatment <=8000000)


label def money_spent 0 "None" 1 "1-50000" 2 "50000-100000" 3 "100000-150000" 4 "150000-200000" 5 "200000-8000000" , replace
label val money_spent money_spent
label var money_spent "Hospitalization Cost in Last 12 Months(THS)"


 gen illmoney_spent = 1 if (illnesscost > 0 & illnesscost <=10000)
replace illmoney_spent = 2 if (illnesscost >10000 & illnesscost <= 20000)
replace illmoney_spent = 3 if (illnesscost >20000 & illnesscost <= 30000)
replace illmoney_spent = 4 if (illnesscost >30000 & illnesscost <= 40000)

label def illmoney_spent 0 "None" 1 "1-10000" 2 "10000-20000" 3 "20000-30000" 4 "30000-40000" , replace
label val illmoney_spent illmoney_spent
label var illmoney_spent "Healthcare Cost"

  
merge m:1 y4_hhid indidy4 using `ps_2'
  

keep if _merge==3
 
 drop _merge
 
  save `ps_2', replace
  
 
  
  ******** Analyzing Consumption Data ********
  
   use "/Users/naasirhaleem/Desktop/Econ_327/data/dataset/hh_sec_l.dta"
   
   keep y4_hhid hh_l02 itemcode
   
   foreach v of var hh_l02 {
	drop if missing(`v')
}

bys y4_hhid: egen garment_consump = total(hh_l02)
drop hh_l02
   
duplicates drop y4_hhid, force
   
    gen men_clothing = 0 if garment_consump ==0 & itemcode == 319
replace men_clothing = 1 if (garment_consump > 0 & garment_consump <=20000) & itemcode == 319
replace men_clothing = 2 if (garment_consump >20000 & garment_consump <= 40000) & itemcode == 319
replace men_clothing = 3 if (garment_consump >40000 & garment_consump <= 60000) & itemcode == 319
replace men_clothing = 4 if (garment_consump >60000 & garment_consump <= 80000) & itemcode == 319

label def men_clothing 0 "None" 1 "1-20000" 2 "20000-40000" 3 "40000-60000" 4 "60000-80000" , replace
label val men_clothing men_clothing
label var men_clothing "Mens Clothing Consumption"

gen women_clothing = 0 if garment_consump ==0 & itemcode == 320
replace women_clothing = 1 if (garment_consump > 0 & garment_consump <=20000) & itemcode == 320
replace women_clothing = 2 if (garment_consump >20000 & garment_consump <= 40000) & itemcode == 320
replace women_clothing = 3 if (garment_consump >40000 & garment_consump <= 60000) & itemcode == 320
replace women_clothing = 4 if (garment_consump >60000 & garment_consump <= 80000) & itemcode == 320

label def women_clothing 0 "None" 1 "1-20000" 2 "20000-40000" 3 "40000-60000" 4 "60000-80000" , replace
label val women_clothing women_clothing
label var women_clothing "Womens Clothing Consumption"


sort y4_hhid

merge 1:m y4_hhid using `ps_2'
  

keep if _merge==3
 
 drop _merge
 
  save `ps_2', replace
  
  *Note: There was in general less money spent on women's clothing than men's clothing, this was also the case when separating out boys from girls. We did not use this in our argument but it is still important and supports it.
  *Note Cont.: Did not use this analysis but felt it was important to still include in the do file

    
   
   
   
    ******** Age at death ********
  
 *use "/Users/naasirhaleem/Desktop/Econ_327/data/dataset/hh_sec_s.dta"

 *keep y4_hhid personid hh_s05 hh_s07_1 hh_s07_2
 *rename hh_s05 gender
 *rename hh_s07_1 ageatdeathyear
 *gen deathage = 1 if (ageatdeathyear >= 0 & ageatdeathyear <= 5)
 *replace deathage = 2 if (ageatdeathyear >5 & ageatdeathyear <= 10)
 *replace deathage = 3 if (ageatdeathyear >10 & ageatdeathyear <= 20)
 *replace deathage = 4 if (ageatdeathyear >20 & ageatdeathyear <= 40)
 *replace deathage = 5 if (ageatdeathyear > 40 & ageatdeathyear <= 60)
 *replace deathage = 6 if (ageatdeathyear > 60 & ageatdeathyear <= 80)
 *replace deathage = 7 if (ageatdeathyear > 80)



*Note: Significantly higher percentage of females dying before 5 - much less females living over 40 years 
*Note Cont.: Keeping this in green because it would erase the rest of the data
 
 
********** Analysis **********

**********Education***************
tab educ_cost gender

*Note: We can clearly see here that there is as much spent on girls as there is on boys, thus we have to look further

tab literacy gender

*Note: Initially we can see that there are significantly more illiterate women

******** Separate out because of drop *********
*drop if age > 16

tab literacy gender 

*Note: Now we can see that boys have higher rate of illiteracy thus we can rule out that girls are more illiterate than boys

*****************************************

******** Healthcare *********
tab money_spent gender

ttest money_spent, by(gender)
*Note: We can see here that taking overall hospitalizations into account men spend more on hospitalization payments than women, which does not necessarily show that girls are discriminated against regarding consumption of goods but women certainly are

*****Separate out because of drop************
*drop if age > 16 
tab treatmentcause gender 
*Note: By doing this we are able to see that males are hospitalized at a higher rate than women at younger ages. 
ttest money_spent, by(gender)
*Note: Taking the age drop into account we can see that girls are only hospitalized if they need expensive treatments
************************************************** 
 
 
 **********Death Rate***************************
 *tab deathage gender 
 
 *Note: Significantly higher percentage of females dying before 5 - much less females living over 40 years 
 
 *Final Analysis: We are able to conclude through the consumption of adult goods, specifically as they relate to healthcare, girls are discriminated against in Tanzania because they are hospitalized at a lower rate than boys. Girls will only be hospitalized if they need expensive treatment. Furthermore, as individuals in Tanzania exit the maternity stage the spending on men exceeds that of women. Finally, we can see that the mortality rate of girls in Tanzania also is higher than that of boys which may be due to the fact that they are hospitalized less at earlier ages.

