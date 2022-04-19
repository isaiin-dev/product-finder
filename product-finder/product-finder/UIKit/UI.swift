//
//  UI.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 12/04/22.
//

import UIKit

struct UI {
    
    struct Layout {
        
        struct Spacing {
            struct Padding {
                static let Zero:            CGFloat = 0
                static let Medium:          CGFloat = 8
                static let Full:            CGFloat = Medium * 2
                static let NegativeMedium:  CGFloat = -8
                static let NegativeFull:    CGFloat = NegativeMedium * 2
            }
        }
        
        struct Radius {
            static let cardCorner: CGFloat = 8
        }
        
        struct Sizing {
            struct Text {
                static let title:       CGSize = CGSize(width: 0, height: 30)
                static let subTitle:    CGSize = CGSize(width: 0, height: 35)
            }
            
            struct Cells {
                static let SearchResultCell: CGSize = CGSize(width: 0, height: 160)
            }
        }
    }
    
    struct Font {
        static let superBigTitle     = UIFont.systemFont(ofSize: 34, weight: .bold)
        static let bigTitle     = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let regularTitle = UIFont.systemFont(ofSize: 16, weight: .bold)
        static let smallTitle   = UIFont.systemFont(ofSize: 13, weight: .bold)
        static let paragraph    = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let subTitle     = UIFont.systemFont(ofSize: 10, weight: .regular)
    }
}
