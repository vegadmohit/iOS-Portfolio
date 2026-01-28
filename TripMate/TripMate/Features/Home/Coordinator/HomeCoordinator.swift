import UIKit

final class HomeCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            fatalError("HomeViewController not found")
        }
        homeVC.viewModel = HomeViewModel()
        homeVC.navigator = self
        navigationController.setViewControllers([homeVC], animated: false)
    }
}

// MARK: - Navigation
extension HomeCoordinator: HomeNavigator {

    func navigateToDetail(place: AttractionModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "PlaceDetailViewController") as? PlaceDetailViewController else {
            return
        }
        detailVC.attraction = place
        navigationController.pushViewController(detailVC, animated: true)
    }
}
