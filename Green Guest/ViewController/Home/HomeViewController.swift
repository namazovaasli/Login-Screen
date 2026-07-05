

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private let router: AppRouterProtocol
    
    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private let categories = ["Kirayə evlər", "Fəaliyyətlər", "Məhsullar"]
    private var selectedCategoryIndex = 0
    private let allListings: [(title: String, location: String, price: String, imageName: String)] = [
            ("Şəki dağ evi",       "Şəki rayonu",      "180 AZN", "sheki"),
            ("Qəbələ kənd evi",    "Qəbələ rayonu",    "200 AZN", "gebele"),
            ("İsmayıllı kənd evi", "İsmayıllı rayonu", "150 AZN", "ismayilli")
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = nil
        navigationController?.navigationBar.isHidden = true
        setupTableView()
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let topInset = view.safeAreaInsets.top + 4
        tableView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
    }
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .systemBackground
            //
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.sectionHeaderTopPadding = 0
        
        //
        tableView.register(SearchCell.self,
                           forCellReuseIdentifier: SearchCell.reuseID)
        tableView.register(CategoryCell.self,
                           forCellReuseIdentifier: CategoryCell.reuseID)
        tableView.register(VIPListingsCell.self,
                           forCellReuseIdentifier: VIPListingsCell.reuseID)
        tableView.register(ListingRowCell.self,
                           forCellReuseIdentifier: ListingRowCell.reuseID)
        tableView.register(SectionHeaderCell.self,
                           forCellReuseIdentifier: SectionHeaderCell.reuseID)
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 2
        case 3: return allListings.count + 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchCell.reuseID, for: indexPath) as! SearchCell
            cell.onSearchTapped = { [weak self] in
                guard let self else { return }
                self.router.pushVC(from: self, to: self.router.searchViewController())
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
            cell.configure(selectedIndex: selectedCategoryIndex)
            cell.onCategorySelected = { [weak self] index in
                self?.selectedCategoryIndex = index
            }
            return cell
            
        case 2:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: SectionHeaderCell.reuseID, for: indexPath) as! SectionHeaderCell
                cell.configure(title: "VIP elanlar")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: VIPListingsCell.reuseID, for: indexPath) as! VIPListingsCell
                return cell
            }
            
        case 3:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: SectionHeaderCell.reuseID, for: indexPath) as! SectionHeaderCell
                cell.configure(title: "Bütün elanlar")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ListingRowCell.reuseID, for: indexPath) as! ListingRowCell
                                let index = indexPath.row - 1
                                
                                if index < allListings.count {
                                    let item = allListings[index]
                                    cell.configure(title: item.title,
                                                   location: item.location,
                                                   price: item.price,
                                                   imageName: item.imageName)
                                }
                return cell
            }
            
        default:
            return UITableViewCell()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 60
        case 1: return 56
        case 2:
            return indexPath.row == 0 ? 44 : 260
            case 3:
            return indexPath.row == 0 ? 44 : UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
