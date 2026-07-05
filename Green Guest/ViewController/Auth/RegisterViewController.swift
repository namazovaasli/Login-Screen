

import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    
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
    private let azbutton = UIButton()
    private let enbutton = UIButton()
    private let symbol = UILabel()
    private let languageStack = UIStackView()
    
    private let guest = BaseButton(buttonStyle: .guest)
    private let google = BaseButton(buttonStyle: .google)
    private let apple = BaseButton(buttonStyle: .apple)
    private let register = BaseButton(buttonStyle: .register)
    private let socialStack = UIStackView()
    
    private let nameTextField = BaseTextFieldView(textFieldStyle: .name , 0)
    private let surnameTextField = BaseTextFieldView(textFieldStyle: .surname, 1)
    private let emailTextField = BaseTextFieldView(textFieldStyle: .email,2)
    private let phoneTextField = BaseTextFieldView(textFieldStyle: .phoneNumber,3)
    private let passwordTextField = BaseTextFieldView(textFieldStyle: .password,4)
    private let confirmPasswordTextField = BaseTextFieldView(textFieldStyle: .password,5)
    
    private let inputStack = UIStackView()
    private let textStack = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let agreementLabel = UILabel()
    private let agreementButton = UIButton()
    private let agreementStack = UIStackView()
    private let inputagreementStack = UIStackView()
    
    private let orLabel = UILabel()
    private let leftLine = UIView()
    private let rightLine = UIView()
    private let orStack = UIStackView()
    
    private let buttonStack = UIStackView()
    private let mainStack = UIStackView()
    private let passwordTextStack = UIStackView()
    
    private let loginLabel = UILabel()
    private let loginButton = UIButton()
    private let loginStack = UIStackView()
    
    
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
        
        titleLabel.text = "Hesab yaradın"
        titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textColor = UIColor(named: "maintext")
        
        subtitleLabel.text = "Bir-birindən fərqli aqroturizm fəaliyyətləri üçün qeydiyyatdan keçin!"
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = UIColor(named: "textfieldcolor")
        subtitleLabel.numberOfLines = 0
        
        agreementLabel.text = "İstifadə şərtlərini və məxfilik siyasətini oxudum və qəbul edirəm."
        agreementLabel.font = .systemFont(ofSize: 14)
        agreementLabel.textColor = UIColor(named: "maintext")
        agreementLabel.numberOfLines = 0
        
        leftLine.backgroundColor = .systemGray5
        orLabel.text = "Və ya"
        orLabel.font = .systemFont(ofSize: 12)
        orLabel.textColor = .gray
        orLabel.textAlignment = .center
        orLabel.setContentHuggingPriority(.required, for: .horizontal)
        orLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        rightLine.backgroundColor = .systemGray5
        loginLabel.text = "Hesabınız var?"
        loginLabel.textColor = UIColor(named: "maintext")
        loginLabel.font = UIFont.systemFont(ofSize: 13)
        
        loginButton.setTitle( "Daxil olun", for: .normal)
        loginButton.setTitleColor(UIColor(named: "forgetpas"), for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
    }
    
    private func setupLayout() {
        
        let scrollView = UIScrollView()
        let contentView = UIView()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
                make.edges.equalTo(view.safeAreaLayoutGuide)
            }
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view)
            }
        
        [azbutton, symbol, enbutton].forEach({languageStack.addArrangedSubview($0)})
        languageStack.axis = .horizontal
        languageStack.spacing = 2
        
        [agreementButton,agreementLabel].forEach {agreementStack.addArrangedSubview($0)}
        agreementStack.axis = .horizontal
        agreementStack.spacing = 8
        agreementStack.alignment = .center
        
        [nameTextField,surnameTextField,emailTextField,phoneTextField,passwordTextField,confirmPasswordTextField].forEach{inputStack.addArrangedSubview($0)}
        inputStack.axis = .vertical
        inputStack.spacing = 16
        
        [leftLine,orLabel,rightLine].forEach{orStack.addArrangedSubview($0)}
        orStack.axis = .horizontal
        orStack.spacing = 12
        orStack.alignment = .center
        
        [google,apple,guest].forEach{socialStack.addArrangedSubview($0)}
        socialStack.axis = .vertical
        socialStack.spacing = 12
        
        [titleLabel,subtitleLabel].forEach{textStack.addArrangedSubview($0)}
        textStack.axis = .vertical
        textStack.spacing = 8
        
        [loginLabel,loginButton].forEach{loginStack.addArrangedSubview($0)}
        loginStack.axis = .horizontal
        loginStack.spacing = 4
        loginStack.alignment = .center
        loginStack.distribution = .fill
        
        [textStack, inputStack, agreementStack, register, orStack, socialStack].forEach { mainStack.addArrangedSubview($0) }
        mainStack.axis = .vertical
        mainStack.spacing = 24
        mainStack.alignment = .fill
        
        contentView.addSubview(languageStack)
        contentView.addSubview(mainStack)
        contentView.addSubview(loginStack)
        
        languageStack.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        mainStack.snp.makeConstraints { make in
            make.top.equalTo(languageStack.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(32)
        }
        loginStack.snp.makeConstraints { make in
            make.top.equalTo(mainStack.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(10)
            }
        
        leftLine.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        rightLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(leftLine)
        }
        
        [nameTextField, surnameTextField, emailTextField, phoneTextField, passwordTextField, confirmPasswordTextField].forEach { field in
            field.snp.makeConstraints { make in
                make.height.equalTo(58)
            }
        }
        register.snp.makeConstraints { make in make.height.equalTo(48) }
        [google, apple, guest].forEach { button in
            button.snp.makeConstraints { make in
                make.height.equalTo(48)
            }
        }
    }
    
    func setupActions () {
        azbutton.tag = 0
        enbutton.tag = 1
        
        azbutton.addTarget(self, action: #selector(toggleLanguage(_ :)), for: .touchUpInside)
        enbutton.addTarget(self, action: #selector(toggleLanguage(_ :)), for: .touchUpInside)
        register.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        nameTextField.inputTextField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
            surnameTextField.inputTextField.addTarget(self, action: #selector(surnameChanged), for: .editingChanged)
            emailTextField.inputTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
            phoneTextField.inputTextField.addTarget(self, action: #selector(phoneChanged), for: .editingChanged)
            passwordTextField.inputTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
            confirmPasswordTextField.inputTextField.addTarget(self, action: #selector(confirmPasswordChanged), for: .editingChanged)
        
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    @objc
    private func didTapLogin() {
        router.pushVC(from: self, to: router.loginViewController())
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
    private func nameChanged() {
        let text = nameTextField.text ?? ""
            if text.isEmpty {
                nameTextField.resetValidationStatus()
            } else {
                let isValid = ValidationManager.isValidNameOrSurname(text)
                nameTextField.setValidationStatus(isValid: isValid)
            }
    }

    @objc
    private func surnameChanged() {
        let text = surnameTextField.text ?? ""
            if text.isEmpty {
                surnameTextField.resetValidationStatus()
            } else {
                let isValid = ValidationManager.isValidNameOrSurname(text)
                surnameTextField.setValidationStatus(isValid: isValid)
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
    private func passwordChanged() {
        let text = passwordTextField.text ?? ""
            if text.isEmpty {
                passwordTextField.resetValidationStatus()
            } else {
                let isValid = ValidationManager.isValidPassword(text)
                passwordTextField.setValidationStatus(isValid: isValid)
            }
            confirmPasswordChanged()
    }
    @objc
    private func confirmPasswordChanged() {
        let pass = passwordTextField.text ?? ""
        let confirmPass = confirmPasswordTextField.text ?? ""
        if confirmPass.isEmpty {
                confirmPasswordTextField.resetValidationStatus()
            } else {
                let isValid = (pass == confirmPass)
                confirmPasswordTextField.setValidationStatus(isValid: isValid)
            }
    }
    
    @objc
    private func didTapRegisterButton() {
        guard let name = nameTextField.text,
              let surname = surnameTextField.text,
              let email = emailTextField.text,
              let enteredPhone = phoneTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text else { return }
        
        let isNameValid = ValidationManager.isValidNameOrSurname(name)
        let isSurnameValid = ValidationManager.isValidNameOrSurname(surname)
        let isEmailValid = ValidationManager.isValidEmail(email)
        let isPhoneValid = ValidationManager.isValidPhone(enteredPhone)
        let isPasswordValid = ValidationManager.isValidPassword(password)
        let isConfirmValid = (password == confirmPassword) && !confirmPassword.isEmpty
        
        
        if !isNameValid || !isSurnameValid || !isEmailValid || !isPhoneValid || !isPasswordValid || !isConfirmValid {
            print("Qeydiyyatda xəta var, keçid bloklandı.")
            return
        }
        
        let fullPhoneNumber = "+994" + enteredPhone.replacingOccurrences(of: " ", with: "")
        let newUser = User(name: name, surname: surname, phone: fullPhoneNumber, email: email, password: password)
        
        let targetVC = router.mainTabbarController(user: newUser)
        router.changeRootViewController(viewController: targetVC)
    }
   
}
