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
    
}

struct CreateDataSourceRequest {
    struct keys {
        static let name = "name"
        static let number = "number"
        static let deviceId = "deviceId"
        static let examinerName = "examinerName"
        static let examinerPhone = "examinerPhone"
        static let examinerEmail = "examinerEmail"
        static let examinerNotes = "examinerNotes"
    }
    
    var name = ""
    var number = ""
    var deviceId = ""
    var examinerName = ""
    var examinerPhone = ""
    var examinerEmail = ""
    var examinerNotes = ""
}
