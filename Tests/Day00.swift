import XCTest

@testable import AdventOfCode

final class Day00Tests: XCTestCase {
    let testData1 = """
    """

    let testData2 = """
    """
    
    func testPart1() throws {
        let challenge = Day00(data: testData1)
        XCTAssertEqual(String(describing: challenge.part1()), "0")
    }
    
    func testPart2() throws {
        let challenge = Day00(data: testData2)
        XCTAssertEqual(String(describing: challenge.part2()), "0")
    }
}
