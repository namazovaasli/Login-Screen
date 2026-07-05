

import UIKit
import SnapKit

class SuccessViewController: UIViewController {
    
    private let router: AppRouterProtocol
    private let source: SuccessSource
    private let successImage = UIImageView(image: UIImage(named: "success"))
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let submitButton = BaseButton(buttonStyle: .submit)
    
    init(router: AppRouterProtocol, source: SuccessSource) {
        self.router = router
        self.source = source
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        successImage.contentMode = .scaleAspectFit
        titleLabel.text = "Şifrəniz uğurla yeniləndi!"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        
        descriptionLabel.text = "Şifrəniz uğurla yeniləndi. Daxil olma prosesinə davam edə bilərsiniz."
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .secondaryLabel
        
        submitButton.setTitle("Davam edin", for: .normal)
        submitButton.addTarget(self, action: #selector(finishTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        [successImage, titleLabel, descriptionLabel, submitButton].forEach { view.addSubview($0) }
        
        successImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.width.equalTo(198)
                  make.height.equalTo(109)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(successImage.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        submitButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
    }
    
    @objc private func finishTapped() {
        switch source {
        case .auth:
            router.changeRootViewController(viewController: router.loginViewController())
        case .profile:
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
