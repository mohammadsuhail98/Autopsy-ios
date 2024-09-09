//
//  AddDataSourceVM.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 3/9/24.
//

import Foundation
import Combine

class AddDataSourceVM: ObservableObject {
    
    @Published var timeZones = [String]()
    @Published var sectorSizes: [String] = ["Auto Detect","512","1024","2048","4096"]
    @Published var ignoreOrphanFiles: Bool = false
    @Published var addUnallocSpace: Bool = false
    @Published var selectedTimeZone: String = "(GMT +1:00) Europe/Berlin"
    @Published var selectedSectorSize: String = "Auto Detect"
    @Published var md5: String = ""
    @Published var sha1: String = ""
    @Published var sha256: String = ""
    @Published var fileUrl: URL?
    @Published var filters: [String] = ["All files, Directories and Unallocated space",
                               "All files and Directories (without Unallocated space)"]
    @Published var selectedFilter: String = "All files, Directories and Unallocated space"
    @Published var exifParser: Bool = false
    @Published var loading: Bool = false
    @Published var errMsg: String = ""
    @Published var showErrorPopup: Bool = false
    
    init(){
        timeZones = getTimeZonesList()
    }
    
    func validateFields(continueBlock: (()->())? = nil, errorBlock: (()->())? = nil){
        guard let _ = fileUrl else {
            self.errMsg = "A disk image needs to be uploaded to continue"
            self.showErrorPopup = true
            errorBlock?()
            return
        }
        continueBlock?()
    }
    
    func addDataSource(successBlock: (()->())? = nil, errorBlock: (()->())? = nil){
        guard let fileUrl else { return }
        
        loading = true
        
        var addDataSourceRequest = AddDataSourceRequest(fileUrl: fileUrl)
        addDataSourceRequest.ignoreOrphanFiles = ignoreOrphanFiles
        
        if selectedFilter.elementsEqual("All files, Directories and Unallocated space") {
            addDataSourceRequest.addUnAllocSpace = true
        } else {
            addDataSourceRequest.addUnAllocSpace = false
        }
        addDataSourceRequest.timeZone = getTimeZoneIdentifier(from: selectedTimeZone)
        addDataSourceRequest.sectorSize = "\(Int(selectedSectorSize) ?? 0)"
        addDataSourceRequest.md5 = md5
        addDataSourceRequest.sha1 = sha1
        addDataSourceRequest.sha256 = sha256
        addDataSourceRequest.exifParser = exifParser
        
        DataSourceManager.addDataSource(caseId: FocusedCase.shared.getCase()?.id ?? 0, fileUrl: fileUrl, addDataSourceRequest: addDataSourceRequest) { [weak self] dataSource in
            guard let self else { return }
            self.loading = false
            print(dataSource)
            successBlock?()
        } errorBlock: { [weak self] error in
            guard let self else { return }
            self.loading = false
            self.errMsg = error.errorMsg
            self.showErrorPopup = true
            errorBlock?()
        }
        
    }
    
    func getTimeZonesList() -> [String] {
        let timeZones = TimeZone.knownTimeZoneIdentifiers
        var formattedTimeZones: [String] = []
        
        for timeZoneIdentifier in timeZones {
            if let timeZone = TimeZone(identifier: timeZoneIdentifier) {
                let secondsFromGMT = timeZone.secondsFromGMT()
                let hours = secondsFromGMT / 3600
                let minutes = abs(secondsFromGMT / 60) % 60
                
                let formattedOffset = String(format: "GMT %+.2d:%.2d", hours, minutes)
                
                let formattedTimeZone = "(\(formattedOffset)) \(timeZone.identifier)"
                
                formattedTimeZones.append(formattedTimeZone)
            }
        }
        
        return formattedTimeZones.sorted()
    }
    
    func getTimeZoneIdentifier(from selectedString: String) -> String {
        let components = selectedString.components(separatedBy: ") ")
        return components.last ?? selectedString
    }
    
}
