 use "/Users/naasirhaleem/Desktop/Econ_327/Tanzania farm panel/Tanzania_panel.dta"
 * Gen Shocks
 * We do this in order to establish a variable that we know will remain significant regardless of whatever else is added into regression
 gen envshock=1 if drought_floods==1 | crop_disease==1 | livestock_death==1 | food_prices==1 | input_costs==1 | water_shortage==1
 replace envshock=0 if drought_floods==0 | crop_disease==0 | livestock_death==0 | food_prices==0 | input_costs==0 | water_shortage==0
 *Gen Education Years for Manager1 and Manager2
 *We did this to establish a possible relation between education years and maximizing profits. Since Manager2 was typically a woman we can assume that if there is a Manager1 and a Manager2 then they're a married couple
gen years_education = 1
replace years_education = 0 if schooling1 == .
replace years_education = 0 if schooling1 == 1
replace years_education = 0 if schooling1 == 2
replace years_education = 1 if schooling1 == 11
replace years_education = 2 if schooling1 == 12
replace years_education = 3 if schooling1 == 13
replace years_education = 4 if schooling1 == 14
replace years_education = 5 if schooling1 == 15
replace years_education = 6 if schooling1 == 16
replace years_education = 7 if schooling1 == 17
replace years_education = 8 if schooling1 == 18
replace years_education = 9 if schooling1 == 21
replace years_education = 10 if schooling1 == 22
replace years_education = 11 if schooling1 == 23
replace years_education = 12 if schooling1 == 24
replace years_education = 13 if schooling1 == 25
replace years_education = 14 if schooling1 == 31
replace years_education = 15 if schooling1 == 32
replace years_education = 16 if schooling1 == 41
replace years_education = 17 if schooling1 == 42
replace years_education = 18 if schooling1 == 43
replace years_education = 19 if schooling1 == 44
replace years_education = 20 if schooling1 == 45


gen years_education2 = 1
replace years_education2 = 0 if schooling2 == .
replace years_education2 = 0 if schooling2 == 1
replace years_education2 = 0 if schooling2 == 2
replace years_education2 = 1 if schooling2 == 11
replace years_education2 = 2 if schooling2 == 12
replace years_education2 = 3 if schooling2 == 13
replace years_education2 = 4 if schooling2 == 14
replace years_education2 = 5 if schooling2 == 15
replace years_education2 = 6 if schooling2 == 16
replace years_education2 = 7 if schooling2 == 17
replace years_education2 = 8 if schooling2 == 18
replace years_education2 = 9 if schooling2 == 21
replace years_education2 = 10 if schooling2 == 22
replace years_education2 = 11 if schooling2 == 23
replace years_education2 = 12 if schooling2 == 24
replace years_education2 = 13 if schooling2 == 25
replace years_education2 = 14 if schooling2 == 31
replace years_education2 = 15 if schooling2 == 32
replace years_education2 = 16 if schooling2 == 41
replace years_education2 = 17 if schooling2 == 42
replace years_education2 = 18 if schooling2 == 43
replace years_education2 = 19 if schooling2 == 44
replace years_education2 = 20 if schooling2 == 45

* schooling1 non_agri_business envshock age harvestvnet
*xtreg
* Regressing Net Harvest Value tells us the harvest value minus cost of seeds and fertilizer. Important when telling us about efficiency.
xtreg harvestvnet non_agri_business envshock years_education years_education2 m1_age m2_age rural plot_size_ha anntot, i(ycvID)
xtreg harvestvnet non_agri_business envshock years_education years_education2 m1_age m2_age rural plot_size_ha anntot if CropID==11 | Crop2ID==21 | Crop2ID==12 | CropID==21 | CropID== 12| Crop2ID==11   , i(ycvID)
*Regressing Average Harvest Value by Hectare enables us to determine the profitability of each plot. We can tell that plots with high average values maximize profits.
xtreg lYva_ha non_agri_business envshock years_education years_education2 m1_age m2_age rural plot_size_ha anntot, i(ycvID)
xtreg harvestv_ha non_agri_business envshock years_education years_education2 m1_age m2_age rural plot_size_ha anntot if CropID==11 | Crop2ID==21 | Crop2ID==12 | CropID==21 | CropID== 12| Crop2ID==11, i(ycvID)
xtreg years_education rural urban non_agri_business welfare, i(ycvID)
xtreg harvestv_ha rural urban non_agri_business welfare years_education years_education2, i(ycvID)
xtreg harvestvnet rural urban non_agri_business welfare years_education years_education2, i(ycvID)

* Graphing Harvest Average Value by Hectare against Years of Education for Person 2
* Can clearly see how important being educated is to maximizing profits
graph twoway (lfit harvestv_ha years_education2) (scatter harvestv_ha years_education2)

*Tab of Gender Differences among Managers
 tab gender_manager2
 tab gender_manager1


 
