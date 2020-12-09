import UIKit

// Day 9
// https://adventofcode.com/2020/day/9

let testInputURL = Bundle.main.url(forResource: "test_input", withExtension: "txt")!
let testInput = try String(contentsOf: testInputURL)

let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt")!
let input = try String(contentsOf: inputURL)

func parse(_ input: String) -> [Int] {
    return input.components(separatedBy: .newlines).filter { $0 != "" }.map { Int($0)! }
}

func twoSumExist(in input: [Int], target: Int) -> Bool {
    var differenceSet = Set<Int>()
    for number in input {
        if differenceSet.contains(number) {
            return true
        }

        let difference = target - number
        differenceSet.insert(difference)
    }

    return false
}

func findFirstInvalidNumber(in input: [Int], preambleLength: Int) -> Int {
    for i in preambleLength..<input.count {
        let preamble = Array(input[i-preambleLength..<i])
        if !twoSumExist(in: preamble, target: input[i]) {
            return input[i]
        }
    }

    return -1
}

func findContiguousSum(in input: [Int], target: Int) -> Int {
    var lowerIndex = 0, higherIndex = 0, sum = 0

    while (sum != target) {
        if sum < target {
            sum += input[higherIndex]
            higherIndex += 1
        } else {
            sum -= input[lowerIndex]
            lowerIndex += 1
        }
    }

    return input[lowerIndex...higherIndex].min()! + input[lowerIndex...higherIndex].max()!
}

// Part 1
let firstInvalid = findFirstInvalidNumber(in: parse(input), preambleLength: 25)
print(firstInvalid)

// Part 2
print(findContiguousSum(in: parse(input), target: firstInvalid))

