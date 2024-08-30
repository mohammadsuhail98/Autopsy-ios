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

    
}
