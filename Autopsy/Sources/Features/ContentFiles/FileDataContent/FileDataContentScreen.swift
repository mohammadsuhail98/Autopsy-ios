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
    @State var selectionArr = [1]

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
                vm.getHexData(fileId: id)
            }
            .onChange(of: selection) { newSelection in
                if newSelection == 1 {
                    if vm.hexFailed { vm.getHexData(fileId: id) }
                } else if newSelection == 2 {
                    if !selectionArr.contains(newSelection) {
                        selectionArr.append(newSelection)
                        vm.getTextData(fileId: id)
                    }
                    if vm.textFailed { vm.getTextData(fileId: id) }
                    
                } else if newSelection == 3 {
                    if !selectionArr.contains(newSelection) {
                        selectionArr.append(newSelection)
                        vm.getMetadata(fileId: id)
                    }
                    if vm.metadataFailed { vm.getMetadata(fileId: id) }
                    
                } else if newSelection == 4 {
                    if !selectionArr.contains(newSelection) {
                        selectionArr.append(newSelection)
                        vm.getApplicationData(fileId: id)
                    }
                    if vm.applicationFailed { vm.getApplicationData(fileId: id) }

                } else if newSelection == 5 {
                    if !selectionArr.contains(newSelection) {
                        selectionArr.append(newSelection)
                        vm.getAnalysisResults(fileId: id)
                    }
                    if vm.resultsFailed { vm.getAnalysisResults(fileId: id) }
                    
                }
            }
            
            if vm.loading { LoadingHUDView(loading: $vm.loading) }

        }
        .customBackground()
    }
}
