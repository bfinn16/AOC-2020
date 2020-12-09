import UIKit

// Day 5
// https://adventofcode.com/2020/day/5

let testInputURL = Bundle.main.url(forResource: "test_input", withExtension: "txt")!
let testInput = try String(contentsOf: testInputURL)

let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt")!
let input = try String(contentsOf: inputURL)

let totalRows = 128.0
let totalColumns = 8.0

func parse(_ input: String) -> [String] {
    return Array(input.split(separator: "\n").map { String($0) })
}

func splitRange(_ directions: String, lower: Character, upper: Character, in range: Range<Double>) -> Double {
    guard range.lowerBound != range.upperBound-1 else {
        return range.lowerBound
    }

    for direction in directions {
        var total = (range.upperBound - range.lowerBound) / 2.0
        total.round(.up)
        if direction == lower {
            return splitRange(String(directions.dropFirst()), lower: lower, upper: upper, in: (range.lowerBound..<(range.upperBound-total)))
        } else if direction == upper {
            return splitRange(String(directions.dropFirst()), lower: lower, upper: upper, in: ((range.lowerBound + total)..<range.upperBound))
        }
    }

    return -1
}

func findSeatIDs(for input: [String]) -> [Int] {
    return input.map { findSeat(for: $0) }
}

let seatIDs = findSeatIDs(for: parse(input))

// Part 1
func findSeat(for input: String) -> Int {
    let rowInput = input.prefix(7).map{ String($0) }.joined()
    let rowNumber = splitRange(rowInput, lower: "F", upper: "B", in: 0..<totalRows)

    let columnInput = input.suffix(3).map{ String($0) }.joined()
    let columnNumber = splitRange(columnInput, lower: "L", upper: "R", in: 0..<totalColumns)

    return Int(rowNumber * 8 + columnNumber)
}

print(seatIDs.max() ?? -1)

// Part 2
func findMissingSeat(from seatIDs: [Int]) -> Int {
    let ids = seatIDs.sorted()
    for i in 1..<ids.count-1 {
        if ids[i] != ids[i-1] + 1 && ids[i] != ids[i+1] + 1 {
            return ids[i]-1
        }
    }

    return -1
}

print(findMissingSeat(from: seatIDs))
