//
//  FilesByTypeScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 30/8/24.
//

import SwiftUI
import PopupView

struct FilesByTypeScreen: View {
    
    @EnvironmentObject var vm: FilesByTypeVM
    
    @State var type: FileViewType?
    
    var body: some View {
        ZStack {
            
            if vm.shoudShowEmptyState {
                NoFilesView()
            } else {
                List {
                    ForEach(vm.files) { item in
                        FileByTypeCell(image: type?.image ?? "", item: item)
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            
            if vm.loading { LoadingHUDView(loading: $vm.loading) }
            
        }
        .customBackground()
        .navigationTitle(type?.title ?? "")
        .popup(isPresented: $vm.showErrorPopup) {
            ErrorToastView(msg: vm.errMsg)
        } customize: { $0
            .type(.floater())
            .position(.bottom)
            .animation(.spring())
            .closeOnTapOutside(true)
            .autohideIn(2)
        }
        .onAppear {
            vm.selectedType = type
            vm.getFiles()
        }
        
    }
}

struct FileByTypeCell: View {
    
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
    }
}

struct NoFilesView: View {
    var body: some View {
        Spacer()
        
        VStack {
            Image("no_files")
            
            Text("No Files")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.custom(CFont.graphikSemibold.rawValue, size: 15))
                .foregroundColor(.textColor)
                .padding(.vertical, 10)
            
            Text("There are no files with this view type!")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.custom(CFont.graphikRegular.rawValue, size: 15))
                .foregroundColor(.textColor)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 50)
        
        Spacer()
    }
}


#Preview {
    FilesByTypeScreen()
}
