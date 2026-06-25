//
//  AppRouterProtocol.swift
//  Login Screen
//
//  Created by Əsli Namazova on 20.06.26.
//

import UIKit
import SnapKit

protocol AppRouterProtocol {
    func changeRootViewController(viewController: UIViewController)
    func mainTabbarController(user: User) -> UITabBarController
    func homeViewController() -> UIViewController
    func favoriteViewController() -> UIViewController
   // func settingsViewController() -> UIViewController
    func profileViewController(user: User) -> UIViewController
    func forgotPasswordViewController() -> UIViewController
    func searchViewController() -> UIViewController
    func loginViewController() -> UIViewController
    func registerViewController() -> UIViewController
    func pushVC(from first: UIViewController, to second: UIViewController)
}
