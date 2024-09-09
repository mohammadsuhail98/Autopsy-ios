//
//  ContentFileInfoScreen.swift
//  Autopsy
//
//  Created by mohammad suhail on 31/8/24.
//

import SwiftUI

struct ContentFileInfoScreen: View {
    
    var autopsyFile: AutopsyFile
    
    var body: some View {
        List {
            if autopsyFile.volume ?? false {
                ContentFileInfoCell(title: "ID", value: "\(autopsyFile.id ?? 0)")
                ContentFileInfoCell(title: "Starting Sector", value: "\(autopsyFile.volumeInfo?.startingSector ?? 0)")
                ContentFileInfoCell(title: "Length in Sectors", value: "\(autopsyFile.volumeInfo?.lengthInSectors ?? 0)")
                ContentFileInfoCell(title: "Description", value: autopsyFile.volumeInfo?.description ?? "")
                ContentFileInfoCell(title: "Flags", value: autopsyFile.volumeInfo?.flags ?? "")
            } else {
                ContentFileInfoCell(title: "Modified Time", value: autopsyFile.mtime ?? "")
                ContentFileInfoCell(title: "Change Time", value: autopsyFile.ctime ?? "")
                ContentFileInfoCell(title: "Access Time", value: autopsyFile.atime ?? "")
                ContentFileInfoCell(title: "Access Time", value: autopsyFile.atime ?? "")
                ContentFileInfoCell(title: "Size", value: "\(autopsyFile.size ?? 0)")
                ContentFileInfoCell(title: "Flags (Dir)", value: autopsyFile.flagsDir ?? "")
                ContentFileInfoCell(title: "Flags (Meta)", value: autopsyFile.flagsMeta ?? "")
                ContentFileInfoCell(title: "Known", value: autopsyFile.known ?? "")
                ContentFileInfoCell(title: "MD5 Hash", value: autopsyFile.md5Hash ?? "")
                ContentFileInfoCell(title: "SHA1 Hash", value: autopsyFile.sha1Hash ?? "")
                ContentFileInfoCell(title: "SHA256 Hash", value: autopsyFile.sha256Hash ?? "")
                ContentFileInfoCell(title: "MIME Type", value: autopsyFile.mimeType?.name ?? "")
                ContentFileInfoCell(title: "Extension", value: autopsyFile.autopsyFileExtension ?? "")
                ContentFileInfoCell(title: "Location", value: autopsyFile.path ?? "")
            }
        }
        .frame(maxWidth: .infinity)
        .customBackground()
        .scrollIndicators(.hidden)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

struct ContentFileInfoCell: View {
    
    var title: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                    .foregroundColor(.textColor)

                Text(value)
                    .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                    .foregroundColor(.gray)
                    .textSelection(.enabled)
            }
            .padding(.bottom, 10)
            
            Divider()
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .padding(.horizontal, 10)
    }
}

#Preview {
    ContentFileInfoScreen(autopsyFile: AutopsyFile(mtime: "2020-32-32 T 43:43 CET", ctime: "2020-32-32 T 43:43 CET"))
}
