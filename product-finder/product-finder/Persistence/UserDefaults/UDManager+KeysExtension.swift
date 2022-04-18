//
//  UDManager+KeysExtension.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 18/04/22.
//

import Foundation

extension UDManager {
    enum DataKey: String, CaseIterable {
        case firstLaunch = "FIRST_LAUNCH"
        case lastSearchItems = "LAST_SEARCH_ITEMS"
    }
}
