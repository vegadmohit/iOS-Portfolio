import Foundation

enum TransferError: LocalizedError {
    case empty
    case invalidAmount
    case minimumAmount
    case invalidUser
    case insufficientBalance
    
    
    var errorDescription: String? {
        switch self {
        case .empty:
            return "Please enter an amount"
        case .invalidAmount:
            return "Please enter a valid number"
        case .minimumAmount:
            return "Minimum add amount is £1"
            
        case .invalidUser:
            return "User not available"
        case .insufficientBalance:
            return "Insufficient balance"
        }
    }
}

