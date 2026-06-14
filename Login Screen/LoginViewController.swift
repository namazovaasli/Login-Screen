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
    private let simvol = UILabel()
    private let stack = UIStackView()
    
    private let guest = BaseButton(buttonStyle: .guest)
    private let google = BaseButton(buttonStyle: .google)
    private let apple = BaseButton(buttonStyle: .apple)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    func setup () {
        [azbutton, simvol, enbutton].forEach({stack.addArrangedSubview($0)})
        
        azbutton.setTitle("AZ", for: .normal)
        simvol.text = "|"
        enbutton.setTitle("EN", for: .normal)
        
        azbutton.setTitleColor(UIColor.gray, for: .normal)
        enbutton.setTitleColor(UIColor.gray, for: .normal)
        
        simvol.textColor = .gray
        
        view.addSubview(stack)
        view.backgroundColor = .systemBackground
        stack.axis = .horizontal
        
        stack.snp.makeConstraints {(make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        azbutton.addTarget(self, action: #selector(toggleLanguage(_ :)), for: .touchUpInside)
        enbutton.addTarget(self, action: #selector(toggleLanguage(_ :)), for: .touchUpInside)
        
        azbutton.tag = 0
        enbutton.tag = 1
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
    
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Xoş gəlmisiniz!"
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = UIColor(named: "maintext")
        return label
    }()
    
    private lazy var phoneContainer = createInputField(title : "Mobil nömrəniz", placeholder : "XX XXX XX XX",tag :1)
    
    private lazy var emailContainer = createInputField(title: "Email", placeholder: "example@gmail.com", tag: 2)
    
    private lazy var passwordContainer = createInputField(title: "Şifrəniz", placeholder: "••••••••", tag: 3, isSecure: true)
    
    private let forgetPasswordButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Şifrəni unutdunuz?", for: .normal)
        button.setTitleColor(UIColor(named: "forgetpas"),for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14 , weight: .semibold)
        return button
    }()
    
    
    
    private let saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Daxil olun", for: .normal)
        btn.backgroundColor = UIColor(named: "mainbuttoncolor")
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.layer.cornerRadius = 24
        return btn
    }()
    
    private let dividerStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 12
        sv.alignment = .center
        sv.distribution = .fill
        
        let leftLine = UIView()
        leftLine.backgroundColor = .systemGray5
        
        
        let label = UILabel()
        label.text = "Və ya"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        let rightLine = UIView()
        rightLine.backgroundColor = .systemGray5
        
        sv.addArrangedSubview(leftLine)
        sv.addArrangedSubview(label)
        sv.addArrangedSubview(rightLine)
        
        leftLine.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        rightLine.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        leftLine.snp.makeConstraints { make in
            make.width.equalTo(rightLine.snp.width)
        }
        
        return sv
    }()
    
    private let registerLabel : UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(
            string: "Hesabınız yoxdur? ",
            attributes: [.foregroundColor: UIColor(named: "maintext") ?? .gray, .font: UIFont.systemFont(ofSize: 13)]
        )
        attributedText.append(NSAttributedString(
            string: "Qeydiyyatdan keçin",
            attributes: [.foregroundColor: UIColor(named: "forgetpas") ?? .green, .font: UIFont.systemFont(ofSize: 13, weight: .semibold)]
        ))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    
    private lazy var formStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [phoneContainer,emailContainer,passwordContainer])
        sv.axis = .vertical
        sv.spacing = 16
        sv.distribution = .fillEqually
        return sv
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [saveButton,dividerStack,google,apple,guest])
        sv.axis = .vertical
        sv.spacing = 12
        sv.distribution = .fillEqually
        return sv
    }()
    
    private lazy var mainStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            welcomeLabel,
            formStack,
            buttonsStack,
            registerLabel
        ])
        sv.axis = .vertical
        sv.spacing = 24
        sv.alignment = .fill
        return sv
    }()
    
    private func setupUI() {
        
        view.addSubview(mainStack)
        view.addSubview(forgetPasswordButton)
    }
    private func setupConstraints() {
        
        mainStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.centerY.equalToSuperview().offset(20)
        }
        
        saveButton.snp.makeConstraints { make in make.height.equalTo(48) }
        dividerStack.snp.makeConstraints { make in make.height.equalTo(24) }
        
        google.snp.makeConstraints { make in make.height.equalTo(48) }
        apple.snp.makeConstraints { make in make.height.equalTo(48) }
        guest.snp.makeConstraints { make in make.height.equalTo(48) }
        
        
        forgetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordContainer.snp.bottom).offset(6)
            make.trailing.equalTo(passwordContainer.snp.trailing)
        }
        mainStack.setCustomSpacing(36, after: formStack)
    }
    
    private func setupActions() {
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(registerTapped))
        registerLabel.addGestureRecognizer(tapGesture)
        
    }
    
    private func createInputField(title : String,placeholder : String, tag : Int, isSecure: Bool = false)-> UIView{
        let container = UIView()
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.systemGray4.cgColor
        container.layer.cornerRadius = 14
        container.backgroundColor = .systemBackground
        container.tag = tag * 10
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 11, weight: .regular)
        titleLabel.textColor = .gray
        
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.font = .systemFont(ofSize: 15)
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = isSecure
        tf.tag = tag
        
        if tag == 1 {
            tf.keyboardType = .phonePad
            tf.placeholder = "XX XXX XX XX"
            
            let prefixLabel = UILabel()
            prefixLabel.text = " +994 "
            prefixLabel.font = .systemFont(ofSize: 15)
            prefixLabel.textColor = .black
            prefixLabel.sizeToFit()
            
            tf.leftView = prefixLabel
            tf.leftViewMode = .always
        }
        if tag == 2 {
            tf.keyboardType = .emailAddress
        }
        
        container.addSubview(titleLabel)
        container.addSubview(tf)
        
        titleLabel.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        tf.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
            
        }
        container.snp.makeConstraints{ make in
            make.height.equalTo(56)
        }
        
        return container
    }
    
    
    
    @objc private func saveTapped() {
        view.endEditing(true)
    }
    
    @objc private func registerTapped() {
        print("Qeydiyyat ekranına keçid xətası")
    }
}

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let container = textField.superview, let text = textField.text else { return }
        
        switch textField.tag {
        case 1:
            if text.count <= 9 {
                container.layer.borderColor = UIColor.systemGreen.cgColor
            } else {
                container.layer.borderColor = UIColor.systemGray5.cgColor
            }
            
        case 2:
            if text.contains("@") && text.contains(".") {
                container.layer.borderColor = UIColor.systemGray5.cgColor
            } else if !text.isEmpty {
                container.layer.borderColor = UIColor.systemRed.cgColor
            } else {
                container.layer.borderColor = UIColor.systemGray5.cgColor
            }
            
        case 3:
            container.layer.borderColor = UIColor.systemGray5.cgColor
        default:
            container.layer.borderColor = UIColor.systemGray5.cgColor
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let container = textField.superview {
            container.layer.borderColor = UIColor.black.cgColor
        }
    }

