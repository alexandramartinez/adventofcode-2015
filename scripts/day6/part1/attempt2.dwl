import mapLeafValues from dw::util::Tree
import countBy from dw::core::Arrays
var max = 2
var allLights = (0 to max) as Array map (
    (0 to max) map 0
)
---
payload splitBy "\n"
reduce ((thisLine, result=allLights) -> do {
    var instruction = (thisLine splitBy / \d+,\d+.+\d+,\d+/)[0]
    var limits = flatten(flatten(thisLine scan /\d+,\d+/) map ($ splitBy ",")) map ($ as Number)
    ---
    result mapLeafValues ((value, path) ->
        if (
            (path[-2].selector >= limits[0]) and
            (path[-1].selector >= limits[1]) and
            (path[-2].selector <= limits[2]) and
            (path[-1].selector <= limits[3])
        ) (
            instruction match {
                case "turn on" -> 1
                case "turn off" -> 0
                else -> value match {
                    case is 0 -> 1
                    case is 1 -> 0
                }
            }
        )
        else value 
    )
})
then flatten($) countBy ($==1)