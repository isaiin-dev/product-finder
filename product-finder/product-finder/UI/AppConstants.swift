//
//  UI.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 12/04/22.
//

import UIKit

struct Constants {
    
    struct Design {
        struct Spacing {
            static let zero: CGFloat        = 0
            static let minimun: CGFloat     = 4
            static let standard: CGFloat    = minimun * 2
            static let higest: CGFloat      = standard * 2
        }
        
        struct Radius {
            static let standard: CGFloat = 8
        }
        
        struct Sizing {
            struct Label {
                static let titleHeight: CGFloat = 30
                static let subTitleHeight: CGFloat = 35
            }
            
            struct Cell {
                static let cellHeight: CGFloat = 160
            }
        }
        
        struct Font {
            static let systemBold34     = UIFont.systemFont(ofSize: 34, weight: .bold)
            static let systemBold24     = UIFont.systemFont(ofSize: 24, weight: .bold)
            static let systemBold16     = UIFont.systemFont(ofSize: 16, weight: .bold)
            static let systemBold13     = UIFont.systemFont(ofSize: 13, weight: .bold)
            static let systemRegular16  = UIFont.systemFont(ofSize: 16, weight: .regular)
            static let systemRegular10  = UIFont.systemFont(ofSize: 10, weight: .regular)
        }
    }
    
    struct Content {
        struct ProductDetail {
            static let title        = "Details"
            static let attributes   = "Features"
            static let CTA          = "Show in MercadoLible"
            static let freeShipping = "Envio gratis "
            static let full         = "⚡️FULL"
        }
    }
}
