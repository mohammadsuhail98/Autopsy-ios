//
//  MimeType.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/8/24.
//

import Foundation

struct MIMEType: Codable, Identifiable {
    var id: Int?
    var name: String?
    var supported: Bool?
}
