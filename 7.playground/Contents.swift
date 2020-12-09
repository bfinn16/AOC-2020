import UIKit

// Day 7
// https://adventofcode.com/2020/day/7

let testInputURL = Bundle.main.url(forResource: "test_input", withExtension: "txt")!
let testInput = try String(contentsOf: testInputURL)

let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt")!
let input = try String(contentsOf: inputURL)

struct Bag {
    let name: String
    let contents: [[String: Int]]

    init(_ input: String) {
        let splitString = input.components(separatedBy: "bags contain")
        let contents = splitString[1]
            .trimmingCharacters(in: .whitespaces)
            .split(separator: ",")
            .map { description -> [String: Int] in
                let bagSplit = description.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")
                if bagSplit[0] == "no" {
                    return [:]
                }
                let bagCount = Int(bagSplit[0]) ?? -1
                let bagColor = bagSplit[1] + " " + bagSplit[2]
                return [bagColor: bagCount]
            }

        self.name = splitString[0].trimmingCharacters(in: .whitespaces)
        self.contents = contents
    }
}

func parse(_ input: String) -> [Bag] {
    let lines = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
    return lines.map { Bag($0) }
}

func search(_ bags: [Bag], for searchString: String) -> Int {
    var parentBags = Set<String>()

    func findBag(_ bags: [Bag], for searchString: String) {
        for bag in bags {
            for bagDict in bag.contents {
                if bagDict[searchString] != nil {
                    parentBags.insert(bag.name)
                    findBag(bags, for: bag.name)
                }
            }
        }
    }

    findBag(bags, for: searchString)
    return parentBags.count
}

func findTotal(for bag: String, from bags: [Bag]) -> Int {
    var totalBags = 0
    var parentBags = [bag]

    while parentBags.count > 0 {
        if let index = bags.firstIndex(where: { $0.name == parentBags.last }) {
            parentBags.removeLast()
            for bagDict in bags[index].contents {
                for (color, bagCount) in bagDict {
                    totalBags += bagCount
                    parentBags.append(contentsOf: repeatElement(color, count: bagCount))
                }
            }
        }
    }

    return totalBags
}

let globalBags = parse(testInput)
print(findTotal(for: "shiny gold", from: globalBags))
print(search(globalBags, for: "shiny gold"))


