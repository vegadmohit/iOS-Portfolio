import UIKit

class AddMoneyViewController: UIViewController {
    
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var addMoneyButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var addMoneyButtonBottomConstraint: NSLayoutConstraint!
    
    private let viewModel: AddMoneyViewModel
    var onAddMoneySuccess: (() -> Void)?
    
    // --------------------------------------
    // MARK: Initialization
    // --------------------------------------
    
    init?(coder: NSCoder, viewModel: AddMoneyViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init instead")
    }
    
    // --------------------------------------
    // MARK: LifeCycle
    // --------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        KeyboardAvoidance.shared.bind(to: view, bottomConstraint: addMoneyButtonBottomConstraint,
            defaultConstant: LayoutConstants.buttonBottomSpacing)
        disableButton()
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
        amountTextField.delegate = self
        amountTextField.text = MoneyConstants.currencySymbol
        errorLabel.isHidden = true
        amountTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    // --------------------------------------
    // MARK: Event
    // --------------------------------------
    
    @IBAction private func addMoneyTapped(_ sender: UIButton) {
        let result = viewModel.addMoney(amount: amountTextField.text)
        switch result {
        case .success:
            onAddMoneySuccess?()
        case .failure(let error):
            showError(error.localizedDescription)
        }
    }
}

extension AddMoneyViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
        AmountTextFieldValidator.shouldAllowChange(currentText: textField.text,range: range,replacement: string)
    }
}

extension AddMoneyViewController {
    
    @objc private func textDidChange() {
        let (state, decimalAmount) = viewModel.validateAmount(text: amountTextField.text)
        switch state {
        case .valid:
            hideError()
            enableButton()
        case .invalid(let error):
            showError(error.localizedDescription)
            disableButton()
        }
    }
    
    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    private func hideError() {
        errorLabel.isHidden = true
    }
    
    private func disableButton() {
        addMoneyButton.isEnabled = false
        addMoneyButton.alpha = 0.5
    }
    
    private func enableButton() {
        addMoneyButton.isEnabled = true
        addMoneyButton.alpha = 1.0
    }
}

