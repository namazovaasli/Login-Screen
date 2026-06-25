//
//  SearchViewController.swift
//  Login Screen
//
//  Created by Əsli Namazova on 20.06.26.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController{
    
    private let router: AppRouterProtocol
    
    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainView = İmageTitle(image: .searchmain, title:"Uyğun nəticə tapılmadı", subtitle: "Axtarışınıza uyğun heç bir elan tapılmadı. Fərqli açar sözlərlə yenidən cəhd edin.")
    
    private func setupviews(){
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(16)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupviews()
    }
}
