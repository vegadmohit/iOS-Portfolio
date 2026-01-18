import Foundation

struct AmountTextFieldValidator {

    static func shouldAllowChange(
        currentText: String?,
        range: NSRange,
        replacement: String
    ) -> Bool {

        let currentText = currentText ?? MoneyConstants.currencySymbol

        if range.location == 0 { return false }

        let allowed = CharacterSet(charactersIn: "0123456789.")
        if replacement.rangeOfCharacter(from: allowed.inverted) != nil {
            return false
        }

        let ns = currentText as NSString
        let updated = ns.replacingCharacters(in: range, with: replacement)
        let numeric = updated.replacingOccurrences(of: MoneyConstants.currencySymbol, with: "")

        if numeric.filter({ $0 == "." }).count > 1 {
            return false
        }

        if let dot = numeric.firstIndex(of: ".") {
            let decimals = numeric.distance(from: dot, to: numeric.endIndex) - 1
            if decimals > 2 { return false }
        }

        if let value = Decimal(string: numeric), value < MoneyConstants.minimumAmount {
            return false
        }

        let digits = numeric.replacingOccurrences(of: ".", with: "")
        return digits.count <= MoneyConstants.maximumDigits
    }
}
