//
//  ItemResultCell.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 12/04/22.
//

import UIKit
import ShimmerSwift

class ItemResultCell: UITableViewCell {
    
    // MARK: - SubViews
    
    private var image: UIImageView = {
        var image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        image.layer.cornerRadius = 4
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var shimmeringView: ShimmeringView = {
        var shimmerView = ShimmeringView()
        shimmerView.contentView = self.image
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        return shimmerView
    }()
    
    private var title: UILabel = {
        var label = UILabel()
        label.textColor = .gray
        label.font = Constants.Design.Font.systemBold13
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var price: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.font = Constants.Design.Font.systemBold24
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var installsOrTag: UILabel = {
        var label = UILabel()
        label.textColor = .lightGray
        label.font = Constants.Design.Font.systemBold13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var shippingInfo: UILabel = {
        var label = UILabel()
        label.textColor = .lightGreen
        label.font = Constants.Design.Font.systemBold13
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Properties
    
    var product: SimpleCollection.SearchProducts.Product? {
        didSet {
            setData()
            guard !configured else { return }
            setupView()
        }
    }
    
    var configured = false

    // MARK: - Object lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setData() {
        guard let product = product else {
            return
        }
        title.text = product.title
        price.text = product.price.asCurrency()
        if let installments = product.installments {
            if installments.rate == 0{
                installsOrTag.attributedText = installments.getAttributtedDescription()
            } else {
                installsOrTag.text = installments.getDescription()
            }
        } else {
            installsOrTag.text = "TAG"
        }
        
        
        
        shippingInfo.text = "\(product.isFavorite ?? false ? Constants.Content.ProductDetail.favorite : "")\(product.shipping.freeShipping ? Constants.Content.ProductDetail.freeShipping : "")\(product.shipping.logisticType == "fulfillment" ? Constants.Content.ProductDetail.full : "")"
       
        if
            let imageURL = URL(string: product.thumbnail) {
            image.load(url: imageURL, id: "\(product.id)", shimmeringView: shimmeringView)
        }
    }
    
    private func setupView() {
        backgroundColor = .white
        contentView.addSubview(shimmeringView)
        contentView.addSubview(title)
        contentView.addSubview(price)
        contentView.addSubview(installsOrTag)
        contentView.addSubview(shippingInfo)
        setupConstraints()
        shimmeringView.isShimmering = true
        configured = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            shimmeringView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.Design.Spacing.higest),
            shimmeringView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.Design.Spacing.standard),
            shimmeringView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: Constants.Design.Spacing.standard.negative()),
            shimmeringView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor, multiplier: 0.25),
            title.leadingAnchor.constraint(
                equalTo: shimmeringView.trailingAnchor,
                constant: Constants.Design.Spacing.standard),
            title.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.Design.Spacing.higest),
            title.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: 0.25,
                constant: Constants.Design.Spacing.standard.negative()),
            title.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.Design.Spacing.higest.negative()),
            price.leadingAnchor.constraint(
                equalTo: shimmeringView.trailingAnchor,
                constant: Constants.Design.Spacing.standard),
            price.topAnchor.constraint(
                equalTo: title.bottomAnchor),
            price.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: 0.27),
            price.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.Design.Spacing.higest.negative()),
            installsOrTag.leadingAnchor.constraint(
                equalTo: shimmeringView.trailingAnchor,
                constant: Constants.Design.Spacing.standard),
            installsOrTag.topAnchor.constraint(
                equalTo: price.bottomAnchor),
            installsOrTag.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: 0.15),
            installsOrTag.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.Design.Spacing.higest.negative()),
            shippingInfo.leadingAnchor.constraint(
                equalTo: shimmeringView.trailingAnchor,
                constant: Constants.Design.Spacing.standard),
            shippingInfo.topAnchor.constraint(
                equalTo: installsOrTag.bottomAnchor),
            shippingInfo.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: 0.15),
            shippingInfo.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.Design.Spacing.higest.negative())
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.title.text = nil
        self.price.text = nil
        self.image.image = nil
        self.installsOrTag.text = nil
        self.shippingInfo.text = nil
    }
}
