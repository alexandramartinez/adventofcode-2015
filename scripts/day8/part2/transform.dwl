import try from dw::Runtime
var newp = (payload splitBy "\n") map {
    code: sizeOf($),
    part2: sizeOf(write($))
}
---
sum(newp.part2) - sum(newp.code)