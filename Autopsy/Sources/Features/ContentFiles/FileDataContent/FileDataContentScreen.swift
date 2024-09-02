//
//  FileDataContentScreen.swift
//  Autopsy
//
//  Created by mohammad suhail on 1/9/24.
//

import SwiftUI
import PagerTabStripView
import WebKit
import PDFKit

struct FileDataContentScreen: View {
    
    @EnvironmentObject var vm: FileDataContentVM

    @State var selection = 1
    @State var swipeGestureEnabled = true
    
    var id: Int
    
    var body: some View {
        
        ZStack {
            PagerTabStripView(swipeGestureEnabled: $swipeGestureEnabled, selection: $selection) {
                
                TextViewer(fileContent: vm.hexString)
                    .pagerTabItem(tag: 1) {
                        Text("Hex")
                            .font(.custom(CFont.graphikMedium.rawValue, size: 14))
                            .foregroundColor(.textColor)
                            .frame(minWidth: 50)
                    }

                TextViewer(fileContent: vm.textString, isText: true)
                    .pagerTabItem(tag: 2) {
                        Text("Text")
                            .font(.custom(CFont.graphikMedium.rawValue, size: 14))
                            .foregroundColor(.textColor)
                            .frame(minWidth: 50)
                    }
                    

                MetadataViewer(metadata: vm.metadata)
                    .pagerTabItem(tag: 3) {
                        Text("Metadata")
                            .font(.custom(CFont.graphikMedium.rawValue, size: 14))
                            .foregroundColor(.textColor)
                            .frame(minWidth: 80)
                    }
                ApplicationViewer(data: vm.applicationData, fileExtension: vm.metadata.autopsyFileExtension ?? "")
                    .pagerTabItem(tag: 4) {
                        Text("Application")
                            .font(.custom(CFont.graphikMedium.rawValue, size: 14))
                            .foregroundColor(.textColor)
                            .frame(minWidth: 80)
                    }
                    
                FileResultsViewer(results: vm.analysisResult)
                    .pagerTabItem(tag: 5) {
                        Text("Results")
                            .font(.custom(CFont.graphikMedium.rawValue, size: 14))
                            .foregroundColor(.textColor)
                            .frame(minWidth: 80)
                    }

            }
            .pagerTabStripViewStyle(.scrollableBarButton(tabItemSpacing: 10, tabItemHeight: 40, indicatorViewHeight: 3, indicatorView: {
                Rectangle().fill(Color.textColor)
                    .frame(height: 0.8)
                    .cornerRadius(5)
            }))
            .customBackground()
            .onFirstAppear {
                vm.getAllData(fileId: id)
            }
        }
        .customBackground()
    }
}

#Preview {
    FileDataContentScreen(id: 0)
}
