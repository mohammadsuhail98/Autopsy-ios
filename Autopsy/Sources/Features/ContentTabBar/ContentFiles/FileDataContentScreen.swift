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
                    .onFirstAppear {
                        vm.getHexData(fileId: id)
                    }
                
                TextViewer(fileContent: vm.textString)
                    .pagerTabItem(tag: 2) {
                        Text("Text")
                            .font(.custom(CFont.graphikMedium.rawValue, size: 14))
                            .foregroundColor(.textColor)
                            .frame(minWidth: 50)
                    }
                    .onFirstAppear {
                        vm.getTextData(fileId: id)
                    }
                
                Text("Hello 3")
                    .pagerTabItem(tag: 3) {
                        Text("Metadata")
                            .font(.custom(CFont.graphikMedium.rawValue, size: 14))
                            .foregroundColor(.textColor)
                            .frame(minWidth: 80)
                    }
                Text("Hello 4")
                    .pagerTabItem(tag: 4) {
                        Text("Application")
                            .font(.custom(CFont.graphikMedium.rawValue, size: 14))
                            .foregroundColor(.textColor)
                            .frame(minWidth: 80)
                    }
                    
                Text("Hello 5")
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
            
        }
        .customBackground()
    }
}

struct TextViewer: View {
        
    private let linesPerPage: Int = 300

    var fileContent: String = ""
    
    var totalPages: Int {
        let totalLines = fileContent.components(separatedBy: .newlines).count
        return (totalLines + linesPerPage - 1) / linesPerPage
    }
    
    @State private var currentPage: Int = 0
    @State private var jumpToPage: String = ""

    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                HStack {
                    TextField("Page", text: $jumpToPage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .frame(width: 50)
                        .font(.custom(CFont.graphikRegular.rawValue, size: 13))
                        .foregroundColor(.textColor)
                    
                    Button {
                        jumpToPageNumber()
                    } label: {
                        Text("Jump")
                            .frame(width: 40)
                            .font(.custom(CFont.graphikSemibold.rawValue, size: 14))
                            .foregroundColor(jumpToPage.isEmpty || !isValidPageNumber() ? .gray : .textColor)
                    }
                    .disabled(jumpToPage.isEmpty || !isValidPageNumber())
                    
                }
                .padding(.horizontal)
                
                Button(action: previousPage) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(currentPage == 0 ? .gray : .textColor)
                }
                .disabled(currentPage == 0)
                                
                Text("\(currentPage + 1) / \(totalPages)")
                    .font(.custom(CFont.graphikMedium.rawValue, size: 14))
                    .foregroundColor(.textColor)
                
                Button(action: nextPage) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(((currentPage + 1) * linesPerPage >= fileContent.components(separatedBy: .newlines).count) ? .gray : .textColor)
                }
                .disabled((currentPage + 1) * linesPerPage >= fileContent.components(separatedBy: .newlines).count)
            }
            .padding(.leading, 10)
            .padding(.trailing, 20)
            .padding(.bottom, 5)

            ScrollView {
                 VStack {
                     Text(getPageContent())
                         .font(.system(size: 8, design: .monospaced))
                         .frame(maxWidth: .infinity, alignment: .leading)
                         .lineSpacing(1)
                         .textSelection(.enabled)
                 }
                 .padding(.horizontal, 5)
             }
        }
        .padding(.top, 5)

    }
    
    private func getPageContent() -> String {
        let lines = fileContent.components(separatedBy: .newlines)
        let start = currentPage * linesPerPage
        let end = min(start + linesPerPage, lines.count)
        let pageLines = lines[start..<end]
        return pageLines.joined(separator: "\n")
    }
    
    private func nextPage() {
        currentPage += 1
    }
    
    private func previousPage() {
        if currentPage > 0 {
            currentPage -= 1
        }
    }
    
    private func jumpToPageNumber() {
        if let page = Int(jumpToPage), page > 0, page <= totalPages {
            currentPage = page - 1
        }
    }
    
    private func isValidPageNumber() -> Bool {
        if let page = Int(jumpToPage), page > 0, page <= totalPages {
            return true
        }
        return false
    }
    
}

struct PDFView: UIViewRepresentable {
    let file: Data
   
    func makeUIView(context: UIViewRepresentableContext<PDFView>) -> PDFKit.PDFView {
        let pdfView = PDFKit.PDFView()
        DispatchQueue.main.async {
            pdfView.document = PDFDocument(data: file)
        }
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFKit.PDFView, context: UIViewRepresentableContext<PDFView>) {
        DispatchQueue.main.async {
            uiView.document = PDFDocument(data: file)
        }
    }
}

#Preview {
    FileDataContentScreen(id: 0)
}
