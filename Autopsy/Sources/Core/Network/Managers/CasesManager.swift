//
//  NetworkManager.swift
//  Autopsy
//
//  Created by mohammad suhail on 25/8/24.
//

import Foundation
import Alamofire

class CasesManager: APIClient {
    
    class func createCase(caseRequest: CreateCaseRequest, successBlock: ((CaseEntity) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        var parameters: [String : Any] = [CreateCaseRequest.keys.name : caseRequest.name,
                                          CreateCaseRequest.keys.deviceId : caseRequest.deviceId]
        
        if Int(caseRequest.number) ?? -1 != -1 { parameters[CreateCaseRequest.keys.number] = caseRequest.number }
        if notEmpty(caseRequest.examinerName) { parameters[CreateCaseRequest.keys.examinerName] = caseRequest.examinerName }
        if notEmpty(caseRequest.examinerPhone) { parameters[CreateCaseRequest.keys.examinerPhone] = caseRequest.examinerPhone }
        if notEmpty(caseRequest.examinerEmail) { parameters[CreateCaseRequest.keys.examinerEmail] = caseRequest.examinerEmail }
        if notEmpty(caseRequest.examinerNotes) { parameters[CreateCaseRequest.keys.examinerNotes] = caseRequest.examinerNotes }

        if (caseRequest.deviceId.isEmpty) { errorBlock?(AutopsyError.error("Failed to get device ID", 0)) }
        
        createRequest(withRoute: .createCase, parameters: parameters) { (result: Result<CaseEntity, AutopsyError>) in
            switch result {
            case .success(let caseDetails):
                successBlock?(caseDetails)
            case .failure(let error):
                errorBlock?(error)
            }
        }
        
        func notEmpty(_ text: String) -> Bool {
            return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    
    class func getCase(caseId: Int, successBlock: ((CaseEntity) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .getCaseDetails(caseId)) { (result: Result<CaseEntity, AutopsyError>) in
            switch result {
            case .success(let caseDetails):
                print("Case details: \(caseDetails)")
            case .failure(let error):
                errorBlock?(error)
            }
        }
        
    }
    
    class func getCases(successBlock: (([CaseEntity]) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        createRequest(withRoute: .getCasesList) { (result: Result<[CaseEntity], AutopsyError>) in
            switch result {
            case .success(let cases):
                successBlock?(cases)
            case .failure(let error):
                errorBlock?(error)
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
    var number = ""
    var deviceId = ""
    var examinerName = ""
    var examinerPhone = ""
    var examinerEmail = ""
    var examinerNotes = ""
}
