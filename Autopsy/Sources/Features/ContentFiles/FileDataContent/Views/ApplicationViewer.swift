//
//  ApplicationViewer.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 2/9/24.
//

import SwiftUI
import UIKit
import PDFKit

struct ApplicationViewer: View {
    
    var data: Data
    var fileExtension: String
    
    var body: some View {
        VStack {
            if !data.isEmpty {
                if FileExtensions.imageExtensions.contains("." + fileExtension) {
                    if let uiimage = UIImage(data: data) {
                        Image(uiImage: uiimage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                } else if FileExtensions.pdfExtensions.contains("." + fileExtension) {
                    PDFView(file: data)
                } else {
                    Spacer()
                    VStack {
                        Image(systemName: "circle.slash")
                            .font(.system(size: 40, design: .monospaced))
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)
                        Text("Media not Supported!")
                            .font(.custom(CFont.graphikRegular.rawValue, size: 13))
                            .foregroundColor(.textColor)
                    }
                    .frame(maxWidth: .infinity)
                    Spacer()
                }
            } else {
                Spacer()
                VStack {
                    Image(systemName: "circle.slash")
                        .font(.system(size: 40, design: .monospaced))
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    Text("No Content")
                        .font(.custom(CFont.graphikRegular.rawValue, size: 13))
                        .foregroundColor(.textColor)
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }

            
        }
        .frame(maxWidth: .infinity, maxHeight: 500)
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
