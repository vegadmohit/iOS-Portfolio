import Foundation

struct TransferMoneyValidator {
    
    static func validate(_ text: String?, currentBalance: Decimal, minimum: Decimal = MoneyConstants.minimumAmount) -> (state: TransferValidateState, amount: Decimal?) {
        
        guard let text = text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
            return (.invalid(.empty), nil)
        }

        guard let amount = AmountParser.toDecimal(from: text) else {
            return (.invalid(.invalidAmount), nil)
        }

        if amount < minimum {
            return (.invalid(.minimumAmount), amount)
        }

        if amount > currentBalance {
            return (.invalid(.insufficientBalance), amount)
        }
        
        return (.valid, amount)
    }
}
