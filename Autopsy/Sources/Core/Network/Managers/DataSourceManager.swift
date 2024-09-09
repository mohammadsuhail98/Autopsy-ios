//
//  DataSourceManager.swift
//  Autopsy
//
//  Created by mohammad suhail on 27/8/24.
//

import Foundation

class DataSourceManager: APIClient {
    
    class func getDataSources(caseId: Int, successBlock: (([DataSource]) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .getDataSourceList(caseId)) { (result: Result<[DataSource], AutopsyError>) in
            switch result {
            case .success(let dataSourceList):
                successBlock?(dataSourceList)
            case .failure(let error):
                errorBlock?(error)
            }
        }
        
    }
    
    class func deleteDataSource(caseId: Int, dataSourceId: Int, successBlock: ((DeleteResponse) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .deleteDataSource(caseId, dataSourceId)) { (result: Result<DeleteResponse, AutopsyError>) in
            switch result {
            case .success(let response):
                successBlock?(response)
            case .failure(let error):
                errorBlock?(error)
            }
        }
        
    }
    
    class func addDataSource(caseId: Int, fileUrl: URL, addDataSourceRequest: AddDataSourceRequest, successBlock: ((DataSource) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        let parameters: [String: Any] = [AddDataSourceRequest.keys.timeZone: addDataSourceRequest.timeZone,
                                         AddDataSourceRequest.keys.sectorSize: addDataSourceRequest.sectorSize,
                                         AddDataSourceRequest.keys.ignoreOrphanFiles: addDataSourceRequest.ignoreOrphanFiles,
                                         AddDataSourceRequest.keys.addUnAllocSpace: addDataSourceRequest.addUnAllocSpace,
                                         AddDataSourceRequest.keys.exifParser: addDataSourceRequest.exifParser,
                                         AddDataSourceRequest.keys.md5: addDataSourceRequest.md5,
                                         AddDataSourceRequest.keys.sha1: addDataSourceRequest.sha1,
                                         AddDataSourceRequest.keys.sha256: addDataSourceRequest.sha256]
        
        uploadFile(withRoute: .addDataSource(caseId), fileURL: fileUrl, parameters: parameters) { (result: Result<DataSource, AutopsyError>) in
            switch result {
            case .success(let dataSource):
                successBlock?(dataSource)
            case .failure(let error):
                errorBlock?(error)
            }
        }
        
    }
    
}

struct AddDataSourceRequest {
    struct keys {
        static let timeZone = "timeZone"
        static let sectorSize = "sectorSize"
        static let ignoreOrphanFiles = "ignoreOrphanFiles"
        static let addUnAllocSpace = "addUnAllocSpace"
        static let exifParser = "exifParser"
        static let md5 = "md5"
        static let sha1 = "sha1"
        static let sha256 = "sha256"
    }
    
    var fileUrl: URL
    var timeZone = ""
    var sectorSize = ""
    var ignoreOrphanFiles = false
    var addUnAllocSpace = false
    var exifParser = false
    var md5 = ""
    var sha1 = ""
    var sha256 = ""
}
