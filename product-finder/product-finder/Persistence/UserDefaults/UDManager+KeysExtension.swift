//
//  UDManager+KeysExtension.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 18/04/22.
//

import Foundation

extension UDManager {
    enum DataKey: String, CaseIterable {
        case firstLaunch                    = "FIRST_LAUNCH"
        case lastSearchItems                = "LAST_SEARCH_ITEMS"
        case favoriteAddedNotShowAgain      = "FAVORITE_ADDED_NOT_SHOW_AGAIN"
        case favoriteDeletedNotShowAgain    = "FAVORITE_DELETED_NOT_SHOW_AGAIN"
        case swipeRight                     = "SWIPE_RIGHT"
        case swipeLeft                      = "SWIPE_LEFT"
    }
}
