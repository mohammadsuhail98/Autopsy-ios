//
//  CaseDetailsVM.swift
//  Autopsy
//
//  Created by mohammad suhail on 27/8/24.
//

import Foundation
import SwiftUI

class CaseDetailsVM: ObservableObject {

    var caseDetails = CaseEntity()
    
    init() {
        if let caseEntity = FocusedCase.shared.getCase(){ self.caseDetails = caseEntity }
    }
    
    
}
