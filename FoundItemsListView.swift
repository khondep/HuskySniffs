//
//  FoundItemsListView.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//

//import SwiftUI
//
//struct FoundItemsListView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        entity: FoundItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) var foundItems: FetchedResults<FoundItem>
//
//    @State private var searchText = ""
//    @State private var editingItem: FoundItem?
//    @State private var showEditSheet = false
//
//    var filteredItems: [FoundItem] {
//        if searchText.isEmpty {
//            return Array(foundItems)
//        } else {
//            return foundItems.filter {
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
//                        Text(item.title ?? "No Title")
//                            .font(.headline)
//                        Text(item.desc ?? "")
//                            .font(.subheadline)
//                        Text("Found at: \(item.location ?? "")")
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
//            .navigationTitle("Found Items")
//            .sheet(isPresented: $showEditSheet) {
//                if let item = editingItem {
//                    EditFoundItemView(item: item)
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



//import SwiftUI
//
//struct FoundItemsListView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        entity: FoundItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) var foundItems: FetchedResults<FoundItem>
//
//    @State private var searchText = ""
//    @State private var editingItem: FoundItem?
//    @State private var showEditSheet = false
//
//    var filteredItems: [FoundItem] {
//        if searchText.isEmpty {
//            return Array(foundItems)
//        } else {
//            return foundItems.filter {
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
//                        Text("Found at: \(item.location ?? "")")
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
//            .navigationTitle("Found Items")
//            .sheet(isPresented: $showEditSheet) {
//                if let item = editingItem {
//                    EditFoundItemView(item: item)
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
