//
//  VolumeInfo.swift
//  Autopsy
//
//  Created by mohammad suhail on 31/8/24.
//

import Foundation

struct VolumeInfo: Codable, Identifiable, Hashable {
    var id: Int?
    var startingSector, lengthInSectors: Int?
    var description: String?
    var flags: String?
}
