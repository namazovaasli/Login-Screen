//
//  MainTabbarController.swift
//  Login Screen
//
//  Created by Əsli Namazova on 20.06.26.
//

import UIKit
import SnapKit

final class MainTabbarController: UITabBarController {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let router :AppRouter
    private let user : User
    
    init(router:AppRouter, user:User){
        self.router = router
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBarViewController()
        
    }
    
    private func createTabBarViewController(){
        viewControllers=[
            makeNavigationController(with : router.homeViewController(),and: "Əsas",and: "house")
            ,makeNavigationController(with : router.searchViewController(),and: "Axtarış",and: "magnifyingglass")
            ,makeNavigationController(with : router.favoriteViewController(),and: "Seçilmişlər",and: "heart")
            ,makeNavigationController(with : router.profileViewController(user: user),and: "Profil",and: "person")
        ]
    }
    
    private func makeNavigationController(with viewController:UIViewController,and title:String,and icon:String)->UINavigationController{
        let viewController = viewController
        viewController.title = title
        viewController.view.backgroundColor = .systemBackground
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(systemName: icon)
        return UINavigationController(rootViewController: viewController)
    }
}
