%dw 2.0
import countMatches from dw::core::Strings
import countBy, some from dw::core::Arrays
---
payload splitBy "\n" map ((line) -> do {
    var letterPairs = (line splitBy "" map ((letter, letterIndex) -> 
        line[letterIndex to letterIndex+1]
    ))[0 to -2] map (line countMatches $) some ($>=2)
    var otherThing = sizeOf(flatten(line scan /(.).\1/)) >= 1
    ---
    letterPairs and otherThing 
}) countBy $