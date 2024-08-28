//
//  GeoLocationScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 28/8/24.
//

import SwiftUI
import MapKit

struct GeoLocationScreen: View {
    @EnvironmentObject private var vm: GeoLocationVM
    @State private var selectedLocation: GeoLocationEntity?

    var body: some View {
        ZStack {
            if let location = selectedLocation {
                LocationDetailOverlay(location: location, imageUrlPath: vm.getFileUrl(path: location.file ?? "")) {
                    selectedLocation = nil
                }.zIndex(2)
            }
            
            Map(mapRect: .constant(.world), annotationItems: vm.locations) { location in
                MapAnnotation(coordinate: location.coordinate!) {
                    LocationAnnotationView(location: location) {
                        selectedLocation = location
                    }
                }
            }
            .zIndex(1)
        }
        .navigationTitle("Geolocation")
        .ignoresSafeArea()
        .toolbar {
            Button {
                
            } label: {
                Image(systemName: "line.horizontal.3.decrease.circle")
                    .foregroundColor(.textColor)
            }
        }
        .onAppear {
            vm.getLocations()
        }
    }
}

struct LocationAnnotationView: View {
    let location: GeoLocationEntity
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Image("location_point")
                .resizable()
                .renderingMode(.template)
                .frame(width: 18, height: 25)
                .foregroundColor(.themeBlue)
                .font(.title)
        }
    }
}

struct LocationDetailOverlay: View {
    let location: GeoLocationEntity
    var imageUrlPath: URL?
    var onClose: () -> Void

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 10) {
                
                AsyncImage(url: imageUrlPath) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 270, maxHeight: 230)
                            .padding(.top, 0)
                        
                    case .failure:
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300, maxHeight: 250)
                        
                    case .empty:
                        ProgressView()
                    @unknown default:
                        EmptyView()
                    }
                }
                
                LocationFileView(label: "Name", value: location.fileName)
                
                if let timestamp = location.timestamp {
                    LocationFileView(label: "Timestamp", value: timestamp)
                }
                
                if let altitude = location.altitude {
                    LocationFileView(label: "Altitude", value: altitude)
                }
                
                LocationFileView(label: "Device Name", value: location.deviceName ?? "")
                LocationFileView(label: "Device Model", value: location.deviceModel ?? "")
                
                Button(action: onClose) {
                    Text("Close")
                        .font(.custom(CFont.graphikBold.rawValue, size: 14))
                        .padding(.vertical, 30)
                        .frame(width: 130, height: 40)
                        .background(Color.themeBlue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
            .background(Color.white)
            .cornerRadius(5)
            .shadow(radius: 5)
        }
        .transition(.move(edge: .bottom))
        .animation(.spring)
    }
}

struct LocationFileView: View {
    
    var label: String
    var value: String
    
    var body: some View {
        HStack(spacing: 5) {
            Text(label)
                .font(.custom(CFont.graphikBold.rawValue, size: 14))
                .foregroundColor(.textColor)
                .multilineTextAlignment(.leading)
            Text(value)
                .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                .foregroundColor(.textColor)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .frame(maxWidth: 270)
    }
}

#Preview {
    GeoLocationScreen()
}
