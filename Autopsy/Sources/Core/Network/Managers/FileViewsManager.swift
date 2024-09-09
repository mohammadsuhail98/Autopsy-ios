//
//  FileViewsManager.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 30/8/24.
//

import Foundation

class FileViewsManager: APIClient {
    

    class func getDeletedFiles(caseId: Int, type: Int, successBlock: ((AutopsyFiles) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .getDeletedFiles(caseId, type)) { (result: Result<AutopsyFiles, AutopsyError>) in
            switch result {
            case .success(let files):
                successBlock?(files)
            case .failure(let error):
                errorBlock?(error)
            }
        }
        
    }
    
    class func getFilesBySize(caseId: Int, type: Int, successBlock: ((AutopsyFiles) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .getFilesBySize(caseId, type)) { (result: Result<AutopsyFiles, AutopsyError>) in
            switch result {
            case .success(let files):
                successBlock?(files)
            case .failure(let error):
                errorBlock?(error)
            }
        }
        
    }
    
    class func getFilesByViewType(caseId: Int, type: Int, successBlock: ((AutopsyFiles) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .getFilesByViewType(caseId, type)) { (result: Result<AutopsyFiles, AutopsyError>) in
            switch result {
            case .success(let files):
                successBlock?(files)
            case .failure(let error):
                errorBlock?(error)
            }
        }
        
    }
    
    class func getCurrentMimeTypes(caseId: Int, successBlock: ((MIMETypes) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .getCurrentMimeTypes(caseId)) { (result: Result<MIMETypes, AutopsyError>) in
            switch result {
            case .success(let mimeTypes):
                successBlock?(mimeTypes)
            case .failure(let error):
                errorBlock?(error)
            }
        }
        
    }
    
    class func getFilesByMimeType(caseId: Int, mimeType: String, successBlock: ((AutopsyFiles) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .getFilesByMimeType(caseId, mimeType)) { (result: Result<AutopsyFiles, AutopsyError>) in
            switch result {
            case .success(let files):
                successBlock?(files)
            case .failure(let error):
                errorBlock?(error)
            }
        }
        
    }

    
}
