//
//  MimeType.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/8/24.
//

import Foundation

struct MIMEType: Codable, Identifiable, Hashable {
    var id: Int?
    var name: String?
    var supported: Bool?
    var mimeSubtypes: [MIMESubtype]?
}

struct MIMESubtype: Codable, Identifiable, Hashable {
    var id: Int?
    var name, fullName: String?
    var count: Int?
}

typealias MIMETypes = [MIMEType]
