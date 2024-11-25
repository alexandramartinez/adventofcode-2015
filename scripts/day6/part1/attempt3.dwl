fun add(result:Object, xStart:Number, yStart:Number, xEnd:Number, yEnd:Number, nextX:Number=-1) = do {
    @Lazy
    var x = if (nextX == -1) xStart else nextX
    @Lazy
    var newResult = result update {
        case ."$(x)"! -> (($ default []) ++ (yStart to yEnd)) distinctBy $
    }
    ---
    if (x <= xEnd) 
        add(newResult, xStart, yStart, xEnd, yEnd, x+1)
    else
        result
}
fun remove(result:Object, xStart:Number, yStart:Number, xEnd:Number, yEnd:Number, nextX:Number=-1) = do {
    @Lazy
    var x = if (nextX == -1) xStart else nextX
    @Lazy
    var newResult = result update {
        case ."$(x)" -> $ -- (yStart to yEnd)
    }
    ---
    if (x <= xEnd) 
        remove(newResult, xStart, yStart, xEnd, yEnd, x+1)
    else
        result
}
fun toggle(result:Object, xStart:Number, yStart:Number, xEnd:Number, yEnd:Number, nextX:Number=-1) = do {
    result
}
---
payload splitBy "\n" reduce ((line, result={}) -> do {
    var instruction = (line splitBy / \d+,\d+.+\d+,\d+/)[0]
    var limits = flatten(flatten(line scan /\d+,\d+/) map ($ splitBy ",")) map ($ as Number)
    ---
    instruction match {
        case "turn on" -> add(result,limits[0],limits[1],limits[2],limits[3])
        case "turn off" -> remove(result,limits[0],limits[1],limits[2],limits[3])
        else -> result
        // else -> toggle(result,limits[0],limits[1],limits[2],limits[3])
    }
})