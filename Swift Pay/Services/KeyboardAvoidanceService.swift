import UIKit

final class KeyboardAvoidance {

    static let shared = KeyboardAvoidance()

    private var bottomConstraint: NSLayoutConstraint?
    private var defaultConstant: CGFloat = 0
    private weak var view: UIView?

    private init() {}

    func bind(
        to view: UIView,
        bottomConstraint: NSLayoutConstraint,
        defaultConstant: CGFloat
    ) {
        self.view = view
        self.bottomConstraint = bottomConstraint
        self.defaultConstant = defaultConstant

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func unbind() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let view = view
        else { return }

        let keyboardHeight = frame.height
        let safeBottom = view.safeAreaInsets.bottom

        bottomConstraint?.constant = keyboardHeight - safeBottom + 8

        UIView.animate(withDuration: duration) {
            view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let view = view
        else { return }

        bottomConstraint?.constant = defaultConstant

        UIView.animate(withDuration: duration) {
            view.layoutIfNeeded()
        }
    }
}
