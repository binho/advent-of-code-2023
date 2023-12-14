import XCTest

@testable import AdventOfCode

final class Day13Tests: XCTestCase {
    let testData1 = """
    #.##..##.
    ..#.##.#.
    ##......#
    ##......#
    ..#.##.#.
    ..##..##.
    #.#.##.#.

    #...##..#
    #....#..#
    ..##..###
    #####.##.
    #####.##.
    ..##..###
    #....#..#
    """

    let testData2 = """
    #.##..##.
    ..#.##.#.
    ##......#
    ##......#
    ..#.##.#.
    ..##..##.
    #.#.##.#.

    #...##..#
    #....#..#
    ..##..###
    #####.##.
    #####.##.
    ..##..###
    #....#..#
    """
    
    func testPart1() throws {
        let challenge = Day13(data: testData1)
        XCTAssertEqual(String(describing: challenge.part1()), "405")
    }
    
    func testPart2() throws {
        let challenge = Day13(data: testData2)
        XCTAssertEqual(String(describing: challenge.part2()), "400")
    }
}
