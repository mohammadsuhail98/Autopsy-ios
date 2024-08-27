//
//  DataSourceListScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 12/8/24.
//

import SwiftUI

struct DataSourceListScreen: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var vm: DataSourceListVM
        
    var body: some View {
        ZStack {
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
                
                ForEach(vm.dataSources) { item in
                    DataSourceCardView(dataSource: item) { id in
                        router.caseHomePath.append(.dataSourceContent)
                    }
                }
                .shadow(color: .shadow, radius: 2, x: 1, y: 1)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .customBackground()
            .onAppear {
                vm.getDataSourceList()
            }
            .popup(isPresented: $vm.showErrorPopup) {
                ErrorToastView(msg: vm.errMsg)
            } customize: { $0
                .type(.floater())
                .position(.bottom)
                .animation(.spring())
                .closeOnTapOutside(true)
                .autohideIn(2)
            }
            .refreshable {
                vm.getDataSourceList()
            }
            
            if vm.loading { LoadingHUDView(loading: $vm.loading) }
        }
    }
}

struct DataSourceCardView: View {
    
    let dataSource: DataSource
    var action: ((String) -> ())
    
    var body: some View {
        
        Button {
            action("\(dataSource.id)")
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                TitleHStackLabelValue(label: dataSource.name ?? "")
                SubtitleHStackLabelValue(label: "Type", value: dataSource.fileType ?? "")
                SubtitleHStackLabelValue(label: "Size (Bytes)", value: "\(dataSource.size ?? 0)")
                SubtitleHStackLabelValue(label: "Sector Size (Bytes)", value: "\(dataSource.sectorSize ?? 0)")
                SubtitleHStackLabelValue(label: "Time Zone", value: dataSource.timeZone ?? "")
                SubtitleHStackLabelValue(label: "Device ID", value: dataSource.dataSourceDeviceID ?? "", bottomPadding: 20)
            }
            .background(Color.white)
            .cornerRadius(0)
        }
        

    }
}

struct TitleHStackLabelValue: View {
    
    var label: String
    
    var body: some View {
        HStack() {
            Text(label)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom(CFont.graphikMedium.rawValue, size: 15))
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
                .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                .foregroundColor(.gray)
            Text(value)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.custom(CFont.graphikRegular.rawValue, size: 13))
                .foregroundColor(.textColor)
        }
        .padding(.horizontal, 30)
        .padding(.bottom, bottomPadding)
    }
}

#Preview {
    DataSourceListScreen()
}
