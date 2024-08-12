//
//  AutopsyApp.swift
//  Autopsy
//
//  Created by mohammad suhail on 29/7/24.
//

import SwiftUI

@main
struct AutopsyApp: App {
    @UIApplicationDelegateAdaptor(AutopsyAppAppDelegate.self) var appDelegate
    
    @StateObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environment(\.mainVM, MainVM())
                .environmentObject(router)
        }
    }
}
