import Foundation
import Combine

final class DashboardViewModel {

    private let wallet = WalletStoreService.shared

    var balancePublisher: AnyPublisher<Decimal, Never> {
        wallet.$transactions
            .map { BalanceCalculator.calculate(from: $0) }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
