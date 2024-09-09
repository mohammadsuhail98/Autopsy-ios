//
//  Utils.swift
//  Autopsy
//
//  Created by mohammad suhail on 31/8/24.
//

import Foundation

class Utils {
    
    static func getFileInfo(for item: AutopsyFile) -> AutopsyFile {
        var file = AutopsyFile()
        file.name = item.name
        file.id = item.id
        file.path = item.path
        file.type = item.type
        file.uid = item.uid
        file.gid = item.gid
        file.size = item.size
        file.flagsDir = item.flagsDir
        file.flagsMeta = item.flagsMeta
        file.known = item.known
        file.md5Hash = item.md5Hash
        file.sha1Hash = item.sha1Hash
        file.sha256Hash = item.sha256Hash
        file.autopsyFileExtension = item.autopsyFileExtension
        file.fileType = item.fileType
        file.crTime = item.crTime
        file.fileSystemType = item.fileSystemType
        file.metaDataText = item.metaDataText
        file.mimeType = item.mimeType
        file.hasAnalysisResults = item.hasAnalysisResults
        file.volumeInfo = item.volumeInfo
        file.virtual = item.virtual
        file.file = item.file
        file.root = item.root
        file.volume = item.volume
        file.mtime = item.mtime
        file.ctime = item.ctime
        file.atime = item.atime
        file.deleted = item.deleted
        file.dir = item.dir
        file.dataSourceId = item.dataSourceId
        return file
    }
    
    static func sortFilesByChildrenFirst(files: AutopsyFiles) -> AutopsyFiles {
        return files.sorted { file1, file2 in
            let file1HasChildren = (file1.children?.isEmpty == false)
            let file2HasChildren = (file2.children?.isEmpty == false)
            return file1HasChildren && !file2HasChildren
        }
    }
    
    static func getImageName(isEmpty: Bool?, autopsyFileExtension: String?, deleted: Bool?, virtual: Bool?) -> String {
        if let isEmpty = isEmpty {
            if !isEmpty {
                
                if deleted ?? false {
                    return "deleted_folder"
                } else if virtual ?? false {
                    return "virtual_folder"
                } else {
                    return "folder"
                }
                
            } else {
                guard let autopsyFileExtension else {
                    if deleted ?? false {
                        return "deleted_file"
                    } else if virtual ?? false {
                        return "virtual_file"
                    } else {
                        return "file"
                    }
                }
                if FileExtensions.imageExtensions.contains("." + autopsyFileExtension) {
                    if deleted ?? false {
                        return "deleted_image"
                    } else if virtual ?? false {
                        return "virtual_image"
                    } else {
                        return "image"
                    }
                } else if FileExtensions.videoExtensions.contains("." + autopsyFileExtension) {
                    if deleted ?? false {
                        return "deleted_video"
                    } else if virtual ?? false {
                        return "virtual_video"
                    } else {
                        return "video"
                    }
                } else if FileExtensions.pdfExtensions.contains("." + autopsyFileExtension) {
                    if deleted ?? false {
                        return "deleted_pdf"
                    } else if virtual ?? false {
                        return "virtual_pdf"
                    } else {
                        return "pdf"
                    }
                } else if FileExtensions.textExtensions.contains("." + autopsyFileExtension) {
                    if deleted ?? false {
                        return "deleted_text"
                    } else if virtual ?? false {
                        return "virtual_text"
                    } else {
                        return "text"
                    }
                } else if FileExtensions.documentExtensions.contains("." + autopsyFileExtension) {
                    if deleted ?? false {
                        return "deleted_document"
                    } else if virtual ?? false {
                        return "virtual_document"
                    } else {
                        return "document"
                    }
                } else if FileExtensions.archiveExtensions.contains("." + autopsyFileExtension) {
                    if deleted ?? false {
                        return "deleted_archive"
                    } else if virtual ?? false {
                        return "virtual_archive"
                    } else {
                        return "archive"
                    }
                } else {
                    if deleted ?? false {
                        return "deleted_file"
                    } else if virtual ?? false {
                        return "virtual_file"
                    } else {
                        return "file"
                    }
                }
            }
        }
        if deleted ?? false {
            return "deleted_file"
        } else if virtual ?? false {
            return "virtual_file"
        } else {
            return "file"
        }
    }

    
}
