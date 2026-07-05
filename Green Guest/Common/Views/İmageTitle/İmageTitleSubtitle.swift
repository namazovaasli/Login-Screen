

import UIKit
import SnapKit

class İmageTitleSubtitle: UIView {
    
    private let image = UIImageView()
    private let titleStack = UIStackView()
    private let mainStack = UIStackView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let title: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 24, weight: .semibold)
        title.textColor = UIColor(named: "maintext")
        return title
    }()
    
    private let subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.font = .systemFont(ofSize: 16, weight: .regular)
        subtitle.numberOfLines = 0
        subtitle.textAlignment = .center
        subtitle.textColor = UIColor(named:"imagesubtitlecolor" )
        return subtitle
    }()
    
    
    init(image: UIImage, title: String, subtitle: String ){
        super.init(frame: .zero)
        self.image.image = image
        self.title.text = title
        self.subtitle.text = subtitle
        setupLayout()
    }
    
    private func setupLayout() {
        [title, subtitle].forEach{titleStack.addArrangedSubview($0)}
        titleStack.axis = .vertical
        titleStack.spacing = 8
        titleStack.alignment = .center
        
        [image, titleStack].forEach{mainStack.addArrangedSubview($0)}
        mainStack.axis = .vertical
        mainStack.spacing = 28
        mainStack.distribution = .equalCentering
        mainStack.alignment = .center
        
        addSubview(mainStack)
        
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
