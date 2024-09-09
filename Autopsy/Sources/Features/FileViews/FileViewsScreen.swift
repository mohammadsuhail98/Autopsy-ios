//
//  FileViewsScreen.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 30/8/24.
//

import SwiftUI

struct FileViewsScreen: View {
    
    @EnvironmentObject private var router: Router

    var body: some View {
        
        List {
            
            Section {
                FileViewCell(viewType: .filesByExtension)
                    .onTapGesture {
                        router.caseHomePath.append(.filesByExtension)
                    }
                FileViewCell(viewType: .filesByMimeType(""))
                    .onTapGesture {
                        router.caseHomePath.append(.mimeTypes)
                    }
            } header: {
                HStack {
                    Text("File Types")
                        .font(.custom(CFont.graphikSemibold.rawValue, size: 17))
                        .foregroundColor(.textColor)
                        .padding(.bottom, 10)
                    Spacer()
                }
            }
            
            Section {
                FileViewCell(viewType: .deletedFilesFileSystem)
                    .onTapGesture {
                        router.caseHomePath.append(.filesByViewType(.deletedFilesFileSystem))
                    }
                
                FileViewCell(viewType: .deletedFilesAll)
                    .onTapGesture {
                        router.caseHomePath.append(.filesByViewType(.deletedFilesAll))
                    }
            } header: {
                HStack {
                    Text("Deleted Files")
                        .font(.custom(CFont.graphikSemibold.rawValue, size: 17))
                        .foregroundColor(.textColor)
                        .padding(.bottom, 10)
                    Spacer()
                }
            }
            
            Section {
                FileViewCell(viewType: .fileSizeMB50To200)
                    .onTapGesture {
                        router.caseHomePath.append(.filesByViewType(.fileSizeMB50To200))
                    }
                
                FileViewCell(viewType: .fileSizeMB200To1GB)
                    .onTapGesture {
                        router.caseHomePath.append(.filesByViewType(.fileSizeMB200To1GB))
                    }
                
                FileViewCell(viewType: .fileSizeMB1GBPlus)
                    .onTapGesture {
                        router.caseHomePath.append(.filesByViewType(.fileSizeMB1GBPlus))
                    }
            } header: {
                HStack {
                    Text("File Size")
                        .font(.custom(CFont.graphikSemibold.rawValue, size: 17))
                        .foregroundColor(.textColor)
                        .padding(.bottom, 10)
                    Spacer()
                }
            }
            
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .customBackground()
    }
}

struct FileViewCell: View {
    
    var viewType: FileViewType
    
    var body: some View {
        
        Color.white
            .frame(height: 50)
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
            .overlay {
                VStack {
                    HStack(spacing: 15) {
                        Image(viewType.image)
                            .foregroundColor(.textColor)
                        Text(viewType.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                            .foregroundColor(.textColor)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.textColor)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .listRowInsets(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
            .listRowSeparator(.hidden)
            .listRowBackground(Color.background)
            .contentShape(Rectangle())
    }
}

#Preview {
    FileViewsScreen()
}
