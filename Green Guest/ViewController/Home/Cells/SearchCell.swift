import UIKit
import SnapKit

final class SearchCell: UITableViewCell {
    
    static let reuseID = "SearchCell"
    private static let barHeight: CGFloat = 52
    
    var onSearchTapped: (() -> Void)?
    
    private let containerView = UIView()
    private let searchIcon = UIImageView()
    private let textStackView = UIStackView()
    private let searchTitleLabel = UILabel()
    private let placeholderLabel = UILabel()
    private let filterButton = UIButton(type: .custom)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupUI()
        setupLayout()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = Self.barHeight / 2
        containerView.isUserInteractionEnabled = true
        
        searchIcon.image = UIImage(named: "search")?
            .withRenderingMode(.alwaysTemplate)
        searchIcon.tintColor = .label
        searchIcon.contentMode = .scaleAspectFit
        
        textStackView.axis = .vertical
        textStackView.spacing = 1
        textStackView.alignment = .leading
        
        searchTitleLabel.text = "Axtarış"
        searchTitleLabel.font = .systemFont(ofSize: 11, weight: .regular)
        searchTitleLabel.textColor = .systemGray
        
        placeholderLabel.text = "Ev, fəaliyyət, məhsul axtarın"
        placeholderLabel.font = .systemFont(ofSize: 15, weight: .regular)
        placeholderLabel.textColor = UIColor(white: 0.45, alpha: 1)
        
        textStackView.addArrangedSubview(searchTitleLabel)
        textStackView.addArrangedSubview(placeholderLabel)
        
        filterButton.backgroundColor = .black
        filterButton.layer.cornerRadius = Self.barHeight / 2
        filterButton.clipsToBounds = true
        filterButton.setImage(
            UIImage(named: "slider")?.withRenderingMode(.alwaysOriginal),
            for: .normal
        )
        filterButton.imageView?.contentMode = .scaleAspectFit
        filterButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    private func setupLayout() {
        contentView.addSubview(containerView)
        contentView.addSubview(filterButton)
        containerView.addSubview(searchIcon)
        containerView.addSubview(textStackView)
        
        filterButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(Self.barHeight)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(filterButton.snp.leading).offset(-10)
            make.height.equalTo(Self.barHeight)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        searchIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(14)
            make.centerY.equalTo(textStackView)
            make.size.equalTo(18)
        }
        
        textStackView.snp.makeConstraints { make in
            make.leading.equalTo(searchIcon.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(12)
        }
    }
    
    private func setupActions() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(searchTapped))
        containerView.addGestureRecognizer(tap)
    }
    
    @objc private func searchTapped() {
        onSearchTapped?()
    }
}
