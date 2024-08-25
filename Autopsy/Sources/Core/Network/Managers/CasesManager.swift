//
//  NetworkManager.swift
//  Autopsy
//
//  Created by mohammad suhail on 25/8/24.
//

import Foundation
import Alamofire

class CasesManager: APIClient {
    
    class func getCase(caseId: Int, successBlock: ((CaseEntity) -> Void)? = nil, errorBlock: ((NSError) -> Void)? = nil) {
        
        createRequest(withRoute: .getCaseDetails(caseId)) { (result: Result<CaseEntity, Error>) in
            switch result {
            case .success(let caseDetails):
                print("Case details: \(caseDetails)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
            
    }
    
}
