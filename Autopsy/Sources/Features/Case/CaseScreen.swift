//
//  CaseDetailsScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 20/8/24.
//

import SwiftUI
import PopupView

struct CaseScreen: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var vm: CaseVM
    @State var showDeleteCase: Bool = false
    
    var body: some View {
        ZStack {
            List {
                
                Section {
                    CaseOptionRow(icon: "case_details", title: "Case Details", action: {
                        router.caseHomePath.append(.caseDetails)
                    })
                    
                    CaseOptionRow(icon: "new_case", title: "New Case", action: {
                        router.caseHomePath.append(.newCase)
                    })
                }
                
                Section {
                    
                    CaseOptionRow(icon: "geolocation", title: "Geolocation", action: {
                        router.caseHomePath.append(.geolocation)
                    })
                }
                
                Section {
                    
                    CaseOptionRow(icon: "add", title: "Add Data Source", action: {
                        router.caseHomePath.append(.addDataSourceType)
                    }, iconWidth: 20, iconHeight: 20)
                }
                
                Section {

                    CaseOptionRow(icon: "confirm_delete", title: "Delete Case", action: {
                        showDeleteCase = true
                    }, iconWidth: 20, iconHeight: 22)
                    
                    
                    CaseOptionRow(icon: "close", title: "Close Case", action: {
                        
                        router.caseCreationPath.removeAll()
                        router.selectedScenario = .caseCreation
                        
                    }, iconWidth: 15, iconHeight: 15)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.background)
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
            .popup(isPresented: $showDeleteCase) {
                DeleteCasePopup(isPresented: $showDeleteCase) {
                    vm.deleteCase {
                        router.caseCreationPath.removeAll()
                        router.selectedScenario = .caseCreation
                    }
                }
            } customize: { $0
                    .type(.floater())
                    .position(.center)
                    .closeOnTap(false)
                    .backgroundColor(.black.opacity(0.4))
            }
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
    }
}

struct DeleteCasePopup: View {
    
    @Binding var isPresented: Bool
    var completion: (() -> Void)
    
    var body: some View {
        VStack(spacing: 12) {
            
            VStack {
                Image("confirm_delete")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 80, maxHeight: 80)
                    .padding(.bottom, 12)

                Text("You are about to delete your case")
                    .font(.custom(CFont.graphikSemibold.rawValue, size: 14))
                    .foregroundColor(.textColor)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 3)
                
                Text("This will delete the case permanently, are you sure?")
                    .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 12)
            }

            HStack {
                Spacer()
                
                Button {
                    isPresented = false
                } label: {
                    Text("Cancel")
                        .font(.custom(CFont.graphikMedium.rawValue, size: 14))
                        .frame(maxWidth: 120, alignment: .trailing)
                        .foregroundColor(.gray)
                        .frame(height: 1)
                        .padding(.vertical, 18)
                        .padding(.trailing, 5)
                }

                Button {
                    isPresented = false
                    completion()
                } label: {
                    Text("Delete")
                        .font(.custom(CFont.graphikSemibold.rawValue, size: 14))
                        .frame(maxWidth: 120)
                        .frame(height: 0)
                        .padding(.vertical, 18)
                        .foregroundColor(.white)
                        .background(Color(hex: 0xf4644c))
                        .cornerRadius(5)
                }
                .shadow(color: .shadow, radius: 2, x: 1, y: 1)
                
            }
            
        }
        .padding(EdgeInsets(top: 37, leading: 24, bottom: 25, trailing: 24))
        .background(Color.white.cornerRadius(5))
        .padding(.horizontal, 30)
    }
}

struct CaseOptionRow: View {
    let icon: String
    let title: String
    var action: () -> Void
    var iconWidth: CGFloat = 25
    var iconHeight: CGFloat = 25
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconWidth, height: iconHeight)
                Text(title)
                    .font(.custom(CFont.graphikRegular.rawValue, size: 15))
                    .foregroundColor(.textColor)
                    .padding(.leading, 8)
            }
        }
        
    }
}

#Preview {
    CaseScreen()
}
