import Algorithms

struct Day02: AdventDay {
    var data: String
    
    var rows: [String] {
        data
            .split(separator: "\n")
            .map { String($0) }
    }

    func part1() -> Any {
        rows.compactMap { row in
            var values = row
                .components(separatedBy: [":", ";", ","])
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

            // No need to split to get game ID, just filter
            guard let gameIdString = values.first?.filter(\.isNumber), let gameId = Int(gameIdString) else { return nil }
            values.removeFirst()

            var possible = true
            values.forEach { value in
                let numberAndColor = value.components(separatedBy: .whitespaces)

                guard let numberString = numberAndColor.first, let number = Int(numberString),
                      let color = numberAndColor.last
                else { return }

                switch color {
                case "red": if number > 12 { possible = false }
                case "green": if number > 13 { possible = false }
                case "blue": if number > 14 { possible = false }
                default: possible = false
                }
            }
            return possible ? gameId : nil
        }
        .reduce(0, +)
    }

    func part2() -> Any {
        rows.compactMap { row in
            let values = row
                .components(separatedBy: [":", ";", ","])
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .dropFirst() // Ignore game ID here

            var red = 0, green = 0, blue = 0
            values.forEach { value in
                let numberAndColor = value.components(separatedBy: .whitespaces)

                guard let numberString = numberAndColor.first, let number = Int(numberString),
                      let color = numberAndColor.last
                else { return }

                switch color {
                case "red": if number > red { red = number }
                case "green": if number > green { green = number }
                case "blue": if number > blue { blue = number }
                default: break
                }
            }
            return red * green * blue
        }
        .reduce(0, +)
    }
}
