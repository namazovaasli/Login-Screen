//
//  İmageTitle.swift
//  Login Screen
//
//  Created by Əsli Namazova on 25.06.26.
//

import UIKit
import SnapKit

class İmageTitle: UIView {
    
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
        let title = UILabel()
        title.font = .systemFont(ofSize: 16, weight: .regular)
        title.numberOfLines = 0
        title.textColor = UIColor(named:"imagesubtitlecolor" )
        return title
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
