import Algorithms
import Foundation
import RegexBuilder

struct Day03: AdventDay {
    var data: String
    
    var rows: [String] {
        data
            .split(separator: "\n")
            .map { String($0) }
    }

    struct Part {
        let number: Int
        let point: Point
    }
    
    struct Point: Hashable {
        let i: Int
        let j: Int
    }

    func part1() -> Any {
        let chars = rows.map { $0.split(separator: "") }
        let lastRowIndex = rows.count - 1

        var parts: [Int] = []
        for (i, row) in rows.enumerated() {
            let regex = Regex { OneOrMore(.digit) }
            let matches = row.matches(of: regex)
            let width = row.count

            for match in matches {
                let start = row.distance(from: row.startIndex, to: match.startIndex) - 1 // .123
                let end = row.distance(from: row.startIndex, to: match.endIndex) // 123.
                let number = Int(match.output) ?? 0

                for j in start...end {
                    // Check in current row
                    if i > 0 && j < width && j != -1 {
                        if (chars[i][j] != "." && !chars[i][j].isDigit) {
                            parts.append(number)
                            break
                        }
                    }
                    // Check in previous row
                    if i > 0 && j < width && j != -1 {
                        if (chars[i-1][j] != "." && !chars[i-1][j].isDigit) {
                            parts.append(number)
                            break
                        }
                    }
                    // Check in next row
                    if i < lastRowIndex && j < width && j != -1 {
                        if (chars[i+1][j] != "." && !chars[i+1][j].isDigit) {
                            parts.append(number)
                            break
                        }
                    }
                }
            }
        }

        return parts.reduce(0, +)
    }

    func part2() -> Any {
        let chars = rows.map { $0.split(separator: "") }
        let lastRowIndex = rows.count - 1

        var parts: [Part] = []
        for (i, row) in rows.enumerated() {
            let regex = Regex { OneOrMore(.digit) }
            let matches = row.matches(of: regex)
            let width = row.count

            for match in matches {
                let start = row.distance(from: row.startIndex, to: match.startIndex) - 1 // .123
                let end = row.distance(from: row.startIndex, to: match.endIndex) // 123.
                let number = Int(match.output) ?? 0

                for j in start...end {
                    // Check in current row
                    if i > 0 && j < width && j != -1 {
                        if (chars[i][j] == "*" && !chars[i][j].isDigit) {
                            parts.append(Part(number: number, point: .init(i: i, j: j)))
                            break
                        }
                    }
                    // Check in previous row
                    if i > 0 && j < width && j != -1 {
                        if (chars[i-1][j] == "*" && !chars[i-1][j].isDigit) {
                            parts.append(Part(number: number, point: .init(i: i - 1, j: j)))
                            break
                        }
                    }
                    // Check in next row
                    if i < lastRowIndex && j < width && j != -1 {
                        if (chars[i+1][j] == "*" && !chars[i+1][j].isDigit) {
                            parts.append(Part(number: number, point: .init(i: i + 1, j: j)))
                            break
                        }
                    }
                }
            }
        }

        // Generate number of occurrences for each row
        var counts = [Point: Int]()
        parts.forEach { counts[$0.point] = (counts[$0.point] ?? 0) + 1 }

        var total = 0
        for (point, count) in counts where count == 2 {
            let product = parts
                .filter { $0.point == point }
                .map { $0.number }
                .reduce(1, *)

            total += product
        }
        return total
    }
}

private extension Substring {
    var isDigit: Bool {
        Double(self) != nil
    }
}
