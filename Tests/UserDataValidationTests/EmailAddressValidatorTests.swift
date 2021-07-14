import XCTest
@testable import UserDataValidation

final class EmailAddressValidatorTests: XCTestCase {
    typealias Result = Swift.Result<EmailAddress, EmailAddressValidator.EmailAddressError>
    var validator: EmailAddressValidator!

    override func setUpWithError() throws {
        validator = EmailAddressValidator(emailAddressLength: 1...50)
    }
    
    func testTooLongEmailAddress() {
        let expectedOutput: Result = .failure(.tooLong)
        let input = String(repeating: "A", count: 51)
        let output = validator.makeEmailAddress(input: input)
        XCTAssertEqual(expectedOutput, output)
    }

    func testLongestEmailAddress() throws {
        let emailAddress = "A@A.A"
        let input = emailAddress + String(repeating: "A", count: 50 - emailAddress.count)
        let output = validator.makeEmailAddress(input: input)
        XCTAssertEqual(input, try output.get().value)
    }

    func testTooShortEmailAddress() {
        let expectedOutput: Result = .failure(.tooShort)
        let input = ""
        let output = validator.makeEmailAddress(input: input)
        XCTAssertEqual(expectedOutput, output)
    }

    func testShortestEmailAddress() {
        let input = "A@A.A"
        let output = validator.makeEmailAddress(input: input)
        XCTAssertEqual(input, try output.get().value)
    }
    
    func testInvalidFormatEmailAddresses() {
        let invalidEmailAddresses = [
            "A",
            "A@A",
            "A.A",
            "@."
        ]
        
        invalidEmailAddresses.forEach { input in
            let expectedOutput: Result = .failure(.invalidFormat)
            let output = validator.makeEmailAddress(input: input)
            XCTAssertEqual(expectedOutput, output)
        }
    }
}
