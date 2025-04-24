////
////  MatchesView.swift
////  LostAndFoundHub
////
////  Created by Purvang Khonde on 4/4/25.
////
//

//import SwiftUI
//import CoreData
//
//struct MatchesView: View {
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
//    var body: some View {
//        NavigationView {
//            List {
//                if lostItems.isEmpty {
//                    Text("No lost items reported yet.")
//                        .foregroundColor(.gray)
//                        .padding()
//                } else {
//                    ForEach(lostItems, id: \.id) { lostItem in
//                        Section(header: Text("Matches for: \(lostItem.title ?? "Unknown Item")")) {
//                            let rawMatches = MatchingService.findMatches(for: lostItem, in: Array(foundItems))
//                            let matches = uniqueByUser(matches: rawMatches)
//
//                            if matches.isEmpty {
//                                Text("No matches found.")
//                                    .foregroundColor(.gray)
//                            } else {
//                                ForEach(matches, id: \.id) { foundItem in
//                                    let sessionID = "\(lostItem.id?.uuidString ?? "")_\(foundItem.id?.uuidString ?? "")"
//                                    let lastMessage = ChatService.latestMessage(for: sessionID, context: viewContext)
//
//                                    VStack(alignment: .leading, spacing: 6) {
//                                        HStack {
//                                            VStack(alignment: .leading, spacing: 4) {
//                                                Text(foundItem.title ?? "")
//                                                    .font(.headline)
//
//                                                Text("Found at: \(foundItem.location ?? "")")
//                                                    .font(.subheadline)
//                                                    .foregroundColor(.gray)
//
//                                                if let lastMessage = lastMessage {
//                                                    Text("💬 \(lastMessage.text ?? "")")
//                                                        .font(.caption)
//                                                        .foregroundColor(.secondary)
//                                                }
//                                            }
//                                            Spacer()
//                                            NavigationLink(destination: ChatView(
//                                                sessionID: sessionID,
//                                                currentUser: "owner"
//                                            )) {
//                                                Image(systemName: "bubble.left.and.bubble.right.fill")
//                                                    .foregroundColor(.blue)
//                                                    .imageScale(.medium)
//                                            }
//                                        }
//                                    }
//                                    .padding(.vertical, 6)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .listStyle(InsetGroupedListStyle())
//            .navigationTitle("AI Matches")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(destination: ChatInboxView()) {
//                        Image(systemName: "bubble.left.and.bubble.right.fill")
//                            .imageScale(.large)
//                    }
//                }
//            }
//        }
//    }
//
//    private func uniqueByUser(matches: [FoundItem]) -> [FoundItem] {
//        var seenLocations = Set<String>()
//        return matches.filter { item in
//            guard let location = item.location else { return false }
//            if seenLocations.contains(location) {
//                return false
//            } else {
//                seenLocations.insert(location)
//                return true
//            }
//        }
//    }
//}
//import SwiftUI
//import CoreData
//
//struct MatchesView: View {
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
//    var body: some View {
//        NavigationView {
//            List {
//                if lostItems.isEmpty {
//                    Text("No lost items reported yet.")
//                        .foregroundColor(.gray)
//                        .padding()
//                } else {
//                    ForEach(lostItems, id: \.id) { lostItem in
//                        Section(header: Text("Matches for: \(lostItem.title ?? "Unknown Item")")) {
//                            let rawMatches = MatchingService.findMatches(for: lostItem, in: Array(foundItems))
//                            let matches = uniqueByUser(matches: rawMatches)
//
//                            if matches.isEmpty {
//                                Text("No matches found.")
//                                    .foregroundColor(.gray)
//                            } else {
//                                ForEach(matches, id: \.id) { foundItem in
//                                    let sessionID = "\(lostItem.id?.uuidString ?? "")_\(foundItem.id?.uuidString ?? "")"
//                                    let lastMessage = ChatService.latestMessage(for: sessionID, context: viewContext)
//
//                                    VStack(alignment: .leading, spacing: 6) {
//                                        HStack(alignment: .top) {
//                                            if let data = foundItem.imageData, let image = UIImage(data: data) {
//                                                Image(uiImage: image)
//                                                    .resizable()
//                                                    .scaledToFill()
//                                                    .frame(width: 60, height: 60)
//                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
//                                                    .padding(.trailing, 8)
//                                            }
//
//                                            VStack(alignment: .leading, spacing: 4) {
//                                                Text(foundItem.title ?? "")
//                                                    .font(.headline)
//
//                                                Text("Found at: \(foundItem.location ?? "")")
//                                                    .font(.subheadline)
//                                                    .foregroundColor(.gray)
//
//                                                if let lastMessage = lastMessage {
//                                                    Text("💬 \(lastMessage.text ?? "")")
//                                                        .font(.caption)
//                                                        .foregroundColor(.secondary)
//                                                }
//                                            }
//                                            Spacer()
//                                            NavigationLink(destination: ChatView(
//                                                sessionID: sessionID,
//                                                currentUser: "owner"
//                                            )) {
//                                                Image(systemName: "bubble.left.and.bubble.right.fill")
//                                                    .foregroundColor(.blue)
//                                                    .imageScale(.medium)
//                                            }
//                                        }
//                                    }
//                                    .padding(.vertical, 6)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .listStyle(InsetGroupedListStyle())
//            .navigationTitle("AI Matches")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(destination: ChatInboxView()) {
//                        Image(systemName: "bubble.left.and.bubble.right.fill")
//                            .imageScale(.large)
//                    }
//                }
//            }
//        }
//    }
//
//    private func uniqueByUser(matches: [FoundItem]) -> [FoundItem] {
//        var seenLocations = Set<String>()
//        return matches.filter { item in
//            guard let location = item.location else { return false }
//            if seenLocations.contains(location) {
//                return false
//            } else {
//                seenLocations.insert(location)
//                return true
//            }
//        }
//    }
//}

