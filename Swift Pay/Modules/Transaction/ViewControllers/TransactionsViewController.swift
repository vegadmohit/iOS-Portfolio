import UIKit
import Combine

final class TransactionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    weak var coordinator: TransactionCoordinator?
    private let viewModel = TransactionsViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var transactions: [Transaction] = []

    // --------------------------------------
    // MARK: LifeCycle
    // --------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    // --------------------------------------
    // MARK: Private
    // --------------------------------------

    private func bind() {
        viewModel.transactionsPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
                self?.transactions = items
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}


extension TransactionsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as! TransactionTableViewCell
        cell.configure(with: transactions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
