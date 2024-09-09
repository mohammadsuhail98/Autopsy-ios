//
//  FilledIconButtonView.swift
//  Autopsy
//
//  Created by mohammad suhail on 2/8/24.
//

import SwiftUI

struct AutopsyButtonStyle: ButtonStyle {
    var icon: String
    
    @Environment(\.isEnabled) var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(icon)

            configuration.label
                .font(Font.custom(CFont.graphikMedium.rawValue, size: 15))
                .foregroundColor(Color.textColor)
            
        }
        .frame(width: 300, height: 70)
        .background(configuration.isPressed ? Color.gray : Color.white)
        .cornerRadius(5)
        .shadow(color: .shadow, radius: 2, x: 1, y: 1)
    }
}

extension ButtonStyle where Self == AutopsyButtonStyle {
    static func autopsy(icon: String) -> AutopsyButtonStyle {
        return AutopsyButtonStyle(icon: icon)
    }
}
