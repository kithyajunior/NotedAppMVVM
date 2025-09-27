//
//  DemoNotedAppMVVMApp.swift
//  DemoNotedAppMVVM
//
//  Created by Meang Atithkithya on 25/9/25.
//

import SwiftUI

@main
struct DemoNotedAppMVVMApp: App {
    let coreDataManager = DemoNotedAppCoreDataManager()
    @StateObject var notesViewModel: DemoNotedAppViewModel

        init() {
            let viewModel = DemoNotedAppViewModel(manager: coreDataManager)
            _notesViewModel = StateObject(wrappedValue: viewModel)
        }

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notesViewModel)
        }
    }
}
