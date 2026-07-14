clear
*--- STEP 1: prepare household file (cut to UP, keep needed columns)
use "/Users/babydoll/Documents/UP_informality_Project/data_clean/data1.dta", clear
keep if st == "09"
keep mfsu sss ssu sg hh_size relg hhtype
save "/Users/babydoll/Documents/UP_informality_Project/data_clean/hh_UP.dta", replace

*--- STEP 2: load person file
use "/Users/babydoll/Documents/UP_informality_Project/data_clean/person_UP.dta", clear

*--- STEP 3: merge household info into each person
merge m:1 mfsu sss ssu using "/Users/babydoll/Documents/UP_informality_Project/data_clean/hh_UP.dta"

*--- STEP 4: check the match
tab _merge

drop _merge
save "/Users/babydoll/Documents/UP_informality_Project/data_clean/person_UP_merged.dta", replace
log close
