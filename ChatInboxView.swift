//
//  ChatInboxView.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//
//
//import SwiftUI
//import CoreData
//
//struct ChatInboxView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        entity: ChatMessage.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: false)]
//    ) var allMessages: FetchedResults<ChatMessage>
//
//    var groupedSessions: [(sessionID: String, lastMessage: ChatMessage)] {
//        let grouped = Dictionary(grouping: allMessages) { $0.sessionID ?? "unknown" }
//        return grouped.compactMap { (key, messages) in
//            guard let latest = messages.sorted(by: { ($0.timestamp ?? .distantPast) > ($1.timestamp ?? .distantPast) }).first else {
//                return nil
//            }
//            return (sessionID: key, lastMessage: latest)
//        }
//        .sorted(by: { $0.lastMessage.timestamp ?? .distantPast > $1.lastMessage.timestamp ?? .distantPast })
//    }
//
//    var body: some View {
//        List {
//            ForEach(groupedSessions, id: \.sessionID) { session in
//                NavigationLink(destination: ChatView(sessionID: session.sessionID, currentUser: "owner")) {
//                    VStack(alignment: .leading) {
//                        Text("Chat: \(session.sessionID)")
//                            .font(.headline)
//                        Text(session.lastMessage.text ?? "")
//                            .font(.subheadline)
//                            .lineLimit(1)
//                        Text(session.lastMessage.timestamp?.timeAgoString() ?? "")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                    .padding(.vertical, 4)
//                }
//            }
//        }
//        .navigationTitle("Your Chats")
//    }
//}



//import SwiftUI
//import CoreData
//
//struct ChatInboxView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        entity: ChatMessage.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: false)]
//    ) var allMessages: FetchedResults<ChatMessage>
//
//    /// Groups messages by sessionID and picks the latest one
//    private var groupedSessions: [(sessionID: String, lastMessage: ChatMessage)] {
//        let bySession = Dictionary(grouping: allMessages) { $0.sessionID ?? "" }
//        return bySession.compactMap { sessionID, messages in
//            guard !sessionID.isEmpty,
//                  let latest = messages.max(by: {
//                    ($0.timestamp ?? .distantPast) < ($1.timestamp ?? .distantPast)
//                  })
//            else { return nil }
//            return (sessionID: sessionID, lastMessage: latest)
//        }
//        .sorted(by: {
//            ($0.lastMessage.timestamp ?? .distantPast) > ($1.lastMessage.timestamp ?? .distantPast)
//        })
//    }
//
//    var body: some View {
//        List {
//            ForEach(groupedSessions, id: \.sessionID) { session in
//                // Look up the other party’s display name
//                let name = ChatService.participantName(
//                    for: session.sessionID,
//                    currentUser: "owner",
//                    context: viewContext
//                )
//
//                NavigationLink(destination: ChatView(
//                    sessionID: session.sessionID,
//                    currentUser: "owner"
//                )) {
//                    VStack(alignment: .leading, spacing: 4) {
//                        Text(name)
//                            .font(.headline)
//
//                        Text(session.lastMessage.text ?? "")
//                            .font(.subheadline)
//                            .lineLimit(1)
//
//                        Text(session.lastMessage.timestamp?.timeAgoString() ?? "")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                    .padding(.vertical, 6)
//                }
//            }
//        }
//        .navigationTitle("Your Chats")
//    }
//}


