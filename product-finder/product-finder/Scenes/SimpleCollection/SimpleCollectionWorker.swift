//
//  SimpleCollectionWorker.swift
//  product-finder
//
//  Created Alejandro isai Acosta Martinez on 12/04/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file is where we will have direct access to our network layer 
//  (APIManager) and our data persistence layer (DataStore), it is important 
//  that all the functions in this class always return something
//
//  This file was generated by the IsaiinDev's iOS Templates so
//  you can apply clean architecture to your iOS projects.
//

import Foundation

class SimpleCollectionWorker: APIManagerDelegate {
    func searchSuggestedKeywords(
        request: SimpleCollection.SearchKeywords.Request,
        completion: @escaping(Result<SimpleCollection.SearchKeywords.Response, RequestError>) -> Void) {
        let endpoint = Endpoint(
            url: APIConfig.CONFIG.SERVER.RAPIDAPPI.BASE_URL,
            space: APIConfig.SPACE.RAPIDAPI.KEYWORD_SEARCH,
            service: APIConfig.ENDPOINT.RAPIDAPI.SUGGESTED_KEYWORDS,
            method: .GET)
        let config = RequestConfig(body: request, headers: [
            "X-RapidAPI-Host": APIConfig.AUTH.KEYWORDS_API.RapidAPIHost,
            "X-RapidAPI-Key": APIConfig.AUTH.KEYWORDS_API.RapidAPIKey
        ])
        
        fetch(from: endpoint, config: config, completion: completion)
    }
    
    func searchProducts(
        request: SimpleCollection.SearchProducts.Request,
        completion: @escaping(Result<SimpleCollection.SearchProducts.Response, RequestError>) -> Void) {
            let endpoint = Endpoint(
                url: APIConfig.CONFIG.SERVER.MELI.BASE_URL,
                space: APIConfig.SPACE.MELI.SITES.MEXICO,
                service: APIConfig.ENDPOINT.MELI.PRODUCTS.SEARCH,
                method: .GET)
            let config = RequestConfig(
                body: request,
                headers: [
                    "Authorization": APIConfig.AUTH.MELI.BearerToken
                ])
            
            fetch(from: endpoint, config: config, completion: completion)
    }
}
