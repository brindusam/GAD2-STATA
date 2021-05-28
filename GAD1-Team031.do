* 1. Data processing
* Question 1 subquestion a
cd "C:\Users\Brindusa\Desktop\2.2\Research paper\GAD 2"
clear all
use prody, clear
merge 1:1 country using rd_int
keep if _merge==3

* Question 1 subquestion b
tab dvping
generate dvping_d =1 if dvping == "Developing"
replace dvping_d =0 if dvping != "Developing"
**gen dvping_d= dvping == "Developing"
count if dvping_d>0


* 2. Descriptive statistics
* Q2 subquestion a
ssc install asdoc, replace
asdoc summ labprod kdeep rd internet ictshare, save(Q2a)

* Q2 subquestion b
asdoc corr labprod kdeep rd internet ictshare, save(Q2b)

* Q2 subquestion c
tab labprod
tab region
tabstat labprod, by(region)
graph hbar labprod, over(region) title(Figure 2.1 Average labprod by region) blabel(bar, format(%4.1f))

* Q2 subquestion d
tab region
tab internet
tabstat internet, by(region)
graph hbar internet, over(region) title(Figure 2.2 Internet penetration by region) blabel(bar, position(inside) format(%4.1f) color(white))

* Q2 subquestion f
corr ln_labprod ln_kdeep
twoway (scatter ln_labprod ln_kdeep, mlabel(isocode)) (lfit ln_labprod ln_kdeep), title(Figure 2.3 Relationship between ln_labprod and ln_kdeep)

* Q2 subquestion g
corr ln_labprod internet 
twoway (scatter ln_labprod internet, mlabel(isocode)) (lfit ln_labprod internet), title(Figure 2.4 Relationship between ln_labprod and internet)

* Q2 subquestion h
bysort ln_labprod: asdoc ttest ln_labprod, by(dvping), save(Q2h)


* 3. Regression Analysis
ssc install estout, replace

*Q3 subquestion a
quietly regress ln_labprod internet
estimates store reg1
asdoc esttab reg1, aux(se)  

*Q3 subquestion b 
local varlist ln_kdeep dvping_d
local vars

forvalues i=1/2 {
	local v : word `i' of `varlist'
	local vars `vars' `v'
	quietly regress ln_labprod internet `vars'
}
estimates store reg2
asdoc esttab reg2, aux(se) 

*Q3 subquestion c 
quietly regress ln_labprod internet ln_kdeep dvping_d if dvping_d == 1
estimates store reg3
asdoc esttab reg3, aux (se)


*Q3 subquestion d 
asdoc esttab reg1 reg2 reg3, aux (se)