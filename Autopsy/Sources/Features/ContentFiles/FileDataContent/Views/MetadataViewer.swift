//
//  MetadataViewer.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 2/9/24.
//

import SwiftUI

struct MetadataViewer: View {
    
    var metadata: AutopsyFile
    
    var body: some View {
        ScrollView {
            VStack {
                MetadataCell(label: "Name", value: metadata.path ?? "")
                MetadataCell(label: "Type", value: metadata.type ?? "Unknown")
                MetadataCell(label: "MIME Type", value: metadata.mimeType?.name ?? "Unknown")
                MetadataCell(label: "Extension", value: metadata.autopsyFileExtension ?? "Unknown")
                MetadataCell(label: "Size (Bytes)", value: "\(metadata.size ?? 0)")
                MetadataCell(label: "File Name Allocation", value: metadata.flagsDir ?? "Unknown")
                MetadataCell(label: "Metadata Allocation", value: metadata.flagsMeta ?? "Unknown")
                MetadataCell(label: "Known", value: metadata.flagsMeta ?? "Unknown")
                MetadataCell(label: "Modified", value: metadata.mtime ?? "Unknown")
                MetadataCell(label: "Accessed", value: metadata.atime ?? "Unknown")
                MetadataCell(label: "Created", value: metadata.crTime ?? "Unknown")
                MetadataCell(label: "Changed", value: metadata.ctime ?? "Unknown")
                MetadataCell(label: "MD5", value: metadata.md5Hash ?? "Not Calculated")
                MetadataCell(label: "SHA1", value: metadata.sha1Hash ?? "Not Calculated")
                MetadataCell(label: "SHA256", value: metadata.sha256Hash ?? "Not Calculated")
                MetadataCell(label: "Internal ID", value: "\(metadata.id ?? 0)")
                
                Divider()
                    .padding(.vertical, 20)
                
                Text(metadata.metaDataText?.joined(separator: "\n") ?? "")
                    .font(.custom(CFont.graphikRegular.rawValue, size: 12))
                    .foregroundColor(.textColor)
                
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 30)
        }
        .customBackground()
        .padding(.top, 5)
    }
}

struct MetadataDescriptionCell: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack {
            Text(label)
                .font(.custom(CFont.graphikRegular.rawValue, size: 13))
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.custom(CFont.graphikRegular.rawValue, size: 13))
                .foregroundColor(.textColor)
        }
        .padding(.vertical, 10)
        
    }
}

struct MetadataCell: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.custom(CFont.graphikRegular.rawValue, size: 14))
                .foregroundColor(.textColor)
        }
        .padding(.vertical, 5)
        
    }
}
