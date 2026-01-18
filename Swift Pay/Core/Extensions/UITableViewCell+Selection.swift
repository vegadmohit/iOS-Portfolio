import UIKit

extension UITableViewCell {
    func disableSelectEffect() {
        let view = UIView()
        view.backgroundColor = .clear
        selectedBackgroundView = view
    }
}
