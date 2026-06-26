
import UIKit
import SnapKit

protocol AppRouterProtocol {
    func changeRootViewController(viewController: UIViewController)
    func mainTabbarController(user: User) -> UITabBarController
    func homeViewController() -> UIViewController
    func favoriteViewController() -> UIViewController
    func profileViewController(user: User) -> UIViewController
    func forgotPasswordViewController() -> UIViewController
    func verifyViewController() -> UIViewController
    func newPasswordViewController() -> UIViewController
    func successViewController() -> UIViewController
    func searchViewController() -> UIViewController
    func loginViewController() -> UIViewController
    func registerViewController() -> UIViewController
    func pushVC(from first: UIViewController, to second: UIViewController)
}
