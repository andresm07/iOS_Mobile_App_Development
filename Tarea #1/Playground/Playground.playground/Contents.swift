import Foundation

func createArrayWithContent (content: String, number: Int) -> [String] {
    var array = [String] ()
    for i in 1 ... number {
        array.append(content)
    }
    return array
}

//print(createArrayWithContent(content: "Dog", number: 4))

func printDifferentNumbers (number: Int) {
    for i in 1 ... number {
        if i % 2 == 0 {
            print ("\(i) es par")
        }
        else {
            print ("\(i) es impar")
        }
    }
}

//print(printDifferentNumbers(number: 3))

func searchTheLongestString (stringOne: String, stringTwo: String) -> String {
    if stringOne.count > stringTwo.count {
        return stringOne
    }
    else if stringTwo.count > stringOne.count {
        return stringTwo
    }
    else {
        return "Strings de igual tamaño"
    }
}

//print(searchTheLongestString(stringOne: "Dog", stringTwo: "Hello"))

func isFibonacciNumber (number: Int) -> Bool {
    var a = 0
    var b = 1
    if number == a || number == b {
        return true
    }
    var c = a + b
    while c <= number {
        if c == number {
            return true 
        }
        a = b
        b = c
        c = a + b
    }
    return false
}

//print(isFibonacciNumber(number: 12))