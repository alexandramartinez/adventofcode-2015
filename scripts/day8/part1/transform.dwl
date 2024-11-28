import try from dw::Runtime
var newp = (payload splitBy "\n") map {
    code: sizeOf($),
    memory: do {
        var t = try(() -> read($, "json"))
        ---
        (if (t.success) t.result else read($) replace /\\x[A-F0-9a-f]{1}[A-F0-9a-f]{1}/ with "x")
        then sizeOf($)
    }
}
---
sum(newp.code) - sum(newp.memory)