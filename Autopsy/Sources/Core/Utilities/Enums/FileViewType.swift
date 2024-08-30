//
//  FileViewType.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 30/8/24.
//

import Foundation

enum FileViewType: Int {
    case images = 1
    case videos = 2
    case audio = 3
    case archives = 4
    case databases = 5
    case documentsHTML = 6
    case documentsOffice = 7
    case documentsPDF = 8
    case documentsPlainText = 9
    case documentsRichText = 10
    case executableEXE = 11
    case executableDLL = 12
    case executableBAT = 13
    case executableCMD = 14
    case executableCOM = 15
    case deletedFilesFileSystem = 16
    case deletedFilesAll = 17
    case fileSizeMB50To200 = 18
    case fileSizeMB200To1GB = 19
    case fileSizeMB1GBPlus = 20
    case filesByExtension = 21
    case filesByMimeType = 22
    
    var title: String {
        switch self {
        case .filesByExtension:
            return "By Extension"
        case .images:
            return "Images"
        case .videos:
            return "Videos"
        case .audio:
            return "Audio"
        case .archives:
            return "Archives"
        case .databases:
            return "Databases"
        case .documentsHTML:
            return "HTML"
        case .documentsOffice:
            return "Office"
        case .documentsPDF:
            return "PDF"
        case .documentsPlainText, .documentsRichText:
            return "Text Files"
        case .executableEXE, .executableDLL, .executableBAT, .executableCMD, .executableCOM:
            return "Executable Files"
        case .filesByMimeType:
            return "By MIME Type"
        case .deletedFilesFileSystem:
            return "File System"
        case .deletedFilesAll:
            return "All"
        case .fileSizeMB50To200:
            return "50 - 200MB"
        case .fileSizeMB200To1GB:
            return "200 - 1GB"
        case .fileSizeMB1GBPlus:
            return "1GB+"
        }
    }
    
    var image: String {
        switch self {
        case .images, .videos, .audio, .archives, .databases, .documentsHTML, .documentsOffice,
                .documentsPDF, .documentsPlainText, .documentsRichText, .executableEXE, .executableDLL,
                .executableBAT, .executableCMD, .executableCOM, .filesByMimeType, .filesByExtension:
            return "files"
        case .deletedFilesFileSystem, .deletedFilesAll:
            return "deleted_files"
        case .fileSizeMB50To200, .fileSizeMB200To1GB, .fileSizeMB1GBPlus:
            return "files_size"
        }
    }
    
}
