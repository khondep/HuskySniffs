//
//  NeuBranding.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/23/25.
//

//import SwiftUI
//
//extension View {
//    /// Applies Northeastern’s red accent and stamps the Husky Sniffs logo
//    /// into the top‐right of any navigation bar.
//    func neuBranded() -> some View {
//        self
//            .accentColor(.neuRed)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Image("HuskySniffsLogo")
//                        .resizable()
//                        .renderingMode(.original)
//                        .frame(width:62, height:55)
//                }
//            }
//            .accentColor(.neuRed)
//    }
//}



import SwiftUI

private struct NeuBranding: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content
            // apply NEU red accent globally
            .accentColor(.neuRed)
            // place your logo in the top-left of the nav bar
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(colorScheme == .light
                          ? "HuskySniffsLogo-Light"
                          : "HuskySniffsLogo-Dark")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 64, height: 56)
                }
            }
    }
}

extension View {
    /// Applies Northeastern’s red accent and stamps the Husky Sniffs logo
    /// into the top-left of any navigation bar, adapting to light/dark mode.
    func neuBranded() -> some View {
        self.modifier(NeuBranding())
    }
}
