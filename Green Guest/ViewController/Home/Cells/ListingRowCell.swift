

import UIKit
import SnapKit

final class ListingRowCell: UITableViewCell {
    
    static let reuseID = "ListingRowCell"
    
    private var isFavorited = false
    
    private let cardView = UIView()
    private let listingImageView = UIImageView()
    private let favoriteButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let locationIcon = UIImageView()
    private let locationLabel = UILabel()
    private let priceLabel = UILabel()
    private let perDayLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, location: String,
                   price: String, imageName: String? = nil) {
        titleLabel.text = title
        locationLabel.text = location
        priceLabel.text = price
        if let name = imageName {
            listingImageView.image = UIImage(named: name)
        }
        isFavorited = false
        updateFavoriteButton()
    }
    
    private func setupUI() {
        cardView.backgroundColor = .systemBackground
        cardView.layer.cornerRadius = 16
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.08
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 8
        
        listingImageView.contentMode = .scaleAspectFill
        listingImageView.clipsToBounds = true
        listingImageView.layer.cornerRadius = 16
        listingImageView.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner
        ]
        listingImageView.backgroundColor = .systemGray5
        
        
        favoriteButton.backgroundColor = .white
        favoriteButton.layer.cornerRadius = 18
        favoriteButton.clipsToBounds = true
        favoriteButton.tintColor = .systemGray
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(heartTapped),
                                 for: .touchUpInside)
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 1
        
        locationIcon.image = UIImage(named: "location")
        locationIcon.tintColor = .systemGray
        locationIcon.contentMode = .scaleAspectFit
        
        locationLabel.font = .systemFont(ofSize: 13)
        locationLabel.textColor = .systemGray
        
        priceLabel.font = .systemFont(ofSize: 15, weight: .bold)
        priceLabel.textColor = UIColor(named: "mainbuttoncolor")
        
        perDayLabel.text = "/gün"
        perDayLabel.font = .systemFont(ofSize: 13)
        perDayLabel.textColor = .systemGray
    }
    
    private func updateFavoriteButton() {
        let img = UIImage(systemName: isFavorited ? "heart.fill" : "heart")?
                    .withRenderingMode(.alwaysTemplate)
                favoriteButton.setImage(img, for: .normal)
                favoriteButton.tintColor = isFavorited
                    ? UIColor(named: "mainbuttoncolor")
                    : UIColor(named: "mainbuttoncolor") 
    }
    
    @objc private func heartTapped() {
        isFavorited.toggle()
        updateFavoriteButton()
        UIView.animate(withDuration: 0.15,
                       animations: { self.favoriteButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3) },
                       completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.favoriteButton.transform = .identity
            }
        })
    }
    
    private func setupLayout() {
        contentView.addSubview(cardView)
        [listingImageView, favoriteButton,
         titleLabel, locationIcon, locationLabel,
         priceLabel, perDayLabel].forEach { cardView.addSubview($0) }
        
        cardView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        listingImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
        favoriteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(12)
            make.size.equalTo(36)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(listingImageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        locationIcon.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(12)
            make.size.equalTo(14)
        }
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationIcon)
            make.leading.equalTo(locationIcon.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(12)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(16)
        }
        perDayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(priceLabel)
            make.leading.equalTo(priceLabel.snp.trailing).offset(4)
        }
    }
}
