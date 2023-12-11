import Algorithms
import Foundation

struct Day10: AdventDay {
    
    struct Point: Equatable, Hashable {
        var x: Int
        var y: Int
    }
    
    var data: String
    let rows: [String]
    let start: Character = "S"
    let corners: [Character] = ["J", "L", "F", "7"]
    let multipliers: [Character: Int] = ["L": 1, "7": 1, "J": -1, "F": -1]

    init(data: String) {
        self.data = data
        self.rows = data
            .split(separator: "\n")
            .map(String.init)
    }

    func part1() -> Any {
        guard let start = findStart(rows: rows) else { return 0 }

        let loop = findLoop(rows: rows, start: start)
        let count = loop.count

        return count / 2 + count % 2
    }

    func part2() -> Any {
        guard let start = findStart(rows: rows) else { return 0 }

        let loop = findLoop(rows: rows, start: start)
        let area = calculatePolygonArea(points: loop)

        return Int(area - 0.5 * Double(loop.count) + 1)
    }
    
    // MARK: - Helpers

    private func findStart(rows: [String]) -> Point? {
        for (i, row) in rows.enumerated() {
            for (j, col) in row.enumerated() {
                if col == start {
                    return Point(x: i, y: j)
                }
            }
        }
        return nil
    }
    
    private func findLoop(rows: [String], start: Point) -> [Point] {
        guard let initialDirection = findInitialDirection(rows: rows, start: start) else { return [] }
        var directionRow = initialDirection.x
        var directionCol = initialDirection.y
        
        var current = start
        var loop: [Point] = []
        while current != start || loop.isEmpty {
            loop.append(current)
            let row = current.x
            let col = current.y
            current = Point(x: row + directionRow, y: col + directionCol)
            let pipe = rows[current.x][current.y]
            if corners.contains(pipe) {
                let nextDirection = calculateNextDirection(row: directionRow, col: directionCol, pipe: pipe)
                directionRow = nextDirection.x
                directionCol = nextDirection.y
            }
        }
        return loop
    }
    
    private func calculateNextDirection(row: Int, col: Int, pipe: Character) -> Point {
        let multiplier = multipliers[pipe] ?? 1
        return Point(x: col * multiplier, y: row * multiplier)
    }

    // https://rosettacode.org/wiki/Shoelace_formula_for_polygonal_area#Swift
    private func calculatePolygonArea(points: [Point]) -> Double {
        let xx = points.map(\.x)
        let yy = points.map(\.y)
        let overlace = Double(zip(xx, yy.dropFirst() + yy.prefix(1)).map({ $0.0 * $0.1 }).reduce(0, +))
        let underlace = Double(zip(yy, xx.dropFirst() + xx.prefix(1)).map({ $0.0 * $0.1 }).reduce(0, +))
        return abs(overlace - underlace) / 2
    }

    private func findInitialDirection(rows: [String], start: Point) -> Point? {
        let valids: [Point: [Character]] = [
            Point(x: 1, y: 0): ["|", "J", "L"],
            Point(x: 0, y: -1): ["F", "L", "-"],
            Point(x: -1, y: 0): ["|", "7", "F"],
            Point(x: 0, y: 1): ["J", "7", "-"]
        ]

        let rowsCount = rows.count
        let firstRowCount = rows[0].count

        for (point, pipes) in valids {
            let row = start.x + point.x
            let col = start.y + point.y
            let pipe = rows[row][col]
            
            if (0 <= row && row < rowsCount) && (0 <= col && col < firstRowCount) && pipes.contains(pipe) {
                return Point(x: point.x, y: point.y)
            }
        }
        return nil
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
