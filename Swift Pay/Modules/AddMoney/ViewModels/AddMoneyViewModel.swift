import Foundation

final class AddMoneyViewModel {

    private let wallet: WalletStoreService

    init(wallet: WalletStoreService = .shared) {
        self.wallet = wallet
    }

    func validateAmount(text: String?) -> (state: AddMoneyValidateState, value: Decimal?) {
        let result = AddMoneyValidator.validate(text)
        return (state: result.state, value: result.amount)
    }
    

    func addMoney(amount text: String?) -> Result<Void, AddMoneyError> {
        let (state, decimalAmount) = AddMoneyValidator.validate(text)
        switch state {
        case .valid:
            wallet.addMoney(amount: decimalAmount!)
            return .success(())
        case .invalid(let error):
            return .failure(error)
        }
    }

}


