//
//  AnalysisResultsFilesScreen.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/8/24.
//

import SwiftUI
import PopupView

struct AnalysisResultsFilesScreen: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var vm: AnalysisResultsFilesVM
    
    @State var type: AnalysisResultType?
    
    var body: some View {
        ZStack {
            List {
                ForEach(vm.files) { item in
                    AnalysisResultFileCell(image: vm.typeImage, item: item)
                        .onTapGesture {
                            let path = CaseHomePath.contentTabBar(item, [], item.name ?? "")
                            router.caseHomePath.append(path)
                        }
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .onAppear {
                vm.selectedType = type?.id ?? 0
                vm.getFilesByType()
            }
            
            if vm.loading { LoadingHUDView(loading: $vm.loading) }
            
        }
        .customBackground()
        .navigationTitle(type?.name ?? "")
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

struct AnalysisResultFileCell: View {
    
    var image: String
    var item: AutopsyFile
    
    var body: some View {
        
        Color.white
            .frame(height: 50)
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
            .overlay {
                VStack {
                    HStack(spacing: 15) {
                        Image(image)
                            .foregroundColor(.textColor)
                        Text(item.name ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom(CFont.graphikRegular.rawValue, size: 13))
                            .foregroundColor(.textColor)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.textColor)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .contentShape(Rectangle())
    }
}
