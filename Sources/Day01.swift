import Algorithms

struct Day01: AdventDay {
    var data: String
    
    var rows: [String] {
        data
            .split(separator: "\n")
            .map { String($0) }
    }

    func part1() -> Any {
        var total = 0
        rows.forEach { row in
            let numbers = row.filter(\.isNumber)
            guard !numbers.isEmpty else { return }
            total += Int(numbers.prefix(1) + numbers.suffix(1)) ?? 0
        }
        return total
    }

    func part2() -> Any {
        var total = 0
        rows.forEach { row in
            guard let first = firstNumber(in: row),
                  let last = lastNumber(in: row)
            else { return }
            total += Int(first + last) ?? 0
        }
        return total
    }

    let words = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    let digits = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let search = [
        "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
        "1", "2", "3", "4", "5", "6", "7", "8", "9"
    ]
    
    private func firstNumber(in row: String) -> String? {
        var row = row
        
        while !row.isEmpty {
            for (index, string) in search.enumerated() {
                if row.hasPrefix(string) {
                    if words.contains(string) {
                        return digits[index] // Converts one -> 1, two -> 2, ...
                    } else {
                        return string
                    }
                }
            }
            row.removeFirst()
        }
        return nil
    }
    
    private func lastNumber(in row: String) -> String? {
        var row = row
        
        while !row.isEmpty {
            for (index, string) in search.enumerated() {
                if row.hasSuffix(string) {
                    if words.contains(string) {
                        return digits[index] // Converts one -> 1, two -> 2, ...
                    } else {
                        return string
                    }
                }
            }
            row.removeLast()
        }
        return nil
    }
}
