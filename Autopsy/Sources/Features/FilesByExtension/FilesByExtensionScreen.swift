//
//  FilesByExtensionScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 30/8/24.
//

import SwiftUI

struct FilesByExtensionScreen: View {
    
    @EnvironmentObject private var router: Router

    var body: some View {
        List {
            Section {
                FileViewCell(viewType: .images).onTapGesture { addToRouter(.images) }
                FileViewCell(viewType: .videos).onTapGesture { addToRouter(.videos) }
                FileViewCell(viewType: .audio).onTapGesture { addToRouter(.audio) }
                FileViewCell(viewType: .archives).onTapGesture { addToRouter(.archives) }
                FileViewCell(viewType: .databases).onTapGesture { addToRouter(.databases) }
            }
            
            Section {
                FileViewCell(viewType: .documentsHTML).onTapGesture { addToRouter(.documentsHTML) }
                FileViewCell(viewType: .documentsOffice).onTapGesture { addToRouter(.documentsOffice) }
                FileViewCell(viewType: .documentsPDF).onTapGesture { addToRouter(.documentsPDF) }
                FileViewCell(viewType: .documentsPlainText).onTapGesture { addToRouter(.documentsPlainText) }
            } header: {
                HStack {
                    Text("Documents")
                        .font(.custom(CFont.graphikSemibold.rawValue, size: 17))
                        .foregroundColor(.textColor)
                        .padding(.bottom, 10)
                    Spacer()
                }
            }
            
            Section {
                FileViewCell(viewType: .executableEXE).onTapGesture { addToRouter(.executableEXE) }
            } header: {
                HStack {
                    Text("Executables")
                        .font(.custom(CFont.graphikSemibold.rawValue, size: 17))
                        .foregroundColor(.textColor)
                        .padding(.bottom, 10)
                    Spacer()
                }
            }
            
        }
        .navigationTitle("File Types By Extension")
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .customBackground()
    }
    
    func addToRouter(_ type: FileViewType){
        router.caseHomePath.append(.filesByViewType(type))
    }
    
}

#Preview {
    FilesByExtensionScreen()
}
