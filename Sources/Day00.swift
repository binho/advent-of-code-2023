import Algorithms
import Foundation

struct Day00: AdventDay {
    var data: String
    let rows: [String]

    init(data: String) {
        self.data = data
        self.rows = data
            .split(separator: "\n")
            .map(String.init)
    }

    func part1() -> Any {
        return 0
    }

    func part2() -> Any {
        return 0
    }
}
