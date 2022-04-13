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
        image.backgroundColor = .lightText
        image.layer.cornerRadius = 4
        image.contentMode = .scaleAspectFill
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
        label.text = "The Avengers"
        label.font = UI.Font.regularTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var subtitle: UILabel = {
        var label = UILabel()
        label.text = "Pelicula"
        label.font = UI.Font.subTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var cta: UIButton = {
        var button = UIButton()
        button.setTitle("•••", for: .normal)
        button.titleLabel?.textAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        title.text = product.name
        subtitle.text = "Product"
       
        if
            let imagePath = product.pictures.first?.url,
            let imageURL = URL(string: imagePath) {
            image.load(url: imageURL, id: "\(movie.id)", shimmeringView: shimmeringView)
        }
    }
    
    private func setupView() {
        backgroundColor = .clear
        contentView.setGradientBackground(with: [#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor, #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor])
        contentView.addSubview(shimmeringView)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        contentView.addSubview(cta)
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
                multiplier: 0.5,
                constant: UI.Layout.Spacing.Padding.NegativeMedium),
            title.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: 0.5,
                constant: UI.Layout.Spacing.Padding.NegativeMedium),
            subtitle.leadingAnchor.constraint(
                equalTo: shimmeringView.trailingAnchor,
                constant: UI.Layout.Spacing.Padding.Medium),
            subtitle.topAnchor.constraint(
                equalTo: title.bottomAnchor),
            subtitle.heightAnchor.constraint(
                equalTo: contentView.heightAnchor,
                multiplier: 0.12),
            subtitle.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: 0.5,
                constant: UI.Layout.Spacing.Padding.NegativeMedium),
            cta.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            cta.leadingAnchor.constraint(equalTo: subtitle.trailingAnchor),
            cta.leadingAnchor.constraint(equalTo: title.trailingAnchor),
            cta.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cta.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.title.text = nil
        self.subtitle.text = nil
        self.image.image = nil
    }
}
