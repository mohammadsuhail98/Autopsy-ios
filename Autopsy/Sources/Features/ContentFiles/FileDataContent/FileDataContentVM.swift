//
//  FileDataContentVM.swift
//  Autopsy
//
//  Created by mohammad suhail on 1/9/24.
//

import Foundation
import Combine

class FileDataContentVM: ObservableObject {
    
    @Published var hexString = ""
    @Published var textString = ""
    @Published var metadata = AutopsyFile()
    @Published var applicationData = Data()
    @Published var analysisResult = FileResults()
    @Published var loading: Bool = false
    
    @Published var hexFailed: Bool = false
    @Published var textFailed: Bool = false
    @Published var applicationFailed: Bool = false
    @Published var resultsFailed: Bool = false
    @Published var metadataFailed: Bool = false

    func getHexData(fileId: Int){
        loading = true
        DataSourceContentManager.getHexFile(caseId: FocusedCase.shared.getCase()?.id ?? 0, id: fileId) { data in
            self.hexString = String(data: data, encoding: .utf8) ?? "Failed to decode file content."
            self.loading = false
            self.hexFailed = false
        } errorBlock: { error in
            print(error.errorMsg)
            self.loading = false
            self.hexFailed = true
        }
    }
    
    func getTextData(fileId: Int){
        loading = true
        DataSourceContentManager.getTextFile(caseId: FocusedCase.shared.getCase()?.id ?? 0, id: fileId) { data in
            self.textString = String(data: data, encoding: .utf8) ?? "Failed to decode file content."
            self.loading = false
            self.textFailed = false
        } errorBlock: { error in
            print(error.errorMsg)
            self.loading = false
            self.textFailed = true
        }
    }
    
    func getMetadata(fileId: Int){
        loading = true
        DataSourceContentManager.getFileMetadata(caseId: FocusedCase.shared.getCase()?.id ?? 0, id: fileId) { metadata in
            self.metadata = metadata
            self.loading = false
            self.metadataFailed = false
        } errorBlock: { error in
            print(error.errorMsg)
            self.loading = false
            self.metadataFailed = true
        }
    }
    
    func getApplicationData(fileId: Int){
        loading = true
        DataSourceContentManager.getApplicationFile(caseId: FocusedCase.shared.getCase()?.id ?? 0, id: fileId) { data in
            self.applicationData = data
            self.loading = false
            self.applicationFailed = false
        } errorBlock: { error in
            print(error.errorMsg)
            self.loading = false
            self.applicationFailed = true
        }
    }
    
    func getAnalysisResults(fileId: Int){
        loading = true
        DataSourceContentManager.getFileAnalysisResults(caseId: FocusedCase.shared.getCase()?.id ?? 0, id: fileId) { results in
            self.analysisResult = results
            self.loading = false
            self.resultsFailed = false
        } errorBlock: { error in
            print(error.errorMsg)
            self.loading = false
            self.resultsFailed = true
        }
    }
    
}
