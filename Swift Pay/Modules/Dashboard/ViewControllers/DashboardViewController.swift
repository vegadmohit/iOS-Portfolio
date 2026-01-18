import UIKit
import Combine

final class DashboardViewController: UIViewController {

    @IBOutlet private weak var balanceLabel: UILabel!

    weak var coordinator: DashboardCoordinator?
    private let viewModel = DashboardViewModel()
    private var cancellables = Set<AnyCancellable>()

    // --------------------------------------
    // MARK: LifeCycle
    // --------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // --------------------------------------
    // MARK: Private
    // --------------------------------------

    private func bindViewModel() {
        viewModel.balancePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] balance in
                self?.balanceLabel.text = MoneyFormatter.format(balance)
            }
            .store(in: &cancellables)
    }
    
    // --------------------------------------
    // MARK: Event
    // --------------------------------------
    
    @IBAction private func addMoneyTapped(_ sender: UIButton) {
        coordinator?.showAddMoney()
    }

    @IBAction private func sendMoneyTapped(_ sender: UIButton) {
        coordinator?.showTransfer()
    }
}


