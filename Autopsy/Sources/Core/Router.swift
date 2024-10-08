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
    case mainScreen
    case newCase
    case addDataSourceType
    case addDataSource
    case ingestModules
}

enum CaseHomePath: Equatable, Hashable {
    case caseDetails
    case dataSourceList
    case addDataSourceType
    case addDataSource
    case ingestModules
    case dataSourceContent(DataSource)
    case newCase
    case geolocation
    case analysisResultsFiles(AnalysisResultType)
    case filesByViewType(FileViewType)
    case filesByExtension
    case mimeTypes
    case contentTabBar(AutopsyFile, AutopsyFiles, String)
}

class Router: ObservableObject {
    @Published var selectedScenario: Scenario = .caseCreation
    @Published var caseCreationPath: [CaseCreationPath] = []
    @Published var caseHomePath: [CaseHomePath] = []
    
    
}
