import strutils
import tables
import algorithm
import sequtils
import math

#[  
proc hey*(prompt: string): string =
    result = "Whatever."
    if strip(prompt) == "":
        return "Fine. Be that way!"
    var strippedPrompt = ""
    for x in prompt:
        if isAlphaNumeric(x):
            if isDigit(x) == false:
                strippedPrompt.add(x)
        elif x == '?':
            strippedPrompt.add(x)
    if strippedPrompt == "":
        return "Whatever."

    echo "Stripped: ", strippedPrompt

    if strippedPrompt[^1] == '?':
        if len(strippedPrompt) == 1:
            return "Sure."
        elif strippedPrompt == toUpperAscii(strippedPrompt):
            result = "Calm down, I know what I'm doing!"
        else:
            result = "Sure." 
    elif strippedPrompt == toUpperAscii(strippedPrompt):
        result = "Whoa, chill out!"
    elif prompt == "":
        result = "Fine. Be that way!"
#]

# Allergies Exercise

type 
    Allergies* = object
        score*: int
method isAllergicTo*(this: Allergies, allergen: string): bool {.base.} =
    var index: int
    let binaried = toBin(this.score,8)
    case allergen:
        of "eggs":
            index = 7
        of "peanuts":
            index = 6
        of "shellfish":
            index = 5
        of "strawberries":
            index = 4
        of "tomatoes":
            index = 3
        of "chocolate":
            index = 2
        of "pollen":
            index = 1
        of "cats":
            index = 0
        else:
            echo "Error: Invalid allergen."
            return
    if binaried[index] == '1':
        result = true
    else:
        result = false

method lst*(this: Allergies): seq[string] =
    let binaried = toBin(this.score,8)
    if binaried[7] == '1':
        result.add("eggs")
    if binaried[6] == '1':
        result.add("peanuts")
    if binaried[5] == '1':
        result.add("shellfish")
    if binaried[4] == '1':
        result.add("strawberries")
    if binaried[3] == '1':
        result.add("tomatoes")
    if binaried[2] == '1':
        result.add("chocolate")
    if binaried[1] == '1':
        result.add("pollen")
    if binaried[0] == '1':
        result.add("cats")
]#

#[

# Sum of Multiples challenge

proc sum*(limit: int, nums: seq[int]): int =
    result = 0
    var multiples: seq[int]
    for x in nums:
        if x == 0:
            continue
        var count = 1
        while (x * count) < limit:
            if (x * count) in multiples:
                count += 1
                continue
            else:
                multiples.add(x * count)
                count += 1
    for y in multiples:
        result += y
]#
#[
Word Count solution

proc countWords*(sentence: string): CountTable[string] =
    var words: seq[string]
    var noCommas = sentence.replace(',', ' ')
    var splitSentence = noCommas.split(Whitespace)
    for y in 0..(len(splitSentence)-1):
        splitSentence[y] = toLower(splitSentence[y])
        if ',' in splitSentence[y] and y != 0 and y != (len(splitSentence)-1):
            echo splitSentence[y]
    for item in splitSentence:
        var word: string
        for x in 0..(len(item)-1):
            if isAlphaNumeric(item[x]):
                word.add(item[x])
            elif item[x] == '\'' and x != 0 and x != (len(item)-1) and isAlphaNumeric(item[x-1]) and isAlphaNumeric(item[x+1]):
                word.add(item[x])
        if word != "":
            words.add(word)
    return toCountTable(words)
]#
#[
# Hamming Distance calculator
proc distance*(strand1, strand2: string): int =
    result = 0
    if len(strand1) != len(strand2):
        raise newException(ValueError, "Strands must be of equal length.")
    for x in (0..len(strand1)-1):
        if strand1[x] != strand2[x]:
            result += 1
]#

#[
# Grade School solution

type
    Student = tuple
        name: string
        grade: int
    School* = object
        students*: seq[Student]

proc sorted(stdnts: seq[Student]): seq[Student] =
    stdnts.sortedByIt((it.grade, it.name))

method roster*(this: School): seq[string] =
    for item in this.students.sorted:
        result.add(item.name)

