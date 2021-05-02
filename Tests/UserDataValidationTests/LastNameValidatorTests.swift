import XCTest
@testable import UserDataValidation

final class LastNameValidatorTests: XCTestCase {
    typealias Result = Swift.Result<LastName, LastNameValidator.LastNameError>
    var validator: LastNameValidator!

    override func setUp() {
        validator = LastNameValidator(nameLength: 1...50)
    }
    
    func testTooLongLastName() {
        let expectedOutput: Result = .failure(.tooLong)
        let input = String(repeating: "A", count: 51)
        let output = validator.makeLastName(input: input)
        XCTAssertEqual(expectedOutput, output)
    }

    func testLongestLastName() throws {
        let input = String(repeating: "A", count: 50)
        let output = validator.makeLastName(input: input)
        XCTAssertEqual(input, try output.get().value)
    }

    func testTooShortName() {
        let expectedOutput: Result = .failure(.tooShort)
        let input = ""
        let output = validator.makeLastName(input: input)
        XCTAssertEqual(expectedOutput, output)
    }

    func testShortestName() {
        let input = "A"
        let output = validator.makeLastName(input: input)
        XCTAssertEqual(input, try output.get().value)
    }
}
