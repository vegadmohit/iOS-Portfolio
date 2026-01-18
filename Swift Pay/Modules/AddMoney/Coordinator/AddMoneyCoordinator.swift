import UIKit

final class AddMoneyCoordinator: Coordinator {

    private let navigationController: UINavigationController
    var onFinish: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewModel = AddMoneyViewModel()

        let vc = storyboard.instantiateViewController(identifier: "AddMoneyViewController") { coder in
            AddMoneyViewController(coder: coder, viewModel: viewModel)
        }

        vc.onAddMoneySuccess = { [weak self] in
            self?.navigationController.popViewController(animated: true)
            self?.onFinish?()
        }

        navigationController.pushViewController(vc, animated: true)
    }
}
