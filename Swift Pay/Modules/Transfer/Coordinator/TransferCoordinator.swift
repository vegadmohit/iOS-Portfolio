import UIKit

final class TransferCoordinator: Coordinator {

    private let navigationController: UINavigationController
    var onFinish: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewModel = TransferViewModel()

        let vc = storyboard.instantiateViewController(
            identifier: "TransferViewController"
        ) { coder in
            TransferViewController(coder: coder, viewModel: viewModel)
        }

        vc.onTransferSuccess = { [weak self] in
            self?.navigationController.popViewController(animated: true)
            self?.onFinish?()
        }

        navigationController.pushViewController(vc, animated: true)
    }

}

