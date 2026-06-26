//
//  ProfileEditViewController.swift
//  Login Screen
//
//  Created by Əsli Namazova on 26.06.26.
//

import UIKit
import SnapKit

class ProfileEditViewController: UIViewController {
    
    private let router: AppRouterProtocol
    private let user: User
    weak var delegate: ProfileEditDelegate?
    
    protocol ProfileEditDelegate: AnyObject {
        func didUpdateProfile(email: String, phone: String)
    }
    
    private let backStack = UIStackView()
    private let backIcon = UIImageView(image: UIImage(named: "backicon"))
    private let backButton = UIButton(type: .system)
    
    private let titleLabel = UILabel()
    private let textLabel = UILabel()
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
        backIcon.contentMode = .scaleAspectFit
        
        backButton.setTitle("Əvvələ qayıt", for: .normal)
        backButton.setTitleColor(.forgetpas, for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        
        titleLabel.text = "Profili redaktə"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .maintext
        
        emailTextField.inputTextField.text = user.email
        emailTextField.inputTextField.placeholder = "Email ünvanınız"
        phoneTextField.inputTextField.text = user.phone
        phoneTextField.inputTextField.placeholder = "Mobil nömrəniz"
        textLabel.text = "Mobil nömrənizi dəyişmək üçün bizimlə əlaqə saxlayın."
        textLabel.textColor = .gray
        textLabel.font = .italicSystemFont(ofSize: 14)
        textLabel.numberOfLines = 0
        saveButton.setTitle("Yadda saxlayın", for: .normal)
        cancelButton.setTitle("Ləğv edin", for: .normal)
        cancelButton.setTitleColor(.systemRed, for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    private func setupLayout() {
        [backIcon, backButton].forEach { backStack.addArrangedSubview($0) }
        backStack.axis = .horizontal
        backStack.spacing = 8
        backStack.alignment = .center
        
        [backStack, titleLabel, emailTextField,phoneTextField, saveButton,cancelButton].forEach { view.addSubview($0) }
        
        backIcon.snp.makeConstraints { make in
            make.width.equalTo(10)
            make.height.equalTo(16)
        }
        
        backStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backStack.snp.bottom).offset(24)
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.equalToSuperview().inset(16)
        }
    
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
                }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
                }
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
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
    
    @objc private func backTapped() {
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
