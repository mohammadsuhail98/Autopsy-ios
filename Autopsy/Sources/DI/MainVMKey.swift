//
//  MainVMKey.swift
//  Autopsy
//
//  Created by mohammad suhail on 9/8/24.
//

import Foundation
import SwiftUI

struct MainVMKey: EnvironmentKey {
    static let defaultValue = MainVM()
}

extension EnvironmentValues {
    var mainVM: MainVM {
        get { self[MainVMKey.self] }
        set { self[MainVMKey.self] = newValue }
    }
}
