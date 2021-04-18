import Foundation

public struct FirstNameValidator {
    public enum FirstNameError: Error {
        case tooLong
        case tooShort
    }

    var nameLength: ClosedRange<Int>

    public init(nameLength: ClosedRange<Int>) {
        self.nameLength = nameLength
    }

    public func makeFirstName(input: String) -> Result<FirstName, FirstNameError> {
        guard input.count <= nameLength.upperBound else {
            return .failure(.tooLong)
        }

        guard input.count >= nameLength.lowerBound else {
            return .failure(.tooShort)
        }

        let firstName = FirstName(value: input)
        return .success(firstName)
    }
}
