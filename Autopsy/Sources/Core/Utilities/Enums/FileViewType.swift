//
//  FileViewType.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 30/8/24.
//

import Foundation

enum FileViewType: Hashable {
    case images
    case videos
    case audio
    case archives
    case databases
    case documentsHTML
    case documentsOffice
    case documentsPDF
    case documentsPlainText
    case documentsRichText
    case executableEXE
    case executableDLL
    case executableBAT
    case executableCMD
    case executableCOM
    case deletedFilesFileSystem
    case deletedFilesAll
    case fileSizeMB50To200
    case fileSizeMB200To1GB
    case fileSizeMB1GBPlus
    case filesByExtension
    case filesByMimeType(String)
    
    var id: Int {
        switch self {
        case .images: return 1
        case .videos: return 2
        case .audio: return 3
        case .archives: return 4
        case .databases: return 5
        case .documentsHTML: return 6
        case .documentsOffice: return 7
        case .documentsPDF: return 8
        case .documentsPlainText: return 9
        case .documentsRichText: return 10
        case .executableEXE: return 11
        case .executableDLL: return 12
        case .executableBAT: return 13
        case .executableCMD: return 14
        case .executableCOM: return 15
        case .deletedFilesFileSystem: return 16
        case .deletedFilesAll: return 17
        case .fileSizeMB50To200: return 18
        case .fileSizeMB200To1GB: return 19
        case .fileSizeMB1GBPlus: return 20
        case .filesByExtension: return 21
        case .filesByMimeType: return 22
        }
    }
    
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
