

import UIKit
import SnapKit

class HomeViewController: UIViewController{
    
    private let router: AppRouterProtocol
    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let mainView = İmageTitle(image: .searchmain, title:"Elan tapılmadı", subtitle: "Yeni əlavə olunan elanları burada görəcəksiniz")
    private func setupviews(){
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints { (make) in
            make.trailing.leading.equalToSuperview().inset(16)
            make.center.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupviews()
    }
  
}
