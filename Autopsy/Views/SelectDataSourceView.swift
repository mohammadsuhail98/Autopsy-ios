//
//  SelectDataSourceView.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 5/8/24.
//

import SwiftUI

struct SelectDataSourceView: View {
    
    let timeZones: [String] = TimeZone.knownTimeZoneIdentifiers
    let sectorSizes: [String] = ["Auto Detect","128","256","512","1024"]
    @State var isOrphanFiles: Bool = false
    @State private var selectedTimeZone: String = "(GMT +1:00) Europe/Berlin"
    @State private var selectedSectorSize: String = "Auto Detect"
    @State private var md5: String = ""
    @State private var sha1: String = ""
    @State private var sha256: String = ""
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                backgroundView()
                Form {
                    
                    Section(
                        header: TitleWithIconView(icon: "type_data_source", title: "Case Name", subtitle: "Select Data Source")
                    ) {
                        
                        Button {
                            
                        } label: {
                            FileUploadButtonView()
                        }
                        
                        CheckboxView(isChecked: $isOrphanFiles, title: "Ignore Orphan Files")
                        
                        MenuView(titleText: "Time Zone", items: timeZones, selectedItem: $selectedTimeZone)
                        
                        MenuView(titleText: "Sector Size", items: sectorSizes, selectedItem: $selectedSectorSize)
                    }
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
                    
                    Section(header: SectionTitleView(title: "Hash Values")) {
                        EntryFieldStackView(titleText: "MD5", value: $md5, optional: true)
                        EntryFieldStackView(titleText: "SHA-1", value: $sha1, optional: true)
                        EntryFieldStackView(titleText: "SHA-256", value: $sha256, optional: true)
                        
                        NoteView()
                    }
                    .listRowBackground(Color.clear)
                    
                    Button {
                        
                    } label: {
                        BorderedBtnLabelView(title: "Next")
                            
                    }
                    .listRowBackground(Color.clear)
                    
                }
                .scrollContentBackground(.hidden)
                .navigationBarTitle("Add Data Source", displayMode: .inline)
                .navigationBarModifier(backgroundColor: .systemBackground, foregroundColor: .black, tintColor: .black, withSeparator: false)
            }
        }
    }
}

struct FileUploadButtonView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image("file_upload")
                .foregroundColor(.textColor)
            Text("Choose File to Upload")
                .font(.custom(CFont.graphikLight.rawValue, size: 13))
                .foregroundColor(.gray)
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
        .listRowSeparator(.hidden, edges: .all)
        .padding(.horizontal)
    }
}

struct MenuView: View {
    
    var titleText: String
    var items: [String] = [String]()
    @Binding var selectedItem: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(titleText)
                .font(.custom(CFont.graphikRegular.rawValue, size: 15))
                .foregroundColor(.textColor)
            
            Menu {
                ForEach(items, id: \.self) { item in
                    Button(action: {
                        selectedItem = item
                    }, label: {
                        Text(item)
                    })
                }
            } label: {
                HStack {
                    Text(selectedItem)
                        .padding(.horizontal)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.textColor)
                }
                .font(.custom(CFont.graphikRegular.rawValue, size: 15))
                .foregroundStyle(Color.textColor)
                .frame(height: 50)
                .padding(.horizontal)
                .background(Color.textFieldBackground)
                .cornerRadius(5)
            }
            .padding(.vertical, 5)

        }
        .frame(maxWidth: .infinity)
        .listRowSeparator(.hidden, edges: .all)
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
