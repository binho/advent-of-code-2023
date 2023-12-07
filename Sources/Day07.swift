import Algorithms
import Foundation

struct Day07: AdventDay {
    
    var data: String
    var rows: [String] {
        data
            .split(separator: "\n")
            .map { String($0) }
    }
    
    class Hand {
        let cards: [String]
        let bid: Int
        let partTwo: Bool
        lazy var rank: Rank = getRank()

        init(_ string: String, partTwo: Bool) {
            let parts = string.split(separator: " ")
            guard let first = parts.first, let last = parts.last else { fatalError("Invalid input") }

            self.cards = first.split(separator: "").map(String.init)
            self.bid = Int(last) ?? 0
            self.partTwo = partTwo
        }
        
        private func getRank() -> Rank {
            var dict = cards.reduce(into: [:]) { $0[$1, default: 0] += 1 }
            let values = dict.values

            if partTwo {
                let jokers = dict.removeValue(forKey: "J") ?? 0
                let max = values.max() ?? 0

                switch dict.count {
                case 0: return .five
                case 1:
                    if jokers == 0 { return max == 4 ? .four : .five }
                    return .five
                case 2:
                    switch jokers {
                    case 0:
                        return values.contains(4) ? .four : .fullHouse
                    case 1:
                        switch max {
                        case 3: return jokers == 1 ? .four : .fullHouse
                        case 2: return .fullHouse
                        default: fatalError()
                        }
                    case 2, 3: return .four
                    default: fatalError()
                    }
                case 3:
                    if jokers == 0 { return values.contains(2) ? .twoPair : .three }
                    return .three
                case 4: return .onePair
                case 5: return .highCard
                default: fatalError()
                }
            } else {
                switch dict.count {
                case 1: return .five
                case 2: return values.contains(4) ? .four : .fullHouse
                case 3: return values.contains(3) ? .three : .twoPair
                case 4: return .onePair
                case 5: return .highCard
                default: fatalError()
                }
            }
        }
    }

    enum Rank: Int, Comparable {
        case highCard
        case onePair
        case twoPair
        case three
        case fullHouse
        case four
        case five

        static func < (lhs: Rank, rhs: Rank) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }

    // MARK: - Parts

    func part1() -> Any {
        solve()
    }

    func part2() -> Any {
        solve(partTwo: true)
    }
    
    // MARK: - Helpers
    
    private func solve(partTwo: Bool = false) -> Int {
        rows
            .map { Hand($0, partTwo: partTwo) }
            .sorted(by: compareRank)
            .enumerated()
            .compactMap { $0.element.bid * ($0.offset + 1) }
            .reduce(0, +)
    }
    
    // For part two the joker is the weakest card (1)
    private func map(for partTwo: Bool) -> [String: Int] {
        ["A": 14, "K": 13, "Q": 12, "J": partTwo ? 1 : 11, "T": 10, "9": 9, "8": 8, "7": 7, "6": 6, "5": 5, "4": 4, "3": 3, "2": 2]
    }
    
    private func compareRank(_ lhs: Hand, _ rhs: Hand) -> Bool {
        if lhs.rank != rhs.rank {
            return lhs.rank < rhs.rank
        }

        let map = map(for: lhs.partTwo)
        for (leftCard, rightCard) in zip(lhs.cards, rhs.cards) {
            if leftCard != rightCard {
                return map[leftCard]! < map[rightCard]!
            }
        }
        fatalError()
    }
}
