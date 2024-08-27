//
//  MainVM.swift
//  Autopsy
//
//  Created by mohammad suhail on 9/8/24.
//

import Foundation
import SwiftUI

class MainVM: ObservableObject {
    
    @Published var recentCases: [CaseEntity] = []
    @Published var errMsg: String = ""
    @Published var showErrorPopup: Bool = false
    
    func getCases(){
        CasesManager.getCases { cases in
            self.recentCases = cases
        } errorBlock: { error in
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
        }
    }
    
}
