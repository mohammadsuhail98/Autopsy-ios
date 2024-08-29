//
//  Case.swift
//  Autopsy
//
//  Created by mohammad suhail on 2/8/24.
//

import SwiftUI

struct CaseEntity: Codable, Identifiable {
    var id: Int?
    var deviceID, casePath, creationDate, name: String?
    var number, type: Int?
    var examinerName, examinerPhone, examinerEmail, examinerNotes: String?
    var dataSourceList: [DataSource]?
    
    var formattedDate: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = inputFormatter.date(from: creationDate ?? "") {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            return outputFormatter.string(from: date)
        } else {
            return creationDate ?? ""
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case deviceID = "deviceId"
        case casePath, creationDate, name, number, type, examinerName, examinerPhone, examinerEmail, examinerNotes
        case dataSourceList
    }
}
