//
//  ActivityIndicatorModifier.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 26/8/24.
//

import SwiftUI

struct ActivityIndicatorModifier: AnimatableModifier {
    @Binding var isLoading: Bool

    var animatableData: Bool {
        get { isLoading }
        set { isLoading = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            if isLoading {
                
                ZStack(alignment: .center) {
                    content
                    LoadingHUDView(loading: $isLoading)
                }
            } else {
                content
            }
        }
    }
}
