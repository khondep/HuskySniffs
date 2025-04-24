//
//  MainAppView.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//

import SwiftUI

struct MainAppView: View {
    var body: some View {
        TabView {
            BrowseView()
                .tabItem {
                    Label("Lost", systemImage: "magnifyingglass")
                }

//            FoundItemsListView()
//                .tabItem {
//                    Label("Found", systemImage: "doc.text.viewfinder")
//                }

            MatchesView()
                .tabItem {
                    Label("Matches", systemImage: "link")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}
