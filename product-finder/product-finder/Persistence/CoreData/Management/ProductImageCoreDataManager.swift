//
//  ProductImageCoreDataManager.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 18/04/22.
//

import Foundation
import CoreData
import UIKit

class ProductImageCoreDataManager {
    public static let shared = ProductImageCoreDataManager()

    func saveImage(id: String, image: UIImage) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let coreDataImage = ProductImage(context: managedContext)
        
        coreDataImage.productId = id
        coreDataImage.imageData = image.jpeg(.highest)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            Log.toConsole(type: .e, tag: "Error saving image", error)
        }
    }
    
    func getImage(by id: String, completion: @escaping(_ image: UIImage?) -> Void) {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let request = ProductImage.fetchRequest()
            
            do {
                let fetchedImages = try managedContext.fetch(request)
                var image: UIImage?
                
                fetchedImages.forEach { savedImage in
                    if savedImage.productId == id {
                        if let imageData = savedImage.imageData {
                            image = UIImage(data: imageData)
                        }
                    }
                }
                
                completion(image)
            } catch let error as NSError {
                Log.toConsole(type: .e, tag: "Error getting images", error)
                completion(nil)
            }
        }
    }
    
    func deleteAllData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = ProductImage.fetchRequest()
        
        do {
            let fetchedImages = try managedContext.fetch(request)
            
            fetchedImages.forEach { savedImage in
                managedContext.delete(savedImage)
            }
            
            try managedContext.save()
        } catch let error as NSError {
            Log.toConsole(type: .e, tag: "Error deleting all images", error)
        }
    }
}
