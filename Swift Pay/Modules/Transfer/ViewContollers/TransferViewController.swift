import UIKit

final class TransferViewController: UIViewController {

    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var noteTextField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var transferButton: UIButton!
    @IBOutlet private weak var transferMoneyButtonBottomConstraint: NSLayoutConstraint!
    
    var viewModel: TransferViewModel!
    var onTransferSuccess: (() -> Void)?
    var onTransferFailure: ((TransferError) -> Void)?

    // --------------------------------------
    // MARK: Initialization
    // --------------------------------------

    init?(coder: NSCoder, viewModel: TransferViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
   
    required init?(coder: NSCoder) {
        fatalError("Use init(coder:viewModel:) instead")
    }

    // --------------------------------------
    // MARK: LifeCycle
    // --------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardAvoidance()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        amountTextField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        KeyboardAvoidance.shared.unbind()
    }

    // --------------------------------------
    // MARK: Private
    // --------------------------------------
    
    private func setupUI() {
        amountTextField.text = MoneyConstants.currencySymbol
        amountTextField.delegate = self
        amountTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        errorLabel.isHidden = true
        disableButton()
    }

    private func setupKeyboardAvoidance() {
        KeyboardAvoidance.shared.bind(
            to: view,
            bottomConstraint: transferMoneyButtonBottomConstraint,
            defaultConstant: LayoutConstants.buttonBottomSpacing
        )
    }

    // --------------------------------------
    // MARK: Event
    // --------------------------------------
    
    @IBAction private func transferTapped(_ sender: UIButton) {
        let result = viewModel.sendMoney(text: amountTextField.text, note: noteTextField.text)
        switch result {
        case .success:
            onTransferSuccess?()
        case .failure(let error):
            showError(error.localizedDescription)
        }
    }
}

// --------------------------------------
// MARK: UITextfield Delegate
// --------------------------------------

extension TransferViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == amountTextField else { return true }
        return AmountTextFieldValidator.shouldAllowChange(currentText: textField.text, range: range, replacement: string)
    }
}

extension TransferViewController {
    
    @objc private func textDidChange() {
        let (state, _) = viewModel.validateAmount(text: amountTextField.text)
        switch state {
        case .valid:
            hideError()
            enableButton()
        case .invalid(let error):
            showError(error.localizedDescription)
            disableButton()
        }
    }

    // --------------------------------------
    // MARK: UI Helper
    // --------------------------------------

    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }

    private func hideError() {
        errorLabel.isHidden = true
    }

    private func enableButton() {
        transferButton.isEnabled = true
        transferButton.alpha = 1.0
    }

    private func disableButton() {
        transferButton.isEnabled = false
        transferButton.alpha = 0.5
    }
}
