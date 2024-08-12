//
//  MainVM.swift
//  Autopsy
//
//  Created by mohammad suhail on 9/8/24.
//

import Foundation
import Combine

class MainVM: ObservableObject {
    @Published var recentCases: [Case]

    init() {
        self.recentCases = [
            Case(id: UUID(), name: "Case 1", creationDate: "January 1, 2023"),
            Case(id: UUID(), name: "Case 2", creationDate: "February 2, 2023"),
            Case(id: UUID(), name: "Case 3", creationDate: "March 3, 2023")
        ]
    }

    func addCase(_ newCase: Case) {
        recentCases.append(newCase)
    }

    func removeCase(_ caseToRemove: Case) {
        recentCases.removeAll { $0 == caseToRemove }
    }
}
