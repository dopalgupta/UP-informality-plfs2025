clear
use "/Users/babydoll/Documents/UP_informality_Project/data_clean/person_UP_merged.dta"

tab pas

gen employed = inlist(pas, "11", "12", "21", "31", "41", "51")
tab pas employed
gen wt = mult/100
mean employed [iw=wt] if age>=15
gen employed_all = inlist(pas, "11", "12", "21", "31", "41", "51") | inlist(sas, "11", "12", "21", "31", "41", "51")
tab employed employed_all
tab sas if employed == 0 & employed_all == 1
mean employed_all [iw=wt] if age>=15

gen urban = (sec == "2")
tab sec urban

tab sg
gen sgroup = real(sg) //this is used here bcz we are changing label name.
label define groupnames 1 "ST" 2 "SC" 3 "OBS" 9 "OTHERS" 
label values sgroup groupnames
tab sgroup

label define groupnames 3 "OBC", modify
tab sgroup

tab gedu_lvl
describe gedu_lvl   //string type
gen no_school = inlist(gedu_lvl, "01","02", "03", "04")
gen primary_bp = inlist(gedu_lvl, "05", "06")
gen middle_sec = inlist(gedu_lvl, "07", "08")
gen higher_sec = inlist(gedu_lvl, "10", "11")
gen grad = inlist(gedu_lvl, "12", "13")
gen check = no_school + primary_bp + middle_sec + higher_sec + grad
tab check

tab job_pas //type of job contract
tab ssec_pas //type of  //cat-9 is for self employed
tab etyp_pas //for self-employed workers

//the informality variable
gen informal = .
replace informal = inlist(job_pas, "1") | inlist(ssec_pas, "8") if inlist(pas, "31","41","51")
replace informal = inlist(etyp_pas, "01","02","03","04") if inlist(pas, "11","12","21" ) & etyp_pas!="19"
tab job_pas informal if inlist(pas, "31", "41", "51")
tab etyp_pas informal if inlist(pas, "11", "12", "21")
tab informal, missing

mean informal [iw=wt], over(sgroup)
save "/Users/babydoll/Documents/UP_informality_Project/data_clean/person_UP_vars.dta", replace
