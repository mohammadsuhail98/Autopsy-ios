//
//  AnalysisResultsVM.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/8/24.
//

import Foundation
import SwiftUI

class AnalysisResultsVM: ObservableObject {
    
    @Published var types: AnalysisResultTypes = []
    @Published var errMsg: String = ""
    @Published var showErrorPopup: Bool = false
    @Published var loading: Bool = false

    func getTypes(){
        loading = true

        AnalysisResultsManager.getCurrentTypes(caseId: FocusedCase.shared.getCase()?.id ?? -1) { [weak self] types in
            guard let self else { return }
            self.loading = false
            self.types = types
        } errorBlock: { [weak self] error in
            guard let self else { return }
            self.loading = false
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
        }
    }
    
}
