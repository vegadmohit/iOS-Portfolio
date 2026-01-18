import UIKit

final class TransactionTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!

    private static let amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = MoneyConstants.currencySymbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        disableSelectEffect()
    }

    func configure(with transaction: Transaction) {
        titleLabel.text = transaction.title
        dateLabel.text = transaction.date.formatted()
        configureAmount(transaction)
    }

    // MARK: - Helpers
    private func configureAmount(_ transaction: Transaction) {
        let signedAmount = transaction.type == .income
            ? transaction.amount
            : transaction.amount * -1

        amountLabel.text = Self.amountFormatter.string(
            from: signedAmount as NSDecimalNumber
        )

        amountLabel.textColor = transaction.type == .income
            ? .systemGreen
            : .systemRed
    }
}
