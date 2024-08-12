//
//  AddDataSourceTypeView.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 5/8/24.
//

import SwiftUI

struct AddDataSourceTypeView: View {
    
    @EnvironmentObject private var router: Router

    var body: some View {
        ScrollView {
            VStack() {
                TitleWithIconView(icon: "type_data_source", title: "Case Name", subtitle: "Select Type of Data Source")
                
                Button {
                    router.caseCreationPath.append(.addDataSource)
                } label: {
                    DataSourceLabelView(title: "Disk Image or VM File")
                        .padding(.horizontal)
                }
                
            }
            .padding(.top, 50)
        }
        .customBackground()
        .navigationBarTitle("Add Data Source", displayMode: .inline)
        .navigationBarModifier(backgroundColor: .systemBackground, foregroundColor: .black, tintColor: .black, withSeparator: false)
    }
}

struct DataSourceLabelView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.custom(CFont.graphikSemibold.rawValue, size: 15))
            .foregroundColor(.textColor)
            .frame(maxWidth: .infinity)
            .frame(height: 70)
            .background(Color.white)
            .cornerRadius(5)
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
    }
}

#Preview {
    AddDataSourceTypeView()
}

