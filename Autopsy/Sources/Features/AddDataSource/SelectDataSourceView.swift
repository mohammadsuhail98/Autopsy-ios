//
//  SelectDataSourceView.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 5/8/24.
//

import SwiftUI
import PopupView

struct SelectDataSourceView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var vm: AddDataSourceVM
    
    @State var showFilePicker = false
    @State var fileStatus: FileUploadStatus = .idle
    
    var body: some View {
        Form {
            
            Section(
                header: TitleWithIconView(icon: "type_data_source", title: "Case Name", subtitle: "Select Data Source")
            ) {
                
                Button {
                    showFilePicker.toggle()
                } label: {
                    FileUploadButtonView(fileUrl: $vm.fileUrl, status: $fileStatus)
                }
                .fileImporter(isPresented: $showFilePicker, allowedContentTypes: [.item, .diskImage], allowsMultipleSelection: false, onCompletion: { results in
                    switch results {
                    case .success(let fileurls):
                        fileStatus = .success
                        for fileUrl in fileurls { vm.fileUrl = fileUrl }
                    case .failure(let error):
                        vm.fileUrl = nil
                        fileStatus = .failed(error.localizedDescription)
                    }
                })
                
                CheckboxView(isChecked: $vm.ignoreOrphanFiles, title: "Ignore Orphan Files")
                
                MenuView(titleText: "Time Zone", items: vm.timeZones, selectedItem: $vm.selectedTimeZone)
                
                MenuView(titleText: "Sector Size", items: vm.sectorSizes, selectedItem: $vm.selectedSectorSize)
            }
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
            
            Section(header: Text("Hash Values")
                .font(.custom(CFont.graphikMedium.rawValue, size: 17))
                .foregroundColor(.textColor)
                .frame(width: UIScreen.screenWidth - 75, height: 50)
                .textCase(.none)
            ) {
                EntryFieldStackView(titleText: "MD5", value: $vm.md5, optional: true)
                EntryFieldStackView(titleText: "SHA-1", value: $vm.sha1, optional: true)
                EntryFieldStackView(titleText: "SHA-256", value: $vm.sha256, optional: true)
                
                NoteView()
            }
            .listRowBackground(Color.clear)
            
            Button {
                vm.validateFields {
                    router.selectedScenario == .caseCreation ? router.caseCreationPath.append(.ingestModules) : router.caseHomePath.append(.ingestModules)
                } errorBlock: {
                    
                }
            } label: {
                BorderedBtnLabelView(title: "Next")
            }
            .listRowBackground(Color.clear)
            
        }
        .customBackground()
        .scrollContentBackground(.hidden)
        .navigationBarTitle("Add Data Source", displayMode: .inline)
        .navigationBarModifier(backgroundColor: .systemBackground, foregroundColor: .black, tintColor: .black, withSeparator: false)
        .popup(isPresented: $vm.showErrorPopup) {
            ErrorToastView(msg: vm.errMsg)
        } customize: { $0
            .type(.floater())
            .position(.bottom)
            .animation(.spring())
            .closeOnTapOutside(true)
            .autohideIn(2)
        }
    }
    
}

struct FileUploadButtonView: View {
    
    @Binding var fileUrl: URL?
    @Binding var status: FileUploadStatus
    
    var body: some View {
        VStack(spacing: 8) {
            switch status {
            case .idle:
                Image("file_upload")
                    .foregroundColor(.textColor)
                Text("Choose File to Upload")
                    .font(.custom(CFont.graphikLight.rawValue, size: 13))
                    .foregroundColor(.gray)
                
            case .success:
                if let fileUrl = fileUrl {
                    Image("file_success")
                    Text(fileUrl.lastPathComponent)
                        .font(.custom(CFont.graphikSemibold.rawValue, size: 13))
                        .foregroundColor(.textColor)
                }
            case .failed(let error):
                Image("file_fail")
                Text(error)
                    .font(.custom(CFont.graphikRegular.rawValue, size: 13))
                    .foregroundColor(.textColor)
            }

        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .padding(.horizontal)
        .background(Color.textFieldBackground)
        .cornerRadius(5)
    }
}

struct CheckboxView: View {
    @Binding var isChecked: Bool
    var title: String
    
    var body: some View {
        Button {
            isChecked.toggle()
        } label: {
            HStack() {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .foregroundColor(.textColor)
                Text(title)
                    .font(.custom(CFont.graphikRegular.rawValue, size: 15))
                    .foregroundColor(.textColor)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .listRowSeparator(.hidden, edges: .top)
    }
}

struct NoteView: View {
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 5){
            Text("NOTE:")
                .font(.custom(CFont.graphikBold.rawValue, size: 13))
                .foregroundColor(.textColor)
            Text("These will not be validated when the data source is added")
                .font(.custom(CFont.graphikRegular.rawValue, size: 13))
                .foregroundColor(.textColor)
        }
    }
}

#Preview {
    SelectDataSourceView()
}

enum FileUploadStatus {
    case idle
    case success
    case failed(String)
}
