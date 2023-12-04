import Algorithms
import Foundation

struct Day04: AdventDay {
    var data: String

    var rows: [String] {
        data
            .split(separator: "\n")
            .map { String($0) }
    }

    func part1() -> Any {
        rows.map { row in
            var parts = row.components(separatedBy: [":", "|"])
            parts.removeFirst()

            guard let winning = parse(parts.first), let scratched = parse(parts.last) else { return 0 }

            //let matches = Set(winning).intersection(scratched).count

            var points = 0
            for num in scratched where winning.contains(num) {
                //points = Int(pow(2, Double(matches - 1)))
                points = points == 0 ? 1 : points << 1
            }
            return points
        }
        .reduce(0, +)
    }

    func part2() -> Any {
        let totalRows = rows.count
        var cards = Array(repeating: 1, count: totalRows)
        
        rows
            .enumerated()
            .forEach { index, row in
                var parts = row.components(separatedBy: [":", "|"])
                parts.removeFirst()

                guard let winning = parse(parts.first), let scratched = parse(parts.last) else { return }
                
                var found = 0
                for num in scratched where winning.contains(num) {
                    found += 1
                }
                
                guard found > 0 else { return }

                for offset in 1...found where offset + index < totalRows {
                    let newIndex = offset + index
                    cards[newIndex] += cards[index]
                }
            }

        return cards.reduce(0, +)
    }
    
    // MARK: - Helpers
    
    private func parse(_ string: String?) -> [Int]? {
        string?
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .compactMap { Int($0) }
    }
}
