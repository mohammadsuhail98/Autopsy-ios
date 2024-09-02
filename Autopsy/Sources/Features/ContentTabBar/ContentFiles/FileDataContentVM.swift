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
    
}
