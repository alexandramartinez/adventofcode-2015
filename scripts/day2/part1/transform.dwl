%dw 2.0
fun getSingleResult(data) = do {
    var d = data splitBy "x" map $ as Number orderBy $
    var slack = d[0] * d[1]
    ---
    (2*d[0]*d[1]) + (2*d[1]*d[2]) + (2*d[2]*d[0]) + slack
}
---
sum(payload splitBy "\n" map getSingleResult($))