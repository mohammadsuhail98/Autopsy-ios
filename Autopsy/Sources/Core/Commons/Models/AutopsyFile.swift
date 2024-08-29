//
//  AutopsyFile.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/8/24.
//

import Foundation

struct AutopsyFile: Codable {
    var name, path: String?
    var type: String?
    var id, uid, gid, size: Int?
    var flagsDir, flagsMeta: String?
    var known: String?
    var md5Hash, sha1Hash, sha256Hash: String?
    var autopsyFileExtension: String?
    var fileType: Int?
    var children: [AutopsyFile]?
    var crTime: String?
    var fileSystemType: String?
    var metaDataText: [String]?
    var mimeType: MIMEType?
    var hasAnalysisResults: Bool?
    var virtual, file, root, dir: Bool?
    var deleted, volume: Bool?
    var mtime: String?
    var ctime: String?
    var atime: String?

    enum CodingKeys: String, CodingKey {
        case name, path, type, id, uid, gid, size, flagsDir, flagsMeta, known, md5Hash, sha1Hash, sha256Hash
        case autopsyFileExtension = "extension"
        case fileType, children, crTime, fileSystemType, metaDataText, mimeType, hasAnalysisResults, virtual, file, root, dir, deleted, volume, mtime, ctime, atime
    }
}
