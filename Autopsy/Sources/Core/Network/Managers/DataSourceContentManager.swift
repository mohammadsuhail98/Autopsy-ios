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
    
}
