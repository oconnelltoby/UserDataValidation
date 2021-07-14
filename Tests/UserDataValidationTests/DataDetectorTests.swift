import XCTest
@testable import UserDataValidation

final class DataDetectorTests: XCTestCase {
    func testLinkIsNotNil() {
        XCTAssertNotNil(NSDataDetector.optionalLink)
    }
}
