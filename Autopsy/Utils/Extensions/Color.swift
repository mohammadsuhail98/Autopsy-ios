//
//  Color.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/7/24.
//

import Foundation
import SwiftUI

extension Color {
    
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
    
    public static var background: Color {
        return Color(hex: 0xFAFAFA)
    }
    
    public static var cellBackground: Color {
        return Color(hex: 0xFAFAFA)
    }
    
    public static var textColor: Color {
        return Color(hex: 0x262626)
    }
    
    public static var shadow: Color {
        return Color(hex: 0x000000, opacity: 0.15)
    }
    
}
