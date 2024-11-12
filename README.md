# Advent of Code 2015

DataWeave scripts used in the [adventofcode.com](https://adventofcode.com/) site for 2015.

## 🔹 Day 1

### Part 1

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
---
payload 
replace "(" with "1,"
replace ")" with "-1,"
splitBy ","
map $ as Number
then sum($)
```
</details>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=alexandramartinez%2Fadventofcode-2015&path=scripts%2Fday1%2Fpart1"><img width="300" src="/images/dwplayground-button.png"><a>

### Part 2

<details>
  <summary>Script</summary>

```dataweave
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
```
</details>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=alexandramartinez%2Fadventofcode-2015&path=scripts%2Fday1%2Fpart2"><img width="300" src="/images/dwplayground-button.png"><a>

## 🔹 Day 2

### Part 1

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
fun getSingleResult(data) = do {
    var d = data splitBy "x" map $ as Number orderBy $
    var slack = d[0] * d[1]
    ---
    (2*d[0]*d[1]) + (2*d[1]*d[2]) + (2*d[2]*d[0]) + slack
}
---
sum(payload splitBy "\n" map getSingleResult($))
```
</details>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=alexandramartinez%2Fadventofcode-2015&path=scripts%2Fday2%2Fpart1"><img width="300" src="/images/dwplayground-button.png"><a>

### Part 2

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
fun getSingleResult(data) = do {
    var d = data splitBy "x" map $ as Number orderBy $
    var ribbon = d[0] + d[0] + d[1] + d[1]
    ---
    d[0]*d[1]*d[2] + ribbon
}
---
sum(payload splitBy "\n" map getSingleResult($))
```
</details>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=alexandramartinez%2Fadventofcode-2015&path=scripts%2Fday2%2Fpart2"><img width="300" src="/images/dwplayground-button.png"><a>