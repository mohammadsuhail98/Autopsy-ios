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
        CasesManager.getCases { [weak self] cases in
            guard let self else { return }
            self.recentCases = sortedCases(cases: cases)
        } errorBlock: { [weak self] error in
            guard let self else { return }
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
        }
    }
    
    func sortedCases(cases: [CaseEntity]) -> [CaseEntity] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"

        return cases.sorted { case1, case2 in
            if let date1 = dateFormatter.date(from: case1.formattedDate),
               let date2 = dateFormatter.date(from: case2.formattedDate) {
                return date1 > date2
            }
            return false
        }
    }
    
}
