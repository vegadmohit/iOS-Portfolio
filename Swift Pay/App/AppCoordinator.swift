import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let window: UIWindow
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    // MARK: - Start
    func start() {
        let tabBarController = storyboard.instantiateInitialViewController() as! UITabBarController
        setupCoordinators(for: tabBarController)
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    private func setupCoordinators(for tabBarController: UITabBarController) {
        guard let viewControllers = tabBarController.viewControllers else { return }
        
        if let dashboardNav = viewControllers[0] as? UINavigationController,
           let dashboardVC = dashboardNav.viewControllers.first as? DashboardViewController {
            
            let dashboardCoordinator = DashboardCoordinator(navigationController: dashboardNav)
            dashboardCoordinator.parentCoordinator = self
            childCoordinators.append(dashboardCoordinator)
            dashboardVC.coordinator = dashboardCoordinator
        }
        
        if viewControllers.count > 1,
           let transactionsNav = viewControllers[1] as? UINavigationController,
           let transactionsVC = transactionsNav.viewControllers.first as? TransactionsViewController {
            
            let transactionCoordinator = TransactionCoordinator(navigationController: transactionsNav)
            transactionCoordinator.parentCoordinator = self
            childCoordinators.append(transactionCoordinator)
            
            transactionsVC.coordinator = transactionCoordinator
        }
    }
    
    func childDidFinish(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
