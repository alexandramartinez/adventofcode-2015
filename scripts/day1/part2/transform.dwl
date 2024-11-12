%dw 2.0
fun getResult(data, index=0, sum=0) = 
    if (!isEmpty(data)) do {
        var newSum = data[0] as Number + sum
        var currentIndex = index+1
        ---
        if (newSum == -1)
            currentIndex
        else
            getResult(data[1 to -1], currentIndex, newSum)
    }
    else index
---
payload 
replace "(" with "1,"
replace ")" with "-1,"
splitBy ","
then getResult($)