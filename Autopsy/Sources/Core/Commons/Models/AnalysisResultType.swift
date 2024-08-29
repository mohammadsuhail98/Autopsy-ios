//
//  Analysis.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/8/24.
//

import Foundation

struct AnalysisResultType: Codable, Identifiable {
    var id: Int?
    var name: String?
    
    var image: String {
        if id == 16 {
            return "exif_camera"
        } else if id == 56 {
            return "user_suspected"
        }
        return ""
    }
    
}

typealias AnalysisResultTypes = [AnalysisResultType]
