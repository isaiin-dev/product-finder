//
//  Float+Extensions.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 13/04/22.
//

import Foundation
import CoreGraphics

extension Float {
    func asCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "es_MX")
        
        return formatter.string(from: NSNumber(value: self)) ?? "--"
    }
    
    func negative() -> Float {
        return -self
    }
}

extension CGFloat {
    func negative() -> CGFloat {
        return -self
    }
}
