%dw 2.0
import countBy from dw::core::Arrays
---
payload splitBy "\n" map do {
    var vowels = sizeOf(flatten($ scan /[aeiou]/))
    var doubleLetters = sizeOf(flatten($ scan /(.)\1/))
    var notThese = sizeOf(flatten($ scan /ab|cd|pq|xy/))
    ---
    (notThese == 0) and (doubleLetters >= 2) and (vowels >= 3)
} countBy $