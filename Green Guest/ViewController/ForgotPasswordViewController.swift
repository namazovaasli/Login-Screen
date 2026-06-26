

import UIKit
import SnapKit

class ForgotPasswordViewController: UIViewController{
    private var backIcon = UIImageView()
    private var backButton = UIButton()
    private var backStack = UIStackView()
    
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var textStack = UIStackView()
    
    private var phoneTextField = BaseTextFieldView(textFieldStyle: .phoneNumber)
    private var submitButton = BaseButton(buttonStyle: .submit)
    private var mainStack = UIStackView()
    
    private let router: AppRouterProtocol
    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setUp()
        setupLayout()
        setupActions()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
  
    
    private func setUp () {
        backIcon.image = UIImage(named: "backicon")
        backIcon.contentMode = .scaleAspectFit
        
        backButton.setTitle("Əvvələ qayıt", for: .normal)
        backButton.setTitleColor (.forgetpas,for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        backButton.contentHorizontalAlignment = .left
        
        titleLabel.text = "Şifrəni yeniləyin"
        titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textColor = .maintext
        titleLabel.numberOfLines = 0
        
        descriptionLabel.text = "Mobil nömrənizi daxil edin və sizə şifrəni yeniləmək üçün sizə kod göndərək."
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textColor = .textfieldcolor
        descriptionLabel.numberOfLines = 0
        
        submitButton.setTitle("Davam edin", for: .normal)
    }
    
    private func setupLayout () {
        [backIcon,backButton].forEach{backStack.addArrangedSubview($0)}
        backStack.axis = .horizontal
        backStack.spacing = 8
        backStack.alignment = .center
        
        [titleLabel,descriptionLabel].forEach{textStack.addArrangedSubview($0)}
        textStack.axis = .vertical
        textStack.spacing = 8
        
        [textStack,phoneTextField,submitButton].forEach{mainStack.addArrangedSubview($0)}
        mainStack.axis = .vertical
        mainStack.spacing = 28
        
        [backStack,mainStack].forEach{view.addSubview($0)}
        
        backIcon.snp.makeConstraints { make in
            make.width.equalTo(10)
            make.height.equalTo(16)
        }
        backStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(30)
                }
        mainStack.snp.makeConstraints { make in
            make.top.equalTo(backStack.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        submitButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupActions () {
        phoneTextField.inputTextField.addTarget(self, action: #selector(phoneChanged), for: .editingChanged)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
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
    @objc private func backButtonTapped() {
            navigationController?.popViewController(animated: true)
        }

    @objc private func submitButtonTapped() {
        guard let enteredPhone = phoneTextField.text else { return }
        
        let isPhoneValid = ValidationManager.isValidPhone(enteredPhone)
        
        if !isPhoneValid {
            phoneTextField.setValidationStatus(isValid: false)
            print("Nömrə yanlışdır")
            return
        }
        phoneTextField.setValidationStatus(isValid: true)
       
        let targetVC = router.verifyViewController()
        
        router.pushVC(from: self, to: targetVC)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
