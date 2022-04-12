//
//  ApiManagerDelegate.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 12/04/22.
//

import Foundation

/// Protocol to extend any worker with the APIManager **fetch** function implementation.
protocol APIManagerDelegate {
    /**
     Create and launch any type of **HTTP** request
     
     - Author: IsaiinDev
     - Parameters:
        - endpoint: The **Endpoint** object of the request.
        - config: The **RequestConfig** object of the request.
        - completion: A closure returning the **Result<T, RquestError>** object.
     - returns: nothing
     - warning: !
     */
    func fetch<T: Codable>(
        from endpoint: Endpoint,
        config: RequestConfig,
        completion: @escaping(Result<T, RequestError>) -> Void)
}

/// Standalone implementation of the APIManager **fetch** function.
extension APIManagerDelegate {
    /**
     Create and launch any type of **HTTP** request
     
     - Author: IsaiinDev
     - Parameters:
        - endpoint: The **Endpoint** object of the request.
        - config: The **RequestConfig** object of the request.
        - completion: A closure returning the **Result<T, RquestError>** object.
     - returns: nothing
     - warning: !
     */
    func fetch<T: Codable>(
        from endpoint: Endpoint,
        config: RequestConfig,
        completion: @escaping(Result<T, RequestError>) -> Void) {
            APIManager.shared.fetch(from: endpoint, config: config, completion: completion)
        }
}
