import XCTest
@testable import UserDataValidation

final class FirstNameValidatorTests: XCTestCase {
    typealias Result = Swift.Result<FirstName, FirstNameValidator.FirstNameError>
    var validator: FirstNameValidator!

    override func setUp() {
        validator = FirstNameValidator(nameLength: 1...50)
    }
    
    func testTooLongFirstName() {
        let expectedOutput: Result = .failure(.tooLong)
        let input = String(repeating: "A", count: 51)
        let output = validator.makeFirstName(input: input)
        XCTAssertEqual(expectedOutput, output)
    }

    func testLongestFirstName() throws {
        let input = String(repeating: "A", count: 50)
        let output = validator.makeFirstName(input: input)
        XCTAssertEqual(input, try output.get().value)
    }

    func testTooShortName() {
        let expectedOutput: Result = .failure(.tooShort)
        let input = ""
        let output = validator.makeFirstName(input: input)
        XCTAssertEqual(expectedOutput, output)
    }

    func testShortestName() {
        let input = "A"
        let output = validator.makeFirstName(input: input)
        XCTAssertEqual(input, try output.get().value)
    }
}
