

import UIKit
import SnapKit

class NewPasswordViewController: UIViewController {
    
    private let router: AppRouterProtocol
    private let backStack = UIStackView()
    private let backIcon = UIImageView(image: UIImage(named: "backicon"))
    private let backButton = UIButton(type: .system)
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let newPasswordTextField = BaseTextFieldView(textFieldStyle: .password)
    private let confirmPasswordTextField = BaseTextFieldView(textFieldStyle: .password)
    private let submitButton = BaseButton(buttonStyle: .submit)
    
    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        backButton.setTitle("Əvvələ qayıt", for: .normal)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        titleLabel.text = "Yeni şifrə yaradın"
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        descriptionLabel.text = "Daxil olmaq üçün öz yeni şifrənizi yaradın."
        descriptionLabel.textColor = .secondaryLabel
        
        newPasswordTextField.inputTextField.placeholder = "Şifrəniz"
        confirmPasswordTextField.inputTextField.placeholder = "Yenidən şifrəniz"
        
        newPasswordTextField.inputTextField.addTarget(self, action: #selector(passChanged), for: .editingChanged)
        confirmPasswordTextField.inputTextField.addTarget(self, action: #selector(confirmChanged), for: .editingChanged)
        
        submitButton.setTitle("Yadda saxlayın", for: .normal)
        submitButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }

    @objc private func passChanged() {
        let valid = ValidationManager.isValidPassword(newPasswordTextField.text ?? "")
        newPasswordTextField.setValidationStatus(isValid: valid)
        confirmChanged()
    }

    @objc private func confirmChanged() {
        let pass = newPasswordTextField.text ?? ""
        let confirm = confirmPasswordTextField.text ?? ""
        let valid = (pass == confirm) && !confirm.isEmpty
        confirmPasswordTextField.setValidationStatus(isValid: valid)
    }
    
    private func setupLayout() {
        [backIcon, backButton].forEach { backStack.addArrangedSubview($0) }
        [backStack, titleLabel, descriptionLabel, newPasswordTextField, confirmPasswordTextField, submitButton].forEach { view.addSubview($0) }
        
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
            make.leading.equalToSuperview().inset(16)
        }
        
        newPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
    }
    
    @objc private func backTapped() { navigationController?.popViewController(animated: true) }
    
    @objc private func saveTapped() {
        if ValidationManager.isValidPassword(newPasswordTextField.text ?? "") && (newPasswordTextField.text == confirmPasswordTextField.text) {
            let nextVC = router.successViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
