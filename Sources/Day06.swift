import Algorithms
import Foundation

struct Day06: AdventDay {
    var data: String

    var rows: [String] {
        data
            .split(separator: "\n")
            .map { String($0) }
    }

    func part1() -> Any {
        guard let first = rows.first, let last = rows.last else { fatalError("Invalid input") }

        let times = parseMultiple(first)
        let distances = parseMultiple(last)
        let zipped = zip(times, distances)

        return zipped.map { solve(time: $0.0, distance: $0.1) }.reduce(1, *)
    }

    func part2() -> Any {
        guard let first = rows.first, let last = rows.last else { fatalError("Invalid input") }

        let time = parseSingle(first)
        let distance = parseSingle(last)

        return solve(time: time, distance: distance)
    }
    
    // MARK: - Helpers
    
    private func parseMultiple(_ string: String) -> [Int] {
        string
            .components(separatedBy: .whitespaces)
            .compactMap { Int($0) }
    }
    
    private func parseSingle(_ string: String) -> Int {
        let parsed = string
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .dropFirst()
            .joined()

        return Int(parsed) ?? 0
    }

    private func solve(time: Int, distance: Int) -> Int {
        let t = Double(time)
        let d = Double(distance)

        // Quadratic formula is `y = -(x ^ 2) + (x * time) - distance`
        // Formula for delta is Δ = (time ^ 2) - (4 * distance)

        //let delta = sqrt(pow(t, 2) - 4 * d)
        let delta = sqrt(pow(t, 2) - 4 * (d + 1))
        //let root = Int(floor((-t - delta) / -2 - 1e-9) - ceil((-t + delta) / -2 + 1e-9) + 1)
        let root = Int(floor((t + delta) / 2) - ceil((t - delta) / 2)) + 1

        /*
        let delta = sqrt(pow(t, 2) - 4 * d)
        let start = floor(((-t) + delta) / -2) + 1
        let end = ceil(((-t) - delta) / -2) - 1
        return Int(end - start + 1)
         */

        return root
    }
}
