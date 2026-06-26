//
//  ProfileViewController.swift
//  Login Screen
//
//  Created by Əsli Namazova on 20.06.26.
//

import UIKit
import SnapKit

class ProfileViewController : UIViewController {
    
    private let router: AppRouterProtocol
       private let user: User
       
       init(router: AppRouterProtocol, user: User) {
           self.router = router
           self.user = user
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    private let avatarImageView = UIImageView()
        private let emailLabel = UILabel()
        
        private let editButton = UIButton(type: .system)
        private let renewPasswordButton = UIButton(type: .system)
        private let logoutButton = UIButton(type: .system)
        
        private let mainStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupLayout()
        setupActions()
    }
    
    private func setupUI() {
            avatarImageView.image = UIImage(named: "profile")
            avatarImageView.tintColor = .systemGray4
            avatarImageView.contentMode = .scaleAspectFill
            avatarImageView.clipsToBounds = true
            avatarImageView.layer.cornerRadius = 50
            
            emailLabel.text = user.email
            emailLabel.font = .systemFont(ofSize: 16, weight: .regular)
            emailLabel.textColor = .secondaryLabel
            emailLabel.textAlignment = .center
            
            editButton.setTitle("Düzəliş et", for: .normal)
            editButton.setTitleColor(.white, for: .normal)
            editButton.backgroundColor = .systemBlue
            editButton.layer.cornerRadius = 12
            editButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
            
            renewPasswordButton.setTitle("Şifrəni Yeniləyin", for: .normal)
            renewPasswordButton.setTitleColor(.systemOrange, for: .normal)
            renewPasswordButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            
            logoutButton.setTitle("Çıxış et", for: .normal)
            logoutButton.setTitleColor(.systemRed, for: .normal)
            logoutButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            
            mainStackView.axis = .vertical
            mainStackView.spacing = 20
        }
        
        private func setupLayout() {
            [avatarImageView, emailLabel, editButton, renewPasswordButton, logoutButton].forEach {
                mainStackView.addArrangedSubview($0)
            }
            
            view.addSubview(mainStackView)
            
            avatarImageView.snp.makeConstraints { make in
                make.size.equalTo(100)
            }
            
            editButton.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
            
            mainStackView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(24)
            }
        }
        
        private func setupActions() {
            editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
            renewPasswordButton.addTarget(self, action: #selector(renewPasswordTapped), for: .touchUpInside)
            logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        }
        
        
        @objc private func editTapped() {
            let editVC = ProfileEditViewController(router: router, user: user)
            router.pushVC(from: self, to: editVC)
        }
        
        @objc private func renewPasswordTapped() {
            let newPassVC = router.newPasswordViewController()
            router.pushVC(from: self, to: newPassVC)
        }
        
        @objc private func logoutTapped() {
            let loginVC = router.loginViewController()
            router.changeRootViewController(viewController: loginVC)
        }
}
