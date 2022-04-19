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

enum BottomSheetAction {
    case leading, trailing, simpleOk
}

protocol BottomSeheetDelegate: AnyObject {
    func didTap(action: BottomSheetAction, bottomSheet: BottomSheet)
}

class BottomSheet: UIView {
    // MARK: - Properties
    
    var style: BottomSheetStyle?
    var target: UIViewController?
    var isOpen: Bool = false
    var blurEffectView: UIVisualEffectView?
    weak var delegate: BottomSeheetDelegate?
    
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
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "OK"
        configuration.cornerStyle = .large
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .spaceCadet
        let button = UIButton(configuration: configuration)
        button.addAction(UIAction { _ in
            self.delegate?.didTap(action: .simpleOk, bottomSheet: self)
        }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var twinsButtons: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = UI.Layout.Spacing.Padding.Medium
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        var leadingConfiguration = UIButton.Configuration.tinted()
        leadingConfiguration.title = "Cancel"
        leadingConfiguration.cornerStyle = .large
        leadingConfiguration.baseForegroundColor = .white
        leadingConfiguration.baseBackgroundColor = .kobi
        let leadingButton = UIButton(configuration: leadingConfiguration)
        leadingButton.addAction(UIAction { _ in
            self.delegate?.didTap(action: .leading, bottomSheet: self)
        }, for: .touchUpInside)
        leadingButton.translatesAutoresizingMaskIntoConstraints = false
        
        var trailingConfiguration = UIButton.Configuration.tinted()
        trailingConfiguration.title = "Okay"
        trailingConfiguration.cornerStyle = .large
        trailingConfiguration.baseForegroundColor = .white
        trailingConfiguration.baseBackgroundColor = .spaceCadet
        let trailingButton = UIButton(configuration: trailingConfiguration)
        trailingButton.addAction(UIAction { _ in
            self.delegate?.didTap(action: .trailing, bottomSheet: self)
        }, for: .touchUpInside)
        trailingButton.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(leadingButton)
        stack.addArrangedSubview(trailingButton)
        
        return stack
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
                height: parentFrame.height * 0.25)
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
        backgroundColor = .purpureus
        
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
        case .action(let data):
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
            
            addSubview(twinsButtons)
        }

        setupContraints()
        addVisualEffect()
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
        case .action(let data):
            if data.title != nil {
                constraints += titleConstraints
            }
            
            if data.content != nil {
                constraints += contentConstraints
                
                constraints += [
                    twinsButtons.topAnchor.constraint(equalTo: content.bottomAnchor, constant: UI.Layout.Spacing.Padding.Full),
                    twinsButtons.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Layout.Spacing.Padding.Full),
                    twinsButtons.trailingAnchor.constraint(equalTo: trailingAnchor, constant: UI.Layout.Spacing.Padding.NegativeFull),
                    twinsButtons.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
                ]
            }
            
            if data.image != nil {
                constraints += imageConstraints
                
                constraints += [
                    twinsButtons.topAnchor.constraint(equalTo: image.bottomAnchor, constant: UI.Layout.Spacing.Padding.Full),
                    twinsButtons.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Layout.Spacing.Padding.Full),
                    twinsButtons.trailingAnchor.constraint(equalTo: trailingAnchor, constant: UI.Layout.Spacing.Padding.NegativeFull),
                    twinsButtons.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
                ]
            }
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addVisualEffect() {
        if let parent = self.target {
            let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView?.frame = parent.view.bounds
            blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView?.tag = "BLUREFFECT".hashValue
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBlur(_:)))
            blurEffectView?.addGestureRecognizer(tapGestureRecognizer)
        }
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
    
    @objc func didTapBlur(_ sender: UITapGestureRecognizer) {
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
        self.target?.navigationController?.setNavigationBarHidden(true, animated: true)
        DispatchQueue.main.async {
            if let blur = self.blurEffectView {
                blur.alpha = 0
                self.target?.view.addSubview(blur)
            }
            self.target?.view.addSubview(self)
            UIView.animate(withDuration: 0.25, delay: .zero, options: .curveEaseOut) {
                self.frame.origin.y = (self.target?.view.frame.height)! - self.frame.height
                self.blurEffectView?.alpha = 0.7
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
                    if let blur = self.blurEffectView {
                        blur.alpha = 0
                        blur.removeFromSuperview()
                    }
                } completion: { finished in
                    if finished {
                        sView.removeFromSuperview()
                        self.isOpen = false
                        self.target?.tabBarController?.tabBar.isHidden = false
                        self.target?.navigationController?.setNavigationBarHidden(false, animated: true)
                    }
                }
            })
        }
    }
}
