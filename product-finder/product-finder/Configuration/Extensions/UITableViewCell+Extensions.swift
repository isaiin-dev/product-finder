//
//  UITableViewCell+Extensions.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 13/04/22.
//

import UIKit

extension UITableViewCell {
    func setSelectedBackground(color: UIColor) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = color
        self.selectedBackgroundView = backgroundView
    }
}
