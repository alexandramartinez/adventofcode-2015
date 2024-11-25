import countBy from dw::core::Arrays
var max = 999
var allLights = (0 to max) as Array map (
    (0 to max) map 0
)
fun switch(allLines:Array, result:Array) = if (!isEmpty(allLines)) do {
    @Lazy
    var thisLine = allLines[0]
    @Lazy
    var value = thisLine.inst match {
        case "turn on" -> 1
        case "turn off" -> 0
        else -> -1
    }
    @Lazy
    var newResult = result map ((x, xi) -> 
        x map ((y, yi) -> 
            if ( 
                (xi >= thisLine.start[0]) and 
                (yi >= thisLine.start[1]) and
                (xi <= thisLine.end[0]) and
                (yi <= thisLine.end[1])
            ) value match {
                case is -1 -> y match {
                    case is 0 -> 1
                    case is 1 -> 0
                }
                else -> value
            }
            else y
        )
    )
    ---
    switch(allLines[1 to -1], newResult)
} else result
---
payload splitBy "\n" map ((line) -> {
    inst: (line splitBy / \d+,\d+.+\d+,\d+/)[0],
    start: flatten(line scan /\d+,\d+/)[0] splitBy "," map $ as Number,
    end: flatten(line scan /\d+,\d+/)[1] splitBy "," map $ as Number
}) 
then switch($, allLights)
then flatten($) countBy ($==1)