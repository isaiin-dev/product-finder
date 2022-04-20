//
//  LastResultsCoreDataManager.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 16/04/22.
//

import Foundation
import CoreData
import UIKit

class FavoritesCoreDataManager {
    public static let shared = FavoritesCoreDataManager()
    
    func save(favorite product: SimpleCollection.SearchProducts.Product) -> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let coreDataProduct = Favorite(context: managedContext)
        
        coreDataProduct.id = product.id
        
        let encoder = JSONEncoder()
        if let encodedProduct = try? encoder.encode(product) {
            coreDataProduct.product = encodedProduct
        }
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            Log.toConsole(type: .e, tag: "Error saving product", error)
            return false
        }
    }
    
    func getFavorites() -> [SimpleCollection.SearchProducts.Product] {
        var favorites = [SimpleCollection.SearchProducts.Product]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = Favorite.fetchRequest()
        
        do {
            let fetchedProducts = try managedContext.fetch(request)
            
            fetchedProducts.forEach { savedProduct in
                let decoder = JSONDecoder()
                if let product = savedProduct.product, let decodedProduct = try? decoder.decode(SimpleCollection.SearchProducts.Product.self, from: product) {
                    favorites.append(decodedProduct)
                }
            }
            
        } catch let error as NSError {
            Log.toConsole(type: .e, tag: "Error getting all products", error)
        }
        
        return favorites
    }
    
    func deleteFavorite(by id: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        var deleted: Bool = false
        let request = Favorite.fetchRequest()
        
        do {
            let fetchedProducts = try managedContext.fetch(request)
            
            fetchedProducts.forEach { savedProduct in
                if id == savedProduct.id {
                    managedContext.delete(savedProduct)
                    deleted = true
                }
            }
            
            try managedContext.save()
        } catch let error as NSError {
            Log.toConsole(type: .e, tag: "Error deleting all products", error)
        }
        
        return deleted
    }
    
    func deleteAllData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = Favorite.fetchRequest()
        
        do {
            let fetchedProducts = try managedContext.fetch(request)
            
            fetchedProducts.forEach { savedProduct in
                managedContext.delete(savedProduct)
            }
            
            try managedContext.save()
        } catch let error as NSError {
            Log.toConsole(type: .e, tag: "Error deleting all products" , error)
        }
    }
}
