//
//  FileDataContentVM.swift
//  Autopsy
//
//  Created by mohammad suhail on 1/9/24.
//

import Foundation
import Combine

class FileDataContentVM: ObservableObject {
    
    @Published var hexString = "loading..."
    @Published var textString = "loading..."
    @Published var metadata = AutopsyFile()
    @Published var applicationData = Data()
    @Published var analysisResult = FileResults()

    func getAllData(fileId: Int){
        getHexData(fileId: fileId)
        getTextData(fileId: fileId)
        getMetadata(fileId: fileId)
        getApplicationData(fileId: fileId)
        getAnalysisResults(fileId: fileId)
    }
    
    func getHexData(fileId: Int){
        DataSourceContentManager.getHexFile(caseId: FocusedCase.shared.getCase()?.id ?? 0, id: fileId) { data in
            self.hexString = String(data: data, encoding: .utf8) ?? "Failed to decode file content."
        } errorBlock: { error in
            print(error.errorMsg)
        }
    }
    
    func getTextData(fileId: Int){
        DataSourceContentManager.getTextFile(caseId: FocusedCase.shared.getCase()?.id ?? 0, id: fileId) { data in
            self.textString = String(data: data, encoding: .utf8) ?? "Failed to decode file content."
        } errorBlock: { error in
            print(error.errorMsg)
        }
    }
    
    func getMetadata(fileId: Int){
        DataSourceContentManager.getFileMetadata(caseId: FocusedCase.shared.getCase()?.id ?? 0, id: fileId) { metadata in
            self.metadata = metadata
        } errorBlock: { error in
            print(error.errorMsg)
        }
    }
    
    func getApplicationData(fileId: Int){
        DataSourceContentManager.getApplicationFile(caseId: FocusedCase.shared.getCase()?.id ?? 0, id: fileId) { data in
            self.applicationData = data
        } errorBlock: { error in
            print(error.errorMsg)
        }
    }
    
    func getAnalysisResults(fileId: Int){
        DataSourceContentManager.getFileAnalysisResults(caseId: FocusedCase.shared.getCase()?.id ?? 0, id: fileId) { results in
            self.analysisResult = results
        } errorBlock: { error in
            print(error.errorMsg)
        }
    }
    
}
