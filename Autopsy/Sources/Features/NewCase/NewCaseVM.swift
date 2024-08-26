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

    @Published var loading: Bool = false
    @Published var caseRequest = CreateCaseRequest()

    func sendData(successBlock: ((CaseEntity) -> Void)? = nil, errorBlock: ((String) -> Void)? = nil){
        guard caseNameValid() else {
            errorBlock?("case Name is not valid")
            return
        }
        self.loading = true
        
        caseRequest.deviceId = Constants.deviceId
        
        CasesManager.createCase(caseRequest: caseRequest) { caseDetails in
            self.loading = false
            successBlock?(caseDetails)
        } errorBlock: { error in
            self.loading = false
            errorBlock?(error.errorMsg)
            print(error)
        }
        
    }
    
    func caseNameValid() -> Bool {
        return !caseRequest.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
