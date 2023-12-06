import Algorithms
import Foundation

/*
 NOTES:
 OK, part 2 was very bad for performance running on macbook m1 using brute force method.
 Had to look into other solutions to get some hints. Will try to come up with something when I have some time.
*/

struct Day05: AdventDay {
    
    struct Map {
        let ranges: [Range]
    }
    
    struct Range {
        let from: Int
        let to: Int
        let adjustment: Int

        init(from: Int, to: Int, adjustment: Int = 0) {
            self.from = from
            self.to = to
            self.adjustment = adjustment
        }

        init(_ string: String) {
            let ints = string
                .split(separator: " ")
                .compactMap { Int($0) }

            // from: 2926455387, to: 2926455387 + 455063168 - 1, adjustment: 3333452986 - 2926455387
            //           ↓               ↓                                       ↓
            // from: 2926455387, to: 3381518554,                 adjustment: 406997599
            self.init(from: ints[1], to: ints[1] + ints[2] - 1, adjustment: ints[0] - ints[1])
        }
        
        func contains(_ seed: Int) -> Bool {
            seed >= from && seed <= to
        }
        
        var isValid: Bool { from <= to }
    }
    
    // MARK: - Properties
    
    var data: String

    var input: [String] {
        data
            .split(separator: "\n\n")
            .map { String($0) }
    }
    
    var seeds: [Int] {
        input.first?
            .split(separator: " ")
            .compactMap { Int($0) } ?? []
    }

    var maps: [Map] {
        // Drop seed line
        input.dropFirst().map {
            // Drop section name. E.g. "seed-to-soil map:"
            let map = $0.split(separator: "\n").filter { !$0.isEmpty }.dropFirst()
            let ranges: [Range] = map
                .map { Range(String($0)) }
                .sorted { $0.from < $1.from }
            return Map(ranges: ranges)
        }
    }

    func part1() -> Any {
        let locations = seeds.compactMap { location(for: $0) }
        return locations.min() ?? 0
    }

    func part2() -> Any {
        var chunkRanges = seeds
            .chunks(ofCount: 2)
            .compactMap { Range(from: $0.first!, to: $0.first! + $0.last! - 1) }

        for map in maps {
            var newRanges = [Range]()
            for chunkRange in chunkRanges {
                var range = chunkRange
                for mapRange in map.ranges {
                    if range.from < mapRange.from {
                        newRanges.append(Range(from: range.from, to: min(range.to, mapRange.from - 1)))
                        range = Range(from: mapRange.from, to: range.to)
                        if !range.isValid { break }
                    }

                    if range.from <= mapRange.to {
                        newRanges.append(Range(from: range.from + mapRange.adjustment, to: min(range.to, mapRange.to) + mapRange.adjustment))
                        range = Range(from: mapRange.to + 1, to: range.to)
                        if !range.isValid { break }
                    }
                }
                if range.isValid {
                    newRanges.append(range)
                }
            }
            chunkRanges = newRanges
        }

        return chunkRanges.min(by: { $0.from < $1.from })?.from ?? 0
    }
    
    // MARK:  - Helpers

    private func location(for seed: Int) -> Int {
        var result = seed
        for map in maps {
            if let range = map.ranges.first(where: { $0.contains(result) }) {
                result += range.adjustment
            }
        }
        return result
    }
}
