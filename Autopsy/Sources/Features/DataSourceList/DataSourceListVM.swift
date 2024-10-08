//
//  DataSourceListVM.swift
//  Autopsy
//
//  Created by mohammad suhail on 27/8/24.
//

import Foundation
import SwiftUI

class DataSourceListVM: ObservableObject {
    
    @Published var dataSources = [DataSource]()
    @Published var errMsg: String = ""
    @Published var showErrorPopup: Bool = false
    @Published var loading: Bool = false
    @Published var shoudShowEmptyState: Bool = false

    func getDataSourceList(){
        guard let caseEntity = FocusedCase.shared.getCase() else { return }
        self.loading = true
        
        DataSourceManager.getDataSources(caseId: caseEntity.id ?? 0) { [weak self] dataSourceList in
            guard let self else { return }
            
            self.loading = false
            self.shoudShowEmptyState = dataSourceList.isEmpty
            
            self.dataSources = dataSourceList
            
        } errorBlock: { [weak self] error in
            guard let self else { return }
            self.loading = false
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
        }
    }
    
    func deleteDataSource(dataSource: DataSource) {
        guard let caseEntity = FocusedCase.shared.getCase() else { return }

        self.loading = true

        DataSourceManager.deleteDataSource(caseId: caseEntity.id ?? 0, dataSourceId: dataSource.id ?? 0) { [weak self] response in
            guard let self else { return }
            self.getDataSourceList()

        } errorBlock: { [weak self] error in
            guard let self else { return }
            self.loading = false
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
        }
    }
    
}
