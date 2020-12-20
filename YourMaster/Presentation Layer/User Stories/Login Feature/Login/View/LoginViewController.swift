

import Foundation
import UIKit

protocol LoginViewOutput: AnyObject {
    func didRequesLogin(with phone: String)
}

final class LoginViewController: UIViewController {
    @IBOutlet private weak var firstLabel: UILabel!
    @IBOutlet private weak var secondLabel: UILabel!
    @IBOutlet private weak var numberTextField: UITextField!
    @IBOutlet private weak var continueButton: UIButton!
    
    private let output: LoginViewOutput
    private let maxNumbersCount = 18
    
    init(output: LoginViewOutput) {
        self.output = output
        super.init(nibName: LoginViewController.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        applyStyles()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupComponents() {
        numberTextField.delegate = self
        setupLabels()
        setupButton()
    }
    
    func applyStyles() {
        numberTextField.apply(.phoneStyle(fontSize: 23))
        continueButton.apply(.interactionDisabledStyle())
    }
    
    func setupActions() {
        continueButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    func setupLabels() {
        firstLabel.text = "Введите номер телефона"
        firstLabel.font = SFUIDisplay.bold.font(size: 23)
        firstLabel.minimumScaleFactor = 0.7
        firstLabel.adjustsFontSizeToFitWidth = true
        secondLabel.text = "Мы отправим на него код подтверждения"
        secondLabel.font = SFUIDisplay.regular.font(size: 16)
        secondLabel.minimumScaleFactor = 0.7
        secondLabel.adjustsFontSizeToFitWidth = true
        firstLabel.backgroundColor = .white
        secondLabel.backgroundColor = .white
    }
    
    func setupButton() {
        continueButton.layer.cornerRadius = 10
        continueButton.setTitle("Далее", for: .normal)
    }
    
    @objc
    func tap(_ sender: UIButton) {
        guard let phone = numberTextField.text else {
            return
        }
        let filteredPhone = phone.filter("+0123456789".contains)
        output.didRequesLogin(with: filteredPhone)
    }
}

extension LoginViewController: LoginViewInput {
    func startLoaiding() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            self.continueButton.startLoader()
            self.continueButton.setTitle("", for: .normal)
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.continueButton.stopLoader()
            self.continueButton.setTitle("Далее", for: .normal)
            self.view.endEditing(true)
        }
    }
    
    func showError(message: String) {
        self.showErrorAlert(message: message)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            textField.text = "+"
            return true
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let text = textField.text, text.count == 1 else {
            return
        }
        textField.text = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text {
            switch currentText.count {
            case 0:
                textField.text = "+"
            case 1:
                if string == "" {
                    break
                } else {
                    textField.text?.append(string)
                }
            case 2:
                if string == "" {
                    textField.text?.removeLast()
                } else {
                    let newText = " " + "(" + string
                    textField.text?.append(newText)
                }
            case 5:
                if string == "" {
                    textField.text?.removeLast(3)
                } else {
                    textField.text?.append(string)
                }
            case 6:
                if string == "" {
                    textField.text?.removeLast()
                } else {
                    let newText = string + ")"
                    textField.text?.append(newText)
                }
            case 8:
                if string == "" {
                    textField.text?.removeLast(2)
                } else {
                    let newText = " " + string
                    textField.text?.append(newText)
                }
            case 10:
                if string == "" {
                    textField.text?.removeLast(2)
                } else {
                    textField.text?.append(string)
                }
            case 11:
                if string == "" {
                    textField.text?.removeLast()
                } else {
                    let newText = string + "-"
                    textField.text?.append(newText)
                }
            case 14:
                if string == "" {
                    textField.text?.removeLast(2)
                } else {
                    let newText = string + "-"
                    textField.text?.append(newText)
                }
            case 12, 15:
                if string == "" {
                    textField.text?.removeLast()
                } else {
                    let newText = "-" + string
                    textField.text?.append(newText)
                }
            case 13, 16:
                if string == "" {
                    textField.text?.removeLast(2)
                } else {
                    textField.text?.append(string)
                }
            case 17:
                if string == "" {
                    textField.text?.removeLast(2)
                } else {
                    textField.text?.append(string)
                    continueButton.apply(.interactionEnaledStyle())
                }
            case 18:
                if string == "" {
                    textField.text?.removeLast()
                    continueButton.apply(.interactionDisabledStyle())
                }
            default:
                break
            }
        }
        return false
    }
}
