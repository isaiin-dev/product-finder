//
//  ProductImage.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 18/04/22.
//

import Foundation
import CoreData

public class ProductImage: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductImage> {
        return NSFetchRequest<ProductImage>(entityName: "ProductImage")
    }
    
    @NSManaged public var productId: String?
    @NSManaged public var imageData: Data?
}
