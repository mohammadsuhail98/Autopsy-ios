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
    
    init() {
        
    }
    
    func getCases(){
        CasesManager.getCases { [weak self] cases in
            guard let self else { return }
            self.recentCases = cases.reversed()
        } errorBlock: { [weak self] error in
            guard let self else { return }
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
        }
    }
    
}
