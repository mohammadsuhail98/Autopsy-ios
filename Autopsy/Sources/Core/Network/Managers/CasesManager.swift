//
//  NetworkManager.swift
//  Autopsy
//
//  Created by mohammad suhail on 25/8/24.
//

import Foundation
import Alamofire

class CasesManager: APIClient {
    
    class func createCase(caseRequest: CreateCaseRequest, successBlock: ((CaseEntity) -> Void)? = nil, errorBlock: ((String) -> Void)? = nil) {
        
        var parameters: [String : Any] = [CreateCaseRequest.keys.name : caseRequest.name,
                                          CreateCaseRequest.keys.deviceId : caseRequest.deviceId]
        
        if caseRequest.number != -1 { parameters[CreateCaseRequest.keys.number] = caseRequest.number }
        if let examinerName = caseRequest.examinerName { parameters[CreateCaseRequest.keys.examinerName] = examinerName }
        if let examinerPhone = caseRequest.examinerPhone { parameters[CreateCaseRequest.keys.examinerPhone] = examinerPhone }
        if let examinerEmail = caseRequest.examinerEmail { parameters[CreateCaseRequest.keys.examinerEmail] = examinerEmail }
        if let examinerNotes = caseRequest.examinerNotes { parameters[CreateCaseRequest.keys.examinerNotes] = examinerNotes }

        if (caseRequest.deviceId.isEmpty) { errorBlock?("Failed to get device ID") }
        
        createRequest(withRoute: .createCase, parameters: parameters) { (result: Result<CaseEntity, Error>) in
            switch result {
            case .success(let caseDetails):
                successBlock?(caseDetails)
            case .failure(let error):
                errorBlock?(error.localizedDescription)
            }
        }
        
    }
    
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

struct CreateCaseRequest {
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
    var number = -1
    var deviceId = ""
    var examinerName: String?
    var examinerPhone: String?
    var examinerEmail: String?
    var examinerNotes: String?
}
