//
//  DataSourceContentScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 22/8/24.
//

import SwiftUI
import PopupView

struct DSContentScreen: View {
    
    @EnvironmentObject var vm: DSContentVM
    @EnvironmentObject var router: Router
    var dataSource: DataSource
    
    var body: some View {
        ZStack {
            List {
                ForEach(vm.items) { item in
                    DSContentHStackLabel(item: item)
                        .onTapGesture {
                            var title = "Files"
                            if let name = item.name {
                                title = name.isEmpty ? item.path ?? "" : name
                            }
                            let path = CaseHomePath.contentTabBar(vm.getFileInfo(for: item), item.children ?? [], title)
                            router.caseHomePath.append(path)
                        }
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
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
            
            if vm.loading { LoadingHUDView(loading: $vm.loading) }

        }
        .navigationTitle("Item Name")
        .navigationBarTitleDisplayMode(.inline)
        .customBackground()
        .onAppear {
            vm.getFiles(for: dataSource.id)
        }
    }
        
}

struct DSContentHStackLabel: View {
    
    var item: AutopsyFile
    
    var body: some View {
        
        Color.white
            .frame(height: 50)
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
            .overlay {
                VStack {
                    HStack() {
                        Image("folder")
                            .foregroundColor(.textColor)
                            .padding(.trailing, 5)
                        Text(((item.path?.isEmpty != nil) ? item.path ?? "" : item.name) ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                            .foregroundColor(.textColor)
                        Spacer()
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
    DSContentScreen(dataSource: DataSource())
}
