//
//  APIClient.swift
//  Autopsy
//
//  Created by mohammad suhail on 25/8/24.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClient {
    static func createRequest<T: Codable>(withRoute router: NetworkRouter, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, AutopsyError>) -> Void){
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.port = router.port
        components.path = router.path
        components.queryItems = router.queryItems

        guard let url = components.url else {
            completion(.failure(.invalidUrl))
            return
        }
        
        createRequest(withUrl: url, method: router.method, parameters: parameters, headers: headers ?? router.headers, completion: completion)
    }
}

private extension APIClient {
    static func createRequest<T: Codable>(withUrl url: URL, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding = JSONEncoding.default, completion: @escaping (Result<T, AutopsyError>) -> Void){
        
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
            completion(.failure(.noConnection))
            return
        }
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .responseData { response in
                let code = response.response?.statusCode ?? 0
                
                if code != 200 {
                    do {
                        let json = try SwiftyJSON.JSON(data: response.data ?? Data())
                        if code >= 500 && code <= 599 {
                            let errorStr = json.dictionaryValue["error"]?.string ?? ""
                            completion(.failure(.serverError(errorStr, code)))
                        } else {
                            let errorStr = json.dictionaryValue["message"]?.string ?? ""
                            completion(.failure(.clientError(errorStr, code)))
                        }
                        return
                    } catch let error {
                        completion(.failure(.error(error.localizedDescription, code)))
                        return
                    }
                }
                
                if method == .delete {
                    if code == 200 {
                        let response = DeleteResponse(statusCode: code)
                        completion(.success(response as! T))
                        return
                    }
                }
                
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let output = try decoder.decode(T.self, from: data)
                        completion(.success(output))
                    } catch let decodingError {
                        completion(.failure(.decodingError(decodingError.localizedDescription)))
                    }
                case .failure(let error):
                    completion(.failure(.error(error.localizedDescription, code)))
                }
            }
        
    }
    
}

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager(host: "https://google.com")!.isReachable
    }
}
