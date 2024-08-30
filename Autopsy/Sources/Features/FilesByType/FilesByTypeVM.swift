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
    
    
    
    func getFiles(){
        if selectedType == .deletedFilesAll || selectedType == .deletedFilesFileSystem {
            getDeletedFiles()
        } else if selectedType == .fileSizeMB50To200 || selectedType == .fileSizeMB200To1GB || selectedType == .fileSizeMB1GBPlus {
            getFilesBySize()
        } else {
            getFilesByType()
        }
    }
    
    func getDeletedFiles(){
        loading = true
        
        FileViewsManager.getDeletedFiles(caseId: FocusedCase.shared.getCase()?.id ?? -1, type: selectedType?.rawValue ?? 0) { [weak self] files in
            guard let self else { return }
            self.loading = false
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
        
        FileViewsManager.getFilesBySize(caseId: FocusedCase.shared.getCase()?.id ?? -1, type: selectedType?.rawValue ?? 0) { [weak self] files in
            guard let self else { return }
            self.loading = false
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
        
        FileViewsManager.getFilesBySize(caseId: FocusedCase.shared.getCase()?.id ?? -1, type: selectedType?.rawValue ?? 0) { [weak self] files in
            guard let self else { return }
            self.loading = false
            self.files = files
        } errorBlock: { [weak self] error in
            guard let self else { return }
            self.loading = false
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
        }
    }
    
}
