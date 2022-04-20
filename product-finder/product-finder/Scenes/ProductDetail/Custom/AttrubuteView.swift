//
//  AttrubuteView.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 18/04/22.
//

import UIKit


class AttributeView: UIView {
    // MARK: - Properties
    
    var attribute: SimpleCollection.SearchProducts.Attribute? {
        didSet {
            guard let attribute = attribute else {
                return
            }

            title.text = attribute.name
            content.text = attribute.valueName
        }
    }
    
    // MARK: - Subviews
    
    private var title: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = Constants.Design.Font.systemRegular10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var content: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = Constants.Design.Font.systemBold16
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Object lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .white
        addSubview(title)
        addSubview(content)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.topAnchor.constraint(equalTo: topAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            content.leadingAnchor.constraint(equalTo: leadingAnchor),
            content.topAnchor.constraint(equalTo: title.bottomAnchor),
            content.trailingAnchor.constraint(equalTo: trailingAnchor),
            content.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
