//
//  View.swift
//  Autopsy
//
//  Created by Mohammed Suhail Najm Kanaan on 7/8/24.
//

import SwiftUI
import UIKit

extension View {
    func navigationBarModifier(backgroundColor: UIColor = .systemBackground, foregroundColor: UIColor = .label, tintColor: UIColor?, withSeparator: Bool) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor, tintColor: tintColor, withSeparator: withSeparator))
    }
    
    func customBackground() -> some View {
        self.modifier(backgroundViewModifier())
    }
}
