# Advent of Code 2015

DataWeave scripts used in the [adventofcode.com](https://adventofcode.com/) site for 2015.

## Similar repos

[![](https://github-readme-stats.vercel.app/api/pin/?username=alexandramartinez&repo=adventofcode-2023&theme=neon)](https://github.com/alexandramartinez/adventofcode-2023)
[![](https://github-readme-stats.vercel.app/api/pin/?username=alexandramartinez&repo=adventofcode-2022&theme=neon)](https://github.com/alexandramartinez/adventofcode-2022)

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

## 🔹 Day 3

### Part 1

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
type House = { x:Number, y:Number }
var west = "<" // left
var east = ">" // right
var north = "^" // up
var south = "v" // down
var start:House = { x:0, y:0 }
fun move(direction:String, house:House):House =
    direction match {
        case d if d == west -> { x: house.x-1, y: house.y }
        case d if d == east -> { x: house.x+1, y: house.y }
        case d if d == north -> { x: house.x, y: house.y+1 }
        case d if d == south -> { x: house.x, y: house.y-1 }
        else -> house
    }
---
payload splitBy "" reduce ((direction, houses=[start]) -> 
    houses + move(direction, houses[-1])
) distinctBy $
then sizeOf ($)
```
</details>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=alexandramartinez%2Fadventofcode-2015&path=scripts%2Fday3%2Fpart1"><img width="300" src="/images/dwplayground-button.png"><a>

### Part 2

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
type House = { x:Number, y:Number }
var west = "<" // left
var east = ">" // right
var north = "^" // up
var south = "v" // down
var start:House = { x:0, y:0 }
fun move(direction:String, house:House):House =
    direction match {
        case d if d == west -> { x: house.x-1, y: house.y }
        case d if d == east -> { x: house.x+1, y: house.y }
        case d if d == north -> { x: house.x, y: house.y+1 }
        case d if d == south -> { x: house.x, y: house.y-1 }
        else -> house
    }
fun getHouses(directions:Array):Array = 
    directions reduce ((direction, houses=[start]) -> 
        houses + move(direction, houses[-1])
    ) 
var p = payload splitBy ""
var svrs = [(p filter (($$ mod 2) == 0)), (p filter (($$ mod 2) != 0))]
var santa = getHouses(svrs[0])
var robosanta = getHouses(svrs[1])
---
santa ++ robosanta
distinctBy $
then sizeOf ($)
```
</details>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=alexandramartinez%2Fadventofcode-2015&path=scripts%2Fday3%2Fpart2"><img width="300" src="/images/dwplayground-button.png"><a>

## 🔹 Day 4

### Part 1

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
import MD5 from dw::Crypto
var secretKey = "yzbqklnj"
fun getCorrectHash(number:Number) =
    if (MD5((secretKey ++ number as String) as Binary) startsWith "00000")
        number
    else getCorrectHash(number+1)
---
getCorrectHash(0)
```
</details>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=alexandramartinez%2Fadventofcode-2015&path=scripts%2Fday4%2Fpart1"><img width="300" src="/images/dwplayground-button.png"><a>

### Part 2

> [!NOTE]
> I had to run this from the [DataWeave CLI](https://github.com/mulesoft-labs/data-weave-cli) because vscode was timing out. After you install it, you can run it with `dw run -f MyModule.dwl`

<details>
  <summary>Script</summary>

```dataweave
%dw 2.0
import MD5 from dw::Crypto
var secretKey = "yzbqklnj"
fun getCorrectHash(number:Number) =
    if (MD5((secretKey ++ number as String) as Binary) startsWith "000000")
        number
    else getCorrectHash(number+1)
---
getCorrectHash(0)
```
</details>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=alexandramartinez%2Fadventofcode-2015&path=scripts%2Fday4%2Fpart2"><img width="300" src="/images/dwplayground-button.png"><a>