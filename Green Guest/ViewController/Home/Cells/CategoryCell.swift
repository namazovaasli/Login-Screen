

import UIKit
import SnapKit

final class CategoryCell: UITableViewCell {
    
    static let reuseID = "CategoryCell"
    var onCategorySelected: ((Int) -> Void)?
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private var selectedIndex: Int = 0
    
    private let categories: [(title: String, icon: String)] = [
        ("Kirayə evlər", "house"),
        ("Fəaliyyətlər", "figure"),
        ("Məhsullar",    "cart")
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupUI()
        setupLayout()
        buildButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(selectedIndex: Int) {
        self.selectedIndex = selectedIndex
        buildButtons()
    }
    
    private func setupUI() {
        scrollView.showsHorizontalScrollIndicator = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
    }
    
    private func setupLayout() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
                .inset(UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16))
            make.height.equalToSuperview().inset(6)
        }
    }
    
    private func buildButtons() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        categories.enumerated().forEach { index, item in
            var config = UIButton.Configuration.filled()
            config.title = item.title
            config.image = UIImage(named: item.icon)?
                .withRenderingMode(.alwaysTemplate)
            config.imagePlacement = .leading
            config.imagePadding = 6
            config.titleTextAttributesTransformer =
                UIConfigurationTextAttributesTransformer { attrs in
                    var updated = attrs
                    updated.font = .systemFont(ofSize: 14, weight: .medium)
                    return updated
                }
            config.contentInsets = NSDirectionalEdgeInsets(
                top: 10, leading: 14, bottom: 10, trailing: 14)
            
            config.baseBackgroundColor = isSelected
                ? UIColor(named: "mainbuttoncolor")
                : .white
            
            let button = UIButton(configuration: config)
            button.layer.cornerRadius = 22
            button.clipsToBounds = true
            button.tag = index
            button.layer.borderWidth = isSelected ? 0 : 1
            button.layer.borderColor = UIColor.systemGray4.cgColor
            
            button.addTarget(self, action: #selector(categoryTapped(_:)),
                             for: .touchUpInside)
            applyStyle(to: button, isSelected: index == selectedIndex)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func applyStyle(to button: UIButton, isSelected: Bool) {
        var config = button.configuration ?? UIButton.Configuration.filled()
        config.baseBackgroundColor = isSelected
            ? UIColor(named: "mainbuttoncolor")
            : .systemGray6
        config.baseForegroundColor = isSelected ? .white : .label
        button.configuration = config
    }
    
    @objc private func categoryTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        stackView.arrangedSubviews
            .compactMap { $0 as? UIButton }
            .forEach { applyStyle(to: $0, isSelected: $0.tag == selectedIndex) }
        onCategorySelected?(selectedIndex)
    }
}
