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
    
}
