import Algorithms
import Foundation

struct Day11: AdventDay {
    
    struct Point {
        let x: Int
        let y: Int
    }
    
    var data: String
    let image: [String]
    var galaxies: [Point] = []
    var emptyRows: OrderedSet<Int> = []
    var emptyCols: OrderedSet<Int> = []

    init(data: String) {
        self.data = data
        self.image = data
            .split(separator: "\n")
            .map(String.init)

        guard !image.isEmpty else { return }
        
        // Assume all empty rows
        let rowCount = image.count
        for i in 0..<rowCount {
            emptyRows.append(i)
        }
        // Assume all empty cols
        let colCount = image[0].count
        for i in 0..<colCount {
            emptyCols.append(i)
        }

        // Keep track of galaxies "#" coordinates
        for (i, row) in image.enumerated() {
            for (j, col) in row.split(separator: "").enumerated() {
                if col == "#" {
                    galaxies.append(.init(x: i, y: j))
                    // Remove from empty rows/cols when find out there's a # on row/col
                    emptyRows.remove(i)
                    emptyCols.remove(j)
                }
            }
        }
    }

    func part1() -> Any {
        getSumDistance(expansionRate: 2)
    }

    func part2() -> Any {
        getSumDistance(expansionRate: 1_000_000) // one million
    }
    
    // MARK: - Helpers
    
    private func getSumDistance(expansionRate: Int) -> Int {
        let diff = expansionRate - 1
        let adjusted = galaxies.map { point in
            // Coordinate + expansion rate multiplied by number of empty values before given coordinate
            let x = point.x + diff * emptyRows.filter { $0 < point.x }.count
            let y = point.y + diff * emptyCols.filter { $0 < point.y }.count
            return Point(x: x, y: y)
        }

        let count = adjusted.count

        var result = 0
        for i in 0..<count - 1 {
            for j in (i + 1)..<count {
                result += abs(adjusted[j].x - adjusted[i].x) + abs(adjusted[j].y  - adjusted[i].y)
            }
        }
        return result
    }
}
