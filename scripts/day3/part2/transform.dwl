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