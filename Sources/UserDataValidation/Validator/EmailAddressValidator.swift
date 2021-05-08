import Foundation

public struct EmailAddressValidator {
    private var dataDetector: NSDataDetector
    
    public enum EmailAddressError: Error {
        case tooLong
        case tooShort
        case invalidFormat
    }

    public var emailAddressLength: ClosedRange<UInt>

    public init(emailAddressLength: ClosedRange<UInt>) throws {
        self.emailAddressLength = emailAddressLength
        
        dataDetector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
    }

    public func makeEmailAddress(input: String) -> Result<EmailAddress, EmailAddressError> {
        guard input.count <= emailAddressLength.upperBound else {
            return .failure(.tooLong)
        }

        guard input.count >= emailAddressLength.lowerBound else {
            return .failure(.tooShort)
        }
        
        let range = NSMakeRange(0, NSString(string: input).length)
        if dataDetector.firstMatch(in: input, options: [], range: range) == nil {
            return .failure(.invalidFormat)
        }

        let emailAddress = EmailAddress(value: input)
        return .success(emailAddress)
    }
}

