//
//  CaseDetailsScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 20/8/24.
//

import SwiftUI

struct CaseScreen: View {
    @EnvironmentObject private var router: Router
    
    var body: some View {
        

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
                
                CaseOptionRow(icon: "open_case", title: "Open Case", action: {
                    
                })
            }
            
            Section {
                
                CaseOptionRow(icon: "add", title: "Add Data Source", action: {
                    router.caseHomePath.append(.addDataSourceType)
                }, iconWidth: 20, iconHeight: 20)
            }
            
            Section {

                CaseOptionRow(icon: "confirm_delete", title: "Delete Case", action: {

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
