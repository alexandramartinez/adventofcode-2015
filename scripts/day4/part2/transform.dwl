/*
    NOTE: This code has to run from the CLI
    https://github.com/mulesoft-labs/data-weave-cli

    To install:
    brew tap mulesoft-labs/data-weave
    brew install dw

    To run:
    dw run -f MyModule.dwl
*/

%dw 2.0
import MD5 from dw::Crypto
var secretKey = "yzbqklnj"
fun getCorrectHash(number:Number) =
    if (MD5((secretKey ++ number as String) as Binary) startsWith "000000")
        number
    else getCorrectHash(number+1)
---
getCorrectHash(0)