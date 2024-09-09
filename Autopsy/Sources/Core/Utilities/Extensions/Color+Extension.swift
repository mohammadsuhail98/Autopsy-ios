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
    
    public static var textFieldBackground: Color {
        return Color(hex: 0xefefef)
    }
    
    public static var themeBlue: Color {
        return Color(hex: 0x0f7aff)
    }
    
    public static var themeRed: Color {
        return Color(hex: 0xF05A3F)
    }
    
    public static var themeGray: Color {
        return Color(hex: 0x8D8D8D)
    }
    
}

extension UIColor {
    public static var textFieldBackgroud: UIColor {
        return UIColor(_colorLiteralRed: 239/255, green: 239/255, blue: 239/255, alpha: 1)
    }
    
    public static var themeBackgroud: UIColor {
        return UIColor(_colorLiteralRed: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    }
}
