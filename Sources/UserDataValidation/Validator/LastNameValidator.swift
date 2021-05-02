public struct LastNameValidator {
    public enum LastNameError: Error {
        case tooLong
        case tooShort
    }

    public var nameLength: ClosedRange<UInt>

    public init(nameLength: ClosedRange<UInt>) {
        self.nameLength = nameLength
    }

    public func makeLastName(input: String) -> Result<LastName, LastNameError> {
        guard input.count <= nameLength.upperBound else {
            return .failure(.tooLong)
        }

        guard input.count >= nameLength.lowerBound else {
            return .failure(.tooShort)
        }

        let lastName = LastName(value: input)
        return .success(lastName)
    }
}
