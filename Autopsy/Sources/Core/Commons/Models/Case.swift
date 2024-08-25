//
//  Case.swift
//  Autopsy
//
//  Created by mohammad suhail on 2/8/24.
//

import SwiftUI

struct Case: Identifiable, Equatable {
    let id: UUID
    let name: String
    let creationDate: String
    
    init(id: UUID, name: String, creationDate: String) {
        self.id = id
        self.name = name
        self.creationDate = creationDate
    }
}

struct CaseEntity: Codable {
    var id: Int?
    var deviceID, casePath, creationDate, name: String?
    var number, type: Int?
    var examinerName, examinerPhone, examinerEmail, examinerNotes: String?

    enum CodingKeys: String, CodingKey {
        case id
        case deviceID = "deviceId"
        case casePath, creationDate, name, number, type, examinerName, examinerPhone, examinerEmail, examinerNotes
    }
}
