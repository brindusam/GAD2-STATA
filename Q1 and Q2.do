* 1. Data processing
* Question 1 subquestion a
cd "C:\Users\Brindusa\Desktop\2.2\Research paper\GAD 2"
clear all
use prody, clear
merge 1:1 country using rd_int
keep if _merge==3
* The merge command from STATA merges corresponding observaations from one data set which is curretly opened in memory (the master dataset) with the ones that are from a different dataset (the using dataset) into a single observations.

* Question 1 subquestion b
use rd_int, clear
tab dvping
generate dvping_d =1 if dvping == "Developing"
replace dvping_d =0 if dvping != "Developing"
**gen dvping_d= dvping == "Developing"
count if dvping_d>0


* Question 2
* Q2 subquestion a
cd "C:\Users\Brindusa\Desktop\2.2\Research paper\GAD 2"
clear all
use prody, clear
merge 1:1 country using rd_int
keep if _merge==3
ssc install asdoc, replace
asdoc summ labprod kdeep rd internet ictshare

* Q2 subquestion b
asdoc pwcorr labprod kdeep rd internet ictshare

* Q2 subquestion c
tab labprod
tab region
tabstat labprod, by(region)
graph hbar labprod, over(region) title(Average labprod by region)

* Q2 subquestion d
tab region
tab internet
tabstat internet, by(region)
graph hbar internet, over(region) title(Internet penetration by region)

* Q2 subquestion f
twoway (scatter ln_labprod ln_kdeep, mlabel(isocode)) (lfit ln_labprod ln_kdeep), title(Relationship between ln_labprod and ln_kdeep)

* Q2 subquestion g
twoway (scatter ln_labprod internet, mlabel(isocode)) (lfit ln_labprod internet), title(Relationship between ln_labprod and internet)

* Q2 subquestion h
ssc install asdoc, replace
asdoc ttest ln_labprod, by(dvping) 
