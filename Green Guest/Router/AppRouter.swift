
import UIKit
import SnapKit

class AppRouter: AppRouterProtocol {
   
    func changeRootViewController(viewController:UIViewController)
    {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.changeRootViewController(to: viewController )
        }
    }
    
    func mainTabbarController(user: User) -> UITabBarController {
        MainTabbarController(router:self,user:user)
    }
    
    func profileViewController(user: User) -> UIViewController {
           ProfileViewController(router: self, user: user)
       }
       
       func forgotPasswordViewController() -> UIViewController{
           ForgotPasswordViewController(router: self)
       }
    func verifyViewController() -> UIViewController {
        VerifyViewController(router: self)
    }
    func newPasswordViewController(source: SuccessSource) -> UIViewController {
           NewPasswordViewController(router: self, source: source)
       }
    func successViewController(source: SuccessSource) -> UIViewController {
           SuccessViewController(router: self, source: source)
       }
       func loginViewController()-> UIViewController{
           LoginViewController(router: self)
       }
        func registerViewController() -> UIViewController {
        RegisterViewController(router: self)
        }
    
       func homeViewController() -> UIViewController{
           HomeViewController(router: self)
       }

       func searchViewController() -> UIViewController{
           SearchViewController(router: self)
       }
       
       func favoriteViewController() -> UIViewController{
           FavoriteViewController(router: self)
       }
       
       func pushVC(from first: UIViewController, to second: UIViewController) {
           first.navigationController?.pushViewController(second, animated: true)
       }
    
}



