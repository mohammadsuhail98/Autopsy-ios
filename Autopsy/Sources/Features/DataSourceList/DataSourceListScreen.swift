//
//  DataSourceListScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 12/8/24.
//

import SwiftUI
import PopupView

struct DataSourceListScreen: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var vm: DataSourceListVM
    @State private var showMetadata: Bool = false
    @State private var selectedDataSource: DataSource?
    @State private var toBeDeleted: IndexSet?
    @State private var showingDeleteAlert = false

    var body: some View {
        ZStack {
            
            if vm.shoudShowEmptyState {
                DataSourcesEmptyView {
                    router.caseHomePath.append(.addDataSourceType)
                }
                .customBackground()

            } else {
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
                    
                    ForEach(vm.dataSources, id: \.self) { item in
                        DataSourceCardView(dataSource: item)
                            .onTapGesture {
                                router.caseHomePath.append(.dataSourceContent(item))
                            }
                            .swipeActions(allowsFullSwipe: false) {
                                Button {
                                    self.selectedDataSource = item
                                    showingDeleteAlert = true
                                } label: {
                                    Image(systemName: "trash.fill")
                                    Text("Delete")
                                        .font(.custom(CFont.graphikRegular.rawValue, size: 13))
                                }
                                .tint(Color.themeRed)
                                
                                Button {
                                    self.selectedDataSource = item
                                    showMetadata = true
                                } label: {
                                    Image(systemName: "ellipsis.circle.fill")
                                    Text("More")
                                        .font(.custom(CFont.graphikRegular.rawValue, size: 13))
                                }
                                .tint(Color.themeGray)
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
                .popup(isPresented: $showingDeleteAlert) {
                    DeleteDataSourcePopup(isPresented: $showingDeleteAlert) {
                        if let dataSource = selectedDataSource {
                            deleteDataSource(dataSource)
                        }
                    }
                } customize: { $0
                        .type(.floater())
                        .position(.center)
                        .closeOnTap(false)
                        .backgroundColor(.black.opacity(0.4))
                }
                .refreshable {
                    vm.getDataSourceList()
                }
            }
            
            if vm.loading { LoadingHUDView(loading: $vm.loading) }
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
        .popup(isPresented: $showMetadata) {
            MetadataView(dataSource: $selectedDataSource, isDisplayed: $showMetadata)
        } customize: {
            $0
                .type(.floater(verticalPadding: 0, useSafeAreaInset: true))
                .position(.bottom)
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.4))
            
        }
    }
    
    private func deleteDataSource(_ dataSource: DataSource) {
        vm.deleteDataSource(dataSource: dataSource)
    }
}

struct MetadataView: View {
    
    @Binding var dataSource: DataSource?
    @Binding var isDisplayed: Bool
    