//import SwiftUI
//
//struct ChatInboxView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: false)]
//    ) var messages: FetchedResults<ChatMessage>
//
//    /// Group by session, then pick latest
//    private var sessions: [(id: String, last: ChatMessage)] {
//        Dictionary(grouping: messages, by: { $0.sessionID ?? "" })
//            .compactMap { key, msgs in
//                guard let latest = msgs.max(by: {
//                    ($0.timestamp ?? .distantPast) < ($1.timestamp ?? .distantPast)
//                }) else { return nil }
//                return (id: key, last: latest)
//            }
//            .sorted(by: { $0.last.timestamp ?? .distantPast > $1.last.timestamp ?? .distantPast })
//    }
//
//    var body: some View {
//        List(sessions, id: \.id) { sess in
//            NavigationLink(isActive: sess.id) {
//                ChatView(sessionID: sess.id)
//            } label: {
//                VStack(alignment: .leading, spacing: 4) {
//                    // partner’s name instead of session ID
//                    Text(
//                        ChatService.partnerName(
//                            for: sess.id,
//                            currentUserEmail: currentUserEmail,
//                            context: viewContext
//                        )
//                    )
//                    .font(.headline)
//
//                    Text(sess.last.text ?? "")
//                        .font(.subheadline)
//                        .lineLimit(1)
//
//                    Text(sess.last.timestamp?.timeAgoString() ?? "")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                }
//                .padding(.vertical, 4)
//            }
//        }
//        .navigationTitle("Your Chats")
//    }
//}


//
//import SwiftUI
//import CoreData
//
//struct ChatInboxView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: false)]
//    ) var messages: FetchedResults<ChatMessage>
//
//    /// Group by session, then pick the most recent message per session
//    private var sessions: [(id: String, last: ChatMessage)] {
//        Dictionary(grouping: messages, by: { $0.sessionID ?? "" })
//            .compactMap { sessionID, msgs in
//                guard let latest = msgs.max(by: {
//                    ($0.timestamp ?? .distantPast) < ($1.timestamp ?? .distantPast)
//                }) else { return nil }
//                return (id: sessionID, last: latest)
//            }
//            .sorted {
//                ($0.last.timestamp ?? .distantPast) > ($1.last.timestamp ?? .distantPast)
//            }
//    }
//
//    var body: some View {
//        List(sessions, id: \.id) { sess in
//            // Push the session ID into the NavigationStack
//            NavigationLink(value: sess.id) {
//                VStack(alignment: .leading, spacing: 4) {
//                    // Show partner’s name instead of raw sessionID
//                    Text(
//                        ChatService.partnerName(
//                            for: sess.id,
//                            currentUserEmail: currentUserEmail,
//                            context: viewContext
//                        )
//                    )
//                    .font(.headline)
//
//                    Text(sess.last.text ?? "")
//                        .font(.subheadline)
//                        .lineLimit(1)
//
//                    Text(sess.last.timestamp?.timeAgoString() ?? "")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                }
//                .padding(.vertical, 4)
//            }
//        }
//        .navigationTitle("Your Chats")
//        // Wire up the pushed sessionID to ChatView
//        .navigationDestination(for: String.self) { sessionID in
//            ChatView(sessionID: sessionID)
//        }
//    }
//}


//
//import SwiftUI
//import CoreData
//
//struct ChatInboxView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @FetchRequest(
//      sortDescriptors: [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: false)]
//    ) var allMessages: FetchedResults<ChatMessage>
//
//    /// Group messages by sessionID, pick the most‐recent in each
//    private var sessions: [(sessionID: String, last: ChatMessage)] {
//        Dictionary(grouping: allMessages, by: { $0.sessionID ?? "" })
//          .compactMap { key, msgs in
//            guard let latest = msgs.max(by: {
//              ($0.timestamp ?? .distantPast) < ($1.timestamp ?? .distantPast)
//            }) else { return nil }
//            return (sessionID: key, last: latest)
//        }
//        .sorted(by: {
//          ($0.last.timestamp ?? .distantPast) > ($1.last.timestamp ?? .distantPast)
//        })
//    }
//
//    var body: some View {
//        List(sessions, id:\.sessionID) { sess in
//            let partner = ChatService.partnerName(
//              for: sess.sessionID,
//              currentUserEmail: currentUserEmail,
//              context: viewContext
//            )
//            NavigationLink(value: sess.sessionID) {
//                VStack(alignment: .leading) {
//                    Text(partner)
//                        .font(.headline)
//                    Text(sess.last.text ?? "")
//                        .font(.subheadline)
//                        .lineLimit(1)
//                    Text(sess.last.timestamp?.timeAgoString() ?? "")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                }
//                .padding(.vertical, 4)
//            }
//        }
//        .navigationTitle("Your Chats")
//        // this uses the same path type (String) as BrowseView’s
//        .navigationDestination(for: String.self) { sessionID in
//            ChatView(sessionID: sessionID)
//        }
//    }
//}

