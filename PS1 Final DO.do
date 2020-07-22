************************ Initial Setup ************************
cd /Users/mcguo/Documents/michael-guo/senior/winter/econ_327/PS_1
cap log close
pause on
clear

************************ Consumption nps4 import ************************
tempfile ps_1
log using ps_1, replace
use ../data/dataset/consumptionnps4.dta

keep y4_hhid expmR adulteq mainland

gen cons_ae_month = (expmR/adulteq)/12


* Mainland == 1, Zanzibar == 2
gen poor_food = (cons_ae_month <= 32225 & mainland==1) | (cons_ae_month <= 38071 & mainland==2)
gen poor_basic = (cons_ae_month <= 45070 & mainland==1) | (cons_ae_month <= 53377 & mainland==2)
gen poor_int = (cons_ae_month <= 56338)

label def poor_basic 0 "Not poor" 1 "Poor"
label val poor_basic poor_basic
label var poor_basic "National basic poverty line"

label def poor_food 0 "Not poor" 1 "Poor"
label val poor_food poor_food
label var poor_food "National basic food poverty line"

label def poor_int 0 "Not poor" 1 "Poor"
label val poor_int poor_int
label var poor_int "Global poverty line (1 USD per day)"

tab poor_basic

sort y4_hhid
save `ps_1', replace


************************ Food Security Data Import ************************

use ../data/dataset/hh_sec_h.dta, clear

keep y4_hhid hh_h01 hh_h03_1

rename hh_h01 food_worry_7

rename hh_h03_1 meals_per_day

merge 1:1 y4_hhid using `ps_1'
keep if _merge==3
drop _merge

save `ps_1',replace


************************ Education Data Import ************************
use ../data/dataset/hh_sec_c.dta, clear
keep y4_hhid indidy4 hh_c03  hh_c05 hh_c07
rename hh_c03 attend_school
rename hh_c05 curr_in_school
rename hh_c07 years_edu
merge m:1 y4_hhid using `ps_1'
keep if _merge==3
drop _merge

save `ps_1',replace

************************ Subjective Welfare Data Import ************************

use ../data/dataset/hh_sec_g.dta, clear
keep y4_hhid indidy4 hh_g04 hh_g03_5 hh_g03_6 hh_g03_8
rename hh_g04 curr_financial
rename hh_g03_5 contentment_healthcare
rename hh_g03_6 contentment_edu
rename hh_g03_8 contentment_life
merge 1:1 y4_hhid indidy4 using `ps_1'
keep if _merge==3
drop _merge

save `ps_1', replace

************************ House Data Import ************************

use ../data/dataset/hh_sec_i.dta, clear
keep y4_hhid hh_i03 hh_i35
rename hh_i03 rent
rename hh_i35 source_water
merge 1:m y4_hhid using `ps_1'

keep if _merge==3
drop _merge
save`ps_1',replace

************************ Udry Data Import ************************


use ../data/dataset/hh_sec_d, clear
keep y4_hhid indidy4 hh_d31 hh_d42 hh_d43

merge m:1 y4_hhid indidy4 using `ps_1'
keep if _merge==3
drop _merge
save`ps_1',replace
************************ Food Consumption 1 week Data Import ************************

use ../data/dataset/hh_sec_j1.dta, clear

keep y4_hhid hh_j04


* We want to use best practices and not implement a many to many merge
foreach v of var hh_j04 {
	drop if missing(`v')
}

* We aggregate the amount of spendings for each unique y4_hhid
bys y4_hhid: egen spendings_per_week = total(hh_j04)
drop hh_j04

* We then drop duplicate y4_hhid values
duplicates drop y4_hhid, force

* Now we can do a 1:m merge
merge 1:m y4_hhid using `ps_1'
keep if _merge==3
drop _merge

save `ps_1',replace

************************ End of Setup ************************

**********             Initial Analysis      **********

tab poor_food
tab poor_basic
tab poor_int

* We decided to use poor_basic as a metric for the poverty line because ... results.

**********     Beginning of education Section     **********

sort y4_hhid

tabulate attend_school

* This output has too many distinct variables for us to clearly understand a relationship
tabulate years_edu

**********     Consolidating education information categorically     **********
gen highest_educ_level = 0 if attend_school == 2
replace highest_educ_level = 2 if years_edu >=11 & years_edu <=20
replace highest_educ_level = 3 if years_edu >=21 & years_edu <=34
replace highest_educ_level = 4 if years_edu >=41 & years_edu <=45
replace highest_educ_level = 1 if curr_in_school == 1

label def highest_educ_level 0 "No education" 1 "Still in school" 2 "Primary" 3 "Secondary" 4 "University" , replace
label val highest_educ_level highest_educ_level
label var highest_educ_level "Highest education level attained"

**********     End of education modification     **********

* Looking at education level attainment between poor and non-poor in Tanzania
tabulate highest_educ_level poor_basic
* We see that porportionally, it is much more likely for a poor person in tanzania to have no education

**********     Beginning of food Section     **********

* Next, we will be looking at the food consumption data inside the household survey

tabulate meals_per_day poor_basic

* The results looked concerning, because not poor people are consuming 0 meals a day
* Thus, we have to integrate outside of household consumption

gen spending_per_day = spendings_per_week/(7*adulteq)

**********     Modifying spending information categorically     **********
gen adjusted_spending_per_day = 0
replace adjusted_spending_per_day = 1 if spending_per_day > 0 & spending_per_day <= 250
replace adjusted_spending_per_day = 2 if spending_per_day > 250 & spending_per_day <= 500
replace adjusted_spending_per_day = 3 if spending_per_day > 500 & spending_per_day <= 750
replace adjusted_spending_per_day = 4 if spending_per_day > 750 & spending_per_day <= 1000
replace adjusted_spending_per_day = 5 if spending_per_day > 1000 & spending_per_day <= 1250
replace adjusted_spending_per_day = 6 if spending_per_day > 1250 & spending_per_day <= 2000
replace adjusted_spending_per_day = 7 if spending_per_day > 2000

label def adjusted_spending_per_day 0 "No spending" 1 "<= 250 THS" 2 "250 to 500 THS" 3 "500 to 750 THS" 4 "750 to 1000 THS" 5 " 1000 to 1250 THS" 6 "1250 to 2000 THS" 7 "> 2000 THS", replace
label val adjusted_spending_per_day adjusted_spending_per_day
label var adjusted_spending_per_day "Spendings per day on food"

tab adjusted_spending_per_day poor_basic

**********     End of spending modification     **********

tab adjusted_spending_per_day curr_financial

clear all
log close
