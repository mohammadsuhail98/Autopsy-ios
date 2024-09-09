//
//  DataSourceContentManager.swift
//  Autopsy
//
//  Created by mohammad suhail on 31/8/24.
//

import Foundation

class DataSourceContentManager: APIClient {
    
    class func getMainContent(dataSourceId: Int, successBlock: ((AutopsyFile) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .getDataSourceContent(dataSourceId)) { (result: Result<AutopsyFile, AutopsyError>) in
            switch result {
            case .success(let content):
                successBlock?(content)
            case .failure(let error):
                errorBlock?(error)
            }
        }
    }
    
    class func getHexFile(caseId: Int, id: Int, successBlock: ((Data) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createDataRequest(withRoute: .getFileHex(caseId, id)) { (result: Result<Data, AutopsyError>) in
            switch result {
            case .success(let content):
                successBlock?(content)
            case .failure(let error):
                errorBlock?(error)
            }
        }
    }
    
    class func getTextFile(caseId: Int, id: Int, successBlock: ((Data) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createDataRequest(withRoute: .getFileText(caseId, id)) { (result: Result<Data, AutopsyError>) in
            switch result {
            case .success(let content):
                successBlock?(content)
            case .failure(let error):
                errorBlock?(error)
            }
        }
    }
    
    class func getFileMetadata(caseId: Int, id: Int, successBlock: ((AutopsyFile) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .getFileContent(caseId, id)) { (result: Result<AutopsyFile, AutopsyError>) in
            switch result {
            case .success(let content):
                successBlock?(content)
            case .failure(let error):
                errorBlock?(error)
            }
        }
    }
    
    class func getApplicationFile(caseId: Int, id: Int, successBlock: ((Data) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createDataRequest(withRoute: .getFileApplication(caseId, id)) { (result: Result<Data, AutopsyError>) in
            switch result {
            case .success(let content):
                successBlock?(content)
            case .failure(let error):
                errorBlock?(error)
            }
        }
    }
    
    class func getFileAnalysisResults(caseId: Int, id: Int, successBlock: ((FileResults) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .getFileAnalysisResults(caseId, id)) { (result: Result<FileResults, AutopsyError>) in
            switch result {
            case .success(let content):
                successBlock?(content)
            case .failure(let error):
                errorBlock?(error)
            }
        }
    }
    
}
