//
//  LastResults.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 16/04/22.
//

import Foundation
import CoreData

public class Favorite: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var product: Data?
}
