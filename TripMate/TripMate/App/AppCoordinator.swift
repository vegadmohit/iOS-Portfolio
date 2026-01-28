import UIKit

final class AppCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBarController = storyboard.instantiateInitialViewController() as? UITabBarController else { return }

        if let homeNav = tabBarController.viewControllers?[0] as? UINavigationController {
            let homeCoordinator = HomeCoordinator(navigationController: homeNav)
            homeCoordinator.parentCoordinator = self
            childCoordinators.append(homeCoordinator)
            homeCoordinator.start()
        }

        if tabBarController.viewControllers?.count ?? 0 > 1,
           let _ = tabBarController.viewControllers?[1] as? UINavigationController {
            
        }

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    func childDidFinish(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}