//
//import SwiftUI
//import CoreData
//
//struct MatchesView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//      entity: LostItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//      entity: FoundItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) var foundItems: FetchedResults<FoundItem>
//
//    /// Minimum match score to consider
//    private let threshold: Double = 0.3
//
//    var body: some View {
//        NavigationStack {
//            List {
//                if lostItems.isEmpty {
//                    Text("No lost items reported yet.")
//                        .foregroundColor(.gray)
//                        .padding()
//                } else {
//                    ForEach(lostItems) { lost in
//                        Section(header: Text("Matches for: \(lost.title ?? "Unknown")")) {
//                            let rawMatches = MatchingService.findMatches(
//                                for: lost,
//                                in: Array(foundItems),
//                                minimumScore: threshold
//                            )
//                            let matches = uniqueByFinder(matches: rawMatches)
//
//                            if matches.isEmpty {
//                                Text("No matches found.")
//                                    .foregroundColor(.gray)
//                            } else {
//                                ForEach(matches) { found in
//                                    matchRow(lost: lost, found: found)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .listStyle(.insetGrouped)
//            .navigationTitle("AI Matches")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(destination: ChatInboxView()) {
//                        Image(systemName: "bubble.left.and.bubble.right.fill")
//                            .imageScale(.large)
//                    }
//                }
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func matchRow(lost: LostItem, found: FoundItem) -> some View {
//        // build a chat session ID
//        let sessionID = "\(lost.id!.uuidString)_\(found.id!.uuidString)"
//        let lastMsg  = ChatService.latestMessage(for: sessionID, context: viewContext)
//
//        HStack(alignment: .top, spacing: 12) {
//            // thumbnail
//            if let data = found.imageData,
//               let ui = UIImage(data: data)
//            {
//                Image(uiImage: ui)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 60, height: 60)
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//            }
//
//            // details
//            VStack(alignment: .leading, spacing: 4) {
//                Text(found.title ?? "")
//                    .font(.headline)
//                Text("Found at: \(found.location ?? "")")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                if let msg = lastMsg {
//                    Text("💬 \(msg.text ?? "")")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
//            }
//            Spacer()
//
//            // Chat button
//            NavigationLink(destination: ChatView(sessionID: sessionID, currentUser: "owner")) {
//                Image(systemName: "bubble.left.and.bubble.right.fill")
//                    .foregroundColor(.blue)
//                    .imageScale(.medium)
//            }
//        }
//        .padding(.vertical, 6)
//    }
//
//    /// Deduplicate by finder (ownerEmail)
//    private func uniqueByFinder(matches: [FoundItem]) -> [FoundItem] {
//        var seen = Set<String>()
//        return matches.filter { item in
//            let key = item.finderEmail ?? item.id?.uuidString ?? UUID().uuidString
//            guard !seen.contains(key) else { return false }
//            seen.insert(key)
//            return true
//        }
//    }
//}



//import SwiftUI
//import CoreData
//
//struct MatchesView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//      entity: LostItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//      entity: FoundItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) var foundItems: FetchedResults<FoundItem>
//
//    var body: some View {
//        NavigationStack {
//            List {
//                if lostItems.isEmpty {
//                    Text("No lost items reported yet.")
//                        .foregroundColor(.gray)
//                        .padding()
//                } else {
//                    ForEach(lostItems) { lost in
//                        Section(header: Text("Matches for: \(lost.title ?? "Unknown")")) {
//                            let rawMatches = MatchingService
//                                .findMatches(for: lost, in: Array(foundItems))
//                            let matches = uniqueByFinder(matches: rawMatches)
//
//                            if matches.isEmpty {
//                                Text("No matches found.")
//                                    .foregroundColor(.gray)
//                            } else {
//                                ForEach(matches) { found in
//                                    matchRow(lost: lost, found: found)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .listStyle(.insetGrouped)
//            .navigationTitle("AI Matches")
//            .toolbar {
//                // inbox button
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(value: "inbox") {
//                        Image(systemName: "bubble.left.and.bubble.right.fill")
//                            .imageScale(.large)
//                    }
//                }
//            }
//            // handle pushed values: either a sessionID or "inbox"
//            .navigationDestination(for: String.self) { value in
//                if value == "inbox" {
//                    ChatInboxView()
//                } else {
//                    ChatView(sessionID: value, currentUser: "owner")
//                }
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func matchRow(lost: LostItem, found: FoundItem) -> some View {
//        let sessionID = "\(lost.id!.uuidString)_\(found.id!.uuidString)"
//        let lastMsg  = ChatService.latestMessage(for: sessionID, context: viewContext)
//
//        HStack(alignment: .top, spacing: 12) {
//            if let data = found.imageData, let ui = UIImage(data: data) {
//                Image(uiImage: ui)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 60, height: 60)
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//            }
//
//            VStack(alignment: .leading, spacing: 4) {
//                Text(found.title ?? "")
//                    .font(.headline)
//                Text("Found at: \(found.location ?? "")")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                if let msg = lastMsg {
//                    Text("💬 \(msg.text ?? "")")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
//            }
//            Spacer()
//
//            // Push the chat screen for this session
//            NavigationLink(value: sessionID) {
//                Image(systemName: "bubble.left.and.bubble.right.fill")
//                    .foregroundColor(.blue)
//                    .imageScale(.medium)
//            }
//        }
//        .padding(.vertical, 6)
//    }
//
//    /// Deduplicate by finderEmail so each person only shows once per lost item
//    private func uniqueByFinder(matches: [FoundItem]) -> [FoundItem] {
//        var seen = Set<String>()
//        return matches.filter { item in
//            let key = item.finderEmail ?? item.id?.uuidString ?? UUID().uuidString
//            if seen.contains(key) { return false }
//            seen.insert(key)
//            return true
//        }
//    }
//}


//
//import SwiftUI
//import CoreData
//
//struct MatchesView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//      entity: LostItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//      entity: FoundItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) var foundItems: FetchedResults<FoundItem>
//
//    var body: some View {
//        NavigationStack {
//            List {
//                if lostItems.isEmpty {
//                    Text("No lost items reported yet.")
//                        .foregroundColor(.gray)
//                        .padding()
//                } else {
//                    ForEach(lostItems) { lost in
//                        Section(header: Text("Matches for: \(lost.title ?? "Unknown")")) {
//                            let rawMatches = MatchingService
//                                .findMatches(for: lost, in: Array(foundItems))
//                            let matches = uniqueByFinder(matches: rawMatches)
//
//                            if matches.isEmpty {
//                                Text("No matches found.")
//                                    .foregroundColor(.gray)
//                            } else {
//                                ForEach(matches) { found in
//                                    matchRow(lost: lost, found: found)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .listStyle(.insetGrouped)
//            .navigationTitle("AI Matches")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(value: "inbox") {
//                        Image(systemName: "bubble.left.and.bubble.right.fill")
//                            .imageScale(.large)
//                    }
//                }
//            }
//            .navigationDestination(for: String.self) { value in
//                if value == "inbox" {
//                    ChatInboxView()
//                } else {
//                    // ChatView now only takes sessionID
//                    ChatView(sessionID: value)
//                }
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func matchRow(lost: LostItem, found: FoundItem) -> some View {
//        let sessionID = "\(lost.id!.uuidString)_\(found.id!.uuidString)"
//        // Use fetchMessages + last() instead of latestMessage
//        let lastMsg = ChatService.fetchMessages(for: sessionID, context: viewContext).last
//
//        HStack(alignment: .top, spacing: 12) {
//            if let data = found.imageData, let ui = UIImage(data: data) {
//                Image(uiImage: ui)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 60, height: 60)
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//            }
//
//            VStack(alignment: .leading, spacing: 4) {
//                Text(found.title ?? "")
//                    .font(.headline)
//                Text("Found at: \(found.location ?? "")")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                if let msg = lastMsg {
//                    Text("💬 \(msg.text ?? "")")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
//            }
//            Spacer()
//
//            NavigationLink(value: sessionID) {
//                Image(systemName: "bubble.left.and.bubble.right.fill")
//                    .foregroundColor(.blue)
//                    .imageScale(.medium)
//            }
//        }
//        .padding(.vertical, 6)
//    }
//
//    /// Deduplicate by finderEmail so each person only shows once per lost item
//    private func uniqueByFinder(matches: [FoundItem]) -> [FoundItem] {
//        var seen = Set<String>()
//        return matches.filter { item in
//            let key = item.finderEmail ?? item.id?.uuidString ?? UUID().uuidString
//            if seen.contains(key) { return false }
//            seen.insert(key)
//            return true
//        }
//    }
//}


//
//import SwiftUI
//import CoreData
//
//struct MatchesView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//      entity: LostItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//      entity: FoundItem.entity(),
//      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) var foundItems: FetchedResults<FoundItem>
//
//    var body: some View {
//        NavigationStack {
//            List {
//                if lostItems.isEmpty {
//                    Text("No lost items reported yet.")
//                        .foregroundColor(.gray)
//                        .padding()
//                } else {
//                    ForEach(lostItems) { lost in
//                        Section(header: Text("Matches for: \(lost.title ?? "Unknown")")) {
//                            let rawMatches = MatchingService
//                                .findMatches(for: lost, in: Array(foundItems))
//                            let matches = uniqueByFinder(matches: rawMatches)
//
//                            if matches.isEmpty {
//                                Text("No matches found.")
//                                    .foregroundColor(.gray)
//                            } else {
//                                ForEach(matches) { found in
//                                    matchRow(lost: lost, found: found)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .listStyle(.insetGrouped)
//            .navigationTitle("AI Matches")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(value: "inbox") {
//                        Image(systemName: "bubble.left.and.bubble.right.fill")
//                            .imageScale(.large)
//                    }
//                }
//            }
//            // **Root‐level** destination only
//            .navigationDestination(for: String.self) { value in
//                if value == "inbox" {
//                    ChatInboxView()
//                } else {
//                    ChatView(sessionID: value)
//                }
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func matchRow(lost: LostItem, found: FoundItem) -> some View {
//        let sessionID = "\(lost.id!.uuidString)_\(found.id!.uuidString)"
//        let lastMsg = ChatService.fetchMessages(for: sessionID, context: viewContext).last
//
//        HStack(alignment: .top, spacing: 12) {
//            if let data = found.imageData, let ui = UIImage(data: data) {
//                Image(uiImage: ui)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 60, height: 60)
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//            }
//
//            VStack(alignment: .leading, spacing: 4) {
//                Text(found.title ?? "")
//                    .font(.headline)
//                Text("Found at: \(found.location ?? "")")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                if let msg = lastMsg {
//                    Text("💬 \(msg.text ?? "")")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
//            }
//
//            Spacer()
//
//            NavigationLink(value: sessionID) {
//                Image(systemName: "bubble.left.and.bubble.right.fill")
//                    .foregroundColor(.blue)
//                    .imageScale(.medium)
//            }
//        }
//        .padding(.vertical, 6)
//    }
//
//    /// Deduplicate by finderEmail so each person shows only once per lost item
//    private func uniqueByFinder(matches: [FoundItem]) -> [FoundItem] {
//        var seen = Set<String>()
//        return matches.filter { item in
//            let key = item.finderEmail ?? item.id?.uuidString ?? UUID().uuidString
//            if seen.contains(key) { return false }
//            seen.insert(key)
//            return true
//        }
//    }
//}

//
//import SwiftUI
//import CoreData
//
//struct MatchesView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserType") private var currentUserType: String = "owner"
//
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
//    var body: some View {
//        NavigationStack {
//            List {
//                if lostItems.isEmpty {
//                    Text("No lost items reported yet.")
//                        .foregroundColor(.gray)
//                        .padding()
//                } else {
//                    ForEach(lostItems) { lost in
//                        Section(header: Text("Matches for: \(lost.title ?? "Unknown")")) {
//                            let rawMatches = MatchingService
//                                .findMatches(for: lost, in: Array(foundItems))
//                            let matches = uniqueByFinder(matches: rawMatches)
//
//                            if matches.isEmpty {
//                                Text("No matches found.")
//                                    .foregroundColor(.gray)
//                            } else {
//                                ForEach(matches) { found in
//                                    matchRow(lost: lost, found: found)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .listStyle(.insetGrouped)
//            .navigationTitle("AI Matches")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(value: "inbox") {
//                        Image(systemName: "bubble.left.and.bubble.right")
//                            .imageScale(.large)
//                    }
//                    .neuBranded() 
//                }
//            }
//            // Single, root‐level destination for all String values
//            .navigationDestination(for: String.self) { value in
//                if value == "inbox" {
//                    ChatInboxView()
//                } else {
//                    ChatView(
//                      sessionID: value,
//                      currentUserType: currentUserType
//                    )
//                }
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func matchRow(lost: LostItem, found: FoundItem) -> some View {
//        let sessionID = "\(lost.id!.uuidString)_\(found.id!.uuidString)"
//        let lastMsg  = ChatService.fetchMessages(for: sessionID, context: viewContext).last
//
//        HStack(alignment: .top, spacing: 12) {
//            if let data = found.imageData,
//               let ui = UIImage(data: data)
//            {
//                Image(uiImage: ui)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 60, height: 60)
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//            }
//
//            VStack(alignment: .leading, spacing: 4) {
//                Text(found.title ?? "")
//                    .font(.headline)
//                Text("Found at: \(found.location ?? "")")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                if let msg = lastMsg {
//                    Text("💬 \(msg.text ?? "")")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
//            }
//
//            Spacer()
//
//            // Push into ChatView, passing along currentUserType
//            NavigationLink(value: sessionID) {
//                Image(systemName: "bubble.left.and.bubble.right.fill")
//                    .foregroundColor(.blue)
//                    .imageScale(.medium)
//            }
//        }
//        .padding(.vertical, 6)
//    }
//
//    /// Deduplicate by finderEmail so each person shows only once
//    private func uniqueByFinder(matches: [FoundItem]) -> [FoundItem] {
//        var seen = Set<String>()
//        return matches.filter { item in
//            let key = item.finderEmail
//                  ?? item.id?.uuidString
//                  ?? UUID().uuidString
//            guard !seen.contains(key) else { return false }
//            seen.insert(key)
//            return true
//        }
//    }
//}


import SwiftUI
import CoreData

struct MatchesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("currentUserType") private var currentUserType: String = "owner"

    @FetchRequest(
      entity: LostItem.entity(),
      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
    ) private var lostItems: FetchedResults<LostItem>

    @FetchRequest(
      entity: FoundItem.entity(),
      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
    ) private var foundItems: FetchedResults<FoundItem>

    private var sortedLost: [LostItem] {
        let withMatches = lostItems.filter { lost in
            !MatchingService.findMatches(for: lost, in: Array(foundItems)).isEmpty
        }
        let without    = lostItems.filter { lost in
            MatchingService.findMatches(for: lost, in: Array(foundItems)).isEmpty
        }
        return withMatches + without
    }

    var body: some View {
        NavigationStack {
            List {
                if sortedLost.isEmpty {
                    Text("No lost items reported yet.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(sortedLost) { lost in
                        Section(header: Text("Matches for: \(lost.title ?? "Unknown")")) {
                            let rawMatches = MatchingService
                                .findMatches(for: lost, in: Array(foundItems))
                            let matches = uniqueByFinder(matches: rawMatches)

                            if matches.isEmpty {
                                Text("No matches found.")
                                    .foregroundColor(.gray)
                            } else {
                                ForEach(matches) { found in
                                    matchRow(lost: lost, found: found)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("AI Matches")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(value: "inbox") {
                        Image(systemName: "bubble.left.and.bubble.right")
                            .imageScale(.large)
                    }
                }
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                case "inbox":
                    ChatInboxView()
                default:
                    ChatView(sessionID: value, currentUserType: currentUserType)
                }
            }
        }
        .neuBranded()
    }

    @ViewBuilder
    private func matchRow(lost: LostItem, found: FoundItem) -> some View {
        let sessionID = "\(lost.id!.uuidString)_\(found.id!.uuidString)"
        let lastMsg  = ChatService.fetchMessages(for: sessionID, context: viewContext).last

        HStack(alignment: .top, spacing: 12) {
            if let data = found.imageData,
               let ui   = UIImage(data: data)
            {
                Image(uiImage: ui)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(found.title ?? "")
                    .font(.headline)
                Text("Found at: \(found.location ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                if let msg = lastMsg {
                    Text("💬 \(msg.text ?? "")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            NavigationLink(value: sessionID) {
                Image(systemName: "bubble.left.and.bubble.right.fill")
                    .foregroundColor(.blue)
                    .imageScale(.medium)
            }
        }
        .padding(.vertical, 6)
    }

    private func uniqueByFinder(matches: [FoundItem]) -> [FoundItem] {
        var seen = Set<String>()
        return matches.filter { item in
            let key = item.finderEmail
                  ?? item.id?.uuidString
                  ?? UUID().uuidString
            guard !seen.contains(key) else { return false }
            seen.insert(key)
            return true
        }
    }
}
