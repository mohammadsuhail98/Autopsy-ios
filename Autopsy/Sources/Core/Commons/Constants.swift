//
//  Constants.swift
//  Autopsy
//
//  Created by mohammad suhail on 25/8/24.
//

import Foundation
import UIKit

struct Constants {
    
    struct NetworkBasePath {
        
        static let cases = "/api/cases"
        static let fileViews = "/api/file_views"
        static let analysisResults = "/api/analysis_results"
        static let geolocation = "/api/geolocation"
        static let fileContent = "/api/datasource"
        
        static func dataSource(for caseId: Int) -> String {
            return "/api/cases/\(caseId)/datasources"
        }
        
        static func dsContent(_ dsId: Int) -> String {
            return "/api/datasource/\(dsId)/content"
        }
        
    }
    
    static var deviceId: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    
}
