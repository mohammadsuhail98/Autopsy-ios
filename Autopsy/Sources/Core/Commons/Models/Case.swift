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
