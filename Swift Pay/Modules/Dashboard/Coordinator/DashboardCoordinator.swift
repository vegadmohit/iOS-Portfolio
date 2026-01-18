import UIKit

final class DashboardCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(
            withIdentifier: "DashboardViewController"
        ) as! DashboardViewController
        
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func showAddMoney() {
        let coordinator = AddMoneyCoordinator(
            navigationController: navigationController
        )
        
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.childCoordinators.removeAll { $0 === coordinator }
        }
        
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func showTransfer() {
        let coordinator = TransferCoordinator(
            navigationController: navigationController
        )
        
        coordinator.onFinish = { [weak self, weak coordinator] in
            self?.childCoordinators.removeAll { $0 === coordinator }
        }
        
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
