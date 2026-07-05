

import UIKit
import SnapKit

final class ListingCardCell: UICollectionViewCell {
    
    static let reuseID = "ListingCardCell"
    
    private var isFavorited = false
    
    private let imageView = UIImageView()
    private let vipBadge = UIView()
    private let vipIconImageView = UIImageView()
    private let vipLabel = UILabel()
    private let favoriteButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let locationIcon = UIImageView()
    private let locationLabel = UILabel()
    private let priceLabel = UILabel()
    private let perDayLabel = UILabel()
    
    private let amenitiesStack = UIStackView()
    private let moreLabel = UILabel()
    
    private let amenityIconNames = ["wifi", "pool", "grill"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, location: String,
                   price: String, isVIP: Bool,
                   imageName: String? = nil) {
        titleLabel.text = title
        locationLabel.text = location
        priceLabel.text = price
        vipBadge.isHidden = !isVIP
        
        if let name = imageName {
            imageView.image = UIImage(named: name)
        }
        isFavorited = false
        updateFavoriteButton()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.08
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 6
        contentView.clipsToBounds = false
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner
        ]
        imageView.backgroundColor = .systemGray5
        
        vipBadge.backgroundColor = .white
        vipBadge.layer.cornerRadius = 12
        vipBadge.clipsToBounds = true
        
        vipIconImageView.image = UIImage(named: "vip")
                vipIconImageView.tintColor = UIColor(named: "mainbuttoncolor")
                vipIconImageView.contentMode = .scaleAspectFit
                
                vipLabel.text = "VIP"
                vipLabel.font = .systemFont(ofSize: 11, weight: .semibold)
                vipLabel.textColor = .label
        
        favoriteButton.backgroundColor = .white
        favoriteButton.layer.cornerRadius = 18
        favoriteButton.clipsToBounds = true
        favoriteButton.tintColor = .systemGray
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(heartTapped),
                                 for: .touchUpInside)
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 1
        
        locationIcon.image = UIImage(named: "location")
        locationIcon.tintColor = .systemGray
        locationIcon.contentMode = .scaleAspectFit
        
        locationLabel.font = .systemFont(ofSize: 14)
        locationLabel.textColor = .systemGray
        locationLabel.numberOfLines = 1
        
        priceLabel.font = .systemFont(ofSize: 14, weight: .bold)
        priceLabel.textColor = UIColor(named: "mainbuttoncolor")
        
        perDayLabel.text = "/gün"
        perDayLabel.font = .systemFont(ofSize: 14)
        perDayLabel.textColor = .systemGray
        
        amenitiesStack.axis = .horizontal
        amenitiesStack.spacing = 6
        amenitiesStack.alignment = .center
        setupAmenities()
    }
    
    private func setupAmenities() {
        amenitiesStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        amenityIconNames.forEach { name in
            let iconView = UIImageView()
            iconView.image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = .systemGray
            iconView.contentMode = .scaleAspectFit
            iconView.snp.makeConstraints { make in
                make.size.equalTo(14)
            }
            amenitiesStack.addArrangedSubview(iconView)
        }
        
        moreLabel.text = "+4"
        moreLabel.font = .systemFont(ofSize: 12, weight: .medium)
        moreLabel.textColor = .systemGray
        amenitiesStack.addArrangedSubview(moreLabel)
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
        [imageView, vipBadge, favoriteButton,
         titleLabel, locationIcon, locationLabel,
         amenitiesStack, priceLabel, perDayLabel].forEach { contentView.addSubview($0) }
        [vipIconImageView, vipLabel].forEach { vipBadge.addSubview($0) }
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
        vipBadge.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
            make.height.equalTo(26)
        }
        vipIconImageView.snp.makeConstraints { make in
                    make.leading.equalToSuperview().inset(8)
                    make.centerY.equalToSuperview()
                    make.size.equalTo(14)
                }
        vipLabel.snp.makeConstraints { make in
            make.leading.equalTo(vipIconImageView.snp.trailing).offset(4)
                        make.centerY.equalToSuperview()
                        make.trailing.equalToSuperview().inset(8)
        }
        favoriteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
            make.size.equalTo(32)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        locationIcon.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
            make.size.equalTo(13)
        }
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationIcon)
            make.leading.equalTo(locationIcon.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(10)
        }
        amenitiesStack.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(14)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(amenitiesStack.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        perDayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(priceLabel)
            make.leading.equalTo(priceLabel.snp.trailing).offset(4)
        }
    }
}
