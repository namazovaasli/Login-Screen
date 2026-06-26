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
    
    private let backStack = UIStackView()
    private let backIcon = UIImageView(image: UIImage(named: "backicon"))
    private let backButton = UIButton(type: .system)
    
    private let titleLabel = UILabel()
    
    private let emailTextField = BaseTextFieldView(textFieldStyle: .email)
    
    private let saveButton = BaseButton(buttonStyle: .submit)
    
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
        
        setupUI()
        setupLayout()
        setupActions()
    }
    
    private func setupUI() {
        backIcon.contentMode = .scaleAspectFit
        
        backButton.setTitle("Əvvələ qayıt", for: .normal)
        backButton.setTitleColor(.forgetpas, for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        
        titleLabel.text = "Profili redaktə et"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .maintext
        
        emailTextField.inputTextField.text = user.email
        emailTextField.inputTextField.placeholder = "Email ünvanınız"
        
        saveButton.setTitle("Yadda saxla", for: .normal)
    }
    
    private func setupLayout() {
        [backIcon, backButton].forEach { backStack.addArrangedSubview($0) }
        backStack.axis = .horizontal
        backStack.spacing = 8
        backStack.alignment = .center
        
        [backStack, titleLabel, emailTextField, saveButton].forEach { view.addSubview($0) }
        
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
            make.leading.equalToSuperview().inset(16)
        }
    
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveTapped() {
        print("Məlumatlar uğurla yeniləndi.")
        navigationController?.popViewController(animated: true)
    }
}
