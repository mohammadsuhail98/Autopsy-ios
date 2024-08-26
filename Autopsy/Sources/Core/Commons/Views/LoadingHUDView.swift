//
//  LoadingHUDView.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 26/8/24.
//

import SwiftUI
import ActivityIndicatorView

struct LoadingHUDView: View {
    @Binding var loading: Bool
    
    var body: some View {
        Color(.black)
            .ignoresSafeArea()
            .opacity(0.4)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        ZStack {
            Color(.white)
                .opacity(loading ? 0.7 : 0)
                .blur(radius: 1)
            
            VStack {
                ActivityIndicatorView(isVisible: $loading, type: .growingArc(Color.themeBlue, lineWidth: 4))
                    .frame(width: 30, height: 30)
                    .foregroundColor(.themeBlue)
                Text("Loading")
                    .padding(.top, 10)
            }
        }
        .frame(width: 120, height: 120)
        .foregroundColor(Color.textColor)
        .cornerRadius(10)
    }
}
