%dw 2.0
---
payload 
replace "(" with "1,"
replace ")" with "-1,"
splitBy ","
map $ as Number
then sum($)