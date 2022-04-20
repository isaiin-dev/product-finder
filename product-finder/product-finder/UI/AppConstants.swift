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
        struct Scenes {
            static let searchTitle      = "Product search"
            static let lastSearchTitle  = "Last search"
            static let favoritesTitle   = "Favorites"
            
            static let searchIcon       = UIImage(systemName: "magnifyingglass.circle")!
            static let lastSearchIcon   = UIImage(systemName: "clock.arrow.circlepath")!
            static let favoritesIcon    = UIImage(systemName: "heart.circle")!
        }
        struct ProductDetail {
            static let title        = "Details"
            static let attributes   = "Features"
            static let CTA          = "Show in MercadoLible"
            static let freeShipping = "Envio gratis "
            static let full         = "⚡️FULL"
            static let favorite     = "💜 - "
        }
        
        struct KeywordsView {
            static let noData       = "No data, try another word."
        }
        
        struct SimpleCollectionView {
            struct Search {
                static let title        = "Product search"
                static let placeHolder  = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            }
            
            struct LastSearch {
                
            }
            
            struct Favorites {
                
            }
            
            struct Alert {
                static let firstLauch = BottomSheet.InfoData(
                    title: "Welcome buddy!",
                    content: "Remember that every time you make a search you can delete it by pressing 🗑 in the upper right",
                    image: nil)
                static let favoriteSaved = BottomSheet.InfoData(title: "Yay!", content: "Your product has been saved to favorites!", image: nil)
                static let favoriteNotSaved = BottomSheet.InfoData(title: "Ooops!", content: "Your product can't been saved to favorites!", image: nil)
                static let favoriteDeleted = BottomSheet.InfoData(title: "Okay", content: "Your product has been deleted from favorites!", image: nil)
                static let favoriteNotDeleted = BottomSheet.InfoData(title: "Ooops!", content: "Your product can't been deleted from favorites!", image: nil)
                static let alreadyFavorite = BottomSheet.InfoData(
                    title: "going fast?",
                    content: "You have already added this product to your favorites list!",
                    image: nil)
            }
        }
    }
}
