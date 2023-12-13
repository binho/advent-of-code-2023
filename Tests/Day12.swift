import XCTest

@testable import AdventOfCode

final class Day12Tests: XCTestCase {
    let testData1 = """
    ???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1
    """

    let testData2 = """
    ???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1
    """
    
    func testPart1() throws {
        let challenge = Day12(data: testData1)
        XCTAssertEqual(String(describing: challenge.part1()), "21")
    }
    
    func testPart2() throws {
        let challenge = Day12(data: testData2)
        XCTAssertEqual(String(describing: challenge.part2()), "525152")
    }
}
