import Foundation

enum AmountParser {
    static func toDecimal(from text: String?) -> Decimal? {
        guard let text = text, !text.isEmpty else { return nil }

        let cleaned = text
            .replacingOccurrences(of: MoneyConstants.currencySymbol, with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        guard let amount = Decimal(string: cleaned), amount > 0 else { return nil }

        return amount
    }
}
