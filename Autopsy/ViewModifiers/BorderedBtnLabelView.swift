//
//  File.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 5/8/24.
//

import SwiftUI

struct BorderedBtnLabelView: View {
    
    var title: String
    var width: CGFloat = UIScreen.screenWidth - 75
    var height: CGFloat = 50
    
    var body: some View {
        Text(title)
            .frame(width: width, height: height)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.themeBlue, lineWidth: 2)
            )
            .foregroundColor(Color.themeBlue)
            .font(.custom(CFont.graphikMedium.rawValue, size: 15))
    }
}
