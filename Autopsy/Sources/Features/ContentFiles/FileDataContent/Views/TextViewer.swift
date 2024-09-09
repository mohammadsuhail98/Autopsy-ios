//
//  TextViewer.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 2/9/24.
//

import SwiftUI

struct TextViewer: View {

    var fileContent: String = ""
    var isText: Bool = false
    
    var totalPages: Int {
        let totalLines = fileContent.components(separatedBy: .newlines).count
        return (totalLines + linesPerPage - 1) / linesPerPage
    }
    
    @State private var currentPage: Int = 0
    @State private var jumpToPage: String = ""
    private let linesPerPage: Int = 300

    var body: some View {
        VStack {
            if fileContent.isEmpty {
                Spacer()
                VStack {
                    Image(systemName: "circle.slash")
                        .font(.system(size: 40, design: .monospaced))
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    Text("No Content in this Page")
                        .font(.custom(CFont.graphikRegular.rawValue, size: 13))
                        .foregroundColor(.textColor)
                }
                .frame(maxWidth: .infinity)
                Spacer()
            } else {
                HStack {
                    
                    Button {
                        shareTextFile(text: fileContent)
                    } label: {
                        Text("Share")
                            .font(.custom(CFont.graphikMedium.rawValue, size: 13))
                            .foregroundColor(.textColor)
                    }
                    .padding(.leading, 10)
                    
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
                             .font(.system(size: isText ? 10 : 8, design: .monospaced))
                             .frame(maxWidth: .infinity, alignment: .leading)
                             .lineSpacing(1)
                             .textSelection(.enabled)
                     }
                     .padding(.horizontal, 5)
                 }
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
    
    func shareTextFile(text: String) {
        let textData = text.data(using: .utf8)!
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(isText ? "textFile.txt" : "hexFile.hex")
        
        do {
            try textData.write(to: tempURL)
            let activityVC = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
            if let topController = UIApplication.shared.windows.first?.rootViewController {
                topController.present(activityVC, animated: true, completion: nil)
            }
        } catch {
            print("Failed to write text to file: \(error)")
        }
    }
    
}
