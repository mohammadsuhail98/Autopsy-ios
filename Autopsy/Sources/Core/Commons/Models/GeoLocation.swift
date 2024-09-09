//
//  GeoLocationModel.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 28/8/24.
//

import Foundation
import CoreLocation

struct GeoLocationEntity: Identifiable, Codable {
    let id: Int
    let fileName: String
    let latitude: String?
    let longitude: String?
    let altitude: String?
    let timestamp: String?
    let deviceModel: String?
    let deviceName: String?
    let file: String?
    
    var coordinate: CLLocationCoordinate2D? {
        guard
            let latString = latitude,
            let lonString = longitude,
            let lat = Double(latString),
            let lon = Double(lonString)
        else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    var shouldDisplay: Bool {
        return (coordinate != nil && deviceName != nil && deviceModel != nil)
    }
    
    var altitudeValue: Double? {
        guard let altString = altitude, let alt = Double(altString) else {
            return nil
        }
        return alt
    }
    
    var date: Date? {
        guard let timestamp = timestamp else { return nil }
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: timestamp)
    }
}
