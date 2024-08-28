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
    
    func getLocations() {
        
        GeolocationManager.getAllGeolocations(caseId: FocusedCase.shared.getCase()?.id ?? -1) { [weak self] geolocations in
            guard let self else { return }
            
            self.locations = geolocations.compactMap { $0.shouldDisplay ? $0 : nil }
            print(self.locations)
        } errorBlock: { error in
            
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
