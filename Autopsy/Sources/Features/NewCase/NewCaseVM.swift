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
    @Published var errMsg = ""
    @Published var showErrorPopup = false
    
    func sendData(successBlock: ((CaseEntity) -> Void)? = nil, errorBlock: ((String) -> Void)? = nil){
        guard caseNameValid() else {
            errMsg = "Case Name is not valid"
            self.showErrorPopup = true
            errorBlock?(errMsg)
            return
        }
        self.loading = true
        
        caseRequest.deviceId = Constants.deviceId
        
        CasesManager.createCase(caseRequest: caseRequest) { caseDetails in
            self.loading = false
            successBlock?(caseDetails)
        } errorBlock: { error in
            self.loading = false
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
            errorBlock?(error.errorMsg)
        }
        
    }
    
    func updateRoutes(_ tag: Int, router: Router){
        let isCaseCreation = router.selectedScenario == .caseCreation

        if tag == 0 {
            if isCaseCreation {
                router.caseCreationPath.append(.addDataSourceType)
            } else {
                router.caseHomePath.append(.dataSourceList)
            }
        } else {
            if isCaseCreation {
                router.selectedScenario = .caseHome
            } else {
                router.caseHomePath.append(.dataSourceList)
            }
        }
    }
    
    func caseNameValid() -> Bool {
        return !caseRequest.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
