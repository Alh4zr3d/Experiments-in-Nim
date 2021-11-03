# Testing a comment

#[
    Author:
        Alh4zr3d
        Cthulhu fhtagn
]#

proc getAlphabet(): string =
    var result = ""
    for letter in 'a'..'z':
        result.add(letter)
    return result

const alpha = getAlphabet()

echo alpha