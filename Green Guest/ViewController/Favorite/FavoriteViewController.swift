

import UIKit
import SnapKit

class FavoriteViewController: UIViewController{
    private let router: AppRouterProtocol
    
    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainView = İmageTitleSubtitle(image: .searchmain, title: "Seçilmiş elan tapılmadı", subtitle: "Elanları sevimlilərə əlavə edərək bu səhifədən izləyə bilərsiniz")
    
    private func setupView() {
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints { (make) in
            make.trailing.leading.equalToSuperview().inset(16)
            make.center.equalToSuperview()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
    }
    
}
