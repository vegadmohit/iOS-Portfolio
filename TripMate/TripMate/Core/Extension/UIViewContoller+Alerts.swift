import Foundation

import UIKit

extension UIViewController {

    func showAlert(title: String = "Error", message: String, actionTitle: String = "OK") {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default))
        self.present(alert, animated: true)
    }

    func showRetryAlert(title: String = "Error",
                        message: String,
                        retryTitle: String = "Retry",
                        cancelTitle: String = "Cancel",
                        retryAction: @escaping () -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: retryTitle, style: .default) { _ in retryAction() })
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel))
        self.present(alert, animated: true)
    }
}

