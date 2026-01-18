import Foundation

enum AddMoneyValidateState {
    case valid
    case invalid(AddMoneyError)
}

enum TransferValidateState {
    case valid
    case invalid(TransferError)
}
