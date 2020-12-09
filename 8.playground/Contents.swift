import UIKit

// Day 8
// https://adventofcode.com/2020/day/8

let testInputURL = Bundle.main.url(forResource: "test_input", withExtension: "txt")!
let testInput = try String(contentsOf: testInputURL)

let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt")!
let input = try String(contentsOf: inputURL)

typealias instructions = [(Instruction, Int)]

enum Instruction: String {
    case acc
    case jmp
    case nop
    case loop
}

func parse(_ input: String) -> [(Instruction, Int)] {
    let lines = input
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: .newlines)
        .map { $0.components(separatedBy: .whitespaces) }
        .map { (Instruction(rawValue: $0[0])!, Int($0[1])!) }

    return lines
}

func accumulate(for instructions: instructions) -> Int {
    var instructionSet = instructions
    var count = 0
    var i = 0
    while i < instructionSet.count {
        let instruction = instructionSet[i]
        instructionSet[i] = (Instruction.loop, 0)

        switch instruction {
        case (Instruction.nop, _):
            i += 1
        case (Instruction.acc, let value):
            count += value
            i += 1
        case (Instruction.jmp, let value):
            i += value
        case (Instruction.loop, _):
            return count
        }
    }

    return count
}

func instructionsComplete(_ instructions: instructions) -> Int? {
    var instructionSet = instructions
    var count = 0
    var i = 0
    while i < instructionSet.count {
        let instruction = instructionSet[i]
        instructionSet[i] = (Instruction.loop, 0)

        switch instruction {
        case (Instruction.nop, _):
            i += 1
        case (Instruction.acc, let value):
            count += value
            i += 1
        case (Instruction.jmp, let value):
            i += value
        case (Instruction.loop, _):
            return nil
        }
    }

    return count
}

func completeLoop(for instructions: instructions) -> Int {
    for (i, (instruction, count)) in instructions.enumerated() {
        if instruction == .nop {
            var acylicInstriction = instructions
            acylicInstriction[i] = (Instruction.jmp, count)
            if let count = instructionsComplete(acylicInstriction) {
                return count
            }
        } else if instruction == .jmp {
            var acylicInstriction = instructions
            acylicInstriction[i] = (Instruction.nop, count)
            if let count = instructionsComplete(acylicInstriction) {
                return count
            }
        }
    }

    return -1
}

// Part 1
print(accumulate(for: parse(input)))

// Part 2
print(completeLoop(for: parse(input)))
