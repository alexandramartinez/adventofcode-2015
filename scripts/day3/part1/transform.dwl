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