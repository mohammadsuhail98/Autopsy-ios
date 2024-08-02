//
//  FilledIconButtonView.swift
//  Autopsy
//
//  Created by mohammad suhail on 2/8/24.
//

import SwiftUI

struct FilledIconButtonView: View {
    var title: String
    var image: String
    
    var body: some View {
        Label(title, image: image)
            .font(Font.custom(CFont.graphikMedium.rawValue, size: 15))
            .frame(width: 300, height: 70)
            .background(Color.white)
            .foregroundColor(Color.textColor)
            .cornerRadius(5)
            .shadow(color: .shadow, radius: 2, x: 1, y: 1)
    }
}
