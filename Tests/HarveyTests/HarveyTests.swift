import XCTest
@testable import Harvey

class HarveyTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(Harvey().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
