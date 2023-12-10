import XCTest

@testable import AdventOfCode

final class Day09Tests: XCTestCase {
    let testData1 = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """

    let testData2 = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """

    func testPart1() throws {
        let challenge = Day09(data: testData1)
        XCTAssertEqual(String(describing: challenge.part1()), "114")
    }
    
    func testPart2() throws {
        let challenge = Day09(data: testData2)
        XCTAssertEqual(String(describing: challenge.part2()), "2")
    }
}
