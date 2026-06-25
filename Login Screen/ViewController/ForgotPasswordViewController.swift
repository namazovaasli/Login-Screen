//
//  ForgotPasswordViewController.swift
//  Login Screen
//
//  Created by Əsli Namazova on 20.06.26.
//

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
        setUp()
        setupLayout()
        setupActions()
    }
    
    private func setUp () {
        backIcon.image = UIImage(named: "backicon")
        backButton.setTitle("Əvvələ qayıt", for: .normal)
        backButton.setTitleColor (.forgetpas,for: .normal)
        
        titleLabel.text = "Şifrəni yeniləyin"
        titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textColor = .maintext
        titleLabel.numberOfLines = 0
        
        descriptionLabel.text = "Mobil nömrənizi daxil edin və sizə şifrəni yeniləmək üçün sizə kod göndərək."
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textColor = .textfieldcolor
        descriptionLabel.numberOfLines = 0
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backStack)
    }
    
    private func setupLayout () {
        [backIcon,backButton].forEach{backStack.addArrangedSubview($0)}
        backStack.axis = .horizontal
        
        [titleLabel,descriptionLabel].forEach{textStack.addArrangedSubview($0)}
        textStack.axis = .vertical
        textStack.spacing = 8
        
        [textStack,phoneTextField,submitButton].forEach{mainStack.addArrangedSubview($0)}
        mainStack.axis = .vertical
        mainStack.spacing = 28
        
        [mainStack].forEach{view.addSubview($0)}
        
        backIcon.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        mainStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupActions () {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
