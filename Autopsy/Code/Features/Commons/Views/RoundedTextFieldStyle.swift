//
//  RoundedTextFieldStyle.swift
//  Autopsy
//
//  Created by mohammad suhail on 2/8/24.
//

import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical)
            .padding(.horizontal, 24)
            .background(
                Color(UIColor.textFieldBackgroud)
            )
            .cornerRadius(5)
    }
}
