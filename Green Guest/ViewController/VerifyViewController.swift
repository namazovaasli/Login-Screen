//
//  VerifyViewController.swift
//  Login Screen
//
//  Created by Əsli Namazova on 26.06.26.
//

import SnapKit
import UIKit

class VerifyViewController: UIViewController {
    
    private let router: AppRouterProtocol
    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private let backStack = UIStackView()
    private let backIcon = UIImageView(image: UIImage(named: "backicon"))
    private let backButton = UIButton(type: .system)
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let otpStackView = UIStackView()
    private var otpTextFields: [UITextField] = []
    
    private let resendButton = UIButton(type: .system)
    private let submitButton = BaseButton(buttonStyle: .submit)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupLayout()
        setupOTPFields()
    }
    
    private func setupUI() {
            backButton.setTitle("Əvvələ qayıt", for: .normal)
            backButton.setTitleColor(.forgetpas, for: .normal)
            backButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
            
            titleLabel.text = "Kodu daxil edin"
            titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
            
            descriptionLabel.text = "Mobil nömrənizə göndərilən 6 rəqəmli təsdiqləmə kodunu daxil edin."
            descriptionLabel.numberOfLines = 0
            descriptionLabel.textColor = .secondaryLabel
            
            otpStackView.axis = .horizontal
            otpStackView.spacing = 10
            otpStackView.distribution = .fillEqually
            
            resendButton.setTitle("Yenidən göndərin", for: .normal)
            resendButton.setTitleColor(.systemYellow, for: .normal) 
            resendButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
            
            submitButton.setTitle("Davam edin", for: .normal)
            submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        }
        
        private func setupOTPFields() {
            for _ in 0..<6 {
                let tf = UITextField()
                tf.backgroundColor = .systemGray6
                tf.layer.cornerRadius = 8
                tf.textAlignment = .center
                tf.keyboardType = .numberPad
                tf.font = .systemFont(ofSize: 20, weight: .bold)
                tf.addTarget(self, action: #selector(otpChanged), for: .editingChanged)
                otpStackView.addArrangedSubview(tf)
                otpTextFields.append(tf)
            }
        }
        
        @objc private func otpChanged(_ textField: UITextField) {
            if let text = textField.text, text.count >= 1 {
                let index = otpTextFields.firstIndex(of: textField) ?? 0
                if index < 5 {
                    otpTextFields[index + 1].becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
            }
        }
        
        private func setupLayout() {
            [backIcon, backButton].forEach { backStack.addArrangedSubview($0) }
            backStack.spacing = 8
            
            [backStack, titleLabel, descriptionLabel, otpStackView, resendButton, submitButton].forEach { view.addSubview($0) }
            
            backIcon.snp.makeConstraints { $0.size.equalTo(CGSize(width: 10, height: 18)) }
            
            backStack.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
                make.leading.equalToSuperview().inset(16)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(backStack.snp.bottom).offset(32)
                make.leading.equalToSuperview().inset(16)
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
                make.leading.trailing.equalToSuperview().inset(16)
            }
            
            otpStackView.snp.makeConstraints { make in
                make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(55)
            }
            
            resendButton.snp.makeConstraints { make in
                make.top.equalTo(otpStackView.snp.bottom).offset(16)
                make.trailing.equalToSuperview().inset(16)
            }
            
            submitButton.snp.makeConstraints { make in
                make.top.equalTo(resendButton.snp.bottom).offset(32)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(52)
            }
        }
        
        @objc private func backTapped() { navigationController?.popViewController(animated: true) }
        
    @objc private func submitTapped() {
        let nextVC = router.newPasswordViewController()
        router.pushVC(from: self, to: nextVC)
    }
}
