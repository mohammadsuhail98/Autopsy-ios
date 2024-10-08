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
    
    static func createDataRequest(withRoute router: NetworkRouter, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<Data, AutopsyError>) -> Void){
        
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
        
        createDataRequest(withUrl: url, method: router.method, parameters: parameters, headers: headers ?? router.headers, completion: completion)
    }
    
    static func uploadFile<T: Codable>(withRoute router: NetworkRouter, fileURL: URL? = nil, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, AutopsyError>) -> Void){
        
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
        
        uploadFile(withUrl: url, fileURL: fileURL, method: router.method, parameters: parameters, headers: headers ?? router.headers, completion: completion)
    }
}

private extension APIClient {
    
    static func uploadFile<T: Codable>(withUrl url: URL, fileURL: URL? = nil, method: HTTPMethod = .post, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding = JSONEncoding.default, completion: @escaping (Result<T, AutopsyError>) -> Void){
        
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
        
        AF.upload(multipartFormData: { multipartFormData in

            if let fileURL = fileURL {
                multipartFormData.append(fileURL, withName: "file")
            }
            
            if let parameters = parameters {
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: .utf8) ?? Data(), withName: key)
                }
            }
            
        }, to: url, headers: headers).response { response in
            
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
            
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let output = try decoder.decode(T.self, from: data ?? Data())
                    completion(.success(output))
                } catch let decodingError {
                    print(decodingError)
                    completion(.failure(.decodingError(decodingError.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(.error(error.localizedDescription, code)))
            }
            
        }
    }
    
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
                        print(decodingError)
                        completion(.failure(.decodingError(decodingError.localizedDescription)))
                    }
                case .failure(let error):
                    completion(.failure(.error(error.localizedDescription, code)))
                }
            }
        
    }
    
    static func createDataRequest(withUrl url: URL, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding = JSONEncoding.default, completion: @escaping (Result<Data, AutopsyError>) -> Void){
        
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

                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    if code == 200 {
                        completion(.success(response.data ?? Data()))
                        return
                    }
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
