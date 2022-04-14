//
//  BottomSheet.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 14/04/22.
//

import UIKit

enum BottomSheetStyle {
    case info(data: BottomSheet.InfoData)
    case action(data: BottomSheet.ActionData)
}

class BottomSheet: UIView {
    // MARK: - Properties
    
    var style: BottomSheetStyle?
    var target: UIViewController?
    var isOpen: Bool = false
    
    let TAG = "BottomSheet".hashValue
    
    // MARK: - Subviews
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UI.Font.bigTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var content: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UI.Font.paragraph
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var bigButton: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    init(target: UIViewController, style: BottomSheetStyle) {
        var frame: CGRect = .zero
        let parentFrame = target.view.frame
        
        switch style {
        case .info(_):
            frame = CGRect(
                x: .zero,
                y: parentFrame.height,
                width: parentFrame.width,
                height: parentFrame.height * 0.25)
        case .action(_):
            frame = CGRect(
                x: .zero,
                y: parentFrame.height,
                width: parentFrame.width,
                height: parentFrame.height * 0.35)
        }
        
        super.init(frame: frame)
        self.target = target
        self.style = style
        setupView()
        tag = TAG
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup view
    
    private func setupView() {
        backgroundColor = .accentColor
        
        guard let style = style else { return }
        
        switch style {
        case .info(let data):
            if let dataTitle = data.title {
                addSubview(title)
                title.text = dataTitle
            }
            
            if let dataContent = data.content {
                addSubview(content)
                content.text = dataContent
            }
            
            if let dataImage = data.image {
                addSubview(image)
                image.image = dataImage
            }
            
            addSubview(bigButton)
        case .action(_):
            print("TODO")
        }
        
        let gestureRecognizer = UIGestureRecognizer(target: self, action: #selector(touchOutside))
        addGestureRecognizer(gestureRecognizer)
        
        setupContraints()
    }
    
    private func setupContraints() {
        let titleConstraints = [
            title.topAnchor.constraint(equalTo: topAnchor, constant: UI.Layout.Spacing.Padding.Full),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Layout.Spacing.Padding.Full),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: UI.Layout.Spacing.Padding.NegativeFull),
            title.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ]
        
        let contentConstraints = [
            content.topAnchor.constraint(equalTo: title.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Layout.Spacing.Padding.Full),
            content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: UI.Layout.Spacing.Padding.NegativeFull),
            content.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25)
        ]
        
        let imageConstraints = [
            image.topAnchor.constraint(equalTo: title.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Layout.Spacing.Padding.Full),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: UI.Layout.Spacing.Padding.NegativeFull),
            image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ]
        
        var constraints = [NSLayoutConstraint]()
        
        guard let style = style else { return }
        
        switch style {
        case .info(let data):
            if data.title != nil {
                constraints += titleConstraints
            }
            
            if data.content != nil {
                constraints += contentConstraints
                
                constraints += [
                    bigButton.topAnchor.constraint(equalTo: content.bottomAnchor, constant: UI.Layout.Spacing.Padding.Full),
                    bigButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Layout.Spacing.Padding.Full),
                    bigButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: UI.Layout.Spacing.Padding.NegativeFull),
                    bigButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
                ]
            }
            
            if data.image != nil {
                constraints += imageConstraints
                
                constraints += [
                    bigButton.topAnchor.constraint(equalTo: image.bottomAnchor, constant: UI.Layout.Spacing.Padding.Full),
                    bigButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Layout.Spacing.Padding.Full),
                    bigButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: UI.Layout.Spacing.Padding.NegativeFull),
                    bigButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
                ]
            }
        case .action(_):
            print("TODO")
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Actions
    
    func show() {
        guard !isOpen else { return }
        showAnimation()
    }
    
    func hide() {
        guard isOpen else { return }
        hideAnimation()
    }
    
    @objc func touchOutside() {
        hide()
    }
    
    // MARK: - Structs
    
    struct InfoData {
        let title: String?
        let content: String?
        let image: UIImage?
    }
    
    struct ActionData {
        let title: String?
        let content: String?
        let image: UIImage?
    }
}

extension BottomSheet {
    func showAnimation() {
        self.target?.tabBarController?.tabBar.isHidden = true
        DispatchQueue.main.async {
            self.target?.view.addSubview(self)
            UIView.animate(withDuration: 0.25, delay: .zero, options: .curveEaseOut) {
                self.frame.origin.y = (self.target?.view.frame.height)! - self.frame.height
            } completion: { finished in
                if finished {
                    self.isOpen = true
                }
            }
        }
    }
    
    func hideAnimation() {
        DispatchQueue.main.async {
            self.target?.view.subviews.forEach({ sView in
                guard sView.tag == self.TAG else { return }
                UIView.animate(withDuration: 0.25, delay: .zero, options: .curveEaseOut) {
                    self.frame.origin.y = (self.target?.view.frame.height)!
                } completion: { finished in
                    if finished {
                        sView.removeFromSuperview()
                        self.isOpen = false
                        self.target?.tabBarController?.tabBar.isHidden = true
                    }
                }
            })
        }
    }
}
