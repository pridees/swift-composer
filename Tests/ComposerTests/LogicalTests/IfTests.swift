import XCTest
@testable import Composer

final class IfTests: XCTestCase {
    
    func testIfElse() {
        let isNotZero = (!) <<< equals(0.0)
        let mapToDateOrNil: (Double) -> Date? = `if`(isNotZero, then: { Date.init(timeIntervalSince1970: $0) })
        let nilValue: Double = 0
        
        XCTAssertEqual(isNotZero(nilValue), false)
        XCTAssertEqual(mapToDateOrNil(nilValue), .none)
    }
}
