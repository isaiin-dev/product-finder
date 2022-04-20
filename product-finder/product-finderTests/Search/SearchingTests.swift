//
//  SearchingTests.swift
//  product-finderTests
//
//  Created by Alejandro isai Acosta Martinez on 20/04/22.
//

import XCTest
@testable import product_finder

class SearchingTests: XCTestCase {
    var rapidApiHost    = ""
    var rapidApiToken   = ""
    var meliAPiToken    = ""
    
    override func setUp() {
        super.setUp()
        self.rapidApiHost   = APIConfig.AUTH.KEYWORDS_API.RapidAPIHost
        self.rapidApiToken  = APIConfig.AUTH.KEYWORDS_API.RapidAPIKey
        self.meliAPiToken   = APIConfig.AUTH.MELI.BearerToken
        Log.enabled = false
    }
    
    override func tearDown() {
        super.tearDown()
        self.rapidApiHost   = ""
        self.rapidApiToken  = ""
        self.meliAPiToken   = ""
        Log.enabled = true
    }
    
    func testRapidApi_APIHostHasAValue() {
        XCTAssertFalse(self.rapidApiHost.isEmpty, "Host is not empty")
    }
    
    func testRapidApi_APITokenHasAValue() {
        XCTAssertFalse(self.rapidApiToken.isEmpty, "Token is not empty")
    }
    
    func testSearchKeywords_whenUserStartTyping_ResultHasAtLeastOneKeyword() {
        let query   = "Camera"
        let country = "mx"
        
        let worker  = SimpleCollectionWorker()
        let request = SimpleCollection.SearchKeywords.Request(search: query, country: country)
        
        let expectation = self.expectation(description: "waiting response")
        
        worker.searchSuggestedKeywords(request: request) { result in
            switch result {
            case .success(let response):
                XCTAssertTrue(response.suggestedKeywords.count > 1, "Response keywords is empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.description)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 300)
    }
    
    func testSearchProducts_whenUserSearch_ResultHasAtLeastOneProduct() {
        let worker  = SimpleCollectionWorker()
        let request = SimpleCollection.SearchProducts.Request(query: "Camera")
        
        let expectation = self.expectation(description: "waiting products response")
        
        worker.searchProducts(request: request) { result in
            switch result {
            case .success(let response):
                XCTAssertTrue(response.results.count > 1, "Response products is empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.description)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 300)
    }
    
    func testSearch_CanSaveProductAsFavorite() {
        let worker  = SimpleCollectionWorker()
        let request = SimpleCollection.SearchProducts.Request(query: "Camera")
        let coreDataManager = FavoritesCoreDataManager()
        
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
                    XCTAssertTrue(coreDataManager.save(favorite: firstProduct), "Product can't be saved to favorites")
                    expectation.fulfill()
                }
            case .failure(let error):
                XCTFail(error.description)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 300)
    }
}
