import Foundation

enum AddMoneyError: LocalizedError {
    case empty
    case invalidAmount
    case minimumAmount

    var errorDescription: String? {
        switch self {
        case .empty:
            return "Please enter an amount"
        case .invalidAmount:
            return "Please enter a valid number"
        case .minimumAmount:
            return "Minimum add amount is £1"
        }
    }
}
