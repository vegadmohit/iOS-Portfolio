import Foundation

final class TransferViewModel {

    private let wallet: WalletStoreService
    private let usersStore: UserStoreService

    init(
        wallet: WalletStoreService = .shared,
        usersStore: UserStoreService = .shared
    ) {
        self.wallet = wallet
        self.usersStore = usersStore
    }

    // MARK: - Outputs

    var currentUser: User? {
        usersStore.users.first
    }

    var currentBalance: Decimal {
        wallet.currentBalance
    }

    // MARK: - Actions
    func validateAmount(text: String?) -> (state: TransferValidateState, value: Decimal?) {
        let (state, amount) = TransferMoneyValidator.validate(text,
            currentBalance: wallet.currentBalance)
        return (state, amount)
    }

    
    
    func sendMoney(text: String?, note: String?) -> Result<Void, TransferError> {
        let (state, decimalAmount) = TransferMoneyValidator.validate(text, currentBalance: wallet.currentBalance)

        switch state {
        case .valid:
            guard let amount = decimalAmount else {
                return .failure(.invalidAmount)
            }

            guard let user = currentUser else {
                return .failure(.invalidUser)
            }

            let title = makeTitle(for: user, note: note)
            wallet.addExpense(amount: amount, title: title)
            return .success(())

        case .invalid(let error):
            return .failure(error)
        }
    }

    // MARK: - Helpers

    private func makeTitle(for user: User, note: String?) -> String {
        guard let note, !note.isEmpty else {
            return "Transfer to \(user.name)"
        }
        return "Transfer to \(user.name) — \(note)"
    }
}

