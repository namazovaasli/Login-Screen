

import UIKit
import SnapKit


final class SectionHeaderCell: UITableViewCell {
    
    static let reuseID = "SectionHeaderCell"
    
    var onSeeAllTapped: (() -> Void)?
    
    private let titleLabel = UILabel()
    private let seeAllButton = UIButton(type: .system)
    
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
    
    func configure(title: String, showSeeAll: Bool = true) {
        titleLabel.text = title
        seeAllButton.isHidden = !showSeeAll
    }
    
    private func setupUI() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .label
        
        seeAllButton.setTitle("Hamısına bax", for: .normal)
        seeAllButton.setTitleColor(UIColor(named: "mainbuttoncolor"), for: .normal)
        seeAllButton.titleLabel?.font = .systemFont(ofSize: 14)
        seeAllButton.addTarget(self, action: #selector(seeAllTapped),
                               for: .touchUpInside)
    }
    
    private func setupLayout() {
        [titleLabel, seeAllButton].forEach { contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        seeAllButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func seeAllTapped() {
        onSeeAllTapped?()
    }
}
