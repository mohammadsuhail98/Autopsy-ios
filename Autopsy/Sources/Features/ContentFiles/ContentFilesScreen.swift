//
//  ContentFilesScreen.swift
//  Autopsy
//
//  Created by mohammad suhail on 31/8/24.
//

import SwiftUI

struct ContentFilesScreen: View {
    
    @EnvironmentObject var router: Router
    var contentFiles: AutopsyFiles
    
    var body: some View {
        List {
            ForEach(Utils.sortFilesByChildrenFirst(files: contentFiles)) { item in
                ContentFileCell(item: item)
                    .onTapGesture {
                        var title = "Files"
                        if let name = item.name {
                            title = name.isEmpty ? item.path ?? "" : name
                        }
                        let path = CaseHomePath.contentTabBar(Utils.getFileInfo(for: item), item.children ?? [], title)
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
    }
}

struct ContentFileCell: View {
    
    var item: AutopsyFile
    
    var body: some View {
        
        Color.white
            .frame(height: 50)
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
            .overlay {
                VStack {
                    HStack() {
                        Image(Utils.getImageName(isEmpty: item.children?.isEmpty,
                                                 autopsyFileExtension: item.autopsyFileExtension,
                                                 deleted: item.deleted,
                                                 virtual: item.virtual))
                            .foregroundColor(.textColor)
                            .padding(.trailing, 5)
                        Text((item.name ?? "" == "") ? item.path ?? "" : item.name ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                            .foregroundColor(.textColor)
                        Spacer()
                        if item.children?.count ?? 0 != 0 {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.textColor)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .contentShape(Rectangle())
    }
}

#Preview {
    ContentFilesScreen(contentFiles: AutopsyFiles())
}
