//
//  IngestModulesView.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 8/8/24.
//

import SwiftUI
import PopupView

struct IngestModulesView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var vm: AddDataSourceVM
    
    var body: some View {
        ZStack {
            VStack {
                TitleWithIconView(icon: "type_data_source", title: "Case Name", subtitle: "Select Type of Data Source")
                
                MenuView(items: vm.filters, selectedItem: $vm.selectedFilter, fontSize: 13)
                
                List {
                    CheckboxView(isChecked: $vm.exifParser, title: "Exif Parser")
                }
                .frame(maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: .shadow, radius: 2, x: 1, y: 1)
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                
                Button {
                    vm.addDataSource {
                        router.selectedScenario == .caseCreation ? router.selectedScenario = .caseHome : router.caseHomePath.append(.dataSourceList)
                    } errorBlock: {
                        
                    }
                    
                } label: {
                    BorderedBtnLabelView(title: "Add Data Source")
                }
            }
            .padding(.horizontal, 30)

            if vm.loading { LoadingHUDView(loading: $vm.loading) }

        }
        .customBackground()
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

#Preview {
    IngestModulesView()
}
