import Foundation

struct AddMoneyValidator {
    
    static func validate(_ text: String?, minimum: Decimal = MoneyConstants.minimumAmount) -> (state: AddMoneyValidateState, amount: Decimal?) {
        
        guard let text = text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
            return (.invalid(.empty), nil)
        }

        guard let amount = AmountParser.toDecimal(from: text) else {
            return (.invalid(.invalidAmount), nil)
        }

        if amount < minimum {
            return (.invalid(.minimumAmount), amount)
        }

        return (.valid, amount)
    }
}
