//
//  AnalysisResultsFilesVM.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/8/24.
//

import Foundation
import Combine

class AnalysisResultsFilesVM: ObservableObject {

    @Published var files: AutopsyFiles = []
    @Published var errMsg: String = ""
    @Published var showErrorPopup: Bool = false
    @Published var loading: Bool = false
    @Published var typeImage: String = ""
    @Published var selectedType: Int = 0

    func getFilesByType() {
        loading = true
        
        if selectedType == 16 {
            typeImage = "exif_camera"
        } else if selectedType == 56 {
            typeImage = "user_suspected"
        }
        
        AnalysisResultsManager.getFilesByType(caseId: FocusedCase.shared.getCase()?.id ?? -1, type: selectedType) { [weak self] files in
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
