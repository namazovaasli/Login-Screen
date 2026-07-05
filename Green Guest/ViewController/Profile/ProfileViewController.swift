import UIKit
import SnapKit


class ProfileViewController: UIViewController, ProfileEditDelegate {
    
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
    
    private let avatarImageView = UIImageView()
    private let emailLabel = UILabel()
    private let editProfileButton = UIButton(type: .system)
    
    private let changePasswordIcon = UIImageView()
    private let changePasswordLabel = UILabel()
    private let renewPasswordButton = UIButton(type: .system)
    
    private let logoutIcon = UIImageView()
    private let logoutLabel = UILabel()
    private let logoutButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Profil"
        setupUI()
        setupLayout()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        updateProfileUI()
    }
    
    private func setupUI() {
        avatarImageView.image = UIImage(named: "profile")
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 40
        avatarImageView.backgroundColor = .systemGray5
        
        emailLabel.font = .systemFont(ofSize: 16, weight: .regular)
        emailLabel.textColor = UIColor(named: "maintext") ?? .label
        emailLabel.textAlignment = .left
        
        var editConfig = UIButton.Configuration.plain()
        editConfig.title = "Düzəliş edin"
        editConfig.image = UIImage(named: "edit")
        editConfig.imagePlacement = .leading
        editConfig.imagePadding = 6
        editConfig.baseForegroundColor = UIColor(named: "maintext") ?? .label
        editConfig.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
        
        editProfileButton.configuration = editConfig
        editProfileButton.backgroundColor = .clear
        editProfileButton.layer.cornerRadius = 16
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.borderColor = UIColor.systemGray4.cgColor
        
        changePasswordIcon.image = UIImage(named: "changepas")
        changePasswordIcon.tintColor = UIColor(named: "textfieldcolor") ?? .systemGray
        changePasswordIcon.contentMode = .scaleAspectFit
        
        changePasswordLabel.text = "Şifrənizi dəyişin"
        changePasswordLabel.textColor = UIColor(named: "maintext") ?? .label
        changePasswordLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        var renewConfig = UIButton.Configuration.filled()
        renewConfig.title = "Yeniləyin"
        renewConfig.baseBackgroundColor = UIColor(named: "mainbuttoncolor") ?? .systemGreen
        renewConfig.baseForegroundColor = .white
        renewConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { _ in
            var attrs = AttributeContainer()
            attrs.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            return attrs
        }
        renewConfig.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
        
        renewPasswordButton.configuration = renewConfig
        renewPasswordButton.layer.cornerRadius = 16
        renewPasswordButton.clipsToBounds = true
        
        logoutIcon.image = UIImage(named: "logout")
        logoutIcon.tintColor = .systemRed
        logoutIcon.contentMode = .scaleAspectFit
        
        logoutLabel.text = "Çıxış et"
        logoutLabel.font = .systemFont(ofSize: 16, weight: .regular)
        logoutLabel.textColor = .systemRed
        
        logoutButton.backgroundColor = .clear
    }
    
    private func setupLayout() {
        [avatarImageView, emailLabel, editProfileButton,
         changePasswordIcon, changePasswordLabel, renewPasswordButton,
         logoutIcon, logoutLabel, logoutButton].forEach { view.addSubview($0) }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(80)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.top).offset(8)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.height.equalTo(32)
        }
        
        changePasswordIcon.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        
        changePasswordLabel.snp.makeConstraints { make in
            make.centerY.equalTo(changePasswordIcon)
            make.leading.equalTo(changePasswordIcon.snp.trailing).offset(12)
        }
        
        renewPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(changePasswordIcon)
            make.trailing.equalToSuperview().offset(-16)
            make.width.greaterThanOrEqualTo(90)
            make.height.equalTo(32)
        }
        
        logoutIcon.snp.makeConstraints { make in
            make.top.equalTo(changePasswordIcon.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        
        logoutLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoutIcon)
            make.leading.equalTo(logoutIcon.snp.trailing).offset(12)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(changePasswordIcon.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
    }
    
    private func setupActions() {
        editProfileButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        renewPasswordButton.addTarget(self, action: #selector(renewPasswordTapped), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    private func updateProfileUI() {
        emailLabel.text = user.email
    }
    
    func didUpdateProfile(email: String, phone: String) {
        if ValidationManager.isValidEmail(email) {
            self.user.email = email
            self.user.phone = phone
            self.emailLabel.text = email
        }
    }
    
    @objc private func editTapped() {
        let editVC = ProfileEditViewController(router: router, user: user)
        editVC.delegate = self
        router.pushVC(from: self, to: editVC)
    }
    
    @objc private func renewPasswordTapped() {
        tabBarController?.tabBar.isHidden = true
        let newPassVC = router.newPasswordViewController(source: .profile)
        router.pushVC(from: self, to: newPassVC)
    }
    
    @objc private func logoutTapped() {
        router.changeRootViewController(viewController: router.loginViewController())
    }
}
