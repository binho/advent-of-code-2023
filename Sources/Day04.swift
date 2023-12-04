import Algorithms

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

            guard let winning = parts.first?.components(separatedBy: .whitespaces).filter({ !$0.isEmpty }).compactMap({ Int($0) }),
                  let scratched = parts.last?.components(separatedBy: .whitespaces).filter({ !$0.isEmpty }).compactMap({ Int($0) })
            else { return 0 }

            var points = 1
            for num in scratched where winning.contains(num) {
                points = points << 1
            }
            // Divide by 2 because we started with 1
            return points / 2
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
                
                guard let winning = parts.first?.components(separatedBy: .whitespaces).filter({ !$0.isEmpty }).compactMap({ Int($0) }),
                      let scratched = parts.last?.components(separatedBy: .whitespaces).filter({ !$0.isEmpty }).compactMap({ Int($0) })
                else { return }
                
                var found = 0
                for num in scratched {
                    if winning.contains(num) {
                        found += 1
                    }
                }
                
                guard found > 0 else { return }

                for offset in 1...found where offset + index < totalRows {
                    let newIndex = offset + index
                    cards[newIndex] += cards[index]
                }
            }

        return cards.reduce(0, +)
    }
}
