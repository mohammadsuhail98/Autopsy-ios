//
//  FocusedCase.swift
//  Autopsy
//
//  Created by mohammad suhail on 27/8/24.
//

import Foundation

class FocusedCase {
    static let shared = FocusedCase()
    
    private init() {}
    
    private var caseItem: CaseEntity?
    
    func setCase(caseItem: CaseEntity) {
        self.caseItem = caseItem
    }
    
    func getCase() -> CaseEntity? {
        self.caseItem
    }
}
