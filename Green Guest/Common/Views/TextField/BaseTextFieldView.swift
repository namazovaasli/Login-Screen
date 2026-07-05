

import UIKit
import SnapKit

class BaseTextFieldView :UIView{
    
    func setValidationStatus(isValid: Bool) {
        self.layer.borderWidth = 1.5
        self.layer.borderColor = isValid ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
    }
    func resetValidationStatus() {
            self.layer.borderWidth = 1.0
            self.layer.borderColor = UIColor.systemGray4.cgColor
        }
    
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
        inputTextField.delegate = self
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
        inputTextField.keyboardType = .emailAddress
        inputTextField.autocapitalizationType = .none
        horizontalStackView.addArrangedSubview(inputTextField)
    }
    
    func passwordTextFieldDesign (){
        firstLabel.text = "Şifrəniz"
        firstLabel.textColor = UIColor(named: "textfieldcolor")
        inputTextField.isSecureTextEntry = true
        inputTextField.placeholder = "••••••••"
        
        eyeButton.setImage(UIImage(named: "eye"), for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.addTarget(self, action: #selector(togglePassword), for: .touchUpInside)
        eyeButton.imageView?.contentMode = .scaleAspectFit
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
        self.layer.borderColor = UIColor.systemGray4.cgColor 
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
        
        let imageName = inputTextField.isSecureTextEntry ? "eye" : "openeye"
            eyeButton.setImage(UIImage(named: imageName), for: .normal)
        
    }
}

extension BaseTextFieldView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        switch textFieldStyle {
        case .phoneNumber:
            let allowedChars = CharacterSet.decimalDigits
            guard string.unicodeScalars.allSatisfy({ allowedChars.contains($0) })
                    || string.isEmpty else { return false }
            let current = textField.text ?? ""
            guard let stringRange = Range(range, in: current) else { return false }
            let updated = current.replacingCharacters(in: stringRange, with: string)
            return updated.count <= 9
            
        default:
            return true
        }
    }
    
}
