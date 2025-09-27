//
//  ContentView.swift
//  DemoNotedAppMVVM
//
//  Created by Meang Atithkithya on 25/9/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: DemoNotedAppViewModel

    var body: some View {
        Group {
            if viewModel.isDataLoaded {
                NotedView()
            } else {
                ProgressView("Loading...")
            }
        }
    }
}
