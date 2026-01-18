import Foundation

struct BalanceCalculator {

    static func calculate(from transactions: [Transaction]) -> Decimal {
        transactions.reduce(Decimal.zero) { total, transaction in
            switch transaction.type {
            case .income:
                return total + transaction.amount
            case .expense:
                return total - transaction.amount
            }
        }
    }
}
