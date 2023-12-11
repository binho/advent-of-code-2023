import XCTest

@testable import AdventOfCode

final class Day10Tests: XCTestCase {
    let testData1 = """
    .....
    .S-7.
    .|.|.
    .L-J.
    .....
    """

    let testData2 = """
    .F----7F7F7F7F-7....
    .|F--7||||||||FJ....
    .||.FJ||||||||L7....
    FJL7L7LJLJ||LJ.L-7..
    L--J.L7...LJS7F-7L7.
    ....F-J..F7FJ|L7L7L7
    ....L7.F7||L7|.L7L7|
    .....|FJLJ|FJ|F7|.LJ
    ....FJL-7.||.||||...
    ....L---J.LJ.LJLJ...
    """
    
    func testPart1() throws {
        let challenge = Day10(data: testData1)
        XCTAssertEqual(String(describing: challenge.part1()), "4")
    }
    
    func testPart2() throws {
        let challenge = Day10(data: testData2)
        XCTAssertEqual(String(describing: challenge.part2()), "8")
    }
}
