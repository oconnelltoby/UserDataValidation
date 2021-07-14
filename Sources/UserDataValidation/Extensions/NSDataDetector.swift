import Foundation

extension NSDataDetector {
    static let optionalLink = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
    static let link = optionalLink!
}
