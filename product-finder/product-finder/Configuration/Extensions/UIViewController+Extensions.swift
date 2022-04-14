//
//  UIViewController+Extensions.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 12/04/22.
//

import UIKit

extension UIViewController {
    func setGradientBackground(with colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.shouldRasterize = true
        view.layer.addSublayer(gradientLayer)
    }
    
    func showInfoAlert(data: BottomSheet.InfoData) {
        self.tabBarController?.bottomSheet = BottomSheet(target: self, style: .info(data: data))
        self.tabBarController?.bottomSheet?.show()
    }
    
    func showActionAlert(data: BottomSheet.ActionData) {
        self.tabBarController?.bottomSheet = BottomSheet(target: self, style: .action(data: data))
        self.tabBarController?.bottomSheet?.show()
    }
}
