

import Foundation
import UIKit

protocol VerifyViewOutput: AnyObject {
    func configure()
    func didRequestVerify(code: String)
    func didRequestResendSMS()
}

final class VerifyViewController: UIViewController {
    @IBOutlet private weak var firstLabel: UILabel!
    @IBOutlet private weak var secondLabel: UILabel!
    @IBOutlet private weak var pinTextField: UITextField!
    @IBOutlet private weak var invalidCodeLabel: UILabel!
    @IBOutlet private weak var resendCodeButton: UIButton!

    var output: VerifyViewOutput?
    
    init() {
        super.init(nibName: VerifyViewController.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        setupActions()
        output?.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.shouldRemoveShadow(true)
    }
    
    
    func setupComponents() {
        firstLabel.text = "Введите код подтверждения"
        firstLabel.font = SFUIDisplay.bold.font(size: 20)
        secondLabel.font = SFUIDisplay.regular.font(size: 13)
        pinTextField.delegate = self
        setupResendButton()
        setupInvalidCodeLabel()
    }
    
    func setupActions() {
        resendCodeButton.addTarget(self, action: #selector(resendDidTap), for: .touchUpInside)
    }
    
    func setupResendButton() {
        resendCodeButton.isUserInteractionEnabled = true
        let atrrTitle = NSAttributedString(string: "Повторить сообщение", attributes: [.foregroundColor: UIColor.gray, .font: SFUIDisplay.semibold.font(size: 13)])
        resendCodeButton.setAttributedTitle(atrrTitle, for: .normal)
        resendCodeButton.backgroundColor = .white
    }
    
    func setupInvalidCodeLabel() {
        invalidCodeLabel.textAlignment = .center
        invalidCodeLabel.text = "Неверный код"
        invalidCodeLabel.textColor = .red
        invalidCodeLabel.isHidden = true
    }
    
    @objc
    func resendDidTap(_ sender: UIButton) {
        output?.didRequestResendSMS()
    }
}

extension VerifyViewController: VerifyViewInput {
    func setTitle(title: String) {
        secondLabel.text = "Мы отправили его на номер \(title)"
    }
    
    func startLoaiding() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            self.view.startLoader()
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.pinTextField.text?.removeAll()
            self.view.isUserInteractionEnabled = true
            self.view.stopLoader()
        }
    }
    
    func hideResendButtonWhenRequest() {
        resendCodeButton.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) {
            self.resendCodeButton.isUserInteractionEnabled = true
        }
    }
    
    func showError(message: String) {
        self.showErrorAlert(message: message)
    }
}

extension VerifyViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if !invalidCodeLabel.isHidden {
            invalidCodeLabel.isHidden = true
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString = textField.text ?? ""
        let newString = NSString(string: currentString).replacingCharacters(in: range, with: string)
        if newString.count == 4 {
            output?.didRequestVerify(code: newString)
        }
        return newString.count <= maxLength
    }
}
