//
//  RootView.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//

import SwiftUI

struct RootView: View {
    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""

    var body: some View {
        if currentUserEmail.isEmpty {
            WelcomeView()
        } else {
            ContentView() // Replace with your actual tab-based main view
        }
    }
}
