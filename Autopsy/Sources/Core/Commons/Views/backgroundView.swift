//
//  BackgroundView.swift
//  Autopsy
//
//  Created by mohammad suhail on 2/8/24.
//

import SwiftUI

struct backgroundView: View {
    var body: some View {
        Color.background
            .ignoresSafeArea()
    }
}

struct backgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            content
        }
    }
}
