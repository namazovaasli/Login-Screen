//
//  ViewController.swift
//  Login Screen
//
//  Created by Əsli Namazova on 11.06.26.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    private let azbutton = UIButton()
    private let enbutton = UIButton()
    private let symbol = UILabel()
    private let languageStack = UIStackView()
    
    private let guest = BaseButton(buttonStyle: .guest)
    private let google = BaseButton(buttonStyle: .google)
    private let apple = BaseButton(buttonStyle: .apple)
    private let login = BaseButton(buttonStyle: .login)
    private let socialStack = UIStackView()
    
    private let phoneTextField = BaseTextFieldView(textFieldStyle: .phoneNumber,0)
    private let emailTextField = BaseTextFieldView(textFieldStyle: .email,1)
    private let passwordTextField = BaseTextFieldView(textFieldStyle: .password)
    
    private let inputStack = UIStackView()
    
    private let welcomeLabel = UILabel()
    private let forgetPasswordButton = UIButton()
    private let inputWithForgetStack = UIStackView()
    
    private let orLabel = UILabel()
    private let leftLine = UIView()
    private let rightLine = UIView()
    private let orStack = UIStackView()
    
    private let buttonStack = UIStackView()
    private let mainStack = UIStackView()
    
    private let registerLabel = UILabel()
    private let registerButton = UIButton()
    private let registerStack = UIStackView()
    
    private let router : AppRouterProtocol
    
    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupActions()
        setupUI()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupUI() {
        azbutton.setTitle("AZ", for: .normal)
        symbol.text = "|"
        symbol.textColor = .gray
        enbutton.setTitle("EN", for: .normal)
        azbutton.setTitleColor(UIColor.gray, for: .normal)
        enbutton.setTitleColor(UIColor.gray, for: .normal)
        
        welcomeLabel.text = "Xoş gəlmisiniz!"
        welcomeLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        welcomeLabel.textColor = UIColor(named: "maintext")
        forgetPasswordButton.setTitle("Şifrəni unutdunuz?", for: .normal)
        forgetPasswordButton.setTitleColor(UIColor(named: "forgetpas"),for: .normal)
        forgetPasswordButton.titleLabel?.font = .systemFont(ofSize: 14 , weight: .medium)
        forgetPasswordButton.contentHorizontalAlignment = .right
        
        leftLine.backgroundColor = .systemGray5
        orLabel.text = "Və ya"
        orLabel.font = .systemFont(ofSize: 12)
        orLabel.textColor = .gray
        orLabel.textAlignment = .center
        orLabel.setContentHuggingPriority(.required, for: .horizontal)
        orLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        rightLine.backgroundColor = .systemGray5
        registerLabel.text = "Hesabınız yoxdur?"
        registerLabel.textColor = UIColor(named: "maintext")
        registerLabel.font = UIFont.systemFont(ofSize: 13)
        
        registerButton.setTitle( "Qeydiyyatdan keçin", for: .normal)
        registerButton.setTitleColor(UIColor(named: "forgetpas"), for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
    }
    
    private func setupLayout() {
        [azbutton, symbol, enbutton].forEach({languageStack.addArrangedSubview($0)})
        languageStack.axis = .horizontal
        languageStack.spacing = 2
        
        [phoneTextField,emailTextField,passwordTextField].forEach{inputStack.addArrangedSubview($0)}
        inputStack.axis = .vertical
        inputStack.spacing = 16
        inputStack.distribution = .fillEqually
        
        [inputStack,forgetPasswordButton].forEach{inputWithForgetStack.addArrangedSubview($0)}
        inputWithForgetStack.axis = .vertical
        inputWithForgetStack.spacing = 8
        
        [leftLine,orLabel,rightLine].forEach{orStack.addArrangedSubview($0)}
        orStack.axis = .horizontal
        orStack.spacing = 12
        orStack.alignment = .center
        orStack.distribution = .fill
        
        [google,apple,guest].forEach{socialStack.addArrangedSubview($0)}
        socialStack.axis = .vertical
        socialStack.spacing = 12
        socialStack.distribution = .equalCentering
        
        [login,orStack,socialStack].forEach{buttonStack.addArrangedSubview($0)}
        buttonStack.axis = .vertical
        buttonStack.spacing = 12
        
        [welcomeLabel,inputWithForgetStack,buttonStack].forEach{mainStack.addArrangedSubview($0)}
        mainStack.axis = .vertical
        mainStack.spacing = 24
        mainStack.alignment = .fill
        
        
        [registerLabel,registerButton].forEach{registerStack.addArrangedSubview($0)}
        registerStack.axis = .horizontal
        registerStack.spacing = 4
        registerStack.alignment = .center
        
        
        [languageStack,mainStack,registerStack].forEach { view.addSubview($0) }
        
        languageStack.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalToSuperview().inset(14)
        }
        
        mainStack.snp.makeConstraints { make in
            make.top.equalTo(languageStack.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(inputWithForgetStack.snp.bottom).offset(28)
        }
        
        leftLine.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        rightLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(leftLine)
        }
        
        registerStack.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupActions () {
        azbutton.tag = 0
        enbutton.tag = 1
        
        azbutton.addTarget(self, action: #selector(toggleLanguage(_ :)), for: .touchUpInside)
        enbutton.addTarget(self, action: #selector(toggleLanguage(_ :)), for: .touchUpInside)
        
        forgetPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        login.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        phoneTextField.inputTextField.addTarget(self, action: #selector(phoneChanged), for: .editingChanged)
            emailTextField.inputTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
            passwordTextField.inputTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }
    
    @objc
    func toggleLanguage (_ sender :UIButton) {
        switch sender.tag {
        case 0 :
            azbutton.setTitleColor(UIColor.black, for: .normal)
            enbutton.setTitleColor(UIColor.gray, for: .normal)
            
        case 1 :
            azbutton.setTitleColor(UIColor.gray, for: .normal)
            enbutton.setTitleColor(UIColor.black, for: .normal)
        default :
            return
        }
    }
    @objc
    private func didTapRegister() {
        router.pushVC(from: self, to: router.registerViewController())
    }
    @objc
    private func didTapForgotPassword() {
        router.pushVC(from: self, to: router.forgotPasswordViewController())
    }
    
    @objc
    private func phoneChanged() {
        let text = phoneTextField.text ?? ""
            if text.isEmpty {
                phoneTextField.resetValidationStatus()
            } else {
                let isValid = ValidationManager.isValidPhone(text)
                phoneTextField.setValidationStatus(isValid: isValid)
            }
    }

    @objc
    private func emailChanged() {
        let text = emailTextField.text ?? ""
            if text.isEmpty {
                emailTextField.resetValidationStatus()
            } else {
                let isValid = ValidationManager.isValidEmail(text)
                emailTextField.setValidationStatus(isValid: isValid)
            }
    }

    @objc
    private func passwordChanged() {
        let text = passwordTextField.text ?? ""
            if text.isEmpty {
                passwordTextField.resetValidationStatus()
            } else {
                let isValid = ValidationManager.isValidPassword(text)
                passwordTextField.setValidationStatus(isValid: isValid)
            }
    }
    @objc
    private func didTapLoginButton() {
        guard let enteredPhone = phoneTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        let isPhoneValid = ValidationManager.isValidPhone(enteredPhone)
        let isEmailValid = ValidationManager.isValidEmail(email)
        let isPasswordValid = ValidationManager.isValidPassword(password)
        
        if !isPhoneValid || !isEmailValid || !isPasswordValid {
            print("Logində xəta var, keçid dayandırıldı.")
            return
        }
        
        let fullPhoneNumber = "+994" + enteredPhone.replacingOccurrences(of: " ", with: "")
        let user = User(name: "", surname: "", phone: fullPhoneNumber, email: email, password: password)
        
        let targetVC = router.mainTabbarController(user: user)
        router.changeRootViewController(viewController: targetVC)
    }
}






