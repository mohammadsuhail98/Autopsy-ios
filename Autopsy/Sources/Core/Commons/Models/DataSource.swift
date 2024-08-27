//
//  DataSource.swift
//  Autopsy
//
//  Created by mohammad suhail on 27/8/24.
//

import Foundation

struct DataSource: Codable, Identifiable {
    var id: Int?
    var dataSourceDeviceID: String?
    var dataSourceID: Int?
    var name, creationDate, fileType: String?
    var ignoreOrphanFiles, addUnAllocSpace: Bool?
    var timeZone: String?
    var sectorSize: Int?
    var md5Hash, sha1Hash, sha256Hash: String?
    var size: Int?
    var errors: String?
    var exifParser: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case dataSourceDeviceID = "dataSourceDeviceId"
        case dataSourceID = "dataSourceId"
        case name, creationDate, fileType, ignoreOrphanFiles, addUnAllocSpace, timeZone, sectorSize, md5Hash, sha1Hash, sha256Hash, size, errors, exifParser
    }
}
