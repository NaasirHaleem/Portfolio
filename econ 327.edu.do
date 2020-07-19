cd "X:\Box\teaching\327\W2019\data\Ghana Panel\Wave 2\"
clear
use 01d_background.dta
merge 1:1 FP hhmid using 01fi_generaleducation
drop _merge
merge 1:1 FP hhmid using 01fiii_literacy
drop _merge

merge 1:1 FP hhmid using 01ei_employmentmain
drop _merge
gen edyears= 0
replace edyears=1 if highestgrade == 1
replace edyears=2 if highestgrade == 2
replace edyears=3 if highestgrade == 12
replace edyears=4 if highestgrade == 13
replace edyears=5 if highestgrade == 14



replace edyears=6 if highestgrade == 15
replace edyears=7 if highestgrade == 16
replace edyears=8 if highestgrade == 17
replace edyears=9 if highestgrade == 18
replace edyears=10 if highestgrade == 19
replace edyears=6 if highestgrade == 20
replace edyears=7 if highestgrade == 21
replace edyears=8 if highestgrade == 22
replace edyears= 9 if highestgrade == 23
replace edyears= 11 if highestgrade == 24
replace edyears= 12 if highestgrade == 25
replace edyears= 13 if highestgrade == 26
replace edyears= 9 if highestgrade == 27
replace edyears= 10 if highestgrade == 28
replace edyears= 11 if highestgrade == 29
replace edyears= 12 if highestgrade == 30
replace edyears= 13 if highestgrade == 31
replace edyears= 14 if highestgrade == 32
replace edyears= 16 if highestgrade == 95

gen monthlypay = paidamount *30 if paidperiod ==1

replace monthlypay = paidamount *4 if paidperiod ==2
replace monthlypay = paidamount if paidperiod==3
replace monthlypay = paidamount /4 if paidperiod ==4
replace monthlypay = . if paidperiod ==5
replace monthlypay = paidamount /12 if paidperiod ==6



gen lnpay=ln(monthlypay )
reg lnpay edyears age

gen job = paid==1
reg job edyears age


gen nofathered=fathereduc == 0
gen nomothered=mothereduc  == 0
gen male=gender==1
gen inschool=attendingstill ==1

gen nevermarried=maritalstatus ==6|maritalstatus ==7
gen ethnicgroup=floor(real(ethnicity))

gen dadfarmer = fatherwork ==36|fatherwork ==38
gen momfarmer = motherwork ==36|motherwork ==38

gen rc = real(whereborn_rcode )

reg job edyears age
 reg job edyears age nofathered nomothered male inschool nevermarried i.ethnicgroup i.rc momfarmer dadfarmer
 
   reg lnpay edyears age 
  reg lnpay edyears age nofathered nomothered male inschool nevermarried i.ethnicgroup i.rc momfarmer dadfarmer

