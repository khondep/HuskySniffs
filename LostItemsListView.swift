//
//  LostItemsListView.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//
//


//
//import SwiftUI
//
//struct LostItemsListView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        entity: LostItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) var lostItems: FetchedResults<LostItem>
//
//    @State private var searchText = ""
//    @State private var editingItem: LostItem?
//    @State private var showEditSheet = false
//
//    var filteredItems: [LostItem] {
//        if searchText.isEmpty {
//            return Array(lostItems)
//        } else {
//            return lostItems.filter {
//                ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false) ||
//                ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//            }
//        }
//    }
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(filteredItems, id: \.id) { item in
//                    VStack(alignment: .leading) {
//                        if let data = item.imageData, let image = UIImage(data: data) {
//                            Image(uiImage: image)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(height: 150)
//                                .clipped()
//                                .cornerRadius(10)
//                        }
//                        Text(item.title ?? "No Title")
//                            .font(.headline)
//                        Text(item.desc ?? "")
//                            .font(.subheadline)
//                        Text("Lost at: \(item.location ?? "")")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                    .onTapGesture {
//                        editingItem = item
//                        showEditSheet = true
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .searchable(text: $searchText)
//            .navigationTitle("Lost Items")
//            .sheet(isPresented: $showEditSheet) {
//                if let item = editingItem {
//                    EditLostItemView(item: item)
//                }
//            }
//        }
//    }
//
//    private func deleteItems(at offsets: IndexSet) {
//        for index in offsets {
//            let item = filteredItems[index]
//            viewContext.delete(item)
//        }
//
//        do {
//            try viewContext.save()
//        } catch {
//            print("Delete failed: \(error)")
//        }
//    }
//}

//
//import SwiftUI
//import CoreData
//
//struct LostItemsListView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // Fetch all lost items
//    @FetchRequest(
//        entity: LostItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) var lostItems: FetchedResults<LostItem>
//
//    // Fetch all found items so we can match
//    @FetchRequest(
//        entity: FoundItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) var foundItems: FetchedResults<FoundItem>
//
//    @State private var searchText = ""
//    @State private var editingItem: LostItem?
//    @State private var showEditSheet = false
//
//    /// Filter lostItems by the search bar
//    var filteredItems: [LostItem] {
//        guard !searchText.isEmpty else { return Array(lostItems) }
//        return lostItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false) ||
//            ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(filteredItems, id: \.id) { item in
//                    // Try to find a matching FoundItem
//                    let matches = MatchingService.findMatches(
//                        for: item,
//                        in: Array(foundItems)
//                    )
//                    // Use the first match (or nil)
//                    let firstMatch = matches.first
//
//                    // If we have a match, wrap in a NavigationLink to ChatView
//                    if let found = firstMatch,
//                       let lostID = item.id?.uuidString,
//                       let foundID = found.id?.uuidString {
//                        let sessionID = "\(lostID)_\(foundID)"
//
//                        NavigationLink(value: sessionID) {
//                            LostItemRow(item: item)
//                        }
//                    }
//                    // Otherwise just show the row and let user edit
//                    else {
//                        LostItemRow(item: item)
//                            .onTapGesture {
//                                editingItem = item
//                                showEditSheet = true
//                            }
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .searchable(text: $searchText)
//            .navigationTitle("Lost Items")
//            .navigationDestination(for: String.self) { sessionID in
//                // When user taps a matched row, we navigate to ChatView
//                ChatView(sessionID: sessionID, currentUser: "owner")
//            }
//            .sheet(isPresented: $showEditSheet) {
//                if let item = editingItem {
//                    EditLostItemView(item: item)
//                }
//            }
//        }
//    }
//
//    private func deleteItems(at offsets: IndexSet) {
//        offsets.map { filteredItems[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//}
//
///// Extracted row view for clarity
//private struct LostItemRow: View {
//    let item: LostItem
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            // Show image if available
//            if let data = item.imageData,
//               let uiImage = UIImage(data: data) {
//                Image(uiImage: uiImage)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 150)
//                    .clipped()
//                    .cornerRadius(8)
//            }
//
//            Text(item.title ?? "No Title")
//                .font(.headline)
//            Text(item.desc ?? "")
//                .font(.subheadline)
//            Text("Lost at: \(item.location ?? "")")
//                .font(.caption)
//                .foregroundColor(.gray)
//        }
//        .padding(.vertical, 4)
//    }
//}

//import SwiftUI
//import MapKit
//import CoreData
//
//struct LostItemsListView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        entity: LostItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//        entity: FoundItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) var foundItems: FetchedResults<FoundItem>
//
//    @State private var searchText = ""
//    @State private var editingItem: LostItem?
//    @State private var showEditSheet = false
//    @State private var navigationPath = [String]()
//
//    // Center map on campus
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//    )
//
//    private var filteredItems: [LostItem] {
//        guard !searchText.isEmpty else { return Array(lostItems) }
//        return lostItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//
//    /// Build map annotations from filtered lost items
//    private var annotations: [LostMapAnnotation] {
//        filteredItems.compactMap { item in
//            guard let id = item.id else { return nil }
//            return LostMapAnnotation(
//                id: id,
//                coordinate: CLLocationCoordinate2D(
//                    latitude: item.latitude,
//                    longitude: item.longitude
//                )
//            )
//        }
//    }
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            VStack(spacing: 0) {
//                // MARK: Map with annotations
//                Map(
//                    coordinateRegion: $region,
//                    annotationItems: annotations
//                ) { (annotation: LostMapAnnotation) in
//                    // Use a simple marker; tap to trigger same logic as list row
//                    MapAnnotation(coordinate: annotation.coordinate) {
//                        Button {
//                            if let item = filteredItems.first(where: { $0.id == annotation.id }) {
//                                handleRowTap(item: item)
//                            }
//                        } label: {
//                            Image(systemName: "mappin.circle.fill")
//                                .font(.title2)
//                                .foregroundColor(.red)
//                        }
//                    }
//                }
//                .frame(height: 200)
//                .cornerRadius(12)
//                .padding([.horizontal, .top])
//
//                // MARK: List of lost items
//                List {
//                    ForEach(filteredItems, id: \.id) { item in
//                        LostItemRow(item: item) {
//                            handleRowTap(item: item)
//                        }
//                    }
//                    .onDelete(perform: deleteItems)
//                }
//                .listStyle(.insetGrouped)
//                .searchable(text: $searchText)
//            }
//            .navigationTitle("Lost Items")
//            // When we push a sessionID, show ChatView
//            .navigationDestination(for: String.self) { sessionID in
//                ChatView(sessionID: sessionID, currentUser: "owner")
//            }
//            // Edit sheet for items without matches
//            .sheet(isPresented: $showEditSheet) {
//                if let item = editingItem {
//                    EditLostItemView(item: item)
//                }
//            }
//        }
//    }
//
//    private func handleRowTap(item: LostItem) {
//        let matches = MatchingService.findMatches(
//            for: item,
//            in: Array(foundItems)
//        )
//        if let found = matches.first,
//           let lostID = item.id?.uuidString,
//           let foundID = found.id?.uuidString {
//            // navigate to chat
//            navigationPath.append("\(lostID)_\(foundID)")
//        } else {
//            // no match yet → edit
//            editingItem = item
//            showEditSheet = true
//        }
//    }
//
//    private func deleteItems(at offsets: IndexSet) {
//        let toDelete = offsets.map { filteredItems[$0] }
//        toDelete.forEach { viewContext.delete($0) }
//        try? viewContext.save()
//    }
//}
//
//// MARK: - Annotation Model
//private struct LostMapAnnotation: Identifiable {
//    let id: UUID
//    let coordinate: CLLocationCoordinate2D
//}
//
//// MARK: - Lost Item Row
//private struct LostItemRow: View {
//    let item: LostItem
//    let onTap: () -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            if let data = item.imageData,
//               let uiImage = UIImage(data: data) {
//                Image(uiImage: uiImage)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 150)
//                    .clipped()
//                    .cornerRadius(8)
//            }
//            Text(item.title ?? "No Title")
//                .font(.headline)
//            Text(item.desc ?? "")
//                .font(.subheadline)
//            Text("Lost at: \(item.location ?? "")")
//                .font(.caption)
//                .foregroundColor(.gray)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//        .padding(.vertical, 4)
//    }
//}

//
//import SwiftUI
//import MapKit
//import CoreData
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct LostItemsListView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // MARK: Fetch lost & found items
//    @FetchRequest(
//        entity: LostItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//        entity: FoundItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) var foundItems: FetchedResults<FoundItem>
//
//    // MARK: UI state
//    @State private var searchText = ""
//    @State private var editingItem: LostItem?
//    @State private var showEditSheet = false
//    @State private var navigationPath = [String]()
//
//    // Center the map on campus by default
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//    )
//
//    // MARK: Filtered results
//    private var filteredItems: [LostItem] {
//        guard !searchText.isEmpty else { return Array(lostItems) }
//        return lostItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//
//    // Convert LostItem → map annotations
//    private var annotations: [LostMapAnnotation] {
//        filteredItems.compactMap { item in
//            guard let id = item.id else { return nil }
//            return LostMapAnnotation(
//                id: id,
//                coordinate: CLLocationCoordinate2D(
//                    latitude: item.latitude,
//                    longitude: item.longitude
//                )
//            )
//        }
//    }
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            VStack(spacing: 0) {
//                // MARK: – Campus map with pins
//                Map(
//                    coordinateRegion: $region,
//                    annotationItems: annotations
//                ) { annotation in
//                    // Each pin is tappable
//                    MapAnnotation(coordinate: annotation.coordinate) {
//                        Button {
//                            guard
//                                let item = filteredItems.first(where: { $0.id == annotation.id })
//                            else { return }
//                            rowTapped(item: item)
//                        } label: {
//                            Image(systemName: "mappin.circle.fill")
//                                .font(.title2)
//                                .foregroundColor(.red)
//                        }
//                    }
//                }
//                .frame(height: 200)
//                .cornerRadius(12)
//                .padding([.horizontal, .top])
//
//                // MARK: – Scrollable list below
//                List {
//                    ForEach(filteredItems, id: \.id) { item in
//                        LostItemRow(item: item) {
//                            rowTapped(item: item)
//                        }
//                    }
//                    .onDelete(perform: deleteItems)
//                }
//                .listStyle(.insetGrouped)
//                .searchable(text: $searchText)
//            }
//            .navigationTitle("Lost Items")
//            // When we push a sessionID, we show ChatView
//            .navigationDestination(for: String.self) { sessionID in
//                ChatView(sessionID: sessionID, currentUser: "owner")
//            }
//            // If no chat match, show the edit sheet instead
//            .sheet(isPresented: $showEditSheet) {
//                if let item = editingItem {
//                    EditLostItemView(item: item)
//                }
//            }
//        }
//    }
//
//    // MARK: – Helpers
//
//    /// Called when either a pin or row is tapped.
//    /// If there’s a finder‐match, navigate to the chat; else open the edit‐item sheet.
//    private func rowTapped(item: LostItem) {
//        let matches = MatchingService.findMatches(for: item, in: Array(foundItems))
//        if let found = matches.first,
//           let lostID  = item.id?.uuidString,
//           let foundID = found.id?.uuidString
//        {
//            navigationPath.append("\(lostID)_\(foundID)")
//        } else {
//            editingItem = item
//            showEditSheet = true
//        }
//    }
//
//    private func deleteItems(at offsets: IndexSet) {
//        let toDelete = offsets.map { filteredItems[$0] }
//        toDelete.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//}
//
//// MARK: – Map annotation model
//private struct LostMapAnnotation: Identifiable {
//    let id: UUID
//    let coordinate: CLLocationCoordinate2D
//}
//
//// MARK: – Reusable row view
//private struct LostItemRow: View {
//    let item: LostItem
//    let onTap: () -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            // Show the uploaded image if available
//            #if canImport(UIKit)
//            if let data = item.imageData,
//               let uiImage = UIImage(data: data) {
//                Image(uiImage: uiImage)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 150)
//                    .clipped()
//                    .cornerRadius(8)
//            }
//            #endif
//
//            Text(item.title ?? "No Title")
//                .font(.headline)
//            Text(item.desc ?? "")
//                .font(.subheadline)
//            Text("Lost at: \(item.location ?? "")")
//                .font(.caption)
//                .foregroundColor(.gray)
//        }
//        .contentShape(Rectangle())    // Makes the whole cell tappable
//        .onTapGesture(perform: onTap)
//        .padding(.vertical, 4)
//    }
//}
//
//import SwiftUI
//import MapKit
//import CoreData
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct LostItemsListView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // MARK: Fetch lost & found items
//    @FetchRequest(
//        entity: LostItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//        entity: FoundItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) var foundItems: FetchedResults<FoundItem>
//
//    // MARK: UI state
//    @State private var searchText = ""
//    @State private var editingItem: LostItem?
//    @State private var showEditSheet = false
//    @State private var navigationPath = [String]()
//
//    // Center the map on campus by default
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//    )
//
//    // MARK: Filtered results
//    private var filteredItems: [LostItem] {
//        guard !searchText.isEmpty else { return Array(lostItems) }
//        return lostItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//
//    // Convert LostItem → map annotations
//    private var annotations: [LostMapAnnotation] {
//        filteredItems.compactMap { item in
//            guard let id = item.id else { return nil }
//            return LostMapAnnotation(
//                id: id,
//                coordinate: CLLocationCoordinate2D(
//                    latitude: item.latitude,
//                    longitude: item.longitude
//                )
//            )
//        }
//    }
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            VStack(spacing: 0) {
//                // MARK: – Campus map with pins
//                Map(
//                    coordinateRegion: $region,
//                    annotationItems: annotations
//                ) { annotation in
//                    MapAnnotation(coordinate: annotation.coordinate) {
//                        Button {
//                            guard
//                                let item = filteredItems.first(where: { $0.id == annotation.id })
//                            else { return }
//                            rowTapped(item: item)
//                        } label: {
//                            Image(systemName: "mappin.circle.fill")
//                                .font(.title2)
//                                .foregroundColor(.red)
//                        }
//                    }
//                }
//                .frame(height: 200)
//                .cornerRadius(12)
//                .padding([.horizontal, .top])
//
//                // MARK: – Scrollable list below
//                List {
//                    ForEach(filteredItems, id: \.id) { item in
//                        LostItemRow(item: item) {
//                            rowTapped(item: item)
//                        }
//                    }
//                    .onDelete(perform: deleteItems)
//                }
//                .listStyle(.insetGrouped)
//                .searchable(text: $searchText)
//            }
//            .navigationTitle("Lost Items")
//            // **NEW**: chat icon in top right
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink {
//                        ChatInboxView()
//                    } label: {
//                        Image(systemName: "bubble.left.and.bubble.right")
//                    }
//                }
//            }
//            // When we push a sessionID, we show ChatView
//            .navigationDestination(for: String.self) { sessionID in
//                ChatView(sessionID: sessionID, currentUser: "owner")
//            }
//            // If no chat match, show the edit sheet instead
//            .sheet(isPresented: $showEditSheet) {
//                if let item = editingItem {
//                    EditLostItemView(item: item)
//                }
//            }
//        }
//    }
//
//    // MARK: – Helpers
//
//    private func rowTapped(item: LostItem) {
//        let matches = MatchingService.findMatches(for: item, in: Array(foundItems))
//        if let found = matches.first,
//           let lostID  = item.id?.uuidString,
//           let foundID = found.id?.uuidString
//        {
//            navigationPath.append("\(lostID)_\(foundID)")
//        } else {
//            editingItem = item
//            showEditSheet = true
//        }
//    }
//
//    private func deleteItems(at offsets: IndexSet) {
//        let toDelete = offsets.map { filteredItems[$0] }
//        toDelete.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//}
//
//// MARK: – Map annotation model
//private struct LostMapAnnotation: Identifiable {
//    let id: UUID
//    let coordinate: CLLocationCoordinate2D
//}
//
//// MARK: – Reusable row view
//private struct LostItemRow: View {
//    let item: LostItem
//    let onTap: () -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            #if canImport(UIKit)
//            if let data = item.imageData,
//               let uiImage = UIImage(data: data) {
//                Image(uiImage: uiImage)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 150)
//                    .clipped()
//                    .cornerRadius(8)
//            }
//            #endif
//
//            Text(item.title ?? "No Title")
//                .font(.headline)
//            Text(item.desc ?? "")
//                .font(.subheadline)
//            Text("Lost at: \(item.location ?? "")")
//                .font(.caption)
//                .foregroundColor(.gray)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//        .padding(.vertical, 4)
//    }
//}


//import SwiftUI
//import MapKit
//import CoreData
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct LostItemsListView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // MARK: – Fetch
//    @FetchRequest(
//      entity: LostItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) private var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//      entity: FoundItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) private var foundItems: FetchedResults<FoundItem>
//
//    // MARK: – UI State
//    @State private var searchText       = ""
//    @State private var editingItem: LostItem?
//    @State private var showEditSheet    = false
//    @State private var navigationPath   = [String]()
//    @State private var region           = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//    )
//    @State private var displayMode: DisplayMode = .list
//
//    enum DisplayMode: String, CaseIterable, Identifiable {
//        case map, list
//        var id: String { rawValue }
//        var title: String {
//            switch self {
//            case .map:  return "Map"
//            case .list: return "List"
//            }
//        }
//    }
//
//    // MARK: – Filtered + Annotation helpers
//    private var filteredItems: [LostItem] {
//        guard !searchText.isEmpty else { return Array(lostItems) }
//        return lostItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//    private var annotations: [LostMapAnnotation] {
//        filteredItems.compactMap { item in
//            guard let id = item.id else { return nil }
//            return LostMapAnnotation(
//                id: id,
//                coordinate: CLLocationCoordinate2D(
//                    latitude: item.latitude,
//                    longitude: item.longitude
//                )
//            )
//        }
//    }
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            Group {
//                switch displayMode {
//                case .map:
//                    // FULL SCREEN MAP
//                    Map(coordinateRegion: $region,
//                        annotationItems: annotations
//                    ) { ann in
//                        MapAnnotation(coordinate: ann.coordinate) {
//                            Image(systemName: "mappin.circle.fill")
//                                .font(.title)
//                                .foregroundColor(.red)
//                        }
//                    }
//                    .ignoresSafeArea(edges: .bottom)
//
//                case .list:
//                    // YOUR EXISTING MAP + LIST LAYOUT
//                    VStack(spacing: 0) {
//                        Map(coordinateRegion: $region,
//                            annotationItems: annotations
//                        ) { ann in
//                            MapAnnotation(coordinate: ann.coordinate) {
//                                Button {
//                                    if let item = filteredItems.first(where: { $0.id == ann.id }) {
//                                        rowTapped(item: item)
//                                    }
//                                } label: {
//                                    Image(systemName: "mappin.circle.fill")
//                                        .font(.title2)
//                                        .foregroundColor(.red)
//                                }
//                            }
//                        }
//                        .frame(height: 200)
//                        .cornerRadius(12)
//                        .padding([.horizontal, .top])
//
//                        List {
//                            ForEach(filteredItems, id: \.id) { item in
//                                LostItemRow(item: item) {
//                                    rowTapped(item: item)
//                                }
//                            }
//                            .onDelete(perform: deleteItems)
//                        }
//                        .listStyle(.insetGrouped)
//                        .searchable(text: $searchText)
//                    }
//                }
//            }
//            .navigationTitle("Lost Items")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Picker("", selection: $displayMode) {
//                        ForEach(DisplayMode.allCases) { mode in
//                            Text(mode.title).tag(mode)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink {
//                        ChatInboxView()
//                    } label: {
//                        Image(systemName: "bubble.left.and.bubble.right")
//                    }
//                }
//            }
//            // push into a specific chat session
//            .navigationDestination(for: String.self) { sessionID in
//                ChatView(sessionID: sessionID, currentUser: "owner")
//            }
//            // show edit sheet if no match
//            .sheet(isPresented: $showEditSheet) {
//                if let item = editingItem {
//                    EditLostItemView(item: item)
//                }
//            }
//        }
//    }
//
//    // MARK: – Helpers
//    private func rowTapped(item: LostItem) {
//        let matches = MatchingService.findMatches(for: item, in: Array(foundItems))
//        if let found = matches.first,
//           let lostID = item.id?.uuidString,
//           let foundID = found.id?.uuidString
//        {
//            navigationPath.append("\(lostID)_\(foundID)")
//        } else {
//            editingItem = item
//            showEditSheet = true
//        }
//    }
//
//    private func deleteItems(at offsets: IndexSet) {
//        let toDelete = offsets.map { filteredItems[$0] }
//        toDelete.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//}
//
//// MARK: – Annotation Model
//private struct LostMapAnnotation: Identifiable {
//    let id: UUID
//    let coordinate: CLLocationCoordinate2D
//}
//
//// MARK: – Row View
//private struct LostItemRow: View {
//    let item: LostItem
//    let onTap: () -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            #if canImport(UIKit)
//            if let data = item.imageData,
//               let uiImage = UIImage(data: data) {
//                Image(uiImage: uiImage)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 150)
//                    .clipped()
//                    .cornerRadius(8)
//            }
//            #endif
//            Text(item.title ?? "No Title").font(.headline)
//            Text(item.desc ?? "").font(.subheadline)
//            Text("Lost at: \(item.location ?? "")")
//                .font(.caption).foregroundColor(.gray)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//        .padding(.vertical, 4)
//    }
//}

//
//import SwiftUI
//import MapKit
//import CoreData
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct LostItemsView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // MARK: – Core Data fetches
//    @FetchRequest(
//      entity: LostItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) private var lostItems: FetchedResults<LostItem>
//    @FetchRequest(
//      entity: FoundItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) private var foundItems: FetchedResults<FoundItem>
//
//    // MARK: – UI State
//    @State private var searchText     = ""
//    @State private var displayMode    = DisplayMode.list
//    @State private var region         = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//    )
//    @State private var navigationPath = [String]()
//    @State private var editingItem: LostItem?
//    @State private var showEditSheet  = false
//
//    enum DisplayMode: String, CaseIterable, Identifiable {
//        case list, map
//        var id: String { rawValue }
//        var title: String {
//            switch self {
//            case .list: return "List"
//            case .map:  return "Map"
//            }
//        }
//    }
//
//    // MARK: – Helpers
//    private var filteredItems: [LostItem] {
//        guard !searchText.isEmpty else { return Array(lostItems) }
//        return lostItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//
//    private var annotations: [LostMapAnnotation] {
//        filteredItems.compactMap { item in
//            guard let id = item.id else { return nil }
//            return .init(
//                id: id,
//                coordinate: CLLocationCoordinate2D(
//                    latitude: item.latitude,
//                    longitude: item.longitude
//                )
//            )
//        }
//    }
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            VStack(spacing: 0) {
//                // — Search Bar —
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.secondary)
//                    TextField("Search lost items...", text: $searchText)
//                        .autocorrectionDisabled(true)
//                }
//                .padding(8)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .padding(.horizontal)
//
//                // — Mode Toggle —
//                Picker("", selection: $displayMode) {
//                    ForEach(DisplayMode.allCases) { mode in
//                        Text(mode.title).tag(mode)
//                    }
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//                .padding(.top, 4)
//
//                // — Content —
//                Group {
//                    if displayMode == .map {
//                        Map(
//                            coordinateRegion: $region,
//                            annotationItems: annotations
//                        ) { ann in
//                            MapAnnotation(coordinate: ann.coordinate) {
//                                Image(systemName: "mappin.circle.fill")
//                                    .font(.title2)
//                                    .foregroundColor(.red)
//                                    .onTapGesture {
//                                        if let item = filteredItems.first(where: { $0.id == ann.id }) {
//                                            rowTapped(item: item)
//                                        }
//                                    }
//                            }
//                        }
//                        .ignoresSafeArea(edges: .bottom)
//                    } else {
//                        List {
//                            ForEach(filteredItems, id: \.id) { item in
//                                LostItemRow(item: item) {
//                                    rowTapped(item: item)
//                                }
//                            }
//                            .onDelete(perform: deleteItems)
//                        }
//                        .listStyle(.insetGrouped)
//                    }
//                }
//                .animation(.default, value: displayMode)
//            }
//            .navigationTitle("Lost Items")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink {
//                        ChatInboxView()
//                    } label: {
//                        Image(systemName: "bubble.left.and.bubble.right")
//                    }
//                }
//            }
//            // Push into ChatView when a sessionID string is appended
//            .navigationDestination(for: String.self) { sessionID in
//                ChatView(sessionID: sessionID, currentUser: "owner")
//            }
//            // If no match, present Edit sheet
//            .sheet(isPresented: $showEditSheet) {
//                if let item = editingItem {
//                    EditLostItemView(item: item)
//                }
//            }
//        }
//    }
//
//    // MARK: – Actions
//    private func rowTapped(item: LostItem) {
//        let matches = MatchingService.findMatches(for: item, in: Array(foundItems))
//        if let f = matches.first,
//           let lID = item.id?.uuidString,
//           let fID = f.id?.uuidString
//        {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingItem = item
//            showEditSheet = true
//        }
//    }
//
//    private func deleteItems(at offsets: IndexSet) {
//        offsets.map { filteredItems[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//}
//
//// MARK: – Map Annotation Model
//private struct LostMapAnnotation: Identifiable {
//    let id: UUID
//    let coordinate: CLLocationCoordinate2D
//}
//
//// MARK: – Row View
//private struct LostItemRow: View {
//    let item: LostItem
//    let onTap: () -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            #if canImport(UIKit)
//            if let data = item.imageData,
//               let ui = UIImage(data: data)
//            {
//                Image(uiImage: ui)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 140)
//                    .clipped()
//                    .cornerRadius(8)
//            }
//            #endif
//
//            Text(item.title ?? "No Title")
//                .font(.headline)
//            Text(item.desc ?? "")
//                .font(.subheadline)
//            Text("Lost at: \(item.location ?? "")")
//                .font(.caption)
//                .foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//        .padding(.vertical, 4)
//    }
//}


//import SwiftUI
//import MapKit
//import CoreData
//
//struct LostItemsView: View {
//  @Environment(\.managedObjectContext) private var viewContext
//
//  @FetchRequest(
//    entity: LostItem.entity(),
//    sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//  ) private var lostItems: FetchedResults<LostItem>
//
//  @State private var displayMode    = DisplayMode.list
//  @State private var region         = MKCoordinateRegion(
//      center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//      span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//  )
//  @State private var navigationPath = [String]()
//  @State private var editingItem: LostItem?
//  @State private var showEditSheet  = false
//
//  enum DisplayMode: String, CaseIterable, Identifiable {
//    case list, map
//    var id: String { rawValue }
//    var title: String {
//      switch self {
//      case .list: return "List"
//      case .map:  return "Map"
//      }
//    }
//  }
//
//  private var annotations: [LostMapAnnotation] {
//    lostItems.compactMap { item in
//      guard let id = item.id else { return nil }
//      return LostMapAnnotation(
//        id: id,
//        coordinate: CLLocationCoordinate2D(
//          latitude: item.latitude,
//          longitude: item.longitude
//        )
//      )
//    }
//  }
//
//  var body: some View {
//    NavigationStack(path: $navigationPath) {
//      VStack(spacing: 0) {
//        // mode toggle
//        Picker("", selection: $displayMode) {
//          ForEach(DisplayMode.allCases) { m in
//            Text(m.title).tag(m)
//          }
//        }
//        .pickerStyle(.segmented)
//        .padding()
//
//        Group {
//          if lostItems.isEmpty {
//            // show spinner while the very first fetch is in flight
//            VStack {
//              ProgressView()
//                .progressViewStyle(CircularProgressViewStyle())
//              Text("Loading lost items…")
//                .foregroundColor(.secondary)
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//          }
//          else if displayMode == .map {
//            Map(
//              coordinateRegion: $region,
//              annotationItems: annotations
//            ) { ann in
//              MapAnnotation(coordinate: ann.coordinate) {
//                Image(systemName: "mappin.circle.fill")
//                  .font(.title2)
//                  .foregroundColor(.red)
//                  .onTapGesture {
//                    if let item = lostItems.first(where: { $0.id == ann.id }) {
//                      rowTapped(item: item)
//                    }
//                  }
//              }
//            }
//            .ignoresSafeArea(edges: .bottom)
//          }
//          else {
//            List {
//              ForEach(lostItems, id: \.id) { item in
//                LostItemRow(item: item) {
//                  rowTapped(item: item)
//                }
//              }
//              .onDelete(perform: deleteItems)
//            }
//            .listStyle(.insetGrouped)
//          }
//        }
//      }
//      .navigationTitle("Lost Items")
//      .toolbar {
//        ToolbarItem(placement: .navigationBarTrailing) {
//          NavigationLink { ChatInboxView() } label: {
//            Image(systemName: "bubble.left.and.bubble.right")
//          }
//        }
//      }
//      .navigationDestination(for: String.self) { session in
//        ChatView(sessionID: session, currentUser: "owner")
//      }
//      .sheet(isPresented: $showEditSheet) {
//        if let item = editingItem {
//          EditLostItemView(item: item)
//        }
//      }
//      .onAppear {
//        // In case you didn’t fire it in the App
//        MockDataService.insertMockDataFromMockAPI()
//      }
//      .onChange(of: lostItems.count) { newCount in
//        print("🟢 Core Data now has \(newCount) LostItem(s)")
//      }
//    }
//  }
//
//  private func rowTapped(item: LostItem) {
//    // ... same matching logic as before ...
//  }
//
//  private func deleteItems(at offsets: IndexSet) {
//    offsets.map { lostItems[$0] }.forEach(viewContext.delete)
//    try? viewContext.save()
//  }
//}
//
//// Map annotation model
//private struct LostMapAnnotation: Identifiable {
//  let id: UUID
//  let coordinate: CLLocationCoordinate2D
//}
//
//// Row view
//private struct LostItemRow: View {
//  let item: LostItem
//  let onTap: () -> Void
//
//  var body: some View {
//    VStack(alignment: .leading, spacing: 8) {
//      #if canImport(UIKit)
//      if let data = item.imageData,
//         let ui = UIImage(data: data)
//      {
//        Image(uiImage: ui)
//          .resizable()
//          .scaledToFill()
//          .frame(height: 140)
//          .clipped()
//          .cornerRadius(8)
//      }
//      #endif
//      Text(item.title ?? "No Title").font(.headline)
//      Text(item.desc ?? "").font(.subheadline)
//      Text("Lost at: \(item.location ?? "")")
//        .font(.caption)
//        .foregroundColor(.secondary)
//    }
//    .contentShape(Rectangle())
//    .onTapGesture(perform: onTap)
//    .padding(.vertical, 4)
//  }
//}

//
//import SwiftUI
//import MapKit
//import CoreData
//
//struct LostItemsView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // MARK: – Core Data fetches
//    @FetchRequest(
//      entity: LostItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) private var lostItems: FetchedResults<LostItem>
//    @FetchRequest(
//      entity: FoundItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) private var foundItems: FetchedResults<FoundItem>
//
//    // MARK: – UI state
//    @State private var searchText  = ""
//    @State private var displayMode = DisplayMode.lost
//    @State private var region      = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//    )
//    @State private var navigationPath = [String]()
//    @State private var editingItem: LostItem?
//    @State private var showEditSheet = false
//
//    enum DisplayMode: String, CaseIterable, Identifiable {
//        case lost   = "Lost"
//        case found  = "Found"
//        case map    = "Map"
//        var id: String { rawValue }
//    }
//
//    // MARK: – Filtered arrays
//    private var filteredLost: [LostItem] {
//        guard !searchText.isEmpty else { return Array(lostItems) }
//        return lostItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false) ||
//            ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//    private var filteredFound: [FoundItem] {
//        guard !searchText.isEmpty else { return Array(foundItems) }
//        return foundItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false) ||
//            ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//
//    // MARK: – Map annotations for lost items
//    private var lostAnnotations: [MapPin] {
//        filteredLost.compactMap { item in
//            guard let id = item.id else { return nil }
//            return MapPin(id: id,
//                          coord: CLLocationCoordinate2D(latitude: item.latitude,
//                                                        longitude: item.longitude),
//                          isLost: true)
//        }
//    }
//    // (Could similarly show foundAnnotations if you prefer)
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            VStack(spacing: 8) {
//                // — Search Bar —
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.secondary)
//                    TextField(
//                      displayMode == .found
//                        ? "Search found items..."
//                        : "Search lost items...",
//                      text: $searchText
//                    )
//                    .autocorrectionDisabled(true)
//                }
//                .padding(8)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .padding(.horizontal)
//
//                // — Mode Picker —
//                Picker("", selection: $displayMode) {
//                    ForEach(DisplayMode.allCases) { mode in
//                        Text(mode.rawValue).tag(mode)
//                    }
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                // — Content —
//                Group {
//                  switch displayMode {
//                  case .lost:
//                    List {
//                      ForEach(filteredLost, id: \.id) { item in
//                        LostRow(item: item) { rowTapped(item) }
//                      }
//                      .onDelete(perform: deleteLost)
//                    }
//                    .listStyle(.insetGrouped)
//
//                  case .found:
//                    List {
//                      ForEach(filteredFound, id: \.id) { item in
//                        FoundRow(item: item) { foundTapped(item) }
//                      }
//                      .onDelete(perform: deleteFound)
//                    }
//                    .listStyle(.insetGrouped)
//
//                  case .map:
//                    Map(
//                      coordinateRegion: $region,
//                      annotationItems: lostAnnotations
//                    ) { pin in
//                      MapAnnotation(coordinate: pin.coord) {
//                        Button {
//                          if let item = filteredLost.first(where: { $0.id == pin.id }) {
//                            rowTapped(item)
//                          }
//                        } label: {
//                          Image(systemName: pin.isLost
//                                      ? "mappin.circle.fill"
//                                      : "mappin.circle")
//                            .font(.title2)
//                            .foregroundColor(.red)
//                        }
//                      }
//                    }
//                    .ignoresSafeArea(edges: .bottom)
//                  }
//                }
//                .animation(.default, value: displayMode)
//            }
//            .navigationTitle("Browse Items")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink {
//                        ChatInboxView()
//                    } label: {
//                        Image(systemName: "bubble.left.and.bubble.right")
//                    }
//                }
//            }
//            .navigationDestination(for: String.self) { sessionID in
//                ChatView(sessionID: sessionID, currentUser: "owner")
//            }
//            .sheet(isPresented: $showEditSheet) {
//                if let item = editingItem {
//                    EditLostItemView(item: item)
//                }
//            }
//            .onAppear {
//                MockDataService.insertMockDataFromMockAPI()
//            }
//        }
//    }
//
//    // MARK: – Actions
//    private func rowTapped(_ lost: LostItem) {
//        let matches = MatchingService.findMatches(for: lost,
//                      in: Array(foundItems))
//        if let found = matches.first,
//           let lID = lost.id?.uuidString,
//           let fID = found.id?.uuidString {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingItem = lost
//            showEditSheet = true
//        }
//    }
//    private func foundTapped(_ found: FoundItem) {
//        // jump into a chat with finder, or simply start a new session:
//        if let l = lostItems.first,
//           let lID = l.id?.uuidString,
//           let fID = found.id?.uuidString {
//            navigationPath.append("\(lID)_\(fID)")
//        }
//    }
//    private func deleteLost(at offsets: IndexSet) {
//        offsets.map { filteredLost[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//    private func deleteFound(at offsets: IndexSet) {
//        offsets.map { filteredFound[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//}
//
//// MARK: – Shared models
//
//private struct MapPin: Identifiable {
//    let id: UUID
//    let coord: CLLocationCoordinate2D
//    let isLost: Bool
//}
//
//private struct LostRow: View {
//    let item: LostItem
//    let onTap: ()->Void
//    var body: some View {
//      VStack(alignment:.leading, spacing:6) {
//        #if canImport(UIKit)
//        if let d = item.imageData, let ui = UIImage(data: d) {
//          Image(uiImage: ui)
//            .resizable()
//            .scaledToFill()
//            .frame(height:120)
//            .clipped()
//            .cornerRadius(8)
//        }
//        #endif
//        Text(item.title ?? "").font(.headline)
//        Text(item.desc  ?? "").font(.subheadline)
//        Text("Lost at \(item.location ?? "")")
//          .font(.caption).foregroundColor(.secondary)
//      }
//      .contentShape(Rectangle())
//      .onTapGesture(perform: onTap)
//    }
//}
//
//private struct FoundRow: View {
//    let item: FoundItem
//    let onTap: ()->Void
//    var body: some View {
//      VStack(alignment:.leading, spacing:6) {
//        #if canImport(UIKit)
//        if let d = item.imageData, let ui = UIImage(data: d) {
//          Image(uiImage: ui)
//            .resizable()
//            .scaledToFill()
//            .frame(height:120)
//            .clipped()
//            .cornerRadius(8)
//        }
//        #endif
//        Text(item.title ?? "").font(.headline)
//        Text(item.desc  ?? "").font(.subheadline)
//        Text("Found at \(item.location ?? "")")
//          .font(.caption).foregroundColor(.secondary)
//      }
//      .contentShape(Rectangle())
//      .onTapGesture(perform: onTap)
//    }
//}


//
//import SwiftUI
//import MapKit
//import CoreData
//
//struct BrowseView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // MARK: – Core Data fetches
//    @FetchRequest(
//      entity: LostItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) private var lostItems: FetchedResults<LostItem>
//    @FetchRequest(
//      entity: FoundItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) private var foundItems: FetchedResults<FoundItem>
//
//    // MARK: – UI state
//    @State private var searchText  = ""
//    @State private var displayMode = DisplayMode.lost
//    @State private var region      = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//    )
//    @State private var navigationPath = [String]()
//    @State private var editingLostItem: LostItem?
//    @State private var editingFoundItem: FoundItem?
//    @State private var showEditSheet = false
//
//    enum DisplayMode: String, CaseIterable, Identifiable {
//        case lost   = "Lost"
//        case found  = "Found"
//        case map    = "Map"
//        var id: String { rawValue }
//    }
//
//    // Filtered collections
//    private var filteredLost: [LostItem] {
//        guard !searchText.isEmpty else { return Array(lostItems) }
//        return lostItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//    private var filteredFound: [FoundItem] {
//        guard !searchText.isEmpty else { return Array(foundItems) }
//        return foundItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//
//    // MapPin model
//    private struct MapPin: Identifiable {
//        let id: UUID
//        let coordinate: CLLocationCoordinate2D
//    }
//    private var lostPins: [MapPin] {
//        filteredLost.compactMap { item in
//            guard let id = item.id else { return nil }
//            return MapPin(id: id, coordinate: CLLocationCoordinate2D(latitude: item.latitude,
//                                                                      longitude: item.longitude))
//        }
//    }
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            VStack(spacing: 8) {
//                // Search bar
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                    TextField(
//                      displayMode == .found
//                        ? "Search found items…"
//                        : "Search lost items…",
//                      text: $searchText
//                    )
//                    .autocorrectionDisabled(true)
//                }
//                .padding(8)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .padding(.horizontal)
//
//                // Mode selector
//                Picker("", selection: $displayMode) {
//                    ForEach(DisplayMode.allCases) { mode in
//                        Text(mode.rawValue).tag(mode)
//                    }
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                // Content
//                Group {
//                    switch displayMode {
//                    case .lost:
//                        lostList
//
//                    case .found:
//                        foundList
//
//                    case .map:
//                        lostMap
//                    }
//                }
//                .animation(.default, value: displayMode)
//            }
//            .navigationTitle("Browse")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink {
//                        ChatInboxView()
//                    } label: {
//                        Image(systemName: "bubble.left.and.bubble.right")
//                    }
//                }
//            }
//            // **simplified** navigationDestination
//            .navigationDestination(for: String.self) { sessionID in
//                ChatView(sessionID: sessionID, currentUser: "owner")
//            }
//            // editing sheet
//            .sheet(isPresented: $showEditSheet) {
//                if displayMode == .lost, let item = editingLostItem {
//                    EditLostItemView(item: item)
//                } else if displayMode == .found, let item = editingFoundItem {
//                    EditFoundItemView(item: item)
//                }
//            }
//            .onAppear {
//                MockDataService.importMockAPIData(into: PersistenceController.shared.container)
//            }
//        }
//    }
//
//    // MARK: – Subviews
//
//    private var lostList: some View {
//        List {
//            ForEach(filteredLost, id: \.id) { item in
//                LostRow(item: item) { onLostTap(item) }
//            }
//            .onDelete(perform: deleteLost)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var foundList: some View {
//        List {
//            ForEach(filteredFound, id: \.id) { item in
//                FoundRow(item: item) { onFoundTap(item) }
//            }
//            .onDelete(perform: deleteFound)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var lostMap: some View {
//        Map(coordinateRegion: $region, annotationItems: lostPins) { pin in
//            MapAnnotation(coordinate: pin.coordinate) {
//                Button {
//                    if let item = filteredLost.first(where: { $0.id == pin.id }) {
//                        onLostTap(item)
//                    }
//                } label: {
//                    Image(systemName: "mappin.circle.fill")
//                        .font(.title2)
//                        .foregroundColor(.red)
//                }
//            }
//        }
//        .ignoresSafeArea(edges: .bottom)
//    }
//
//    // MARK: – Actions
//
//    private func onLostTap(_ lost: LostItem) {
//        let matches = MatchingService.findMatches(for: lost, in: Array(foundItems))
//        if let found = matches.first,
//           let lID = lost.id?.uuidString,
//           let fID = found.id?.uuidString {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingLostItem = lost
//            showEditSheet = true
//        }
//    }
//    private func onFoundTap(_ found: FoundItem) {
//        // use some lost ID to start chat…
//        if let anyLost = lostItems.first,
//           let lID = anyLost.id?.uuidString,
//           let fID = found.id?.uuidString {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingFoundItem = found
//            showEditSheet = true
//        }
//    }
//    private func deleteLost(at offsets: IndexSet) {
//        offsets.map { filteredLost[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//    private func deleteFound(at offsets: IndexSet) {
//        offsets.map { filteredFound[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//}
//
//// MARK: – Row Views
//
//private struct LostRow: View {
//    let item: LostItem
//    let onTap: () -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let data = item.imageData,
//               let ui = UIImage(data: data) {
//                Image(uiImage: ui)
//                  .resizable()
//                  .scaledToFill()
//                  .frame(height: 120)
//                  .clipped()
//                  .cornerRadius(8)
//            }
//            #endif
//            Text(item.title ?? "").font(.headline)
//            Text(item.desc  ?? "").font(.subheadline)
//            Text("Lost at \(item.location ?? "")")
//              .font(.caption)
//              .foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}
//
//private struct FoundRow: View {
//    let item: FoundItem
//    let onTap: () -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let data = item.imageData,
//               let ui = UIImage(data: data) {
//                Image(uiImage: ui)
//                  .resizable()
//                  .scaledToFill()
//                  .frame(height: 120)
//                  .clipped()
//                  .cornerRadius(8)
//            }
//            #endif
//            Text(item.title ?? "").font(.headline)
//            Text(item.desc  ?? "").font(.subheadline)
//            Text("Found at \(item.location ?? "")")
//              .font(.caption)
//              .foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}

//
//import SwiftUI
//import MapKit
//import CoreData
//
//struct BrowseView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // MARK: – Core Data fetches
//    @FetchRequest(
//      entity: LostItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) private var lostItems: FetchedResults<LostItem>
//    @FetchRequest(
//      entity: FoundItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) private var foundItems: FetchedResults<FoundItem>
//
//    // MARK: – UI state
//    @State private var searchText      = ""
//    @State private var displayMode     = DisplayMode.lost
//    @State private var region          = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//    )
//    @State private var navigationPath  = [String]()
//    @State private var editingLostItem: LostItem?
//    @State private var editingFoundItem: FoundItem?
//    @State private var showEditSheet   = false
//
//    enum DisplayMode: String, CaseIterable, Identifiable {
//        case lost  = "Lost"
//        case found = "Found"
//        case map   = "Map"
//        var id: String { rawValue }
//    }
//
//    // MARK: – Filtered collections
//    private var filteredLost: [LostItem] {
//        guard !searchText.isEmpty else { return Array(lostItems) }
//        return lostItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false) ||
//            ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//    private var filteredFound: [FoundItem] {
//        guard !searchText.isEmpty else { return Array(foundItems) }
//        return foundItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false) ||
//            ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//
//    // MARK: – MapPin model for LostItems
//    private struct MapPin: Identifiable {
//        let id: UUID
//        let coordinate: CLLocationCoordinate2D
//    }
//    private var lostPins: [MapPin] {
//        filteredLost.compactMap { item in
//            guard let id = item.id else { return nil }
//            return MapPin(
//                id: id,
//                coordinate: .init(latitude: item.latitude, longitude: item.longitude)
//            )
//        }
//    }
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            VStack(spacing: 8) {
//                // — Search bar —
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.secondary)
//                    TextField(
//                        displayMode == .found ? "Search found items…" : "Search lost items…",
//                        text: $searchText
//                    )
//                    .autocorrectionDisabled(true)
//                }
//                .padding(8)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .padding(.horizontal)
//
//                // — Mode selector —
//                Picker("", selection: $displayMode) {
//                    ForEach(DisplayMode.allCases) { mode in
//                        Text(mode.rawValue).tag(mode)
//                    }
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                // — Content —
//                Group {
//                    switch displayMode {
//                    case .lost:
//                        lostList
//                    case .found:
//                        foundList
//                    case .map:
//                        lostMap
//                    }
//                }
//                .animation(.default, value: displayMode)
//            }
//            .navigationTitle("Browse")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink {
//                        ChatInboxView()
//                    } label: {
//                        Image(systemName: "bubble.left.and.bubble.right")
//                    }
//                }
//            }
//            // Navigate to ChatView when a sessionID is pushed
//            .navigationDestination(for: String.self) { sessionID in
//                ChatView(sessionID: sessionID, currentUser: "owner")
//            }
//            // Edit‐item sheet for both modes
//            .sheet(isPresented: $showEditSheet) {
//                if displayMode == .lost, let item = editingLostItem {
//                    EditLostItemView(item: item)
//                } else if displayMode == .found, let item = editingFoundItem {
//                    EditFoundItemView(item: item)
//                }
//            }
//            // Import your mock‐API data once
//            .onAppear {
//                MockDataService.importMockAPIData(into: PersistenceController.shared.container)
//            }
//        }
//    }
//
//    // MARK: – Subviews
//
//    private var lostList: some View {
//        List {
//            ForEach(filteredLost, id: \.id) { item in
//                LostRow(item: item) { onLostTap(item) }
//            }
//            .onDelete(perform: deleteLost)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var foundList: some View {
//        List {
//            ForEach(filteredFound, id: \.id) { item in
//                FoundRow(item: item) { onFoundTap(item) }
//            }
//            .onDelete(perform: deleteFound)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var lostMap: some View {
//        Map(coordinateRegion: $region, annotationItems: lostPins) { pin in
//            MapAnnotation(coordinate: pin.coordinate) {
//                Button {
//                    if let item = filteredLost.first(where: { $0.id == pin.id }) {
//                        onLostTap(item)
//                    }
//                } label: {
//                    Image(systemName: "mappin.circle.fill")
//                        .font(.title2)
//                        .foregroundColor(.red)
//                }
//            }
//        }
//        .ignoresSafeArea(edges: .bottom)
//    }
//
//    // MARK: – Actions
//
//    private func onLostTap(_ lost: LostItem) {
//        let matches = MatchingService.findMatches(for: lost, in: Array(foundItems))
//        if let found = matches.first,
//           let lID = lost.id?.uuidString, let fID = found.id?.uuidString {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingLostItem = lost
//            showEditSheet = true
//        }
//    }
//
//    private func onFoundTap(_ found: FoundItem) {
//        // Kick off a chat with any lost‐item as context
//        if let anyLost = lostItems.first,
//           let lID = anyLost.id?.uuidString, let fID = found.id?.uuidString {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingFoundItem = found
//            showEditSheet = true
//        }
//    }
//
//    private func deleteLost(at offsets: IndexSet) {
//        offsets.map { filteredLost[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//    private func deleteFound(at offsets: IndexSet) {
//        offsets.map { filteredFound[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//}
//
//// MARK: – Row Views
//
//private struct LostRow: View {
//    let item: LostItem
//    let onTap: () -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let data = item.imageData, let ui = UIImage(data: data) {
//                Image(uiImage: ui)
//                  .resizable()
//                  .scaledToFill()
//                  .frame(height: 120)
//                  .clipped()
//                  .cornerRadius(8)
//            }
//            #endif
//            Text(item.title ?? "No Title").font(.headline)
//            Text(item.desc  ?? "").font(.subheadline)
//            Text("Lost at \(item.location ?? "")")
//              .font(.caption).foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}
//
//private struct FoundRow: View {
//    let item: FoundItem
//    let onTap: () -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let data = item.imageData, let ui = UIImage(data: data) {
//                Image(uiImage: ui)
//                  .resizable()
//                  .scaledToFill()
//                  .frame(height: 120)
//                  .clipped()
//                  .cornerRadius(8)
//            }
//            #endif
//            Text(item.title ?? "No Title").font(.headline)
//            Text(item.desc  ?? "").font(.subheadline)
//            Text("Found at \(item.location ?? "")")
//              .font(.caption).foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}
//
//

//
//import SwiftUI
//import MapKit
//import CoreData
//
//struct BrowseView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // MARK: – Core Data fetches
//    @FetchRequest(
//      entity: LostItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) private var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//      entity: FoundItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) private var foundItems: FetchedResults<FoundItem>
//
//    // MARK: – UI state
//    @State private var searchText    = ""
//    @State private var displayMode   = DisplayMode.lost
//    @State private var region        = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//    )
//    @State private var navigationPath = [String]()
//    @State private var editingLostItem: LostItem?
//    @State private var editingFoundItem: FoundItem?
//    @State private var showEditSheet = false
//
//    enum DisplayMode: String, CaseIterable, Identifiable {
//        case lost = "Lost", found = "Found", map = "Map"
//        var id: String { rawValue }
//    }
//
//    // MARK: – Filtered lists
//    private var filteredLost: [LostItem] {
//        guard !searchText.isEmpty else { return Array(lostItems) }
//        return lostItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//
//    private var filteredFound: [FoundItem] {
//        guard !searchText.isEmpty else { return Array(foundItems) }
//        return foundItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//
//    // MARK: – Map pins for lost items only
//    private struct LostPin: Identifiable {
//        let id: UUID
//        let coordinate: CLLocationCoordinate2D
//    }
//    private var lostPins: [LostPin] {
//        filteredLost.compactMap { item in
//            guard let id = item.id else { return nil }
//            return LostPin(
//                id: id,
//                coordinate: CLLocationCoordinate2D(
//                    latitude: item.latitude,
//                    longitude: item.longitude
//                )
//            )
//        }
//    }
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            VStack(spacing: 8) {
//                // — Search Bar —
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                    TextField(
//                        displayMode == .found
//                          ? "Search found items…"
//                          : "Search lost items…",
//                        text: $searchText
//                    )
//                    .autocorrectionDisabled(true)
//                }
//                .padding(8)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .padding(.horizontal)
//
//                // — Segmented Control —
//                Picker("", selection: $displayMode) {
//                    ForEach(DisplayMode.allCases) { mode in
//                        Text(mode.rawValue).tag(mode)
//                    }
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                // — Content —
//                Group {
//                    switch displayMode {
//                    case .lost:
//                        lostList
//
//                    case .found:
//                        foundList
//
//                    case .map:
//                        lostMap
//                    }
//                }
//                .animation(.default, value: displayMode)
//            }
//            .navigationTitle("Browse")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink {
//                        ChatInboxView()
//                    } label: {
//                        Image(systemName: "bubble.left.and.bubble.right")
//                    }
//                }
//            }
//            // Push into ChatView when sessionID is appended
//            .navigationDestination(for: String.self) { sessionID in
//                ChatView(sessionID: sessionID, currentUser: "owner")
//            }
//            // Edit‐item sheet
//            .sheet(isPresented: $showEditSheet) {
//                if displayMode == .lost, let lost = editingLostItem {
//                    EditLostItemView(item: lost)
//                } else if displayMode == .found, let found = editingFoundItem {
//                    EditFoundItemView(item: found)
//                }
//            }
//        }
//    }
//
//    // MARK: – Subviews
//
//    private var lostList: some View {
//        List {
//            ForEach(filteredLost, id: \.id) { item in
//                LostRow(item: item) { onLostTap(item) }
//            }
//            .onDelete(perform: deleteLost)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var foundList: some View {
//        List {
//            ForEach(filteredFound, id: \.id) { item in
//                FoundRow(item: item) { onFoundTap(item) }
//            }
//            .onDelete(perform: deleteFound)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var lostMap: some View {
//        Map(coordinateRegion: $region, annotationItems: lostPins) { pin in
//            MapAnnotation(coordinate: pin.coordinate) {
//                Button {
//                    guard
//                      let tapped = filteredLost.first(where: { $0.id == pin.id })
//                    else { return }
//                    onLostTap(tapped)
//                } label: {
//                    Image(systemName: "mappin.circle.fill")
//                        .font(.title2)
//                        .foregroundColor(.red)
//                }
//            }
//        }
//        .ignoresSafeArea(edges: .bottom)
//    }
//
//    // MARK: – Actions
//
//    private func onLostTap(_ lost: LostItem) {
//        let matches = MatchingService.findMatches(
//            for: lost,
//            in: Array(foundItems)
//        )
//        if let found = matches.first,
//           let lID = lost.id?.uuidString,
//           let fID = found.id?.uuidString
//        {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingLostItem = lost
//            showEditSheet = true
//        }
//    }
//
//    private func onFoundTap(_ found: FoundItem) {
//        // choose any lost‐item to open a chat thread
//        if let someLost = lostItems.first,
//           let lID = someLost.id?.uuidString,
//           let fID = found.id?.uuidString
//        {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingFoundItem = found
//            showEditSheet = true
//        }
//    }
//
//    private func deleteLost(at offsets: IndexSet) {
//        offsets.map { filteredLost[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//    private func deleteFound(at offsets: IndexSet) {
//        offsets.map { filteredFound[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//}
//
//// MARK: – Row Views
//
//private struct LostRow: View {
//    let item: LostItem
//    let onTap: () -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            if let data = item.imageData,
//               let ui  = UIImage(data: data)
//            {
//                Image(uiImage: ui)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 120)
//                    .clipped()
//                    .cornerRadius(8)
//            }
//            Text(item.title ?? "No Title")
//                .font(.headline)
//            Text(item.desc ?? "")
//                .font(.subheadline)
//            Text("Lost at: \(item.location ?? "")")
//                .font(.caption)
//                .foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}
//
//private struct FoundRow: View {
//    let item: FoundItem
//    let onTap: () -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            if let data = item.imageData,
//               let ui  = UIImage(data: data)
//            {
//                Image(uiImage: ui)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 120)
//                    .clipped()
//                    .cornerRadius(8)
//            }
//            Text(item.title ?? "No Title")
//                .font(.headline)
//            Text(item.desc ?? "")
//                .font(.subheadline)
//            Text("Found at: \(item.location ?? "")")
//                .font(.caption)
//                .foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}
//
//

//
//import SwiftUI
//import MapKit
//import CoreData
//
//struct BrowseView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // MARK: – Core Data fetches
//    @FetchRequest(
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) private var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) private var foundItems: FetchedResults<FoundItem>
//
//    // MARK: – UI state
//    @State private var searchText    = ""
//    @State private var displayMode   = DisplayMode.lost
//    @State private var navigationPath = [String]()
//    @State private var editingLostItem: LostItem?
//    @State private var editingFoundItem: FoundItem?
//    @State private var showEditSheet = false
//
//    // Fixed campus region (Northeastern Boston)
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//    )
//
//    enum DisplayMode: String, CaseIterable, Identifiable {
//        case lost = "Lost", found = "Found", map = "Map"
//        var id: String { rawValue }
//    }
//
//    // MARK: – Filters
//    private var filteredLost: [LostItem] {
//        guard !searchText.isEmpty else { return Array(lostItems) }
//        return lostItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false) ||
//            ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//    private var filteredFound: [FoundItem] {
//        guard !searchText.isEmpty else { return Array(foundItems) }
//        return foundItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false) ||
//            ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//
//    // MARK: – Combined pins for Map mode
//    private struct Pin: Identifiable {
//        let id: UUID
//        let coord: CLLocationCoordinate2D
//        let isLost: Bool
//    }
//    private var allPins: [Pin] {
//        let lostPins = filteredLost.compactMap { item -> Pin? in
//            guard let id = item.id else { return nil }
//            return Pin(id: id,
//                       coord: .init(latitude: item.latitude, longitude: item.longitude),
//                       isLost: true)
//        }
//        let foundPins = filteredFound.compactMap { item -> Pin? in
//            guard let id = item.id else { return nil }
//            return Pin(id: id,
//                       coord: .init(latitude: item.latitude, longitude: item.longitude),
//                       isLost: false)
//        }
//        return lostPins + foundPins
//    }
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            VStack(spacing: 8) {
//                // — Search Bar —
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                    TextField(
//                        displayMode == .found
//                          ? "Search found items…"
//                          : "Search lost items…",
//                        text: $searchText
//                    )
//                    .autocorrectionDisabled(true)
//                }
//                .padding(8)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .padding(.horizontal)
//
//                // — Mode Selector —
//                Picker("", selection: $displayMode) {
//                    ForEach(DisplayMode.allCases) { mode in
//                        Text(mode.rawValue).tag(mode)
//                    }
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                // — Content —
//                Group {
//                    switch displayMode {
//                    case .lost:
//                        lostList
//                    case .found:
//                        foundList
//                    case .map:
//                        mapView
//                    }
//                }
//                .animation(.default, value: displayMode)
//            }
//            .navigationTitle("Browse")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink { ChatInboxView() } label: {
//                        Image(systemName: "bubble.left.and.bubble.right")
//                    }
//                }
//            }
//            .navigationDestination(for: String.self) { sessionID in
//                ChatView(sessionID: sessionID, currentUser: "owner")
//            }
//            .sheet(isPresented: $showEditSheet) {
//                if displayMode == .lost, let lost = editingLostItem {
//                    EditLostItemView(item: lost)
//                } else if displayMode == .found, let found = editingFoundItem {
//                    EditFoundItemView(item: found)
//                }
//            }
//        }
//    }
//
//    // MARK: — Subviews
//
//    private var lostList: some View {
//        List {
//            ForEach(filteredLost, id: \.id) { item in
//                LostRow(item: item) { onLostTap(item) }
//            }
//            .onDelete(perform: deleteLost)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var foundList: some View {
//        List {
//            ForEach(filteredFound, id: \.id) { item in
//                FoundRow(item: item) { onFoundTap(item) }
//            }
//            .onDelete(perform: deleteFound)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var mapView: some View {
//        Map(coordinateRegion: $region, annotationItems: allPins) { pin in
//            MapAnnotation(coordinate: pin.coord) {
//                Image(systemName: pin.isLost
//                      ? "mappin.circle.fill"
//                      : "checkmark.circle.fill")
//                    .font(.title2)
//                    .foregroundColor(pin.isLost ? .red : .green)
//                    .onTapGesture {
//                        // tap navigates just like list
//                        if pin.isLost,
//                           let item = filteredLost.first(where: { $0.id == pin.id }) {
//                            onLostTap(item)
//                        } else if !pin.isLost,
//                                  let item = filteredFound.first(where: { $0.id == pin.id }) {
//                            onFoundTap(item)
//                        }
//                    }
//            }
//        }
//        .ignoresSafeArea(edges: .bottom)
//    }
//
//    // MARK: — Actions
//
//    private func onLostTap(_ lost: LostItem) {
//        let matches = MatchingService.findMatches(
//            for: lost,
//            in: Array(foundItems)
//        )
//        if let found = matches.first,
//           let lID = lost.id?.uuidString,
//           let fID = found.id?.uuidString {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingLostItem = lost
//            showEditSheet = true
//        }
//    }
//
//    private func onFoundTap(_ found: FoundItem) {
//        // pick any lost item to start the chat
//        if let someLost = lostItems.first,
//           let lID = someLost.id?.uuidString,
//           let fID = found.id?.uuidString {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingFoundItem = found
//            showEditSheet = true
//        }
//    }
//
//    private func deleteLost(at offsets: IndexSet) {
//        offsets.map { filteredLost[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//    private func deleteFound(at offsets: IndexSet) {
//        offsets.map { filteredFound[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//}
//
//// MARK: – Row Views
//
//private struct LostRow: View {
//    let item: LostItem
//    let onTap: () -> Void
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let data = item.imageData,
//               let ui = UIImage(data: data)
//            {
//                Image(uiImage: ui)
//                  .resizable()
//                  .scaledToFill()
//                  .frame(height: 120)
//                  .clipped()
//                  .cornerRadius(8)
//            }
//            #endif
//            Text(item.title ?? "No Title")
//                .font(.headline)
//            Text(item.desc ?? "")
//                .font(.subheadline)
//            Text("Lost at: \(item.location ?? "")")
//                .font(.caption)
//                .foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}
//
//private struct FoundRow: View {
//    let item: FoundItem
//    let onTap: () -> Void
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let data = item.imageData,
//               let ui = UIImage(data: data)
//            {
//                Image(uiImage: ui)
//                  .resizable()
//                  .scaledToFill()
//                  .frame(height: 120)
//                  .clipped()
//                  .cornerRadius(8)
//            }
//            #endif
//            Text(item.title ?? "No Title")
//                .font(.headline)
//            Text(item.desc ?? "")
//                .font(.subheadline)
//            Text("Found at: \(item.location ?? "")")
//                .font(.caption)
//                .foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}



//
//import SwiftUI
//import MapKit
//import CoreData
//
//struct BrowseView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // MARK: Core Data fetches
//    @FetchRequest(
//        entity: LostItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) private var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//        entity: FoundItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) private var foundItems: FetchedResults<FoundItem>
//
//    // MARK: UI State
//    @State private var searchText     = ""
//    @State private var displayMode    = DisplayMode.lost
//    @State private var navigationPath = [String]()
//    @State private var editingLost    : LostItem?
//    @State private var editingFound   : FoundItem?
//    @State private var showEditSheet  = false
//
//    // Fixed campus region
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
//
//    enum DisplayMode: String, CaseIterable, Identifiable {
//        case lost  = "Lost", found = "Found", map = "Map"
//        var id: String { rawValue }
//    }
//
//    // MARK: Filters
//    private var filteredLost: [LostItem] {
//        searchText.isEmpty
//            ? Array(lostItems)
//            : lostItems.filter {
//                ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//                || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//            }
//    }
//    private var filteredFound: [FoundItem] {
//        searchText.isEmpty
//            ? Array(foundItems)
//            : foundItems.filter {
//                ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//                || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//            }
//    }
//
//    // MARK: Pins combining both types
//    private struct Pin: Identifiable {
//        let id: UUID
//        let coord: CLLocationCoordinate2D
//        let isLost: Bool
//    }
//    private var allPins: [Pin] {
//        let lostPins = filteredLost.compactMap { item -> Pin? in
//            guard let id = item.id else { return nil }
//            return Pin(id: id,
//                       coord: .init(latitude: item.latitude, longitude: item.longitude),
//                       isLost: true)
//        }
//        let foundPins = filteredFound.compactMap { item -> Pin? in
//            guard let id = item.id else { return nil }
//            return Pin(id: id,
//                       coord: .init(latitude: item.latitude, longitude: item.longitude),
//                       isLost: false)
//        }
//        return lostPins + foundPins
//    }
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            VStack(spacing: 8) {
//                // — Search Bar —
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                    TextField(
//                        displayMode == .found
//                          ? "Search found items…"
//                          : "Search lost items…",
//                        text: $searchText
//                    )
//                    .autocorrectionDisabled(true)
//                }
//                .padding(8)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .padding(.horizontal)
//
//                // — Segmented Control —
//                Picker("", selection: $displayMode) {
//                    ForEach(DisplayMode.allCases) { mode in
//                        Text(mode.rawValue).tag(mode)
//                    }
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                // — Content —
//                Group {
//                    switch displayMode {
//                    case .lost:  lostList
//                    case .found: foundList
//                    case .map:   mapView
//                    }
//                }
//                .animation(.default, value: displayMode)
//            }
//            .navigationTitle("Browse")
//            .toolbar {
//                // Chat inbox button
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink { ChatInboxView() } label: {
//                        Image(systemName: "bubble.left.and.bubble.right")
//                    }
//                }
//                // Re-center button
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: { resetRegion() }) {
//                        Image(systemName: "location.circle")
//                    }
//                }
//            }
//            // Deep link into a ChatView
//            .navigationDestination(for: String.self) { sessionID in
//                ChatView(sessionID: sessionID, currentUser: "owner")
//            }
//            // Edit-sheet
//            .sheet(isPresented: $showEditSheet) {
//                if displayMode == .lost, let l = editingLost {
//                    EditLostItemView(item: l)
//                } else if displayMode == .found, let f = editingFound {
//                    EditFoundItemView(item: f)
//                }
//            }
//        }
//    }
//
//    // MARK: Subviews
//
//    private var lostList: some View {
//        List {
//            ForEach(filteredLost, id: \.id) { item in
//                LostRow(item: item) { onLostTap(item) }
//            }
//            .onDelete(perform: deleteLost)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var foundList: some View {
//        List {
//            ForEach(filteredFound, id: \.id) { item in
//                FoundRow(item: item) { onFoundTap(item) }
//            }
//            .onDelete(perform: deleteFound)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var mapView: some View {
//        Map(coordinateRegion: $region, annotationItems: allPins) { pin in
//            MapMarker(
//                coordinate: pin.coord,
//                tint: pin.isLost ? .red : .green
//            )
//        }
//        .ignoresSafeArea(edges: .bottom)
//    }
//
//    // MARK: Actions
//
//    private func onLostTap(_ lost: LostItem) {
//        let matches = MatchingService.findMatches(
//            for: lost,
//            in: Array(foundItems)
//        )
//        if let found = matches.first,
//           let lID = lost.id?.uuidString,
//           let fID = found.id?.uuidString {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingLost = lost
//            showEditSheet = true
//        }
//    }
//
//    private func onFoundTap(_ found: FoundItem) {
//        if let anyLost = lostItems.first,
//           let lID = anyLost.id?.uuidString,
//           let fID = found.id?.uuidString {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingFound = found
//            showEditSheet = true
//        }
//    }
//
//    private func deleteLost(at offsets: IndexSet) {
//        offsets.map { filteredLost[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//
//    private func deleteFound(at offsets: IndexSet) {
//        offsets.map { filteredFound[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//
//    private func resetRegion() {
//        withAnimation {
//            region = MKCoordinateRegion(
//                center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            )
//        }
//    }
//}
//
//// MARK: — Row Views
//
//private struct LostRow: View {
//    let item: LostItem
//    let onTap: () -> Void
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let d = item.imageData, let ui = UIImage(data: d) {
//                Image(uiImage: ui)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 120)
//                    .clipped()
//                    .cornerRadius(8)
//            }
//            #endif
//            Text(item.title ?? "No Title").font(.headline)
//            Text(item.desc ?? "").font(.subheadline)
//            Text("Lost at: \(item.location ?? "")")
//                .font(.caption).foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}
//
//private struct FoundRow: View {
//    let item: FoundItem
//    let onTap: () -> Void
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let d = item.imageData, let ui = UIImage(data: d) {
//                Image(uiImage: ui)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 120)
//                    .clipped()
//                    .cornerRadius(8)
//            }
//            #endif
//            Text(item.title ?? "No Title").font(.headline)
//            Text(item.desc ?? "").font(.subheadline)
//            Text("Found at: \(item.location ?? "")")
//                .font(.caption).foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}


//
//import SwiftUI
//import MapKit
//import CoreData
//
//struct BrowseView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // MARK: – Core Data fetches
//    @FetchRequest(
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) private var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) private var foundItems: FetchedResults<FoundItem>
//
//    // MARK: – UI state
//    @State private var searchText     = ""
//    @State private var displayMode    = DisplayMode.lost
//    @State private var navigationPath = [String]()
//    @State private var editingLost    : LostItem?
//    @State private var editingFound   : FoundItem?
//    @State private var showEditSheet  = false
//
//    // Fixed campus region
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
//
//    enum DisplayMode: String, CaseIterable, Identifiable {
//        case lost  = "Lost", found = "Found", map = "Map"
//        var id: String { rawValue }
//    }
//
//    // MARK: – Filters
//    private var filteredLost: [LostItem] {
//        searchText.isEmpty
//            ? Array(lostItems)
//            : lostItems.filter {
//                ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//                || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//            }
//    }
//    private var filteredFound: [FoundItem] {
//        searchText.isEmpty
//            ? Array(foundItems)
//            : foundItems.filter {
//                ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//                || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//            }
//    }
//
//    // MARK: – Combined pins
//    private struct Pin: Identifiable {
//        let id: UUID
//        let coord: CLLocationCoordinate2D
//        let isLost: Bool
//    }
//    private var allPins: [Pin] {
//        let lostPins = filteredLost.compactMap { item -> Pin? in
//            guard let id = item.id else { return nil }
//            return .init(id: id,
//                         coord: .init(latitude: item.latitude, longitude: item.longitude),
//                         isLost: true)
//        }
//        let foundPins = filteredFound.compactMap { item -> Pin? in
//            guard let id = item.id else { return nil }
//            return .init(id: id,
//                         coord: .init(latitude: item.latitude, longitude: item.longitude),
//                         isLost: false)
//        }
//        return lostPins + foundPins
//    }
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            VStack(spacing: 8) {
//                // — Search Bar —
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                    TextField(
//                        displayMode == .found
//                          ? "Search found items…"
//                          : "Search lost items…",
//                        text: $searchText
//                    )
//                    .autocorrectionDisabled(true)
//                }
//                .padding(8)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .padding(.horizontal)
//
//                // — Segmented Control —
//                Picker("", selection: $displayMode) {
//                    ForEach(DisplayMode.allCases) { mode in
//                        Text(mode.rawValue).tag(mode)
//                    }
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                // — Content —
//                Group {
//                    switch displayMode {
//                    case .lost:  lostList
//                    case .found: foundList
//                    case .map:   mapView
//                    }
//                }
//                .animation(.default, value: displayMode)
//            }
//            .navigationTitle("Browse")
//            .toolbar {
//                // Chat Inbox
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink { ChatInboxView() } label: {
//                        Image(systemName: "bubble.left.and.bubble.right")
//                    }
//                }
//                // Notifications
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink { NotificationsView() } label: {
//                        Image(systemName: "bell")
//                    }
//                }
//                // Recenter map (only in map mode)
//                if displayMode == .map {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button(action: resetRegion) {
//                            Image(systemName: "location.circle")
//                        }
//                    }
//                }
//            }
//            // Deep-link to chat thread
//            .navigationDestination(for: String.self) { sessionID in
//                ChatView(sessionID: sessionID, currentUser: "owner")
//            }
//            // Edit-sheet
//            .sheet(isPresented: $showEditSheet) {
//                if displayMode == .lost, let l = editingLost {
//                    EditLostItemView(item: l)
//                } else if displayMode == .found, let f = editingFound {
//                    EditFoundItemView(item: f)
//                }
//            }
//        }
//    }
//
//    // MARK: Subviews
//
//    private var lostList: some View {
//        List {
//            ForEach(filteredLost, id: \.id) { item in
//                LostRow(item: item) { onLostTap(item) }
//            }
//            .onDelete(perform: deleteLost)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var foundList: some View {
//        List {
//            ForEach(filteredFound, id: \.id) { item in
//                FoundRow(item: item) { onFoundTap(item) }
//            }
//            .onDelete(perform: deleteFound)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var mapView: some View {
//        Map(coordinateRegion: $region,
//            annotationItems: allPins
//        ) { pin in
//            MapMarker(
//                coordinate: pin.coord,
//                tint: pin.isLost ? .red : .green
//            )
//        }
//        .ignoresSafeArea(edges: .bottom)
//    }
//
//    // MARK: Actions
//
//    private func onLostTap(_ lost: LostItem) {
//        if let found = MatchingService.findMatches(for: lost, in: Array(foundItems)).first,
//           let lID = lost.id?.uuidString,
//           let fID = found.id?.uuidString {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingLost = lost
//            showEditSheet = true
//        }
//    }
//
//    private func onFoundTap(_ found: FoundItem) {
//        if let anyLost = lostItems.first,
//           let lID = anyLost.id?.uuidString,
//           let fID = found.id?.uuidString {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingFound = found
//            showEditSheet = true
//        }
//    }
//
//    private func deleteLost(at offsets: IndexSet) {
//        offsets.map { filteredLost[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//    private func deleteFound(at offsets: IndexSet) {
//        offsets.map { filteredFound[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//
//    private func resetRegion() {
//        withAnimation {
//            region = MKCoordinateRegion(
//                center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            )
//        }
//    }
//}
//
//// MARK: — Row Views
//
//private struct LostRow: View {
//    let item: LostItem
//    let onTap: () -> Void
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let d = item.imageData, let ui = UIImage(data: d) {
//                Image(uiImage: ui)
//                  .resizable().scaledToFill()
//                  .frame(height: 120).clipped().cornerRadius(8)
//            }
//            #endif
//            Text(item.title ?? "No Title").font(.headline)
//            Text(item.desc  ?? "").font(.subheadline)
//            Text("Lost at: \(item.location ?? "")")
//              .font(.caption).foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}
//
//private struct FoundRow: View {
//    let item: FoundItem
//    let onTap: () -> Void
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let d = item.imageData, let ui = UIImage(data: d) {
//                Image(uiImage: ui)
//                  .resizable().scaledToFill()
//                  .frame(height: 120).clipped().cornerRadius(8)
//            }
//            #endif
//            Text(item.title ?? "No Title").font(.headline)
//            Text(item.desc  ?? "").font(.subheadline)
//            Text("Found at: \(item.location ?? "")")
//              .font(.caption).foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}
//
//import SwiftUI
//import MapKit
//import CoreData
//
//struct BrowseView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // MARK: – Core Data fetches
//    @FetchRequest(
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) private var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) private var foundItems: FetchedResults<FoundItem>
//
//    // MARK: – UI state
//    @State private var searchText     = ""
//    @State private var displayMode    = DisplayMode.lost
//    @State private var navigationPath = [String]()
//    @State private var editingLost    : LostItem?
//    @State private var editingFound   : FoundItem?
//    @State private var showEditSheet  = false
//
//    // Fixed campus region
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
//
//    enum DisplayMode: String, CaseIterable, Identifiable {
//        case lost  = "Lost", found = "Found", map = "Map"
//        var id: String { rawValue }
//    }
//
//    // MARK: – Filters
//    private var filteredLost: [LostItem] {
//        guard !searchText.isEmpty else { return Array(lostItems) }
//        return lostItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//    private var filteredFound: [FoundItem] {
//        guard !searchText.isEmpty else { return Array(foundItems) }
//        return foundItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//
//    // MARK: – Combined pins
//    private struct Pin: Identifiable {
//        let id: UUID
//        let coord: CLLocationCoordinate2D
//        let isLost: Bool
//    }
//
//    private var allPins: [Pin] {
//        // Explicitly annotate types to help the compiler
//        let lostPins: [Pin] = filteredLost.compactMap { item in
//            guard let id = item.id else { return nil }
//            return Pin(
//                id: id,
//                coord: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude),
//                isLost: true
//            )
//        }
//        let foundPins: [Pin] = filteredFound.compactMap { item in
//            guard let id = item.id else { return nil }
//            return Pin(
//                id: id,
//                coord: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude),
//                isLost: false
//            )
//        }
//        return lostPins + foundPins
//    }
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            VStack(spacing: 8) {
//                // — Search Bar —
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                    TextField(
//                        displayMode == .found
//                            ? "Search found items…"
//                            : "Search lost items…",
//                        text: $searchText
//                    )
//                    .autocorrectionDisabled(true)
//                }
//                .padding(8)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .padding(.horizontal)
//
//                // — Segmented Control —
//                Picker("", selection: $displayMode) {
//                    ForEach(DisplayMode.allCases) { mode in
//                        Text(mode.rawValue).tag(mode)
//                    }
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                // — Content —
//                Group {
//                    switch displayMode {
//                    case .lost:  lostList
//                    case .found: foundList
//                    case .map:   mapView
//                    }
//                }
//                .animation(.default, value: displayMode)
//            }
//            .navigationTitle("Browse")
//            .toolbar {
//                // Chat Inbox
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink { ChatInboxView() } label: {
//                        Image(systemName: "bubble.left.and.bubble.right")
//                    }
//                }
//                // Notifications
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink { NotificationsView() } label: {
//                        Image(systemName: "bell")
//                    }
//                }
//                // Recenter map (only in map mode)
//                if displayMode == .map {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button(action: resetRegion) {
//                            Image(systemName: "location.circle")
//                        }
//                    }
//                }
//            }
//            // Deep-link to chat thread
//            .navigationDestination(for: String.self) { sessionID in
//                ChatView(sessionID: sessionID/*, currentUser: "owner"*/)
//            }
//            // Edit-sheet
//            .sheet(isPresented: $showEditSheet) {
//                if displayMode == .lost, let l = editingLost {
//                    EditLostItemView(item: l)
//                } else if displayMode == .found, let f = editingFound {
//                    EditFoundItemView(item: f)
//                }
//            }
//        }
//    }
//
//    // MARK: Subviews
//
//    private var lostList: some View {
//        List {
//            ForEach(filteredLost, id: \.id) { item in
//                LostRow(item: item) { onLostTap(item) }
//            }
//            .onDelete(perform: deleteLost)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var foundList: some View {
//        List {
//            ForEach(filteredFound, id: \.id) { item in
//                FoundRow(item: item) { onFoundTap(item) }
//            }
//            .onDelete(perform: deleteFound)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var mapView: some View {
//        Map(
//            coordinateRegion: $region,
//            annotationItems: allPins,
//            annotationContent: { (pin: Pin) in
//                MapMarker(
//                    coordinate: pin.coord,
//                    tint: pin.isLost ? .red : .green
//                )
//            }
//        )
//        .ignoresSafeArea(edges: .bottom)
//    }
//
//    // MARK: Actions
//
//    private func onLostTap(_ lost: LostItem) {
//        if let found = MatchingService.findMatches(for: lost, in: Array(foundItems))
//                            .first,
//           let lID = lost.id?.uuidString,
//           let fID = found.id?.uuidString
//        {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingLost = lost
//            showEditSheet = true
//        }
//    }
//
//    private func onFoundTap(_ found: FoundItem) {
//        if let anyLost = lostItems.first,
//           let lID = anyLost.id?.uuidString,
//           let fID = found.id?.uuidString
//        {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingFound = found
//            showEditSheet = true
//        }
//    }
//
//    private func deleteLost(at offsets: IndexSet) {
//        offsets.map { filteredLost[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//    private func deleteFound(at offsets: IndexSet) {
//        offsets.map { filteredFound[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//
//    private func resetRegion() {
//        withAnimation {
//            region = MKCoordinateRegion(
//                center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            )
//        }
//    }
//}
//
//// MARK: — Row Views
//
//private struct LostRow: View {
//    let item: LostItem
//    let onTap: () -> Void
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let d = item.imageData, let ui = UIImage(data: d) {
//                Image(uiImage: ui)
//                  .resizable()
//                  .scaledToFill()
//                  .frame(height: 120)
//                  .clipped()
//                  .cornerRadius(8)
//            }
//            #endif
//            Text(item.title ?? "No Title").font(.headline)
//            Text(item.desc  ?? "").font(.subheadline)
//            Text("Lost at: \(item.location ?? "")")
//              .font(.caption)
//              .foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}
//
//private struct FoundRow: View {
//    let item: FoundItem
//    let onTap: () -> Void
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let d = item.imageData, let ui = UIImage(data: d) {
//                Image(uiImage: ui)
//                  .resizable()
//                  .scaledToFill()
//                  .frame(height: 120)
//                  .clipped()
//                  .cornerRadius(8)
//            }
//            #endif
//            Text(item.title ?? "No Title").font(.headline)
//            Text(item.desc  ?? "").font(.subheadline)
//            Text("Found at: \(item.location ?? "")")
//              .font(.caption)
//              .foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}


//
//import SwiftUI
//import MapKit
//import CoreData
//
//struct BrowseView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // MARK: – Core Data fetches
//    @FetchRequest(
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) private var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) private var foundItems: FetchedResults<FoundItem>
//
//    // MARK: – UI state
//    @State private var searchText     = ""
//    @State private var displayMode    = DisplayMode.lost
//    @State private var navigationPath = [String]()
//    @State private var editingLost    : LostItem?
//    @State private var editingFound   : FoundItem?
//    @State private var showEditSheet  = false
//
//    // Fixed campus region
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
//
//    enum DisplayMode: String, CaseIterable, Identifiable {
//        case lost  = "Lost", found = "Found", map = "Map"
//        var id: String { rawValue }
//    }
//
//    // MARK: – Filters
//    private var filteredLost: [LostItem] {
//        guard !searchText.isEmpty else { return Array(lostItems) }
//        return lostItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//    private var filteredFound: [FoundItem] {
//        guard !searchText.isEmpty else { return Array(foundItems) }
//        return foundItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//
//    // MARK: – Combined pins
//    private struct Pin: Identifiable {
//        let id: UUID
//        let coord: CLLocationCoordinate2D
//        let isLost: Bool
//    }
//
//    private var allPins: [Pin] {
//        let lostPins: [Pin] = filteredLost.compactMap { item in
//            guard let id = item.id else { return nil }
//            return Pin(
//                id: id,
//                coord: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude),
//                isLost: true
//            )
//        }
//        let foundPins: [Pin] = filteredFound.compactMap { item in
//            guard let id = item.id else { return nil }
//            return Pin(
//                id: id,
//                coord: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude),
//                isLost: false
//            )
//        }
//        return lostPins + foundPins
//    }
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            VStack(spacing: 8) {
//                // — Search Bar —
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                    TextField(
//                        displayMode == .found
//                          ? "Search found items…"
//                          : "Search lost items…",
//                        text: $searchText
//                    )
//                    .autocorrectionDisabled(true)
//                }
//                .padding(8)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .padding(.horizontal)
//
//                // — Segmented Control —
//                Picker("", selection: $displayMode) {
//                    ForEach(DisplayMode.allCases) { mode in
//                        Text(mode.rawValue).tag(mode)
//                    }
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                // — Content —
//                Group {
//                    switch displayMode {
//                    case .lost:  lostList
//                    case .found: foundList
//                    case .map:   mapView
//                    }
//                }
//                .animation(.default, value: displayMode)
//            }
//            .navigationTitle("Browse")
//            .toolbar {
//                // Chat Inbox
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(value: "inbox") {
//                        Image(systemName: "bubble.left.and.bubble.right")
//                    }
//                }
//                // Notifications
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(value: "notifications") {
//                        Image(systemName: "bell")
//                    }
//                }
//                // Recenter map (only in map mode)
//                if displayMode == .map {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button(action: resetRegion) {
//                            Image(systemName: "location.circle")
//                        }
//                    }
//                }
//            }
//
//            // — Single, root-level destination handler for all String values —
//            .navigationDestination(for: String.self) { value in
//                switch value {
//                case "inbox":
//                    ChatInboxView()
//                case "notifications":
//                    NotificationsView()
//                default:
//                    // deep-link into a chat thread
//                    ChatView(sessionID: value)
//                }
//            }
//            // Edit-sheet
//            .sheet(isPresented: $showEditSheet) {
//                if displayMode == .lost, let l = editingLost {
//                    EditLostItemView(item: l)
//                } else if displayMode == .found, let f = editingFound {
//                    EditFoundItemView(item: f)
//                }
//            }
//        }
//    }
//
//    // MARK: Subviews
//
//    private var lostList: some View {
//        List {
//            ForEach(filteredLost, id: \.id) { item in
//                LostRow(item: item) {
//                    onLostTap(item)
//                }
//            }
//            .onDelete(perform: deleteLost)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var foundList: some View {
//        List {
//            ForEach(filteredFound, id: \.id) { item in
//                FoundRow(item: item) {
//                    onFoundTap(item)
//                }
//            }
//            .onDelete(perform: deleteFound)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var mapView: some View {
//        Map(
//            coordinateRegion: $region,
//            annotationItems: allPins
//        ) { pin in
//            MapMarker(
//                coordinate: pin.coord,
//                tint: pin.isLost ? .red : .green
//            )
//        }
//        .ignoresSafeArea(edges: .bottom)
//    }
//
//    // MARK: Actions
//
//    private func onLostTap(_ lost: LostItem) {
//        if let found = MatchingService.findMatches(for: lost, in: Array(foundItems)).first,
//           let lID = lost.id?.uuidString,
//           let fID = found.id?.uuidString
//        {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingLost = lost
//            showEditSheet = true
//        }
//    }
//
//    private func onFoundTap(_ found: FoundItem) {
//        if let anyLost = lostItems.first,
//           let lID = anyLost.id?.uuidString,
//           let fID = found.id?.uuidString
//        {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingFound = found
//            showEditSheet = true
//        }
//    }
//
//    private func deleteLost(at offsets: IndexSet) {
//        offsets.map { filteredLost[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//    private func deleteFound(at offsets: IndexSet) {
//        offsets.map { filteredFound[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//
//    private func resetRegion() {
//        withAnimation {
//            region = MKCoordinateRegion(
//                center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            )
//        }
//    }
//}
//
//
//// MARK: — Row Views
//
//private struct LostRow: View {
//    let item: LostItem
//    let onTap: () -> Void
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let d = item.imageData, let ui = UIImage(data: d) {
//                Image(uiImage: ui)
//                  .resizable().scaledToFill()
//                  .frame(height: 120).clipped().cornerRadius(8)
//            }
//            #endif
//            Text(item.title  ?? "No Title").font(.headline)
//            Text(item.desc   ?? "").font(.subheadline)
//            Text("Lost at: \(item.location ?? "")")
//              .font(.caption).foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}
//
//private struct FoundRow: View {
//    let item: FoundItem
//    let onTap: () -> Void
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let d = item.imageData, let ui = UIImage(data: d) {
//                Image(uiImage: ui)
//                  .resizable().scaledToFill()
//                  .frame(height: 120).clipped().cornerRadius(8)
//            }
//            #endif
//            Text(item.title  ?? "No Title").font(.headline)
//            Text(item.desc   ?? "").font(.subheadline)
//            Text("Found at: \(item.location ?? "")")
//              .font(.caption).foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}

//
//import SwiftUI
//import MapKit
//import CoreData
//
//struct BrowseView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    // MARK: – Core Data fetches
//    @FetchRequest(
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) private var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) private var foundItems: FetchedResults<FoundItem>
//
//    // MARK: – Who am I? (owner vs finder)
//    @AppStorage("currentUserType") private var currentUserType: String = "owner"
//
//    // MARK: – UI state
//    @State private var searchText     = ""
//    @State private var displayMode    = DisplayMode.lost
//    @State private var navigationPath = [String]()
//    @State private var editingLost    : LostItem?
//    @State private var editingFound   : FoundItem?
//    @State private var showEditSheet  = false
//
//    // Fixed campus region
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
//
//    enum DisplayMode: String, CaseIterable, Identifiable {
//        case lost  = "Lost", found = "Found", map = "Map"
//        var id: String { rawValue }
//    }
//
//    // MARK: – Filters
//    private var filteredLost: [LostItem] {
//        guard !searchText.isEmpty else { return Array(lostItems) }
//        return lostItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//    private var filteredFound: [FoundItem] {
//        guard !searchText.isEmpty else { return Array(foundItems) }
//        return foundItems.filter {
//            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
//            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
//        }
//    }
//
//    // MARK: – Combined pins
//    private struct Pin: Identifiable {
//        let id: UUID
//        let coord: CLLocationCoordinate2D
//        let isLost: Bool
//    }
//
//    private var allPins: [Pin] {
//        let lostPins: [Pin] = filteredLost.compactMap { item in
//            guard let id = item.id else { return nil }
//            return Pin(
//                id: id,
//                coord: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude),
//                isLost: true
//            )
//        }
//        let foundPins: [Pin] = filteredFound.compactMap { item in
//            guard let id = item.id else { return nil }
//            return Pin(
//                id: id,
//                coord: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude),
//                isLost: false
//            )
//        }
//        return lostPins + foundPins
//    }
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            VStack(spacing: 8) {
//                // — Search Bar —
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                    TextField(
//                        displayMode == .found
//                          ? "Search found items…"
//                          : "Search lost items…",
//                        text: $searchText
//                    )
//                    .autocorrectionDisabled(true)
//                }
//                .padding(8)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .padding(.horizontal)
//
//                // — Segmented Control —
//                Picker("", selection: $displayMode) {
//                    ForEach(DisplayMode.allCases) { mode in
//                        Text(mode.rawValue).tag(mode)
//                    }
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                // — Content —
//                Group {
//                    switch displayMode {
//                    case .lost:  lostList
//                    case .found: foundList
//                    case .map:   mapView
//                    }
//                }
//                .animation(.default, value: displayMode)
//            }
//            .navigationTitle("Browse")
//            .toolbar {
//                // Chat Inbox
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(value: "inbox") {
//                        Image(systemName: "bubble.left.and.bubble.right")
//                    }
//                }
//                // Notifications
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(value: "notifications") {
//                        Image(systemName: "bell")
//                    }
//                }
//                // Recenter map (only in map mode)
//                if displayMode == .map {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button(action: resetRegion) {
//                            Image(systemName: "location.circle")
//                        }
//                    }
//                }
//            }
//
//            //
//            // — Single, root-level navigationDestination for ALL String values —
//            //
//            .navigationDestination(for: String.self) { value in
//                switch value {
//                case "inbox":
//                    ChatInboxView()
//                case "notifications":
//                    NotificationsView()
//                default:
//                    // deep-link into a chat thread
//                    ChatView(
//                      sessionID: value,
//                      currentUserType: currentUserType
//                    )
//                }
//            }
//            // Edit-sheet
//            .sheet(isPresented: $showEditSheet) {
//                if displayMode == .lost, let l = editingLost {
//                    EditLostItemView(item: l)
//                } else if displayMode == .found, let f = editingFound {
//                    EditFoundItemView(item: f)
//                }
//            }
//        }
//    }
//
//    // MARK: Subviews
//
//    private var lostList: some View {
//        List {
//            ForEach(filteredLost, id: \.id) { item in
//                LostRow(item: item) { onLostTap(item) }
//            }
//            .onDelete(perform: deleteLost)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var foundList: some View {
//        List {
//            ForEach(filteredFound, id: \.id) { item in
//                FoundRow(item: item) { onFoundTap(item) }
//            }
//            .onDelete(perform: deleteFound)
//        }
//        .listStyle(.insetGrouped)
//    }
//
//    private var mapView: some View {
//        Map(
//            coordinateRegion: $region,
//            annotationItems: allPins
//        ) { pin in
//            MapMarker(
//                coordinate: pin.coord,
//                tint: pin.isLost ? .red : .green
//            )
//        }
//        .ignoresSafeArea(edges: .bottom)
//    }
//
//    // MARK: Actions
//
//    private func onLostTap(_ lost: LostItem) {
//        if let found = MatchingService.findMatches(for: lost, in: Array(foundItems)).first,
//           let lID = lost.id?.uuidString,
//           let fID = found.id?.uuidString
//        {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingLost = lost
//            showEditSheet = true
//        }
//    }
//
//    private func onFoundTap(_ found: FoundItem) {
//        if let anyLost = lostItems.first,
//           let lID = anyLost.id?.uuidString,
//           let fID = found.id?.uuidString
//        {
//            navigationPath.append("\(lID)_\(fID)")
//        } else {
//            editingFound = found
//            showEditSheet = true
//        }
//    }
//
//    private func deleteLost(at offsets: IndexSet) {
//        offsets.map { filteredLost[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//    private func deleteFound(at offsets: IndexSet) {
//        offsets.map { filteredFound[$0] }.forEach(viewContext.delete)
//        try? viewContext.save()
//    }
//
//    private func resetRegion() {
//        withAnimation {
//            region = MKCoordinateRegion(
//                center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            )
//        }
//    }
//}
//
//// MARK: — Row Views
//
//private struct LostRow: View {
//    let item: LostItem
//    let onTap: () -> Void
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let d = item.imageData, let ui = UIImage(data: d) {
//                Image(uiImage: ui)
//                  .resizable().scaledToFill()
//                  .frame(height: 120).clipped().cornerRadius(8)
//            }
//            #endif
//            Text(item.title  ?? "No Title").font(.headline)
//            Text(item.desc   ?? "").font(.subheadline)
//            Text("Lost at: \(item.location ?? "")")
//              .font(.caption).foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}
//
//private struct FoundRow: View {
//    let item: FoundItem
//    let onTap: () -> Void
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            #if canImport(UIKit)
//            if let d = item.imageData, let ui = UIImage(data: d) {
//                Image(uiImage: ui)
//                  .resizable().scaledToFill()
//                  .frame(height: 120).clipped().cornerRadius(8)
//            }
//            #endif
//            Text(item.title  ?? "No Title").font(.headline)
//            Text(item.desc   ?? "").font(.subheadline)
//            Text("Found at: \(item.location ?? "")")
//              .font(.caption).foregroundColor(.secondary)
//        }
//        .contentShape(Rectangle())
//        .onTapGesture(perform: onTap)
//    }
//}


import SwiftUI
import MapKit
import CoreData

struct BrowseView: View {
    @Environment(\.managedObjectContext) private var viewContext

    // MARK: – Core Data fetches
    @FetchRequest(
      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
    ) private var lostItems: FetchedResults<LostItem>

    @FetchRequest(
      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
    ) private var foundItems: FetchedResults<FoundItem>

    // MARK: – Who am I? (owner vs finder)
    @AppStorage("currentUserType") private var currentUserType: String = "owner"

    // MARK: – UI state
    @State private var searchText     = ""
    @State private var displayMode    = DisplayMode.lost
    @State private var navigationPath = [String]()

    // Fixed campus region
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    enum DisplayMode: String, CaseIterable, Identifiable {
        case lost  = "Lost", found = "Found", map = "Map"
        var id: String { rawValue }
    }

    // MARK: – Filters
    private var filteredLost: [LostItem] {
        guard !searchText.isEmpty else { return Array(lostItems) }
        return lostItems.filter {
            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }
    private var filteredFound: [FoundItem] {
        guard !searchText.isEmpty else { return Array(foundItems) }
        return foundItems.filter {
            ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false)
            || ($0.location?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }

    // MARK: – Combined pins
    private struct Pin: Identifiable {
        let id: UUID
        let coord: CLLocationCoordinate2D
        let isLost: Bool
    }
    private var allPins: [Pin] {
        let lostPins: [Pin] = filteredLost.compactMap { item in
            guard let id = item.id else { return nil }
            return Pin(id: id,
                       coord: CLLocationCoordinate2D(
                            latitude: item.latitude, longitude: item.longitude),
                       isLost: true)
        }
        let foundPins: [Pin] = filteredFound.compactMap { item in
            guard let id = item.id else { return nil }
            return Pin(id: id,
                       coord: CLLocationCoordinate2D(
                            latitude: item.latitude, longitude: item.longitude),
                       isLost: false)
        }
        return lostPins + foundPins
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 8) {
                // — Search Bar —
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField(
                        displayMode == .found
                          ? "Search found items…"
                          : "Search lost items…",
                        text: $searchText
                    )
                    .autocorrectionDisabled(true)
                }
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

                // — Segmented Control —
                Picker("", selection: $displayMode) {
                    ForEach(DisplayMode.allCases) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // — Content —
                Group {
                    switch displayMode {
                    case .lost:  lostList
                    case .found: foundList
                    case .map:   mapView
                    }
                }
                .animation(.default, value: displayMode)
            }
            .navigationTitle("Lost and Found Hub")
            .toolbar {
                // Notifications
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(value: "notifications") {
                        Image(systemName: "bell")
                    }
                }
                
                // Chat Inbox
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(value: "inbox") {
                        Image(systemName: "bubble.left.and.bubble.right")
                    }
                    .neuBranded() 
                }
             
                // Recenter map (only in map mode)
                if displayMode == .map {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: resetRegion) {
                            Image(systemName: "location.circle")
                        }
                    }
                }
            }

            // Single root-level destination for ALL navigation “values”
            .navigationDestination(for: String.self) { value in
                switch value {
                  case "inbox":
                    ChatInboxView()
                  case "notifications":
                    NotificationsView()
                  default:
                    ChatView(
                      sessionID: value,
                      currentUserType: currentUserType
                    )
                }
            }
        }
    }

    // MARK: – Subviews

    private var lostList: some View {
        List {
            ForEach(filteredLost, id: \.id) { item in
                LostRow(item: item) {
//                    onLostTap(item)
                }
            }
            .onDelete(perform: deleteLost)
        }
        .listStyle(.insetGrouped)
    }

    private var foundList: some View {
        List {
            ForEach(filteredFound, id: \.id) { item in
                FoundRow(item: item) {
                    onFoundTap(item)
                }
            }
            .onDelete(perform: deleteFound)
        }
        .listStyle(.insetGrouped)
    }

    private var mapView: some View {
        Map(
            coordinateRegion: $region,
            annotationItems: allPins
        ) { pin in
            MapMarker(
                coordinate: pin.coord,
                tint: pin.isLost ? .red : .green
            )
        }
        .ignoresSafeArea(edges: .bottom)
    }

    // MARK: – Actions

//    private func onLostTap(_ lost: LostItem) {
//        guard
//          let found = MatchingService.findMatches(
//                        for: lost,
//                        in: Array(foundItems)
//                      ).first,
//          let lID = lost.id?.uuidString,
//          let fID = found.id?.uuidString
//        else {
//            // no-edit mode → simply do nothing (or you can show an Alert)
//            return
//        }
//        navigationPath.append("\(lID)_\(fID)")
//    }

    private func onFoundTap(_ found: FoundItem) {
        guard
          let anyLost = lostItems.first,
          let lID     = anyLost.id?.uuidString,
          let fID     = found.id?.uuidString
        else { return }
        navigationPath.append("\(lID)_\(fID)")
    }

    private func deleteLost(at offsets: IndexSet) {
        offsets.map { filteredLost[$0] }.forEach(viewContext.delete)
        try? viewContext.save()
    }
    private func deleteFound(at offsets: IndexSet) {
        offsets.map { filteredFound[$0] }.forEach(viewContext.delete)
        try? viewContext.save()
    }

    private func resetRegion() {
        withAnimation {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }
}

// MARK: — Row Views

private struct LostRow: View {
    let item: LostItem
    let onTap: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            #if canImport(UIKit)
            if let data = item.imageData,
               let ui   = UIImage(data: data)
            {
                Image(uiImage: ui)
                  .resizable()
                  .scaledToFill()
                  .frame(height: 120)
                  .clipped()
                  .cornerRadius(8)
            }
            #endif
            Text(item.title  ?? "No Title").font(.headline)
            Text(item.desc   ?? "").font(.subheadline)
            Text("Lost at: \(item.location ?? "")")
              .font(.caption)
              .foregroundColor(.secondary)
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: onTap)
    }
}

private struct FoundRow: View {
    let item: FoundItem
    let onTap: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            #if canImport(UIKit)
            if let data = item.imageData,
               let ui   = UIImage(data: data)
            {
                Image(uiImage: ui)
                  .resizable()
                  .scaledToFill()
                  .frame(height: 120)
                  .clipped()
                  .cornerRadius(8)
            }
            #endif
            Text(item.title  ?? "No Title").font(.headline)
            Text(item.desc   ?? "").font(.subheadline)
            Text("Found at: \(item.location ?? "")")
              .font(.caption)
              .foregroundColor(.secondary)
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: onTap)
    }
}
