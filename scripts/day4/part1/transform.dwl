%dw 2.0
import MD5 from dw::Crypto
var secretKey = "yzbqklnj"
fun getCorrectHash(number:Number) =
    if (MD5((secretKey ++ number as String) as Binary) startsWith "00000")
        number
    else getCorrectHash(number+1)
---
getCorrectHash(0)