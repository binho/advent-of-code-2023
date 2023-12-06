import XCTest

@testable import AdventOfCode

final class Day06Tests: XCTestCase {
    let testData1 = """
    Time:      7  15   30
    Distance:  9  40  200
    """

    let testData2 = """
    Time:      7  15   30
    Distance:  9  40  200
    """

    func testPart1() throws {
        let challenge = Day06(data: testData1)
        XCTAssertEqual(String(describing: challenge.part1()), "288")
    }
    
    func testPart2() throws {
        let challenge = Day06(data: testData2)
        XCTAssertEqual(String(describing: challenge.part2()), "71503")
    }
}