    var body: some View {
        VStack(spacing: 12) {
 
            Section {
                
                VStack(spacing: 10) {
                    if let name = dataSource?.name {
                        SubtitleHStackLabelValue(label: "Name", value: name, bottomPadding: 5, horizontalPadding: 0)
                    }
                    if let type = dataSource?.fileType {
                        SubtitleHStackLabelValue(label: "Type", value: type, bottomPadding: 5,horizontalPadding: 0)
                    }
                    if let size = dataSource?.size {
                        SubtitleHStackLabelValue(label: "Size (Bytes)", value: "\(size)", bottomPadding: 5,horizontalPadding: 0)
                    }
                    if let md5 = dataSource?.md5Hash, !md5.isEmpty {
                        SubtitleHStackLabelValue(label: "MD5", value: md5, bottomPadding: 5,horizontalPadding: 0)
                    }
                    if let sha1 = dataSource?.sha1Hash, !sha1.isEmpty {
                        SubtitleHStackLabelValue(label: "SHA1", value: sha1, bottomPadding: 5,horizontalPadding: 0)
                    }
                    if let sha256 = dataSource?.sha256Hash, !sha256.isEmpty {
                        SubtitleHStackLabelValue(label: "SHA256", value: sha256, bottomPadding: 5,horizontalPadding: 0)
                    }
                    if let sectorSize = dataSource?.sectorSize {
                        SubtitleHStackLabelValue(label: "Sector Size (Bytes)", value: "\(sectorSize)", bottomPadding: 5,horizontalPadding: 0)
                    }
                    if let timeZone = dataSource?.timeZone {
                        SubtitleHStackLabelValue(label: "Timezone", value: timeZone, bottomPadding: 5,horizontalPadding: 0)
                    }
                    if let deviceId = dataSource?.dataSourceDeviceID {
                        SubtitleHStackLabelValue(label: "Device ID", value: deviceId, bottomPadding: 5,horizontalPadding: 0)
                    }
                    if let errors = dataSource?.errors {
                        SubtitleHStackLabelValue(label: "Non Severe Errors", value: errors, bottomPadding: 5,horizontalPadding: 0)
                    }
                }
                .frame(maxWidth: .infinity)
                
            } header: {
                HStack {
                    Text("Metadata")
                        .font(.custom(CFont.graphikSemibold.rawValue, size: 15))
                        .foregroundColor(.textColor)
                    Spacer()
                    Button {
                        isDisplayed = false
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.textColor)
                    }
                }
                
                Divider()
                    .padding(.vertical, 5)
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 25, leading: 35, bottom: 40, trailing: 35))
        .background(Color.white)
    }
}

struct DataSourcesEmptyView: View {
    
    var completion: (() -> Void)?
    
    var body: some View {
        Spacer()
        
        VStack {
            Image("no_data_sources")
            
            Text("No Data Sources Yet!")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.custom(CFont.graphikMedium.rawValue, size: 15))
                .foregroundColor(.textColor)
                .padding(.vertical, 10)
            
            Button {
                completion?()
            } label: {
                BorderedBtnLabelView(title: "Add Data Source")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 50)
        
        Spacer()
    }
}

struct DataSourceCardView: View {
    
    let dataSource: DataSource
    
    var body: some View {
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
        .contentShape(Rectangle())
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
    var horizontalPadding: CGFloat = 30

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
        .padding(.horizontal, horizontalPadding)
        .padding(.bottom, bottomPadding)
    }
}

struct DeleteDataSourcePopup: View {
    
    @Binding var isPresented: Bool
    var completion: (() -> Void)
    
    var body: some View {
        VStack(spacing: 12) {
            
            VStack {
                Image("confirm_delete")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 80, maxHeight: 80)
                    .padding(.bottom, 12)

                Text("You are about to delete a data source")
                    .font(.custom(CFont.graphikSemibold.rawValue, size: 14))
                    .foregroundColor(.textColor)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 3)
                
                Text("This will delete the data source permanently, are you sure?")
                    .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 12)
            }

            HStack {
                Spacer()
                
                Button {
                    isPresented = false
                } label: {
                    Text("Cancel")
                        .font(.custom(CFont.graphikMedium.rawValue, size: 14))
                        .frame(maxWidth: 120, alignment: .trailing)
                        .foregroundColor(.gray)
                        .frame(height: 1)
                        .padding(.vertical, 18)
                        .padding(.trailing, 5)
                }

                Button {
                    isPresented = false
                    completion()
                } label: {
                    Text("Delete")
                        .font(.custom(CFont.graphikSemibold.rawValue, size: 14))
                        .frame(maxWidth: 120)
                        .frame(height: 0)
                        .padding(.vertical, 18)
                        .foregroundColor(.white)
                        .background(Color.themeRed)
                        .cornerRadius(5)
                }
                .shadow(color: .shadow, radius: 2, x: 1, y: 1)
                
            }
            
        }
        .padding(EdgeInsets(top: 37, leading: 24, bottom: 25, trailing: 24))
        .background(Color.white.cornerRadius(5))
        .padding(.horizontal, 30)
    }
}

#Preview {
    DataSourceListScreen()
}
