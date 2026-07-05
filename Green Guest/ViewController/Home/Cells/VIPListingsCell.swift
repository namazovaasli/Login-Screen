

import UIKit
import SnapKit


final class VIPListingsCell: UITableViewCell {
    
    static let reuseID = "VIPListingsCell"

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 180, height: 240)
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private var items: [(title: String, location: String,
                         price: String, imageName: String)] = [
        ("İsmayıllı kənd evi", "İsmayıllı rayonu", "150 AZN", "ismayilli"),
        ("Qəbələ kənd evi",    "Qəbələ rayonu",    "200 AZN", "gebele"),
        ("Şəki dağ evi",       "Şəki rayonu",      "180 AZN", "sheki"),
    ]

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupCollectionView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListingCardCell.self,
                                forCellWithReuseIdentifier: ListingCardCell.reuseID)
    }
    
    private func setupLayout() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension VIPListingsCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListingCardCell.reuseID,
            for: indexPath) as! ListingCardCell
        let item = items[indexPath.item]
        cell.configure(title: item.title,
                       location: item.location,
                       price: item.price,
                       isVIP: true,
                       imageName: item.imageName)
        return cell
    }
}
