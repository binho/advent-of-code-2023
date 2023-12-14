import Algorithms
import Foundation

struct Day13: AdventDay {
    var data: String
    let patterns: [[String]]

    init(data: String) {
        self.data = data
        self.patterns = data.split(separator: "\n\n").map(String.init)  // Split groups
            .map { $0.split(separator: "\n").map(String.init) } // Split patterns inside each group
    }

    func part1() -> Any {
        patterns
            .map { findMirrors(patterns: $0) }
            .reduce(0, +)
    }

    func part2() -> Any {
        patterns
            .map { findMirrorsSmudge(patterns: $0) }
            .reduce(0, +)
    }
    
    // MARK: - Helpers
    
    private func findMirrors(patterns: [String]) -> Int {
        // Vertical
        let totalCols = patterns[0].count
        for i in 1..<totalCols {
            var mirrored = true
            for line in patterns {
                let num = min(i, totalCols - i)
                guard let left = line[i - num..<i], let right = line[i..<i + num] else { continue }

                if left != String(right.reversed()) {
                    mirrored = false
                    break
                }
            }
            if mirrored { return i }
        }

        // Horizontal
        let totalRows = patterns.count
        for i in 1..<totalRows {
            var mirrored = true
            let num = min(i, totalRows - i)
            let top = Array(patterns[i - num..<i])
            let bottom = Array(patterns[i..<i + num].reversed())

            if zip(top, bottom).contains(where: { $0 != $1 }) {
                mirrored = false
                continue
            }
            if mirrored { return 100 * i }
        }
        return 0
    }
    
    private func findMirrorsSmudge(patterns: [String]) -> Int {
        // Vertical
        let totalCols = patterns[0].count
        for i in 1..<totalCols {
            let num = min(i, totalCols - i)
            var diff = 0
            for line in patterns {
                guard let left = line[i - num..<i], let right = line[i..<i + num] else { continue }

                for (left, right) in zip(left, right.reversed()) {
                    diff += (left != right) ? 1 : 0
                }
                if diff > 1 { break }
            }
            if diff == 1 { return i }
        }

        // Horizontal
        let totalRows = patterns.count
        for i in 1..<totalRows {
            let num = min(i, totalRows - i)
            let top = Array(patterns[i - num..<i])
            let bottom = Array(patterns[i..<i + num].reversed())
            var diff = 0

            // Expected format: [("#", "#"), (".", "."), (".", "."), (".", "."), ("#", "."), ("#", "#"), (".", "."), (".", "."), ("#", "#")]
            let zipped = zip(top.joined(), bottom.joined()).map { ($0, $1) }
            for (top, bottom) in zipped {
                diff += (top != bottom) ? 1 : 0
                if diff > 1 { break }
            }
            if diff == 1 { return 100 * i }
        }
        return 0
    }
}

fileprivate extension StringProtocol {
    // Get substring by index
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    
    // Get substring by range
    subscript(range: Range<Int>) -> String? {
        String(self[index(startIndex, offsetBy: range.lowerBound)..<index(startIndex, offsetBy: range.upperBound)])
    }
}
