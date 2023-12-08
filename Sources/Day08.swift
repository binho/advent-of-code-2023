import Algorithms
import Foundation
import RegexBuilder
import OrderedCollections

// --- Day 8: Haunted Wasteland ---

struct Day08: AdventDay {
    var data: String
    
    let directions: [String]
    let directionsCount: Int
    let paths: OrderedDictionary<String, [String]>
    
    init(data: String) {
        self.data = data
        
        let rows = data
            .split(separator: "\n")
            .map { String($0) }

        // [L, R, L, ...]
        self.directions = rows
            .first?
            .split(separator: "")
            .map(String.init) ?? []
        self.directionsCount = self.directions.count

        // key: 11A, value: [11B, XXX]
        self.paths = rows
            .dropFirst()
            .reduce(into: [:], { partialResult, row in
                let regex = Regex { OneOrMore(.word) }
                let matches = row.matches(of: regex)
                guard matches.count == 3 else { return }

                let key = String(matches[0].output)
                let values = [String(matches[1].output), String(matches[2].output)]

                partialResult.updateValue(values, forKey: key)
            })
    }

    func part1() -> Any {
        var search = "AAA"
        var steps = 0
        while search != "ZZZ" {
            if let path = paths[search] {
                let direction = directions[steps % directionsCount]
                steps += 1
                search = direction == "L" ? path[0] : path[1]
            }
        }
        return steps
    }

    func part2() -> Any {
        let keys = paths.keys.filter { $0.hasSuffix("A") }

        var results: [Int] = []
        for var key in keys {
            var steps = 0

            while !key.hasSuffix("Z") {
                if let path = paths[key] {
                    let direction = directions[steps % directionsCount]
                    steps += 1
                    key = direction == "L" ? path[0] : path[1]
                }
            }
            
            results.append(steps)
        }

        return lcm(results)
    }
    
    // MARK: - Helpers

    // Returns the Greatest Common Divisor of two numbers
    private func gcd(_ a: Int, _ b: Int) -> Int {
        var (a, b) = (a, b)
        while b != 0 {
            (a, b) = (b, a % b)
        }
        return abs(a)
    }
    
    // Returns the Greatest Common Divisor of a vector of numbers
    private func gcd(_ vector: [Int]) -> Int {
        vector.reduce(0, gcd)
    }

    // Returns the least common multiple of two numbers
    private func lcm(a: Int, b: Int) -> Int {
        (a / gcd(a, b)) * b
    }

    // Returns the least common multiple of a vector of numbers
    private func lcm(_ vector : [Int]) -> Int {
        vector.reduce(1, lcm)
    }
}
