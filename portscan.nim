import os
import net
import strutils

proc Scan(tgt: string, pt: int): string =
    var s = newSocket()
    try:
        s.connect(tgt, Port(pt))
    except:
        return "closed"
    close(s)
    return "open"

let usage = """
Usage: portscan.exe <target> <port>
Example: portscan.exe google.com 80
"""

if paramCount() != 2:
    echo usage
    quit()

var 
    target = paramStr(1)
    port: int
try:
    port = parseInt(paramStr(2))
except:
    echo usage
    quit()

echo "This port is ", Scan(target, port), "."