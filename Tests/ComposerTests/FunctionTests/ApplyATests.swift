import XCTest
@testable import Composer

final class ApplyATests: XCTestCase {

    func testApplyOperator() throws {
        let incr: (Int) -> Int = { $0 + 1 }
        let sqrt: (Int) -> Int = { $0 * $0 }
        
        let appying = incr <> sqrt
        
        XCTAssertEqual(appying(2), 9)
        
        /// Test throwing version
        
        enum MathError: Error {
            case incrError
        }
        
        let throwsIncr: (Int) throws -> Int = { _ in throw MathError.incrError }
        let throwsSqrt: (Int) throws -> Int = { $0 * $0 }
        
        let throwsAppying = throwsIncr <> throwsSqrt
        XCTAssertThrowsError(try throwsAppying(2))
    }
    
    func testInOutApplyOperator() throws {
        struct Counter {
            var count = 2
        }
        
        let incr: (inout Counter) -> Void = { $0.count += 1 }
        let sqrt: (inout Counter) -> Void = { $0.count *= $0.count }
        
        let appying = incr <> sqrt
        
        var counter = Counter()
        appying(&counter)
        XCTAssertEqual(counter.count, 9)
        
        // Test throwing version
        
        enum MathError: Error {
            case incrError
        }
        
        let throwsIncr: (inout Counter) throws -> Void = { _ in throw MathError.incrError }
        let throwsSqrt: (inout Counter) throws -> Void = { $0.count *= $0.count }
        
        let throwsAppying = throwsIncr <> throwsSqrt
        XCTAssertThrowsError(try throwsAppying(&counter))
    }
    
    func testAnyObjectApplyOperator() throws {
        class Counter {
            var count = 2
        }
        
        let incr: (Counter) -> Void = { $0.count += 1 }
        let sqrt: (Counter) -> Void = { $0.count *= $0.count }
        
        let appying = incr <> sqrt
        
        let counter = Counter()
        appying(counter)
        XCTAssertEqual(counter.count, 9)
        
        // Test throwing version
        
        enum MathError: Error {
            case incrError
        }
        
        let throwsIncr: (Counter) throws -> Void = { _ in throw MathError.incrError }
        let throwsSqrt: (Counter) throws -> Void = { $0.count *= $0.count }
        
        let throwsAppying = throwsIncr <> throwsSqrt
        XCTAssertThrowsError(try throwsAppying(counter))
    }
    
    func testApplyFunc() throws {
        let incr: (Int) -> Int = { $0 + 1 }
        let sqrt: (Int) -> Int = { $0 * $0 }
        
        let appying = apply(incr, sqrt)
        
        XCTAssertEqual(appying(2), 9)
        
        /// Test throwing version
        
        enum MathError: Error {
            case incrError
        }
        
        let throwsIncr: (Int) throws -> Int = { _ in throw MathError.incrError }
        let throwsSqrt: (Int) throws -> Int = { $0 * $0 }
        
        let throwsAppying = apply(throwsIncr, throwsSqrt)
        XCTAssertThrowsError(try throwsAppying(2))
    }
    
    
    func testInOutApplyFunc() throws {
        struct Counter {
            var count = 2
        }
        
        let incr: (inout Counter) -> Void = { $0.count += 1 }
        let sqrt: (inout Counter) -> Void = { $0.count *= $0.count }
        
        let appying = apply(incr, sqrt)
        
        var counter = Counter()
        appying(&counter)
        XCTAssertEqual(counter.count, 9)
        
        // Test throwing version
        
        enum MathError: Error {
            case incrError
        }
        
        let throwsIncr: (inout Counter) throws -> Void = { _ in throw MathError.incrError }
        let throwsSqrt: (inout Counter) throws -> Void = { $0.count *= $0.count }
        
        let throwsAppying = apply(throwsIncr, throwsSqrt)
        XCTAssertThrowsError(try throwsAppying(&counter))
    }
    
    func testAnyObjectApplyFunc() throws {
        class Counter {
            var count = 2
        }
        
        let incr: (Counter) -> Void = { $0.count += 1 }
        let sqrt: (Counter) -> Void = { $0.count *= $0.count }
        
        let appying = apply(incr, sqrt)
        
        let counter = Counter()
        appying(counter)
        XCTAssertEqual(counter.count, 9)
        
        // Test throwing version
        
        enum MathError: Error {
            case incrError
        }
        
        let throwsIncr: (Counter) throws -> Void = { _ in throw MathError.incrError }
        let throwsSqrt: (Counter) throws -> Void = { $0.count *= $0.count }
        
        let throwsAppying = apply(throwsIncr, throwsSqrt)
        XCTAssertThrowsError(try throwsAppying(counter))
    }
}
