//
//  NewCaseVM.swift
//  Autopsy
//
//  Created by mohammad suhail on 25/8/24.
//

import Foundation
import Combine
import UIKit

class NewCaseVM: ObservableObject {
    
    @Published var caseName: String = ""
    @Published var caseNumber: String = ""
    @Published var examinerName: String = ""
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var notes: String = ""
    
    func sendData(){
        guard caseNameValid() else {
            print("case Name is not valid")
            return
        }
        
        var caseRequest = CreateCaseRequest()
        caseRequest.name = caseName
        caseRequest.number = Int(caseNumber) ?? -1
        caseRequest.examinerName = examinerName
        caseRequest.examinerEmail = email
        caseRequest.examinerPhone = phone
        caseRequest.examinerNotes = notes
        caseRequest.deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
        
        CasesManager.createCase(caseRequest: caseRequest) { caseDetails in
            print("case created: \(caseDetails)")
        } errorBlock: { error in
            print(error)
        }
        
    }
    
    func caseNameValid() -> Bool {
        return !caseName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
