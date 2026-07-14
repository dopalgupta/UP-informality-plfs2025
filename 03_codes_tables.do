clear
cd "/Users/babydoll/Documents/UP_informality_Project"
use "data_clean/person_UP_vars.dta", clear
log using "output/all_tables.txt", text replace

//informality total
mean informal [iw=wt]

//informality over social group
mean informal [iw=wt], over(sgroup)


//showing infromality over sg and edu_level with 
mean informal [iw=wt] if no_school==1, over(sgroup)
mean informal [iw=wt] if primary_bp==1, over(sgroup)
mean informal [iw=wt] if middle_sec==1, over(sgroup)
mean informal [iw=wt] if higher_sec==1, over (sgroup)
mean informal [iw=wt] if grad==1, over(sgroup)

//pay off table
// do SC,ST,OBC workers earn less?
mean earn_m [iw=wt], over(sgroup)
mean earn_m [iw=wt] if pas=="31", over(sgroup)
mean earn_m [iw=wt] if inlist(pas, "11","12","21"), over(sgroup)
mean earn_m [iw=wt] if inlist(pas, "41","51"), over(sgroup)

//how much more does a formal worker earn than an informal one
mean earn_m [iw=wt], over(informal)

//ques: how much more likely for an sc/st/obc worker to be found in informal work than others worker
//running the regression
reg informal ib9.sgroup [pw=wt] //liner perdiction model

//does the gap survive controls? 
reg informal female age urban ib9.sgroup primary_bp middle_sec higher_sec grad [pw=wt]

//do SC/OBC/ST workers earn less even with the same education, age, sex, location?
gen ln_earn = ln(earn_m)
su ln_earn
reg ln_earn female age urban ib9.sgroup primary_bp middle_sec higher_sec grad [pw=wt]
log close
