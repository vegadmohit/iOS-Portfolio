import Foundation
import Combine

final class WalletStoreService {

    static let shared = WalletStoreService()

    @Published private(set) var transactions: [Transaction] = []

    private let storageKey = "wallet_transactions"

    private init() {
        load()
    }

    // MARK: - Derived State

    var currentBalance: Decimal {
        BalanceCalculator.calculate(from: transactions)
    }

    var balancePublisher: AnyPublisher<Decimal, Never> {
        $transactions
            .map { BalanceCalculator.calculate(from: $0) }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    // MARK: - Actions

    func addMoney(amount: Decimal, title: String = "Add Money") {
        insertTransaction(amount: amount, title: title, type: .income)
    }

    func addExpense(amount: Decimal, title: String) {
        insertTransaction(amount: amount, title: title, type: .expense)
    }

    // MARK: - Private

    private func insertTransaction(amount: Decimal,title: String,type: TransactionType) {
        let tx = Transaction(id: UUID(),amount: amount, date: Date(),title: title,
            type: type)
        transactions.insert(tx, at: 0)
        save()
    }

    // MARK: - Persistence

    private func save() {
        guard let data = try? JSONEncoder().encode(transactions) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private func load() {
        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let saved = try? JSONDecoder().decode([Transaction].self, from: data)
        else { return }

        transactions = saved
    }
}
