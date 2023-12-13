import Algorithms
import Foundation

class Day12: AdventDay {

    var data: String
    let rows: [String]
    
    required init(data: String) {
        self.data = data
        self.rows = data
            .split(separator: "\n")
            .map(String.init)
    }

    func part1() -> Any {
        rows
            .map { row in
                let parts = row.split(separator: " ")
                let record = String(parts[0])
                let patterns = parts[1].split(separator: ",").compactMap { Int($0) }
                return count(record: record, patterns: patterns)
            }
            .reduce(0, +)
    }

    func part2() -> Any {
        rows
            .map { row in
                let parts = row.split(separator: " ")
                let record = String(repeating: String(parts[0] + "?"), count: 5)
                    .dropLast()
                let patterns = String(repeating: String(parts[1] + ","), count: 5)
                    .split(separator: ",")
                    .compactMap { Int($0) }
                return count(record: String(record), patterns: patterns)
            }
            .reduce(0, +)
    }
    
    // MARK: - Helpers
    
    struct CacheKey: Equatable, Hashable {
        let record: String
        let patterns: [Int]
    }

    private var cache: [CacheKey: Int] = [:]

    private func count(record: String, patterns: [Int]) -> Int {
        if patterns.isEmpty { return record.contains("#") ? 0 : 1 }
        if record.isEmpty { return 0 }

        let key = CacheKey(record: record, patterns: patterns)

        // Get result from cache
        if let result = cache[key] {
            return result
        }
        
        let firstChar = record[0]
        let firstPattern = patterns[0]
        
        var result = 0
        if [".", "?"].contains(firstChar) {
            result += count(record: String(record.dropFirst()), patterns: patterns)
            cache[key] = result
        }

        if ["#", "?"].contains(firstChar) &&
            firstPattern <= record.count &&
            !record.prefix(firstPattern).contains(".") &&
            (firstPattern == record.count || record[firstPattern] != "#") {
            result += count(record: String(record.dropFirst(firstPattern + 1)), patterns: Array(patterns.dropFirst(1)))
            cache[key] = result
        }
        return result
    }
}

fileprivate extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
