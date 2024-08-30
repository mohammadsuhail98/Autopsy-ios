//
//  MimeTypesVM.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 30/8/24.
//

import Foundation
import Combine

class MimeTypesVM: ObservableObject {
    
    @Published var mimeTypes: MIMETypes = []
    @Published var errMsg: String = ""
    @Published var showErrorPopup: Bool = false
    @Published var loading: Bool = false
    
    func getMimeTypes(){
        loading = true
        
        FileViewsManager.getCurrentMimeTypes(caseId: FocusedCase.shared.getCase()?.id ?? 0) { [weak self] mimeTypes in
            guard let self else { return }
            self.loading = false
            self.mimeTypes = mimeTypes
        } errorBlock: { [weak self] error in
            guard let self else { return }
            self.loading = false
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
        }
    }
    
}
