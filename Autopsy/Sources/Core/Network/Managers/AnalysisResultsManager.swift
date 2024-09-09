//
//  AnalysisResultsManager.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 29/8/24.
//

import Foundation

class AnalysisResultsManager: APIClient {
    
    class func getCurrentTypes(caseId: Int, successBlock: ((AnalysisResultTypes) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .getCurrentAnalysisResultTypes(caseId)) { (result: Result<AnalysisResultTypes, AutopsyError>) in
            switch result {
            case .success(let types):
                successBlock?(types)
            case .failure(let error):
                errorBlock?(error)
            }
        }
        
    }
    
    class func getFilesByType(caseId: Int, type: Int, successBlock: ((AutopsyFiles) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .getAnalysisResultsFilesByType(caseId, type)) { (result: Result<AutopsyFiles, AutopsyError>) in
            switch result {
            case .success(let files):
                successBlock?(files)
            case .failure(let error):
                errorBlock?(error)
            }
        }
        
    }

    
}
