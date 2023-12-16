import Algorithms
import Foundation

struct Day15: AdventDay {
    
    struct Content: Equatable, Hashable {
        let label: String
        let length: Int
    }

    let values: [String]

    init(data: String) {
        self.values = data
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: ",")
            .map(String.init)
    }

    func part1() -> Any {
        values
            .map { hash(text: $0) }
            .reduce(0, +)
    }

    func part2() -> Any {
        var boxes: [Int: [Content]] = [:]
        values
            .forEach { boxedHash(boxes: &boxes, text: $0) }

        var count = 0
        for index in 0...255 {
            guard let box = boxes[index] else { continue }
            for (lens, content) in box.enumerated() {
                count += (index + 1) * (lens + 1) * content.length
            }
        }
        return count
    }
    
    // MARK: - Helpers

    private func hash<S: StringProtocol>(text: S) -> Int {
        var result = 0
        for char in text.utf8 {
            result += Int(char)
            result *= 17
            result %= 256
        }
        return result
    }

    private func boxedHash(boxes: inout [Int: [Content]], text: String) {
        if text.contains("-") {
            let label = text.split(separator: "-")[0]
            let hash = hash(text: label)

            if let box = boxes[hash] {
                for content in box {
                    let length = content.length
                    if content.label == label {
                        boxes[hash]?.removeAll { $0 == .init(label: content.label, length: length) }
                    }
                }
            }
        } else {
            let parts = text.split(separator: "=")
            let label = String(parts[0])
            let length = Int(parts[1]) ?? 0
            let hash = hash(text: label)

            var found = false
            if let box = boxes[hash] {
                for (i, content) in box.enumerated() {
                    if content.label == label {
                        boxes[hash]?[i] = .init(label: content.label, length: length)
                        found = true
                    }
                }
            }

            if !found {
                var values = boxes[hash] ?? []
                values.append(.init(label: label, length: length))
                boxes.updateValue(values, forKey: hash)
            }
        }
    }
}
