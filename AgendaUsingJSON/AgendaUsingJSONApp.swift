//
//  AgendaUsingJSONApp.swift
//  AgendaUsingJSON
//
//  Created by MUNAVAR PM on 27/11/23.
//

import SwiftUI

@main
struct AgendaUsingJSONApp: App {
    @StateObject var viewModel = DataViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}
