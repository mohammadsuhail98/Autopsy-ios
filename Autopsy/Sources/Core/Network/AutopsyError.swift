//
//  AutopsyError.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 26/8/24.
//

import Foundation

enum AutopsyError: Error {
    case invalidUrl
    case noConnection
    case serverError(String, Int)
    case clientError(String, Int)
    case decodingError(String)
    case error(String, Int)

    var errorMsg: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .noConnection:
            return "No internet connection"
        case .serverError(let string, _),
                .clientError(let string, _),
                .error(let string, _),
                .decodingError(let string):
            return string
        }
    }
    
    var statusCode: Int {
        switch self {
        case .decodingError:
            return 0
        case .invalidUrl:
            return 400
        case .noConnection:
            return -1009
        case .serverError(_, let code):
            return code
        case .clientError(_, let code):
            return code
        case .error(_, let code):
            return code
        }
    }
}
