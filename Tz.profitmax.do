cd "C:\Users\udry\Box\teaching\327\W2019\data\Tanzania panel\"
use Tanzania_panel.dta, clear
tab year

sum plot_s*

tab CropID

sort HHID plotID year

*br HHID plotID year slope soil_quality harvestv
tab irrigation_type
gen irrig = irrigation_type !=.
tab land_tenure1 land_tenure2
replace soil_quality=0 if soil_quality==.  //  new category  for missing

replace soil_type = 0 if soil_type ==.    //   missing


replace slope = 0 if slope ==.    //   missing





*br HHID plotID year gender_manager1 person_days child_days woman_days man_days total_labour lLabour loglabour_ha
 
*br HHID plotID year gender_manager1 ferto_expense ferti_expense agrochem_expense ferti_subsidy ferti_kg ferto_kg value_seed_purch


sum ferto_expense ferti_expense agrochem_expense ferti_subsidy ferti_kg ferto_kg value_seed_purch


reg loglabour_ha lLand

reg loglabour_ha lLand i.slope irrig dist_home dist_road dist_market i.soil_quality i.erosion i.soil_type

tab CropID
tab CropID, nolab

reg loglabour_ha lLand i.slope irrig dist_home dist_road dist_market i.soil_quality i.erosion i.soil_type if CropID==11



***
*Base specification
**
xtreg loglabour_ha lLand i.slope irrig dist_home dist_road dist_market i.soil_quality i.erosion i.soil_type if CropID==11, i(ycvID)
testparm i.slope i.soil_quality i.soil_type



***
** Now test for profit maximiation
***

*First, property rights
xtreg loglabour_ha lLand i.slope irrig dist_home dist_road dist_market i.soil_quality i.erosion i.soil_type i.land_tenure1 i.land_tenure2  if CropID==11, i(ycvID)
testparm i.land_tenure1 i.land_tenure2


*second, household demographics

xtreg loglabour_ha lLand i.slope irrig dist_home dist_road dist_market i.soil_quality i.erosion i.soil_type hh_members illness  if CropID==11, i(ycvID)
testparm hh_mem illness

