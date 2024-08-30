//
//  FilesByTypeVM.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 30/8/24.
//

import Foundation
import Combine

class FilesByTypeVM: ObservableObject {
    
    @Published var files: AutopsyFiles = []
    @Published var errMsg: String = ""
    @Published var showErrorPopup: Bool = false
    @Published var loading: Bool = false
    @Published var selectedType: FileViewType?
    @Published var shoudShowEmptyState: Bool = false
    
    func getFiles(){
        switch selectedType {
        case .filesByMimeType(let mimeType):
            getFilesByMimeType(mimeType: mimeType)
        case .deletedFilesFileSystem, .deletedFilesAll:
            getDeletedFiles()
        case .fileSizeMB50To200, .fileSizeMB200To1GB, .fileSizeMB1GBPlus:
            getFilesBySize()
        default:
            getFilesByType()
        }
    }
    
    func getDeletedFiles(){
        loading = true
        
        FileViewsManager.getDeletedFiles(caseId: FocusedCase.shared.getCase()?.id ?? -1, type: selectedType?.id ?? 0) { [weak self] files in
            guard let self else { return }
            self.loading = false
            self.shoudShowEmptyState = files.isEmpty
            self.files = files
        } errorBlock: { [weak self] error in
            guard let self else { return }
            self.loading = false
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
        }
    }
    
    func getFilesBySize(){
        loading = true
        
        FileViewsManager.getFilesBySize(caseId: FocusedCase.shared.getCase()?.id ?? -1, type: selectedType?.id ?? 0) { [weak self] files in
            guard let self else { return }
            self.loading = false
            self.shoudShowEmptyState = files.isEmpty
            self.files = files
        } errorBlock: { [weak self] error in
            guard let self else { return }
            self.loading = false
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
        }
    }
    
    func getFilesByType(){
        loading = true
        
        FileViewsManager.getFilesBySize(caseId: FocusedCase.shared.getCase()?.id ?? -1, type: selectedType?.id ?? 0) { [weak self] files in
            guard let self else { return }
            self.loading = false
            self.shoudShowEmptyState = files.isEmpty
            self.files = files
        } errorBlock: { [weak self] error in
            guard let self else { return }
            self.loading = false
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
        }
    }
    
    func getFilesByMimeType(mimeType: String){
        loading = true
        
        FileViewsManager.getFilesByMimeType(caseId: FocusedCase.shared.getCase()?.id ?? -1, mimeType: mimeType) { [weak self] files in
            guard let self else { return }
            self.loading = false
            self.shoudShowEmptyState = files.isEmpty
            self.files = files
        } errorBlock: { [weak self] error in
            guard let self else { return }
            self.loading = false
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
        }
    }
    
}
