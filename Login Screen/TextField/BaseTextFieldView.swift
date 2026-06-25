//
//  BaseTextFieldView.swift
//  Login Screen
//
//  Created by Əsli Namazova on 20.06.26.
//

import UIKit
import SnapKit

class BaseTextFieldView :UIView{
    
    
    let verticalStackView = UIStackView()
    let horizontalStackView = UIStackView()
    let firstLabel = UILabel()
    let inputTextField = UITextField()
    let eyeButton = UIButton()
    let secondLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var textFieldStyle:TextFieldCases
    
    var text:String?{
        return inputTextField.text
    }
    
    init (textFieldStyle:TextFieldCases,_ tag:Int = -1 ){
        inputTextField.tag = tag
        self.textFieldStyle = textFieldStyle
        super.init(frame: .zero)
        designView()
        changeTextFieldStyle()
    }
    func changeTextFieldStyle (){
        switch textFieldStyle {
        case .name :
            nameTextFieldDesign()
            case .surname:
            surnameTextFieldDesign()
        case .phoneNumber:
            phoneTextFieldDesign()
        case .email:
            emailTextFieldDesign()
        case .password:
            passwordTextFieldDesign()
        }
    }
    
    func nameTextFieldDesign() {
        firstLabel.text = "Adınız"
        firstLabel.textColor = UIColor(named: "textfieldcolor")
        inputTextField.placeholder = "Adınızı yazın"
        horizontalStackView.addArrangedSubview(inputTextField)
    }
    func surnameTextFieldDesign() {
        firstLabel.text = "Soyadınız"
        firstLabel.textColor = UIColor(named: "textfieldcolor")
        inputTextField.placeholder = "Soyadınızı yazın"
        horizontalStackView.addArrangedSubview(inputTextField)
    }
    func phoneTextFieldDesign() {
        firstLabel.text = "Mobil nömrəniz"
        firstLabel.textColor = UIColor(named: "textfieldcolor")
        secondLabel.text = " +994 "
        secondLabel.font = .systemFont(ofSize: 15)
        secondLabel.textColor = .black
        secondLabel.sizeToFit()
        inputTextField.keyboardType = .phonePad
        inputTextField.placeholder = "XX XXX XX XX"
        inputTextField.autocapitalizationType = .none
        
        horizontalStackView.addArrangedSubview(secondLabel)
        horizontalStackView.addArrangedSubview(inputTextField)
    }
    
    func emailTextFieldDesign() {
        firstLabel.text = "Email"
        firstLabel.textColor = UIColor(named: "textfieldcolor")
        inputTextField.placeholder = "example@gmail.com"
        firstLabel.font = .systemFont(ofSize: 11, weight: .regular)
        
        horizontalStackView.addArrangedSubview(inputTextField)
    }
    
    func passwordTextFieldDesign (){
        firstLabel.text = "Şifrəniz"
        firstLabel.textColor = UIColor(named: "textfieldcolor")
        inputTextField.isSecureTextEntry = true
        inputTextField.placeholder = "••••••••"
        
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.addTarget(self, action: #selector(togglePassword), for: .touchUpInside)
        
        horizontalStackView.addArrangedSubview(inputTextField)
        self.addSubview(eyeButton)
        eyeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(inputTextField)
            make.size.equalTo(16)
        }
    }
    
    func designView (){
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 29
        self.layer.borderWidth = 1
        
        self.addSubview(verticalStackView)
        verticalStackView.axis = .vertical
        horizontalStackView.axis = .horizontal
        
        verticalStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(15)
        }
        verticalStackView.addArrangedSubview(firstLabel)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(58)
        }
    }
    
    
    @objc
    private func togglePassword(){
        let isFocused = inputTextField.isFirstResponder
        guard let currentText = inputTextField.text else { return }
        inputTextField.isSecureTextEntry.toggle()
        inputTextField.text = ""
        inputTextField.insertText(currentText)
        if isFocused {
                inputTextField.becomeFirstResponder()
            }
        let imageName = inputTextField.isSecureTextEntry ? "eye.slash" : "eye"
        eyeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}


