

import UIKit
import SnapKit

class ProfileEditViewController: UIViewController {
    
    private let router: AppRouterProtocol
    private let user: User
    weak var delegate: ProfileEditDelegate?
    
    protocol ProfileEditDelegate: AnyObject {
        func didUpdateProfile(email: String, phone: String)
    }
    private let buttonsStackView = UIStackView()
    
    private let backButton = UIButton(type: .system)
    private let infoLabel = UILabel()
    private let titleLabel = UILabel()
    private let emailTextField = BaseTextFieldView(textFieldStyle: .email)
    private let phoneTextField = BaseTextFieldView(textFieldStyle: .phoneNumber)
    
    private let saveButton = BaseButton(buttonStyle: .submit)
    private let cancelButton = UIButton(type: .system)
    
    init(router: AppRouterProtocol, user: User) {
        self.router = router
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        title = "Profili redaktə"
        setupUI()
        setupLayout()
        setupActions()
    }
    
    private func setupUI() {
        backButton.setImage(UIImage(named: "backicon"), for: .normal)
        backButton.tintColor = .label
        
        titleLabel.text = "Profili redaktə"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .maintext
        titleLabel.textAlignment = .center
        
        emailTextField.inputTextField.text = user.email
        emailTextField.inputTextField.placeholder = "E-poçt ünvanınız"
        phoneTextField.inputTextField.text = user.phone
        phoneTextField.inputTextField.placeholder = "Mobil nömrəniz"
        infoLabel.text = "Mobil nömrənizi dəyişmək üçün bizimlə əlaqə saxlayın."
        infoLabel.font = .systemFont(ofSize: 12, weight: .regular)
        infoLabel.textColor = .secondaryLabel
        infoLabel.numberOfLines = 0
        
        cancelButton.setTitle("Ləğv edin", for: .normal)
                cancelButton.setTitleColor(.label, for: .normal)
                cancelButton.backgroundColor = .systemGray6
                cancelButton.layer.cornerRadius = 24
                cancelButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        
        saveButton.setTitle("Yadda saxlayın", for: .normal)
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 12
        buttonsStackView.distribution = .fillEqually
    }
    
    private func setupLayout() {
        [backButton, titleLabel, emailTextField, phoneTextField, infoLabel, buttonsStackView].forEach { view.addSubview($0) }
                [cancelButton, saveButton].forEach { buttonsStackView.addArrangedSubview($0) }
                
                backButton.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
                    make.leading.equalToSuperview().inset(16)
                    make.size.equalTo(32)
                }
                
                titleLabel.snp.makeConstraints { make in
                    make.centerY.equalTo(backButton)
                    make.centerX.equalToSuperview()
                }
        emailTextField.snp.makeConstraints { make in
                    make.top.equalTo(titleLabel.snp.bottom).offset(32)
                    make.leading.trailing.equalToSuperview().inset(16)
                    make.height.equalTo(55)
                }
                
                phoneTextField.snp.makeConstraints { make in
                    make.top.equalTo(emailTextField.snp.bottom).offset(20)
                    make.leading.trailing.equalToSuperview().inset(16)
                    make.height.equalTo(55)
                }
                
                infoLabel.snp.makeConstraints { make in
                    make.top.equalTo(phoneTextField.snp.bottom).offset(8)
                    make.leading.trailing.equalToSuperview().inset(16)
                }
        buttonsStackView.snp.makeConstraints { make in
                    make.top.equalTo(infoLabel.snp.bottom).offset(40)
                    make.leading.trailing.equalToSuperview().inset(16)
                    make.height.equalTo(48)
                }
        
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        emailTextField.inputTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        phoneTextField.inputTextField.addTarget(self, action: #selector(phoneChanged), for: .editingChanged)
    }
    @objc private func emailChanged() {
            let text = emailTextField.text ?? ""
            let isValid = ValidationManager.isValidEmail(text)
            emailTextField.setValidationStatus(isValid: isValid)
        }
        
        @objc private func phoneChanged() {
            let text = phoneTextField.text ?? ""
            let isValid = ValidationManager.isValidPhone(text)
            phoneTextField.setValidationStatus(isValid: isValid)
        }
    @objc private func cancelTapped() {
            navigationController?.popViewController(animated: true)
        }
    
    @objc private func saveTapped() {
            let currentEmail = emailTextField.text ?? ""
            let currentPhone = phoneTextField.text ?? ""
            
            let isEmailValid = ValidationManager.isValidEmail(currentEmail)
            let isPhoneValid = ValidationManager.isValidPhone(currentPhone)
            
            if !isEmailValid || !isPhoneValid {
                if !isEmailValid { emailTextField.setValidationStatus(isValid: false) }
                if !isPhoneValid { phoneTextField.setValidationStatus(isValid: false) }
                return
            }
            
        delegate?.didUpdateProfile(email: currentEmail, phone: currentPhone)
            navigationController?.popViewController(animated: true)
        }
}
