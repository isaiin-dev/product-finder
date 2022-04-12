//
//  ApiManager.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 12/04/22.
//

import Foundation

struct RequestError: Error {
    let statusCode: Int
    let description: String
    var data: Data?
}

class APIManager {
    public static let shared: APIManager = APIManager()
    
    private let session = URLSession.shared

    let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    let jsonEncoder: JSONEncoder = {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .useDefaultKeys
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonEncoder.dateEncodingStrategy = .formatted(dateFormatter)
        return jsonEncoder
    }()
    
    func fetch<T: Codable>(from endpoint: Endpoint, config: RequestConfig, completion: @escaping(Result<T, RequestError>) -> Void) {
        guard let request = makeRequest(from: endpoint, config: config) else {
            completion(.failure(RequestError(statusCode: 00, description: "InvalidRequest", data: nil)))
            return
        }
        session.dataTask(with: request) { result in
            switch result {
            case .success(let (response, data)):
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode)
                else {
                    completion(.failure(self.getError(response: response, data: data)))
                    return
                }
                
                var json = [String : Any]()
                
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(json)
                } catch let error {
                    print("Decoding ERROR - \(error.localizedDescription)")
                }
                
                var decodingErrorMessage = ""
                
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(T.self, from: data)
                    completion(.success(object))
                    return
                }
                catch let DecodingError.dataCorrupted(context) {
                    decodingErrorMessage = context.debugDescription
                } catch let DecodingError.keyNotFound(key, context) {
                    decodingErrorMessage = "Key \(key) not found: \(context.debugDescription) | codingPath: \(context.codingPath)"
                } catch let DecodingError.typeMismatch(type, context)  {
                    decodingErrorMessage = "Type \(type) mismatch: \(context.debugDescription) | codingPath: \(context.codingPath)"
                } catch {
                    decodingErrorMessage = error.localizedDescription
                }
                
                print(decodingErrorMessage)
                completion(.failure(RequestError(
                                    statusCode: 00,
                                    description: "Error decoding response")))
            case .failure(let error):
                completion(.failure(RequestError(statusCode: 00, description: error.localizedDescription, data: nil)))
            }
        }.resume()
    }
    
    fileprivate func makeRequest(from endpoint: Endpoint, config: RequestConfig) -> URLRequest? {
        guard
            let method = endpoint.method,
            let generatedURL = URL(string: "\(endpoint.url)\(endpoint.space)\(endpoint.service)"),
            var urlComponents = URLComponents(url: generatedURL, resolvingAgainstBaseURL: true)
        else { return nil }
        
        var request: URLRequest?
        
        switch method {
        case .POST:
            guard let url = urlComponents.url else { return nil }
            request = URLRequest(url: url)
            if let b = config.body {
                request?.httpBody = b.toData()
            }
        case .GET:
            var queryItems = [URLQueryItem]()
            
            if let b = config.body, let params = b.dictionary {
                params.forEach { key, value in
                    queryItems.append(URLQueryItem(name: key, value: value as? String))
                }
            }
            
            urlComponents.queryItems = queryItems
            
            guard let url = urlComponents.url else { return nil }
            request = URLRequest(url: url)
        }
        
        request?.httpMethod = method.rawValue
        
        if let headers = config.headers {
            headers.forEach { key, value in
                request?.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
    
    fileprivate func getError(response: URLResponse, data: Data) -> RequestError {
        guard let httpResponse = response as? HTTPURLResponse else {
            return RequestError(statusCode: 00, description: "Error getting description of server error.")
        }
        
        switch httpResponse.statusCode {
        case 400:
            return RequestError(statusCode: 400, description: "Invalid Request", data: data)
        case 401:
            return RequestError(statusCode: 401, description: "Unauthorized", data: data)
        case 404:
            return RequestError(statusCode: 404, description: "Not found", data: data)
        case 500:
            return RequestError(statusCode: 500, description: "Server unavailable", data: data)
        default:
            return RequestError(statusCode: 00, description: "Tuvimos un problema, vuelve a intentarlo más tarde", data: data)
        }
    }
}
