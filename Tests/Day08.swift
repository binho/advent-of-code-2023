import XCTest

@testable import AdventOfCode

final class Day08Tests: XCTestCase {
    let testData1 = """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    """

    let testData2 = """
    LR

    11A = (11B, XXX)
    11B = (XXX, 11Z)
    11Z = (11B, XXX)
    22A = (22B, XXX)
    22B = (22C, 22C)
    22C = (22Z, 22Z)
    22Z = (22B, 22B)
    XXX = (XXX, XXX)
    """
    
    func testPart1() throws {
        let challenge = Day08(data: testData1)
        XCTAssertEqual(String(describing: challenge.part1()), "2")
    }
    
    func testPart2() throws {
        let challenge = Day08(data: testData2)
        XCTAssertEqual(String(describing: challenge.part2()), "6")
    }
}
