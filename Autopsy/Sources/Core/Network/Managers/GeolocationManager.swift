//
//  GeolocationManager.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 28/8/24.
//

import Foundation

class GeolocationManager: APIClient {
    
    class func getAllGeolocations(caseId: Int, successBlock: (([GeoLocationEntity]) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .getAllGeolocations(caseId)) { (result: Result<[GeoLocationEntity], AutopsyError>) in
            switch result {
            case .success(let geolocations):
                successBlock?(geolocations)
            case .failure(let error):
                errorBlock?(error)
            }
        }
        
    }
    
    class func getGeolocationsByDataSources(caseId: Int, dataSourceIds: [Int], successBlock: (([GeoLocationEntity]) -> Void)? = nil, errorBlock: ((AutopsyError) -> Void)? = nil) {
        
        createRequest(withRoute: .getGeolocationsByDataSource(caseId, dataSourceIds)) { (result: Result<[GeoLocationEntity], AutopsyError>) in
            switch result {
            case .success(let geolocations):
                successBlock?(geolocations)
            case .failure(let error):
                errorBlock?(error)
            }
        }
        
    }
    
}