//
//import SwiftUI
//import CoreData
//
//struct ChatInboxView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserType") private var currentUserType: String = "owner"
//
//    @FetchRequest(
//      sortDescriptors: [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: false)]
//    ) var allMessages: FetchedResults<ChatMessage>
//
//    private var sessions: [(id: String, last: ChatMessage)] {
//        Dictionary(grouping: allMessages, by: { $0.sessionID ?? "" })
//          .compactMap { key, msgs in
//            guard let latest = msgs.max(by: {
//              ($0.timestamp ?? .distantPast) < ($1.timestamp ?? .distantPast)
//            }) else { return nil }
//            return (id: key, last: latest)
//        }
//        .sorted(by: {
//          ($0.last.timestamp ?? .distantPast) > ($1.last.timestamp ?? .distantPast)
//        })
//    }
//
//    var body: some View {
//        List(sessions, id: \.id) { sess in
//            let partner = ChatService.partnerName(
//              for: sess.id,
//              currentUserType: currentUserType,
//              context: viewContext
//            )
//            NavigationLink(value: sess.id) {
//                VStack(alignment: .leading, spacing: 4) {
//                    Text(partner).font(.headline)
//                    Text(sess.last.text ?? "")
//                      .font(.subheadline)
//                      .lineLimit(1)
//                    Text(sess.last.timestamp?.timeAgoString() ?? "")
//                      .font(.caption)
//                      .foregroundColor(.gray)
//                }
//                .padding(.vertical, 4)
//            }
//        }
//        .navigationTitle("Your Chats")
//        .navigationDestination(for: String.self) { sessionID in
//            ChatView(sessionID: sessionID, currentUserType: currentUserType)
//        }
//    }
//}

import SwiftUI
import CoreData

struct ChatInboxView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("currentUserType") private var currentUserType: String = "owner"

    @FetchRequest(
      sortDescriptors: [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: false)]
    ) private var allMessages: FetchedResults<ChatMessage>

    // Build sessions: id + last message
    private var sessions: [(id: String, last: ChatMessage)] {
        Dictionary(grouping: allMessages, by: { $0.sessionID ?? "" })
        .compactMap { key, msgs in
            guard let latest = msgs.max(by: {
                ($0.timestamp ?? .distantPast) < ($1.timestamp ?? .distantPast)
            }) else { return nil }
            return (id: key, last: latest)
        }
        .sorted(by: { $0.last.timestamp ?? .distantPast > $1.last.timestamp ?? .distantPast })
    }

    var body: some View {
        List {
            ForEach(sessions, id: \.id) { session in
                NavigationLink(value: session.id) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(
                            ChatService.partnerName(
                                for: session.id,
                                currentUserType: currentUserType,
                                context: viewContext
                            )
                        )
                        .font(.headline)

                        Text(session.last.text ?? "")
                            .font(.subheadline)
                            .lineLimit(1)

                        Text(session.last.timestamp?.timeAgoString() ?? "")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
            }
            .onDelete(perform: deleteSessions)
        }
        .navigationTitle("Your Chats")
        .navigationDestination(for: String.self) { sessionID in
            ChatView(
                sessionID: sessionID,
                currentUserType: currentUserType
            )
        }
    }

    private func deleteSessions(at offsets: IndexSet) {
        for idx in offsets {
            let sessionID = sessions[idx].id
            ChatService.deleteSession(sessionID, context: viewContext)
        }
    }
}
