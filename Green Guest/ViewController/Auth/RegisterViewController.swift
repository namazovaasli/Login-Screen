
import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    
    private let router: AppRouterProtocol
    
    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private let nameTextField = BaseTextFieldView(textFieldStyle: .name, 0)
    private let surnameTextField = BaseTextFieldView(textFieldStyle: .surname, 1)
    private let emailTextField = BaseTextFieldView(textFieldStyle: .email, 2)
    private let phoneTextField = BaseTextFieldView(textFieldStyle: .phoneNumber, 3)
    private let passwordTextField = BaseTextFieldView(textFieldStyle: .password, 4)
    private let confirmPasswordTextField = BaseTextFieldView(textFieldStyle: .confirmPassword, 5)
    private let passwordHintLabel = UILabel()
    
    private let inputStack = UIStackView()
    private let textStack = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let agreementLabel = UILabel()
    private let agreementButton = UIButton()
    private let agreementStack = UIStackView()
    
    private let orLabel = UILabel()
    private let leftLine = UIView()
    private let rightLine = UIView()
    private let orStack = UIStackView()
    
    private let mainStack = UIStackView()
    private let loginLabel = UILabel()
    private let loginButton = UIButton()
    private let loginStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupLayout()
        setupActions()
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
        azbutton.setTitleColor(.black, for: .normal)
        azbutton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        
        symbol.text = "|"
        symbol.textColor = .systemGray3
        symbol.font = .systemFont(ofSize: 14)
        
        enbutton.setTitle("EN", for: .normal)
        enbutton.setTitleColor(.systemGray, for: .normal)
        enbutton.titleLabel?.font = .systemFont(ofSize: 14)
        
        titleLabel.text = "Hesab yaradın"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = UIColor(named: "maintext")
        
        subtitleLabel.text = "Bir-birindən fərqli aqroturizm fəaliyyətləri üçün qeydiyyatdan keçin!"
        subtitleLabel.font = .systemFont(ofSize: 15)
        subtitleLabel.textColor = UIColor(named: "textfieldcolor")
        subtitleLabel.numberOfLines = 0
        
        emailTextField.firstLabel.text = "E-poçt ünvanınız"
        
        setupPasswordHint()
        
        agreementButton.setImage(
            UIImage(systemName: "checkmark.circle.fill")?
                .withRenderingMode(.alwaysTemplate),
            for: .selected)
        agreementButton.setImage(
            UIImage(systemName: "circle")?
                .withRenderingMode(.alwaysTemplate),
            for: .normal)
        agreementButton.tintColor = UIColor(named: "mainbuttoncolor")
        agreementButton.isSelected = false
        
        setupAgreementLabel()
        
        leftLine.backgroundColor = .systemGray4
        rightLine.backgroundColor = .systemGray4
        
        orLabel.text = "Və ya"
        orLabel.font = .systemFont(ofSize: 14)
        orLabel.textColor = .systemGray
        orLabel.textAlignment = .center
        orLabel.setContentHuggingPriority(.required, for: .horizontal)
        orLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        loginLabel.text = "Hesabınız var?"
        loginLabel.textColor = UIColor(named: "maintext")
        loginLabel.font = .systemFont(ofSize: 14)
        
        loginButton.setTitle("Daxil olun", for: .normal)
        loginButton.setTitleColor(UIColor(named: "mainbuttoncolor"), for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        
        register.setTitle("Qeydiyyatdan keçin", for: .normal)
    }
    
    private func setupPasswordHint() {
        let hintText = "Şifrə ən az 8 simvoldan ibarət olmalı və ən azı 1 böyük hərf, 1 rəqəm və 1 xüsusi simvol ehtiva etməlidir."
        let attributed = NSMutableAttributedString(string: hintText)
        let green = UIColor(named: "mainbuttoncolor") ?? .systemGreen
        let gray = UIColor.secondaryLabel
        
        attributed.addAttribute(.foregroundColor, value: gray,
                                range: NSRange(location: 0, length: hintText.count))
        
        ["8 simvoldan", "1 böyük hərf", "1 rəqəm", "1 xüsusi simvol"].forEach { part in
            if let range = hintText.range(of: part) {
                attributed.addAttribute(.foregroundColor, value: green,
                                        range: NSRange(range, in: hintText))
            }
        }
        
        passwordHintLabel.attributedText = attributed
        passwordHintLabel.font = .systemFont(ofSize: 12)
        passwordHintLabel.numberOfLines = 0
    }
    
    private func setupAgreementLabel() {
        let fullText = "İstifadə şərtlərini və məxfilik siyasətini oxudum və qəbul edirəm."
        let attributed = NSMutableAttributedString(string: fullText)
        let green = UIColor(named: "mainbuttoncolor") ?? .systemGreen
        
        attributed.addAttribute(.foregroundColor, value: UIColor.label,
                                range: NSRange(location: 0, length: fullText.count))
        
        [("İstifadə şərtlərini", green), ("məxfilik siyasətini", green)].forEach { part, color in
            if let range = fullText.range(of: part) {
                let nsRange = NSRange(range, in: fullText)
                attributed.addAttribute(.underlineStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: nsRange)
                attributed.addAttribute(.foregroundColor, value: color,
                                        range: nsRange)
            }
        }
        
        agreementLabel.attributedText = attributed
        agreementLabel.font = .systemFont(ofSize: 14)
        agreementLabel.numberOfLines = 0
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
        
        [azbutton, symbol, enbutton].forEach { languageStack.addArrangedSubview($0) }
        languageStack.axis = .horizontal
        languageStack.spacing = 4
        
        [titleLabel, subtitleLabel].forEach { textStack.addArrangedSubview($0) }
        textStack.axis = .vertical
        textStack.spacing = 8
        
        let passwordGroup = UIStackView()
        passwordGroup.axis = .vertical
        passwordGroup.spacing = 6
        passwordGroup.addArrangedSubview(passwordTextField)
        passwordGroup.addArrangedSubview(passwordHintLabel)
        
        [nameTextField, surnameTextField, emailTextField,
         phoneTextField, passwordGroup, confirmPasswordTextField]
            .forEach { inputStack.addArrangedSubview($0) }
        inputStack.axis = .vertical
        inputStack.spacing = 16
        
        [agreementButton, agreementLabel].forEach { agreementStack.addArrangedSubview($0) }
        agreementStack.axis = .horizontal
        agreementStack.spacing = 10
        agreementStack.alignment = .top
        
        [leftLine, orLabel, rightLine].forEach { orStack.addArrangedSubview($0) }
        orStack.axis = .horizontal
        orStack.spacing = 12
        orStack.alignment = .center
        
        [google, apple, guest].forEach { socialStack.addArrangedSubview($0) }
        socialStack.axis = .vertical
        socialStack.spacing = 12
        
        [loginLabel, loginButton].forEach { loginStack.addArrangedSubview($0) }
        loginStack.axis = .horizontal
        loginStack.spacing = 4
        loginStack.alignment = .center
        
        [textStack, inputStack, agreementStack,
         register, orStack, socialStack].forEach { mainStack.addArrangedSubview($0) }
        mainStack.axis = .vertical
        mainStack.spacing = 24
        mainStack.alignment = .fill
        
        contentView.addSubview(languageStack)
        contentView.addSubview(mainStack)
        contentView.addSubview(loginStack)
        
        languageStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        mainStack.snp.makeConstraints { make in
            make.top.equalTo(languageStack.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        loginStack.snp.makeConstraints { make in
            make.top.equalTo(mainStack.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
        leftLine.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        rightLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(leftLine)
        }
        
        [nameTextField, surnameTextField, emailTextField,
         phoneTextField, passwordTextField, confirmPasswordTextField].forEach { field in
            field.snp.makeConstraints { make in
                make.height.equalTo(58)
            }
        }
        
        agreementButton.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
        
        register.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        [google, apple, guest].forEach { button in
            button.snp.makeConstraints { make in
                make.height.equalTo(52)
            }
        }
    }
    
    func setupActions() {
        azbutton.tag = 0
        enbutton.tag = 1
        azbutton.addTarget(self, action: #selector(toggleLanguage(_:)), for: .touchUpInside)
        enbutton.addTarget(self, action: #selector(toggleLanguage(_:)), for: .touchUpInside)
        register.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        agreementButton.addTarget(self, action: #selector(toggleAgreement), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
        nameTextField.inputTextField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        surnameTextField.inputTextField.addTarget(self, action: #selector(surnameChanged), for: .editingChanged)
        emailTextField.inputTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        phoneTextField.inputTextField.addTarget(self, action: #selector(phoneChanged), for: .editingChanged)
        passwordTextField.inputTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        confirmPasswordTextField.inputTextField.addTarget(self, action: #selector(confirmPasswordChanged), for: .editingChanged)
    }
    
    @objc private func didTapLogin() {
        router.pushVC(from: self, to: router.loginViewController())
    }
    
    @objc private func toggleAgreement() {
        agreementButton.isSelected.toggle()
    }
    
    @objc private func toggleLanguage(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            azbutton.setTitleColor(.black, for: .normal)
            enbutton.setTitleColor(.systemGray, for: .normal)
        case 1:
            azbutton.setTitleColor(.systemGray, for: .normal)
            enbutton.setTitleColor(.black, for: .normal)
        default: break
        }
    }
    
    @objc private func nameChanged() {
        let text = nameTextField.text ?? ""
        text.isEmpty ? nameTextField.resetValidationStatus()
                     : nameTextField.setValidationStatus(isValid: ValidationManager.isValidNameOrSurname(text))
    }
    
    @objc private func surnameChanged() {
        let text = surnameTextField.text ?? ""
        text.isEmpty ? surnameTextField.resetValidationStatus()
                     : surnameTextField.setValidationStatus(isValid: ValidationManager.isValidNameOrSurname(text))
    }
    
    @objc private func emailChanged() {
        let text = emailTextField.text ?? ""
        text.isEmpty ? emailTextField.resetValidationStatus()
                     : emailTextField.setValidationStatus(isValid: ValidationManager.isValidEmail(text))
    }
    
    @objc private func phoneChanged() {
        let text = phoneTextField.text ?? ""
        text.isEmpty ? phoneTextField.resetValidationStatus()
                     : phoneTextField.setValidationStatus(isValid: ValidationManager.isValidPhone(text))
    }
    
    @objc private func passwordChanged() {
        let text = passwordTextField.text ?? ""
        if text.isEmpty {
            passwordTextField.resetValidationStatus()
        } else {
            passwordTextField.setValidationStatus(isValid: ValidationManager.isValidPassword(text))
        }
        confirmPasswordChanged()
    }
    
    @objc private func confirmPasswordChanged() {
        let pass = passwordTextField.text ?? ""
        let confirm = confirmPasswordTextField.text ?? ""
        if confirm.isEmpty {
            confirmPasswordTextField.resetValidationStatus()
        } else {
            confirmPasswordTextField.setValidationStatus(isValid: pass == confirm)
        }
    }
    
    @objc private func didTapRegisterButton() {
        guard agreementButton.isSelected else { return }
        
        guard let name = nameTextField.text,
              let surname = surnameTextField.text,
              let email = emailTextField.text,
              let phone = phoneTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text else { return }
        
        let isNameValid = ValidationManager.isValidNameOrSurname(name)
        let isSurnameValid = ValidationManager.isValidNameOrSurname(surname)
        let isEmailValid = ValidationManager.isValidEmail(email)
        let isPhoneValid = ValidationManager.isValidPhone(phone)
        let isPasswordValid = ValidationManager.isValidPassword(password)
        let isConfirmValid = (password == confirmPassword) && !confirmPassword.isEmpty
        
        guard isNameValid && isSurnameValid && isEmailValid &&
              isPhoneValid && isPasswordValid && isConfirmValid else { return }
        
        let fullPhone = "+994" + phone.replacingOccurrences(of: " ", with: "")
        let newUser = User(name: name, surname: surname,
                          phone: fullPhone, email: email, password: password)
        let targetVC = router.mainTabbarController(user: newUser)
        router.changeRootViewController(viewController: targetVC)
    }
}
