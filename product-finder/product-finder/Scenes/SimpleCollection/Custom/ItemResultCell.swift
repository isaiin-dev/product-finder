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
        label.font = UI.Font.smallTitle
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var price: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.font = UI.Font.bigTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var installsOrTag: UILabel = {
        var label = UILabel()
        label.textColor = .lightGray
        label.font = UI.Font.smallTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var shippingInfo: UILabel = {
        var label = UILabel()
        label.textColor = .lightGreen
        label.font = UI.Font.smallTitle
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
        
        
        
        shippingInfo.text = "\(product.isFavorite ?? false ? "💜 - ":"")\(product.shipping.freeShipping ? "Envio gratis ":"")\(product.shipping.logisticType == "fulfillment" ? "⚡️FULL":"")"
       
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
                constant: UI.Layout.Spacing.Padding.Full),
            shimmeringView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: UI.Layout.Spacing.Padding.Medium),
            shimmeringView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: UI.Layout.Spacing.Padding.NegativeMedium),
            shimmeringView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor, multiplier: 0.25),
            title.leadingAnchor.constraint(
                equalTo: shimmeringView.trailingAnchor,
                constant: UI.Layout.Spacing.Padding.Medium),
            title.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: UI.Layout.Spacing.Padding.Full),
            title.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: 0.25,
                constant: UI.Layout.Spacing.Padding.NegativeMedium),
            title.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: UI.Layout.Spacing.Padding.NegativeFull),
            price.leadingAnchor.constraint(
                equalTo: shimmeringView.trailingAnchor,
                constant: UI.Layout.Spacing.Padding.Medium),
            price.topAnchor.constraint(
                equalTo: title.bottomAnchor),
            price.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: 0.27),
            price.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: UI.Layout.Spacing.Padding.NegativeFull),
            installsOrTag.leadingAnchor.constraint(
                equalTo: shimmeringView.trailingAnchor,
                constant: UI.Layout.Spacing.Padding.Medium),
            installsOrTag.topAnchor.constraint(
                equalTo: price.bottomAnchor),
            installsOrTag.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: 0.15),
            installsOrTag.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: UI.Layout.Spacing.Padding.NegativeFull),
            shippingInfo.leadingAnchor.constraint(
                equalTo: shimmeringView.trailingAnchor,
                constant: UI.Layout.Spacing.Padding.Medium),
            shippingInfo.topAnchor.constraint(
                equalTo: installsOrTag.bottomAnchor),
            shippingInfo.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: 0.15),
            shippingInfo.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: UI.Layout.Spacing.Padding.NegativeFull)
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
