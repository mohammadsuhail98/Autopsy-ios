//
//  IngestModulesView.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 8/8/24.
//

import SwiftUI

struct IngestModulesView: View {
    
    @EnvironmentObject private var router: Router

    let filters: [String] = ["All files, Directories and Unallocated space",
                               "All files and Directories (without Unallocated space)"]
    @State private var selectedFilter: String = "All files, Directories and Unallocated space"
    @State private var exifParser: Bool = false
    
    var body: some View {
        VStack {
            TitleWithIconView(icon: "type_data_source", title: "Case Name", subtitle: "Select Type of Data Source")
            
            MenuView(items: filters, selectedItem: $selectedFilter, fontSize: 13)
            
            List {
                CheckboxView(isChecked: $exifParser, title: "Exif Parser")
            }
            .frame(maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(5)
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            
            Button {
                router.selectedScenario = .caseHome
            } label: {
                BorderedBtnLabelView(title: "Add Data Source")
            }
            
        }
        .padding(.horizontal, 30)
        .customBackground()
        .navigationBarTitle("Add Data Source", displayMode: .inline)
        .navigationBarModifier(backgroundColor: .systemBackground, foregroundColor: .black, tintColor: .black, withSeparator: false)
        
    }
}

#Preview {
    IngestModulesView()
}
