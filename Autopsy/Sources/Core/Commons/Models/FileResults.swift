//
//  FileResults.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 2/9/24.
//

import Foundation

struct FileResults: Codable, Identifiable {
    var id: Int?
    var itemName, aggregateScore: String?
    var analysisResults: [FileAnalysisResults]?
}

// MARK: - FileAnalysisResults
struct FileAnalysisResults: Codable, Identifiable {
    var id: Int?
    var score, type, configuration, conclusion: String?
    var dateCreated, deviceMake, deviceModel, comment: String?
    var justification, latitude, longitude, altitude: String?
}
