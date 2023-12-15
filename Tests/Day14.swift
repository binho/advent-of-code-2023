import XCTest

@testable import AdventOfCode

final class Day14Tests: XCTestCase {
    let testData1 = """
    O....#....
    O.OO#....#
    .....##...
    OO.#O....O
    .O.....O#.
    O.#..O.#.#
    ..O..#O..O
    .......O..
    #....###..
    #OO..#....
    """

    let testData2 = """
    O....#....
    O.OO#....#
    .....##...
    OO.#O....O
    .O.....O#.
    O.#..O.#.#
    ..O..#O..O
    .......O..
    #....###..
    #OO..#....
    """
    
    func testPart1() throws {
        let challenge = Day14(data: testData1)
        XCTAssertEqual(String(describing: challenge.part1()), "136")
    }
    
    func testPart2() throws {
        let challenge = Day14(data: testData2)
        XCTAssertEqual(String(describing: challenge.part2()), "64")
    }
}
