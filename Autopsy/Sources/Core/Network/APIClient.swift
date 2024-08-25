//
//  APIClient.swift
//  Autopsy
//
//  Created by mohammad suhail on 25/8/24.
//

import Foundation
import Alamofire

class APIClient {
    static func createRequest<T: Codable>(withRoute router: NetworkRouter, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void){
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.port = router.port
        components.path = router.path
        components.queryItems = router.queryItems

        guard let url = components.url else {
            completion(.failure(NSError(domain: "APIClient", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        createRequest(withUrl: url, method: router.method, parameters: parameters, headers: headers ?? router.headers, completion: completion)
    }
}

private extension APIClient {
    static func createRequest<T: Codable>(withUrl url: URL, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding = JSONEncoding.default, completion: @escaping (Result<T, Error>) -> Void){
        
        print("\n---------------- API: START ----------------")
        print("API: URL - \(url.absoluteString)")
        print("API: METHOD - \(method)")
        if let parameters = parameters{
            print("API: BODY - \(parameters)")
        }
        if let headers = headers{
            print("API: HEADERS - \(headers)")
        }
        print("---------------- API: END----------------\n")
        
        if !Connectivity.isConnectedToInternet {
            completion(.failure(NSError(domain: "APIClient", code: -1009, userInfo: [NSLocalizedDescriptionKey: "No internet connection"])))
            return
        }
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let output = try decoder.decode(T.self, from: data)
                        completion(.success(output))
                    } catch let decodingError {
                        completion(.failure(decodingError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
    }
}

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager(host: "https://google.com")!.isReachable
    }
}
