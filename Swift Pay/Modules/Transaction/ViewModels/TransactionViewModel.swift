import Combine

final class TransactionsViewModel {

    private let wallet = WalletStoreService.shared

    var transactionsPublisher: AnyPublisher<[Transaction], Never> {
        wallet.$transactions
            .eraseToAnyPublisher()
    }
}
