import Foundation

struct MoneyFormatter {

    static func format(
        _ amount: Decimal,
        currencySymbol: String = MoneyConstants.currencySymbol
    ) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = MoneyConstants.maxDecimalPlaces
        formatter.maximumFractionDigits = MoneyConstants.maxDecimalPlaces

        let number = amount as NSDecimalNumber
        let formatted = formatter.string(from: number) ?? "0.00"

        return "\(currencySymbol)\(formatted)"
    }
}
