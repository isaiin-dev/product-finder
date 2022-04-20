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
    case toast(data: BottomSheet.ToastData)
}

enum BottomSheetAction {
    case leading, trailing, simpleOk, toast
}

protocol BottomSeheetDelegate: AnyObject {
    func didTap(action: BottomSheetAction, bottomSheet: BottomSheet, code: Int)
}

class BottomSheet: UIView {
    // MARK: - Properties
    
    var style: BottomSheetStyle?
    var target: UIViewController?
    var isOpen: Bool = false
    var blurEffectView: UIVisualEffectView?
    weak var delegate: BottomSeheetDelegate?
    var isToast: Bool = false
    var code: Int = 0
    
    let TAG = "BottomSheet".hashValue
    
    // MARK: - Subviews
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.Design.Font.systemBold24
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var content: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.Design.Font.systemRegular16
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
            self.delegate?.didTap(action: .simpleOk, bottomSheet: self, code: self.code)
        }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var twinsButtons: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = Constants.Design.Spacing.standard
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        var leadingConfiguration = UIButton.Configuration.tinted()
        leadingConfiguration.title = "Cancel"
        leadingConfiguration.cornerStyle = .large
        leadingConfiguration.baseForegroundColor = .white
        leadingConfiguration.baseBackgroundColor = .kobi
        let leadingButton = UIButton(configuration: leadingConfiguration)
        leadingButton.tag = "LEADING".hashValue
        leadingButton.addAction(UIAction { _ in
            self.delegate?.didTap(action: .leading, bottomSheet: self, code: self.code)
        }, for: .touchUpInside)
        leadingButton.translatesAutoresizingMaskIntoConstraints = false
        
        var trailingConfiguration = UIButton.Configuration.tinted()
        trailingConfiguration.title = "Okay"
        trailingConfiguration.cornerStyle = .large
        trailingConfiguration.baseForegroundColor = .white
        trailingConfiguration.baseBackgroundColor = .spaceCadet
        let trailingButton = UIButton(configuration: trailingConfiguration)
        trailingButton.tag = "TRAILING".hashValue
        trailingButton.addAction(UIAction { _ in
            self.delegate?.didTap(action: .trailing, bottomSheet: self, code: self.code)
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
        case .toast(_):
            frame = CGRect(
                x: .zero,
                y: parentFrame.height,
                width: parentFrame.width,
                height: parentFrame.height * 0.1)
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
            
            if let buttonTitles = data.buttonTitles {
                twinsButtons.arrangedSubviews.forEach { button in
                    if let b = button as? UIButton {
                        switch b.tag {
                        case "LEADING".hashValue:
                            b.setTitle(buttonTitles.leading, for: .normal)
                        case "TRAILING".hashValue:
                            b.setTitle(buttonTitles.trailing, for: .normal)
                        default: break
                        }
                    }
                }
            }
            
            if let code = data.code {
                self.code = code
            }
        case .toast(let data):
            if let dataContent = data.content {
                addSubview(title)
                title.text = dataContent
                title.font = Constants.Design.Font.systemBold16
                self.isToast = true
            }
        }

        setupContraints()
        addVisualEffect()
    }
    
    private func setupContraints() {
        let titleConstraints = [
            title.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Design.Spacing.higest),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Design.Spacing.higest),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Design.Spacing.higest.negative()),
            title.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ]
        
        let contentConstraints = [
            content.topAnchor.constraint(equalTo: title.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Design.Spacing.higest),
            content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Design.Spacing.higest.negative()),
            content.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25)
        ]
        
        let imageConstraints = [
            image.topAnchor.constraint(equalTo: title.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Design.Spacing.higest),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Design.Spacing.higest.negative()),
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
                    bigButton.topAnchor.constraint(equalTo: content.bottomAnchor, constant: Constants.Design.Spacing.higest),
                    bigButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Design.Spacing.higest),
                    bigButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Design.Spacing.higest.negative()),
                    bigButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
                ]
            }
            
            if data.image != nil {
                constraints += imageConstraints
                
                constraints += [
                    bigButton.topAnchor.constraint(equalTo: image.bottomAnchor, constant: Constants.Design.Spacing.higest),
                    bigButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Design.Spacing.higest),
                    bigButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Design.Spacing.higest.negative()),
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
                    twinsButtons.topAnchor.constraint(equalTo: content.bottomAnchor, constant: Constants.Design.Spacing.higest),
                    twinsButtons.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Design.Spacing.higest),
                    twinsButtons.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Design.Spacing.higest.negative()),
                    twinsButtons.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
                ]
            }
            
            if data.image != nil {
                constraints += imageConstraints
                
                constraints += [
                    twinsButtons.topAnchor.constraint(equalTo: image.bottomAnchor, constant: Constants.Design.Spacing.higest),
                    twinsButtons.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Design.Spacing.higest),
                    twinsButtons.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Design.Spacing.higest.negative()),
                    twinsButtons.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
                ]
            }
        case .toast(let data):
            if data.content != nil {
                constraints += [
                    title.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Design.Spacing.higest * 1.5),
                    title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Design.Spacing.higest),
                    title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Design.Spacing.higest.negative()),
                    title.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
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
        let buttonTitles: (leading: String, trailing: String)?
        let code: Int?
    }
    
    struct ToastData {
        let content: String?
    }
}

extension BottomSheet {
    func showAnimation() {
        if !isToast {
            self.target?.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        self.target?.tabBarController?.tabBar.isHidden = true
        DispatchQueue.main.async {
            if let blur = self.blurEffectView {
                if !self.isToast {
                    blur.alpha = 0
                    self.target?.view.addSubview(blur)
                }
            }
            self.target?.view.addSubview(self)
            UIView.animate(withDuration: 0.25, delay: .zero, options: .curveEaseOut) {
                self.frame.origin.y = (self.target?.view.frame.height)! - self.frame.height
                if !self.isToast {
                    self.blurEffectView?.alpha = 0.7
                }
            } completion: { finished in
                if finished {
                    self.isOpen = true
                    if self.isToast {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.hide()
                        }
                    }
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
                        if !self.isToast {
                            blur.alpha = 0
                            blur.removeFromSuperview()
                        }
                    }
                } completion: { finished in
                    if finished {
                        sView.removeFromSuperview()
                        self.isOpen = false
                        self.target?.tabBarController?.tabBar.isHidden = false
                        if !self.isToast {
                            self.target?.navigationController?.setNavigationBarHidden(false, animated: true)
                        }
                    }
                }
            })
        }
    }
}
