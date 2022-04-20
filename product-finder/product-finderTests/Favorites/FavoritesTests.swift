//
//  FavoritesTests.swift
//  product-finderTests
//
//  Created by Alejandro isai Acosta Martinez on 20/04/22.
//

import XCTest
@testable import product_finder

class FavoritesTests: XCTestCase {
    var coreDataManager: FavoritesCoreDataManager?
    
    override func setUp() {
        super.setUp()
        self.coreDataManager = FavoritesCoreDataManager()
        Log.enabled = false
    }
    
    override func tearDown() {
        super.tearDown()
        self.coreDataManager = nil
        Log.enabled = true
    }
    
    func testFavorites_AFavoriteCanBeAdded() {
        let worker  = SimpleCollectionWorker()
        let request = SimpleCollection.SearchProducts.Request(query: "Alexa")
        
        let expectation = self.expectation(description: "waiting products response")
        
        worker.searchProducts(request: request) { result in
            switch result {
            case .success(let response):
                guard
                    let firstProduct = response.results.first
                else {
                    XCTFail("Response has no products")
                    expectation.fulfill()
                    return
                }
                DispatchQueue.main.async {
                    if let manager = self.coreDataManager {
                        XCTAssertTrue(manager.save(favorite: firstProduct), "Product can't be saved to favorites")
                        expectation.fulfill()
                    } else {
                        XCTFail("coreDataManager did not initialize")
                        expectation.fulfill()
                    }
                }
            case .failure(let error):
                XCTFail(error.description)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 300)
    }
    
    func testFavorites_UserHasAtLeastOneFavoriteSaved() {
        if let manager = self.coreDataManager {
            XCTAssertNotNil(manager.getFavorites().first, "The user does not have any favorites")
        } else {
            XCTFail("coreDataManager did not initialize")
        }
    }
    
    func testFavorites_AFavoriteCanBeDeleted() {
        let worker  = SimpleCollectionWorker()
        let request = SimpleCollection.SearchProducts.Request(query: "Huawei")
        
        let expectation = self.expectation(description: "waiting products response")
        
        worker.searchProducts(request: request) { result in
            switch result {
            case .success(let response):
                guard
                    let firstProduct = response.results.first
                else {
                    XCTFail("Response has no products")
                    expectation.fulfill()
                    return
                }
                DispatchQueue.main.async {
                    if let manager = self.coreDataManager {
                        _ = manager.save(favorite: firstProduct)
                        
                        XCTAssertTrue(manager.deleteFavorite(by: firstProduct.id), "Can't delete a favorite")
                        expectation.fulfill()
                    } else {
                        XCTFail("coreDataManager did not initialize")
                        expectation.fulfill()
                    }
                }
            case .failure(let error):
                XCTFail(error.description)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 300)
    }
}
