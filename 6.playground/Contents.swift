import UIKit

// Day 5
// https://adventofcode.com/2020/day/5

let testInputURL = Bundle.main.url(forResource: "test_input", withExtension: "txt")!
let testInput = try String(contentsOf: testInputURL)

let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt")!
let input = try String(contentsOf: inputURL)

func parseWholeGroupAsOne(_ input: String) -> [String] {
    return input.components(separatedBy: "\n\n").map{ $0.replacingOccurrences(of: "\n", with: "") }
}

func parseGroup(_ input: String) -> [[String]] {
    return input.components(separatedBy: "\n\n").map{ $0.components(separatedBy: "\n").filter{ $0 != ""} }
}

func countQuestionGroups(for input: [String]) -> Int {
    var yesCount = 0
    for group in input {
        var yesSet = Set<Character>()
        for question in group {
            yesSet.insert(question)
        }
        yesCount += yesSet.count
    }

    return yesCount
}

func countAllYesGroups(for input: [[String]]) -> Int {
    var yesCount = 0
    for group in input {
        var answerDict = [Character: Int]()
        for answers in group {
            for answer in answers {
                answerDict[answer, default: 0] += 1
            }
        }

        for count in answerDict.values {
            if count == group.count {
                yesCount += 1
            }
        }
    }
    return yesCount
}


//print(countQuestionGroups(for: parseWholeGroupAsOne(input)))
print(countAllYesGroups(for: parseGroup(input)))