method grade*(this: School, lvl: int): seq[string] =
    for item in this.students.sorted:
        if item.grade == lvl:
            result.add(item)
]#

#[
# Pangram challenge solution

proc isPangram*(testStr: string): bool =
    result = true
    for chr in 'a'..'z':
        if not contains(testStr.toLower(),chr):
            result = false
]#
#[

# Abbreviation challenge

proc abbreviate*(longStr: string): string =
    var stripped = longStr.replace('\'','a')
    var currentWord: string = ""
    for x in 0..(len(stripped)-1):
        if not isAlphaNumeric(stripped[x]) or x == (len(stripped)-1):
            if currentWord != "":
                result.add(currentWord[0].toUpperAscii())
                currentWord = ""
        else:
            currentWord.add(stripped[x])
]#
#[

# Isogram exercise solution

proc isIsogram*(testStr: string): bool =
    var testSeq = toSeq(testStr.toLower.items)
    testSeq.keepIf(proc(x: char): bool = x != ' ' and x != '-')
    var rmDups = deduplicate(testSeq)
    if rmDups == testSeq:
        return true
    else:
        return false
]#
#[

# Triangle exercise

proc squareOfSum*(num: int): int =
    var numSeq = toSeq(1..num)
    result = sum(numSeq) ^ 2

proc sumOfSquares*(num: int): int =
    var numSeq = toSeq(1..num)
    result = sum(map(numSeq, proc(x: int): int = x ^ 2))

proc difference*(num: int): int =
    return squareOfSum(num) - sumOfSquares(num)
]#
#[
proc isTriangle(tri: array[0..2, int]): bool =
    if map(tri, proc (x: int): int = sgn(x)) != [1,1,1]:
        return false
    else:
        var triangle = tri
        sort(triangle)
        if (triangle[0] + triangle[1]) >= triangle[2]:
            return true
        else:
            return false

proc isEquilateral*(tri: array[0..2, int]): bool =
    if not isTriangle(tri):
#        raise newException(ValueError, "These values do not constitute a valid triangle.")
        return false
    if tri[0] == tri[1] and tri[1] == tri[2]:
        return true
    else:
        return false

proc isIsoceles*(tri: array[0..2, int]): bool =
    if not isTriangle(tri):
#        raise newException(ValueError, "These values do not constitute a valid triangle.")
        return false
    if tri[0] == tri[1] or tri[1] == tri[2] or tri[0] == tri[2]:
        return true
    else:
        return false

proc isScalene*(tri: array[0..2, int]): bool =
    if not isTriangle(tri):
#        raise newException(ValueError, "These values do not constitute a valid triangle.")
        return false
    if tri[0] != tri[1] and tri[1] != tri[2] and tri[0] != tri[2]:
        return true
    else:
        return false

proc isDegenerate*(tri: array[0..2, int]): bool =
    if not isTriangle(tri):
#        raise newException(ValueError, "These values do not constitute a valid triangle.")
        return false
    var triangle = tri
    sort(triangle)
    if triangle[2] == (triangle[0] + triangle[1]):
        return true
    else:
        return false
]#
#[
proc detectAnagrams*(word: string, candidates: seq[string]): seq[string] =
    var letters = toSeq(word.toLower)
    var test: seq[char]
    letters.sort
    for item in candidates:
        if item.toLower == word.toLower:
            continue
        test = toSeq(item.toLower)
        test.sort
        if test == letters:
            result.add(item)
]#

const openBrackets = "([{"
const closeBrackets = ")]}"

proc isPaired*(input: string): bool =
    var testSeq = toSeq(input.items)
    var index = 0
    var correct: seq[char] = @[]
    for chr in testSeq:
        if not openBrackets.contains(chr) and not closeBrackets.contains(chr):
            continue
        index = openBrackets.find(chr)
        if index >= 0:
            correct.add(closeBrackets[index])
        elif correct.len == 0 or correct.pop() != chr:
            return false
    result = (correct.len == 0)

if isMainModule:
        var word = "([{}({}[])])"
        echo isPaired(word)