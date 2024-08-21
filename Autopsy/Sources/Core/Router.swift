//
//  MainPath.swift
//  Autopsy
//
//  Created by mohammad suhail on 10/8/24.
//

import Foundation
import Combine

enum Scenario: Equatable {
    case caseCreation
    case caseHome
}

enum CaseCreationPath: Equatable {
    case newCase
    case addDataSourceType
    case addDataSource
    case ingestModules
}

enum CaseHomePath: Equatable {
    case caseDetails
}

class Router: ObservableObject {
    @Published var selectedScenario: Scenario = .caseCreation
    @Published var caseCreationPath: [CaseCreationPath] = []
    @Published var caseHomePath: [CaseHomePath] = []
    
    
}
