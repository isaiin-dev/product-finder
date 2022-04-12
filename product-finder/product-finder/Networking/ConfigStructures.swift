//
//  ConfigStructures.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 12/04/22.
//

import Foundation

enum Method: String {
    case POST = "POST"
    case GET = "GET"
}

struct Endpoint {
    let url: String
    let space: String
    let service: String
    let method: Method?
}

struct RequestConfig {
    let body: Codable?
    var headers: [String:String]?
}

extension Encodable {
    func toData() -> Data? {
        do {
            let data = try APIManager.shared.jsonEncoder.encode(self)
            return data
        } catch _ {
            return nil
        }
    }
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension Data {
    func cast<T: Codable>(to: T.Type) -> T? {
        do {
            let object = try APIManager.shared.jsonDecoder.decode(T.self, from: self)
            return object
        } catch _ {
            return nil
        }
    }
}
