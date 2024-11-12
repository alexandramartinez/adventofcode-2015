%dw 2.0
fun getSingleResult(data) = do {
    var d = data splitBy "x" map $ as Number orderBy $
    var ribbon = d[0] + d[0] + d[1] + d[1]
    ---
    d[0]*d[1]*d[2] + ribbon
}
---
sum(payload splitBy "\n" map getSingleResult($))