//
//  DSContentVM.swift
//  Autopsy
//
//  Created by mohammad suhail on 31/8/24.
//

import Foundation
import Combine

class DSContentVM: ObservableObject {
    
    @Published var items: AutopsyFiles = []
    @Published var errMsg: String = ""
    @Published var showErrorPopup: Bool = false
    @Published var loading: Bool = false
    
    func getFiles(for dsId: Int?){
        guard let dsId else { return }
        loading = true
        
        DataSourceContentManager.getMainContent(dataSourceId: dsId) { [weak self] content in
            guard let self else { return }
            self.loading = false
            self.items = content.children ?? []
        } errorBlock: { [weak self] error in
            guard let self else { return }
            self.loading = false
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
        }
    }
    
    func getFileInfo(for item: AutopsyFile) -> AutopsyFile {
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
        return file
    }
    
}
