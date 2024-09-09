//
//  CaseVM.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 31/8/24.
//

import Foundation
import Combine

class CaseVM: ObservableObject {
    
    @Published var errMsg: String = ""
    @Published var showErrorPopup: Bool = false
    @Published var loading: Bool = false
    
    func deleteCase(successBlock: (() -> Void)? = nil){
        loading = true
        CasesManager.deleteCase(caseId: FocusedCase.shared.getCase()?.id ?? 0) { [weak self] response in
            guard let self else { return }
            self.loading = false
            successBlock?()
        } errorBlock: { [weak self] error in
            guard let self else { return }
            self.loading = false
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
        }
    }
    
}
