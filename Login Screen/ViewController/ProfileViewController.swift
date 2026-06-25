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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
