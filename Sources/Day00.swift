import Algorithms

struct Day00: AdventDay {
    var data: String

    var rows: [String] {
        data
            .split(separator: "\n")
            .map { String($0) }
    }

    func part1() -> Any {
        return 0
    }

    func part2() -> Any {
        return 0
    }
}
