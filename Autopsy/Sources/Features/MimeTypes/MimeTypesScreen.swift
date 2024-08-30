//
//  MimeTypesScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 30/8/24.
//

import SwiftUI
import PopupView

struct MimeTypesScreen: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject var vm: MimeTypesVM
    
    var body: some View {
        
        ZStack {
            List {
                ForEach(vm.mimeTypes) { item in
                    
                    Section {
                        ForEach(item.mimeSubtypes ?? []) { subtype in
                            MimeTypeCell(label: "\(subtype.name ?? "") (\(subtype.count ?? 0))")
                                .onTapGesture {
                                    router.caseHomePath.append(.filesByViewType(.filesByMimeType(subtype.fullName ?? "")))
                                }
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
                        .listRowSeparator(.hidden)
                        
                    } header: {
                        HStack {
                            Text(item.name ?? "")
                                .font(.custom(CFont.graphikSemibold.rawValue, size: 17))
                                .foregroundColor(.textColor)
                                .padding(.bottom, 10)
                            Spacer()
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
                .listRowSeparator(.hidden)
                
            }
            .scrollContentBackground(.hidden)
            
            if vm.loading { LoadingHUDView(loading: $vm.loading) }

        }
        .onAppear {
            vm.getMimeTypes()
        }
        .customBackground()
        .navigationTitle("File Types By MIME Type")
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

struct MimeTypeCell: View {
    
    var label: String
    
    var body: some View {
        
        Color.white
            .frame(height: 50)
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
            .overlay {
                VStack {
                    HStack(spacing: 15) {
                        Image("files")
                            .foregroundColor(.textColor)
                        Text(label)
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

#Preview {
    MimeTypesScreen()
}
