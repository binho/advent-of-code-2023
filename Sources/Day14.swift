import Algorithms
import Foundation

// Day 14: Parabolic Reflector Dish

class Day14: AdventDay {
    
    private let CUBE = "#"
    private let ROUNDED = "O"

    struct Point: Equatable, Hashable {
        let x: Int
        let y: Int
    }
    
    enum Direction: CaseIterable {
        case west
        case north
        case east
        case south

        var point: Point {
            switch self {
            case .west: return .init(x: 0, y: -1)
            case .north: return .init(x: -1, y: 0)
            case .east: return .init(x: 0, y: 1)
            case .south: return .init(x: 1, y: 0)
            }
        }
    }

    private var data: String
    private let rows: [String]
    private let totalRows: Int
    private let totalCols: Int

    private var roundedRocks: [Point] = []
    private var cubeRocks: Set<Point> = []

    required init(data: String) {
        self.data = data
        self.rows = data
            .split(separator: "\n")
            .map(String.init)
        self.totalRows = rows.count
        self.totalCols = rows[0].count

        parseRockCoordinates()
    }

    func part1() -> Any {
        roundToNorth()

        return roundedRocks
            .map { getLoad(point: $0) }
            .reduce(0, +)
    }

    func part2() -> Any {
        for _ in 1...1000 {
            for dir in Direction.allCases {
                roundToDirection(dir)
            }
        }

        return roundedRocks
            .map { getLoad(point: $0) }
            .reduce(0, +)
    }
    
    // MARK: - Helpers

    private func parseRockCoordinates() {
        for (y, line) in rows.enumerated() {
            for (x, char) in line.toChars.enumerated() {
                if char == ROUNDED {
                    roundedRocks.append(.init(x: x, y: y))
                } else if char == CUBE {
                    cubeRocks.insert(.init(x: x, y: y))
                }
            }
        }
    }
    
    private func roundToNorth() {

        func getNext(point: Point) -> Point {
            let newPoint = Point(x: point.x, y: point.y - 1)
            if cubeRocks.contains(newPoint) ||
                (point.y - 1 < 0) ||
                roundedRocks.contains(newPoint) {
                return point
            }
            return newPoint
        }

        var canMove = OrderedSet(0..<roundedRocks.count)
        while canMove.count > 0 {
            var toRemove: OrderedSet<Int> = []
            for i in canMove {
                let next = getNext(point: roundedRocks[i])
                if next == roundedRocks[i] {
                    toRemove.append(i)
                }
                roundedRocks[i] = next
            }
            toRemove.forEach { canMove.remove($0) } // probably there's a simpler way to do this :)
        }
    }
    
    private func roundToDirection(_ dir: Direction) {

        func getNext(point: Point) -> Point {
            let newPoint = Point(x: point.x + dir.point.x, y: point.y + dir.point.y)
            if cubeRocks.contains(newPoint) ||
                (point.y + dir.point.y < 0 || point.y + dir.point.y >= totalRows || point.x + dir.point.x < 0 || point.x + dir.point.x >= totalCols) ||
                roundedRocks.contains(newPoint) {
                return point
            }
            return newPoint
        }

        var canMove: [Point] = []
        if dir == .west {
            canMove = roundedRocks.sorted(by: { $0.y < $1.y })
        } else if dir == .north {
            canMove = roundedRocks.sorted(by: { $0.x < $1.x })
        } else if dir == .east {
            canMove = roundedRocks.sorted(by: { $0.y < $1.y }).reversed()
        } else if dir == .south {
            canMove = roundedRocks.sorted(by: { $0.x < $1.x }).reversed()
        }

        var canMoveIndexes = canMove.compactMap { roundedRocks.firstIndex(of: $0) }

        while canMoveIndexes.count > 0 {
            var toRemove: Set<Int> = []
            for i in canMoveIndexes {
                let next = getNext(point: roundedRocks[i])
                if next == roundedRocks[i] {
                    toRemove.insert(i)
                }
                roundedRocks[i] = next
            }
            canMoveIndexes = canMoveIndexes.filter { !toRemove.contains($0) }
        }
    }

    private func getLoad(point: Point) -> Int {
        totalRows - point.y
    }
}

fileprivate extension String {
    var toChars: [Substring] {
        split(separator: "")
    }
}
