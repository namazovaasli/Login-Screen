
import UIKit
import SnapKit

class ProfileViewController : UIViewController, ProfileEditViewController.ProfileEditDelegate {
    
    private let router: AppRouterProtocol
    private var user: User
       
       init(router: AppRouterProtocol, user: User) {
           self.router = router
           self.user = user
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    protocol ProfileEditDelegate: AnyObject {
        func didUpdateProfile(email: String, phone: String)
    }
    
    private let avatarImageView = UIImageView()
        private let emailLabel = UILabel()
    
        private let emailTextField = BaseTextFieldView(textFieldStyle: .email)
    
        private let editProfileButton = UIButton(type: .system)
        private let renewPasswordButton = UIButton(type: .system)
    
        private let changePasswordRowContainer = UIView()
        private let changePasswordIcon = UIImageView()
        private let changePasswordLabel = UILabel()
    
        private let logoutButton = UIButton(type: .system)
        private let logoutRowContainer = UIView()
        private let logoutIcon = UIImageView()
        private let logoutLabel = UILabel()
        
    
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
            avatarImageView.contentMode = .scaleAspectFit
            avatarImageView.clipsToBounds = true
            avatarImageView.layer.cornerRadius = 40
        
            emailLabel.text = user.email
            emailLabel.font = .systemFont(ofSize: 16, weight: .regular)
            emailLabel.textColor = .maintext
            emailLabel.textAlignment = .center
        
        var config = UIButton.Configuration.plain()
                config.title = "Düzəliş edin"
                config.image = UIImage(named: "edit")
                config.imagePlacement = .leading
                config.imagePadding = 6
                config.baseForegroundColor = .label
        
        editProfileButton.configuration = config
                editProfileButton.backgroundColor = .systemGray6
                editProfileButton.layer.cornerRadius = 15
                editProfileButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        editProfileButton.setTitleColor(.maintext, for: .normal)
        
        changePasswordIcon.image = UIImage(named: "changepas")
        changePasswordIcon.tintColor = UIColor(named: "textfieldcolor")
        
            changePasswordLabel.text = "Şifrənizi dəyişin"
        changePasswordLabel.textColor = UIColor(named: "maintext")
            changePasswordLabel.font = .systemFont(ofSize: 16, weight: .regular)
        renewPasswordButton.setTitle("Yeniləyin", for: .normal)
        renewPasswordButton.setTitleColor(.white, for: .normal)
        renewPasswordButton.backgroundColor = UIColor(named: "mainbuttoncolor")
        renewPasswordButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        renewPasswordButton.layer.cornerRadius = 12
        
        logoutIcon.image = UIImage(named: "logout")
        logoutIcon.tintColor = .systemRed
        logoutLabel.text = "Çıxış et"
        logoutLabel.font = .systemFont(ofSize: 16, weight: .regular)
        logoutLabel.textColor = .systemRed
        logoutButton.alpha = 0.1
            
        
        }
    
    private func setupLayout() {
        [avatarImageView, emailLabel, editProfileButton, changePasswordRowContainer, logoutRowContainer].forEach { view.addSubview($0) }
        avatarImageView.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
                    make.centerX.equalToSuperview()
                    make.size.equalTo(80)
                }
        emailLabel.snp.makeConstraints { make in
                    make.top.equalTo(avatarImageView.snp.bottom).offset(12)
                    make.centerX.equalToSuperview()
                }
        editProfileButton.snp.makeConstraints { make in
                    make.top.equalTo(emailLabel.snp.bottom).offset(8)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(130)
                    make.height.equalTo(32)
                }
        [changePasswordIcon, changePasswordLabel, renewPasswordButton].forEach { changePasswordRowContainer.addSubview($0) }
                changePasswordRowContainer.snp.makeConstraints { make in
                    make.top.equalTo(editProfileButton.snp.bottom).offset(40)
                    make.leading.trailing.equalToSuperview().inset(16)
                    make.height.equalTo(50)
                }
        changePasswordIcon.snp.makeConstraints { make in
                    make.leading.centerY.equalToSuperview()
                    make.size.equalTo(24)
                }
        changePasswordLabel.snp.makeConstraints { make in
                    make.leading.equalTo(changePasswordIcon.snp.trailing).offset(12)
                    make.centerY.equalToSuperview()
                }
        renewPasswordButton.snp.makeConstraints { make in
                    make.trailing.centerY.equalToSuperview()
                    make.width.equalTo(85)
                    make.height.equalTo(32)
                }
        [logoutIcon, logoutLabel, logoutButton].forEach { logoutRowContainer.addSubview($0) }
                logoutRowContainer.snp.makeConstraints { make in
                    make.top.equalTo(changePasswordRowContainer.snp.bottom).offset(16)
                    make.leading.trailing.equalToSuperview().inset(16)
                    make.height.equalTo(50)
                }
        logoutIcon.snp.makeConstraints { make in
                    make.leading.centerY.equalToSuperview()
                    make.size.equalTo(24)
                }
                
                logoutLabel.snp.makeConstraints { make in
                    make.leading.equalTo(logoutIcon.snp.trailing).offset(12)
                    make.centerY.equalToSuperview()
                }
                
                logoutButton.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
    }
        
        private func setupActions() {
            editProfileButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
            renewPasswordButton.addTarget(self, action: #selector(renewPasswordTapped), for: .touchUpInside)
            logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        }
    func didUpdateProfile(email: String, phone: String) {
        self.user.email = email
        self.user.phone = phone
        self.emailLabel.text = email
        }
        
        @objc private func editTapped() {
            let editVC = ProfileEditViewController(router: router, user: user)
                    editVC.delegate = self
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
