//
//  TitleWithIconView.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 6/8/24.
//

import SwiftUI

struct TitleWithIconView: View {
    
    var icon: String
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
                .padding(.bottom, 10)
            
            Text(title)
                .font(.custom(CFont.graphikSemibold.rawValue, size: 20))
                .foregroundColor(.textColor)
                .textCase(.none)
                .padding(.bottom, 5)
                .multilineTextAlignment(.center)

            Text(subtitle)
                .font(.custom(CFont.graphikLight.rawValue, size: 15))
                .foregroundColor(.textColor)
                .textCase(.none)
                .padding(.bottom, 30)
                .multilineTextAlignment(.center)
        }
    }
}
