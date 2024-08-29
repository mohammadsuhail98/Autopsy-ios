//
//  GeoLocationVM.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 28/8/24.
//
import Foundation
import Combine

class GeoLocationVM: ObservableObject {
    
    @Published var locations: [GeoLocationEntity] = []
    @Published var showFilterScreen: Bool = false
    @Published var selectedDataSourcesIds: Set<Int> = []
    @Published var loading: Bool = false
    @Published var errMsg = ""
    @Published var showErrorPopup = false
    @Published var lastDaysOfActivity: String = ""
    @Published var showAll: Bool = true {
        didSet {
            if showAll {
                lastDaysOfActivity = ""
            }
        }
    }

    func getLocations() {
        
        GeolocationManager.getAllGeolocations(caseId: FocusedCase.shared.getCase()?.id ?? -1) { [weak self] geolocations in
            guard let self else { return }
            self.locations = geolocations.compactMap { $0.shouldDisplay ? $0 : nil }
        } errorBlock: { error in
            self.showErrorPopup = true
            self.errMsg = error.errorMsg
        }
        
    }
    
    func getLocationsByDataSourceIds() {
        loading = true
        let ids = Array(selectedDataSourcesIds.map({ $0 }))
        GeolocationManager.getGeolocationsByDataSources(caseId: FocusedCase.shared.getCase()?.id ?? -1, dataSourceIds: ids) { [weak self] geolocations in
            guard let self else { return }
            loading = false
            var shouldDisplayLocations = geolocations.compactMap { $0.shouldDisplay ? $0 : nil }
            
//            let newGeoLocation = GeoLocationEntity(
//                id: 100,
//                fileName: "NewLocation.jpg",
//                latitude: "43.78559443333333",
//                longitude: "11.234619433333334",
//                altitude: "",
//                timestamp: "2024-8-22 16:38:20 GMT",
//                deviceModel: "iPhone 14 Pro",
//                deviceName: "Apple",
//                file: ""
//            )
//            shouldDisplayLocations.append(newGeoLocation)
            
            if !lastDaysOfActivity.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                if let lastDays = Int(lastDaysOfActivity) {
                    self.locations = filterLastDaysOfActivity(locations: shouldDisplayLocations,
                                                              days: lastDays)
                }
            } else {
                self.locations = shouldDisplayLocations
            }
            
        } errorBlock: { error in
            self.loading = false
            self.showErrorPopup = true
            self.errMsg = error.errorMsg
        }
        
    }
    
    func filterLastDaysOfActivity(locations: [GeoLocationEntity], days: Int) -> [GeoLocationEntity] {
        let keyDate = Calendar(identifier: .gregorian).date(byAdding: .day, value: -days, to: Date())

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-M-dd HH:mm:ss zzz"

        return locations.filter { location in
            if let timestampString = location.timestamp,
               let timestampDate = dateFormatter.date(from: timestampString) {
                return timestampDate >= keyDate ?? Date()
            }
            return false
        }
    }
    
    func getFileUrl(path: String) -> URL? {
        let route = NetworkRouter.getGeolocationImage(path)
        
        var components = URLComponents()
        components.scheme = route.scheme
        components.host = route.host
        components.port = route.port
        components.path = route.path
        components.queryItems = route.queryItems

        return components.url
    }
    
    
}
