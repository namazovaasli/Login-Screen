//
//  SuccessViewController.swift
//  Login Screen
//
//  Created by Əsli Namazova on 26.06.26.
//

import UIKit
import SnapKit

class SuccessViewController: UIViewController {
    
    private let router: AppRouterProtocol
    
    private let successImage = UIImageView(image: UIImage(named: "success"))
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
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
            make.top.equalToSuperview().offset(150)
            make.size.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(successImage.snp.bottom).offset(32)
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
        router.changeRootViewController(viewController: router.loginViewController())
    }
}
