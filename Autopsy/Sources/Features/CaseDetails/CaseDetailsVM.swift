//
//  CaseDetailsVM.swift
//  Autopsy
//
//  Created by mohammad suhail on 27/8/24.
//

import Foundation
import SwiftUI

class CaseDetailsVM: ObservableObject {

    var caseDetails: CaseEntity {
        get {
            return FocusedCase.shared.getCase() ?? CaseEntity()
        }
        
        set {
            FocusedCase.shared.setCase(caseItem: newValue)
        }
    }
    
    @Published var loading: Bool = false
    @Published var errMsg: String = ""
    @Published var showErrorPopup: Bool = false

    
    func updateCaseDetails(number: String, exName: String, exPhone: String, exEmail: String, exNotes: String){
        
        self.loading = true

        var caseRequest = CreateCaseRequest()
        caseRequest.id = self.caseDetails.id ?? -1
        caseRequest.number = number
        caseRequest.examinerName = exName
        caseRequest.examinerPhone = exPhone
        caseRequest.examinerEmail = exEmail
        caseRequest.examinerNotes = exNotes
        
        CasesManager.updateCase(caseRequest: caseRequest) { newCaseDetails in
            self.loading = false
            self.caseDetails = newCaseDetails
            
        } errorBlock: { error in
            self.loading = false
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
            
        }
        
    }
    
    
}
