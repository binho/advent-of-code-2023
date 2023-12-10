import Algorithms
import Foundation

// --- Day 9: Mirage Maintenance ---

struct Day09: AdventDay {
    var data: String
    
    let oasis: [[Int]]
    
    init(data: String) {
        self.data = data

        self.oasis = data
            .split(separator: "\n")
            .map { $0.split(separator: " ").compactMap({ Int($0) }) }
    }

    func part1() -> Any {
        oasis
            .map { getNext(history: $0) }
            .reduce(0, +)
    }

    func part2() -> Any {
        oasis
            .map { getNext(history: $0.reversed()) }
            .reduce(0, +)
    }
    
    // MARK: - Helpers
    
    private func getNext(history: [Int]) -> Int {
        if history.isEmpty { return 0 }

        let count = history.count

        var diffs: [Int] = []
        for i in 1..<count {
            diffs.append(history[i] - history[i - 1])
        }
        return history[count - 1] + getNext(history: diffs)
    }
}
