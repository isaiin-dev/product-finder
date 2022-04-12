//
//  UIView+Extensions.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 12/04/22.
//
import UIKit

extension UIView {
    func setGradientBackground(with colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.shouldRasterize = true
        self.layer.addSublayer(gradientLayer)
    }
    
    func setLinearGradient(with colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.shouldRasterize = true
        layer.addSublayer(gradientLayer)
    }
}
