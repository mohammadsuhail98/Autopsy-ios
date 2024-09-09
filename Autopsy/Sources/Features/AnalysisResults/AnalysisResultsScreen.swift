//
//  AnalysisResultsScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 29/8/24.
//

import SwiftUI
import PopupView

struct AnalysisResultsScreen: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var vm: AnalysisResultsVM
    
    var body: some View {
        ZStack {
            List {
                ForEach(vm.types) { item in
                    AnalysisResultTypeHStackLabel(item: item)
                        .onTapGesture {
                            router.caseHomePath.append(.analysisResultsFiles(item))
                        }
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .customBackground()
            .onAppear {
                if vm.types.isEmpty {
                    vm.getTypes()
                }
            }
            .refreshable {
                vm.getTypes()
            }
            
            if vm.loading { LoadingHUDView(loading: $vm.loading) }
        }
        .customBackground()
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

struct AnalysisResultTypeHStackLabel: View {
    
    var item: AnalysisResultType
    
    var body: some View {
        
        Color.white
            .frame(height: 50)
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
            .overlay {
                VStack {
                    HStack(spacing: 15) {
                        Image(item.image)
                            .foregroundColor(.textColor)
                        Text(item.name ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom(CFont.graphikRegular.rawValue, size: 14))
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


#Preview {
    AnalysisResultsScreen()
}
