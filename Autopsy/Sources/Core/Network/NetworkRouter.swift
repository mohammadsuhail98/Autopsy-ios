//
//  NetworkRouter.swift
//  Autopsy
//
//  Created by mohammad suhail on 25/8/24.
//

import Foundation
import Alamofire

enum NetworkRouter {
    
    // CASE
    case createCase
    case deleteCase(Int)
    case updateCase(Int)
    case getCaseDetails(Int)
    case getCasesList
    
    // DATA SOURCE
    case getDataSourceList(Int)
    case addDataSource(Int)
    case getDataSource(Int, Int)
    case deleteDataSource(Int, Int)
    
    // DATA SOURCE CONTENT
    case getDataSourceContent(Int)
    case getFileContent(Int)
    case getFileText(Int)
    case getFileHex(Int)
    case getFileApplication(Int)
    case getFileAnalysisResults(Int)
    
    // FILE VIEWS
    case getFilesByViewType(Int, Int)
    case getCurrentMimeTypes(Int)
    case getFilesByMimeType(Int, Int)
    case getDeletedFiles(Int, Int)
    case getFilesBySize(Int, Int)
    
    // ANALYSIS RESULTS
    case getCurrentAnalysisResultTypes(Int)
    case getFilesByType(Int, Int)
    
    // GEOLOCATION
    case getAllGeolocations(Int)
    case getGeolocationsByDataSource(Int, [Int])
    
}

extension NetworkRouter {
    
    typealias basePath = Constants.NetworkBasePath

    var scheme: String {
        return "http"
    }
    
    var host: String {
        return "192.168.0.147"
    }
    
    var port: Int {
        return 8081
    }
    
    var path: String {
        switch self {
        case .createCase:
            return basePath.cases
            
        case .deleteCase(let caseId),
                .updateCase(let caseId),
                .getCaseDetails(let caseId):
            return basePath.cases + "/\(caseId)"
            
        case .getCasesList:
            return basePath.cases
            
        case .getDataSourceList(let caseId),
                .addDataSource(let caseId):
            return basePath.dataSource(for: caseId)
            
        case .getDataSource(let caseId, let dataSourceId),
                .deleteDataSource(let caseId, let dataSourceId):
            return "\(basePath.dataSource(for: caseId))/\(dataSourceId)"

        case .getDataSourceContent(let dataSourceId):
            return basePath.dsContent(dataSourceId)
            
        case .getFileContent(let dataSourceId):
            return basePath.dsContent(dataSourceId) + "/file"
            
        case .getFileText(let dataSourceId):
            return basePath.dsContent(dataSourceId) + "/file_strings"

        case .getFileHex(let dataSourceId):
            return basePath.dsContent(dataSourceId) + "/file_hex"

        case .getFileApplication(let dataSourceId):
            return basePath.dsContent(dataSourceId) + "/file_application"

        case .getFileAnalysisResults(let dataSourceId):
            return basePath.dsContent(dataSourceId) + "/analysis_results"

        case .getFilesByViewType:
            return basePath.fileViews + "/files_by_view_type"
            
        case .getCurrentMimeTypes:
            return basePath.fileViews + "/mime_types"
            
        case .getFilesByMimeType:
            return basePath.fileViews + "/files_by_mime_type"
            
        case .getDeletedFiles:
            return basePath.fileViews + "/deleted_files"
            
        case .getFilesBySize:
            return basePath.fileViews + "/files_by_size"
            
        case .getCurrentAnalysisResultTypes:
            return basePath.analysisResults + "/current_types"
            
        case .getFilesByType:
            return basePath.analysisResults + "/files"
            
        case .getAllGeolocations:
            return basePath.geolocation
            
        case .getGeolocationsByDataSource:
            return basePath.geolocation + "/data_sources"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .createCase, .addDataSource:
            return .post
            
        case .deleteCase, .deleteDataSource:
            return .delete
            
        case .updateCase:
            return .put
            
        case .getCaseDetails, .getCasesList, .getDataSourceList, .getDataSource, .getDataSourceContent,
                .getFileContent, .getFileText, .getFileHex, .getFileApplication, .getFileAnalysisResults,
                .getFilesByViewType, .getCurrentMimeTypes, .getFilesByMimeType, .getDeletedFiles,
                .getFilesBySize, .getCurrentAnalysisResultTypes, .getFilesByType, .getAllGeolocations,
                .getGeolocationsByDataSource:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return ["deviceId" : Constants.deviceId]
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .createCase, .deleteCase, .updateCase, .getCaseDetails, .getCasesList, .getDataSourceList,
                .addDataSource, .getDataSource, .deleteDataSource, .getDataSourceContent:
            return nil

        case .getFileHex(let fileId), .getFileAnalysisResults(let fileId),
                .getFileApplication(let fileId), .getFileText(let fileId),
                .getFileContent(let fileId):
            return [URLQueryItem(name: "fileId", value: "\(fileId)")]

        case .getFilesByViewType(let caseId, let type), .getDeletedFiles(let caseId, let type),
                .getFilesBySize(let caseId, let type), .getFilesByType(let caseId, let type):
            return [URLQueryItem(name: "caseId", value: "\(caseId)"),
                    URLQueryItem(name: "type", value: "\(type)")]
            
        case .getCurrentMimeTypes(let caseId), .getAllGeolocations(let caseId),
                .getCurrentAnalysisResultTypes(let caseId):
            return [URLQueryItem(name: "caseId", value: "\(caseId)")]

        case .getFilesByMimeType(let caseId, let mimeType):
            return [URLQueryItem(name: "caseId", value: "\(caseId)"),
                    URLQueryItem(name: "mimeType", value: "\(mimeType)")]

        case .getGeolocationsByDataSource(let caseId, let dataSourcesIds):
            return [URLQueryItem(name: "caseId", value: "\(caseId)"),
                    URLQueryItem(name: "dataSourceIds", value: "\(dataSourcesIds)")]
        }
    }
    
}
