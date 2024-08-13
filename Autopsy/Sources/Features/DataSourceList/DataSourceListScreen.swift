//
//  DataSourceListScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 12/8/24.
//

import SwiftUI

struct DataSource: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let size: String
    let sectorSize: String
    let timezone: String
    let deviceID: String
}

struct DataSourceListScreen: View {
    
    @State private var dataSources = [
        DataSource(name: "USB1.001", type: "Image", size: "13028543", sectorSize: "512", timezone: "Europe/Berlin", deviceID: "99c1cc72-c618-4566-aead-efe316082f1d"),
        DataSource(name: "USB2.041", type: "Image", size: "13028543", sectorSize: "512", timezone: "Europe/Berlin", deviceID: "99c1cc72-c618-4566-aead-efe316082f1d"),
        DataSource(name: "USB3.005", type: "Image", size: "13028543", sectorSize: "512", timezone: "Europe/Berlin", deviceID: "99c1cc72-c618-4566-aead-efe316082f1d")
    ]
    
    var body: some View {
        List {
            Section {
                Text("Data Sources")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 60)
                    .font(.custom(CFont.graphikMedium.rawValue, size: 20))
                    .foregroundColor(.textColor)
                    .padding(.horizontal, 30)
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            .listRowSeparator(.hidden)
            
            ForEach(dataSources) { item in
                DataSourceCardView(dataSource: item)
            }
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .customBackground()
        .navigationBarTitle("Case Name", displayMode: .inline)
        .toolbar(.visible, for: .navigationBar)
        .toolbar {
            Button("Add") {
                print("Add tapped!")
            }
        }
        
    }
}

struct DataSourceCardView: View {
    
    let dataSource: DataSource
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TitleHStackLabelValue(label: dataSource.name)
            SubtitleHStackLabelValue(label: "Type", value: dataSource.type)
            SubtitleHStackLabelValue(label: "Size (Bytes)", value: dataSource.size)
            SubtitleHStackLabelValue(label: "Sector Size (Bytes)", value: dataSource.sectorSize)
            SubtitleHStackLabelValue(label: "Time Zone", value: dataSource.timezone)
            SubtitleHStackLabelValue(label: "Device ID", value: dataSource.deviceID, bottomPadding: 20)
        }
        .background(Color.white)
        .cornerRadius(0)
    }
}

struct TitleHStackLabelValue: View {
    
    var label: String
    
    var body: some View {
        HStack() {
            Text(label)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom(CFont.graphikMedium.rawValue, size: 17))
                .foregroundColor(.textColor)
            Image(systemName: "chevron.right")
                .foregroundColor(.textColor)
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)
        .padding(.bottom, 10)
    }
}

struct SubtitleHStackLabelValue: View {
    
    var label: String
    var value: String
    var bottomPadding: CGFloat = 0
    
    var body: some View {
        HStack() {
            Text(label)
                .font(.custom(CFont.graphikRegular.rawValue, size: 15))
                .foregroundColor(.gray)
            Text(value)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.custom(CFont.graphikRegular.rawValue, size: 15))
                .foregroundColor(.textColor)
        }
        .padding(.horizontal, 30)
        .padding(.bottom, bottomPadding)
    }
}

#Preview {
    DataSourceListScreen()
}
