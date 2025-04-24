//
//  ChatView.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//
//
//import SwiftUI
//
//struct ChatView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    let sessionID: String
//    let currentUser: String // "owner" or "finder"
//
//    @State private var messageText = ""
//    @State private var messages: [ChatMessage] = []
//
//    var body: some View {
//        VStack {
//            ScrollViewReader { scrollView in
//                ScrollView {
//                    VStack(spacing: 12) {
//                        ForEach(messages, id: \.id) { msg in
//                            HStack {
//                                if msg.senderType == currentUser {
//                                    Spacer()
//                                    Text(msg.text ?? "")
//                                        .padding()
//                                        .background(Color.blue.opacity(0.2))
//                                        .cornerRadius(10)
//                                } else {
//                                    Text(msg.text ?? "")
//                                        .padding()
//                                        .background(Color.gray.opacity(0.2))
//                                        .cornerRadius(10)
//                                    Spacer()
//                                }
//                            }
//                        }
//                    }
//                    .padding()
//                }
//                .onAppear {
//                    messages = ChatService.fetchMessages(for: sessionID, context: viewContext)
//                }
//            }
//
//            Divider()
//
//            HStack {
//                TextField("Type a message...", text: $messageText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                Button("Send") {
//                    sendMessage()
//                }
//                .disabled(messageText.trimmingCharacters(in: .whitespaces).isEmpty)
//            }
//            .padding()
//        }
//        .navigationTitle("Chat")
//    }
//
//    private func sendMessage() {
//        let trimmed = messageText.trimmingCharacters(in: .whitespaces)
//        guard !trimmed.isEmpty else { return }
//
//        ChatService.createMessage(trimmed, from: currentUser, sessionID: sessionID, context: viewContext)
//        messageText = ""
//        messages = ChatService.fetchMessages(for: sessionID, context: viewContext)
//    }
//    
//    
//}

// ChatView.swift
let aiPrompts = [
    "Hi! I think this item might be mine.",
    "Can you share more details about the item?",
    "Where and when did you find it?",
    "Thanks for reporting this!",
    "How can I collect the item?"
]
//
//import SwiftUI
//
//struct ChatView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    let sessionID: String
//    let currentUser: String // "owner" or "finder"
//
//    @State private var messageText = ""
//    @State private var messages: [ChatMessage] = []
//
//    var body: some View {
//        VStack {
//            ScrollViewReader { scrollView in
//                ScrollView {
//                    VStack(spacing: 12) {
//                        ForEach(messages, id: \.id) { msg in
//                            HStack(alignment: .top) {
//                                if msg.senderType == currentUser {
//                                    Spacer()
//                                    VStack(alignment: .trailing) {
//                                        Text("You")
//                                            .font(.caption)
//                                            .foregroundColor(.secondary)
//                                        Text(msg.text ?? "")
//                                            .padding()
//                                            .background(Color.blue.opacity(0.2))
//                                            .cornerRadius(10)
//                                        Text(msg.timestamp?.timeAgoString() ?? "")
//                                            .font(.caption2)
//                                            .foregroundColor(.secondary)
//                                            .padding(.top, 2)
//                                    }
//                                } else {
//                                    VStack(alignment: .leading) {
//                                        HStack {
//                                            Circle()
//                                                .fill(Color.gray)
//                                                .frame(width: 24, height: 24)
//                                                .overlay(Text("F").font(.caption).foregroundColor(.white))
//                                            Text("Finder")
//                                                .font(.caption)
//                                                .foregroundColor(.secondary)
//                                        }
//                                        Text(msg.text ?? "")
//                                            .padding()
//                                            .background(Color.gray.opacity(0.2))
//                                            .cornerRadius(10)
//                                        Text(msg.timestamp?.timeAgoString() ?? "")
//                                            .font(.caption2)
//                                            .foregroundColor(.secondary)
//                                            .padding(.top, 2)
//                                    }
//                                    Spacer()
//                                }
//                            }
//                        }
//                    }
//                    .padding()
//                }
//                .onAppear {
//                    messages = ChatService.fetchMessages(for: sessionID, context: viewContext)
//                    ChatService.markMessagesAsRead(for: sessionID, from: currentUser, context: viewContext)
//                }
//            }
//
//            Divider()
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 12) {
//                    ForEach(aiPrompts, id: \.self) { prompt in
//                        Button(action: {
//                            messageText = prompt
//                        }) {
//                            Text(prompt)
//                                .padding(.horizontal, 12)
//                                .padding(.vertical, 6)
//                                .background(Color.gray.opacity(0.2))
//                                .cornerRadius(10)
//                        }
//                    }
//                }
//                .padding(.horizontal)
//            }
//            .padding(.top)
//
//            HStack {
//                TextField("Type a message...", text: $messageText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                Button("Send") {
//                    sendMessage()
//                }
//                .disabled(messageText.trimmingCharacters(in: .whitespaces).isEmpty)
//            }
//            .padding()
//        }
//        .navigationTitle("Chat")
//    }
//
//    private func sendMessage() {
//        let trimmed = messageText.trimmingCharacters(in: .whitespaces)
//        guard !trimmed.isEmpty else { return }
//
//        ChatService.createMessage(trimmed, from: currentUser, sessionID: sessionID, context: viewContext) {
//            messageText = ""
//            messages = ChatService.fetchMessages(for: sessionID, context: viewContext)
//        }
//    }
//}
//


//// ChatView.swift
//
//import SwiftUI
//import CoreData
//
//
//
//struct ChatView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    let sessionID: String
//    let currentUser: String   // "owner" or "finder"
//
//    @State private var messageText = ""
//    @State private var messages: [ChatMessage] = []
//    @State private var participantName = ""
//
//    var body: some View {
//        VStack {
//            ScrollViewReader { scroll in
//                ScrollView {
//                    VStack(spacing: 12) {
//                        ForEach(messages, id: \.id) { msg in
//                            HStack(alignment: .top) {
//                                if msg.senderType == currentUser {
//                                    Spacer()
//                                    VStack(alignment: .trailing) {
//                                        Text("You")
//                                            .font(.caption)
//                                            .foregroundColor(.secondary)
//                                        Text(msg.text ?? "")
//                                            .padding()
//                                            .background(Color.blue.opacity(0.2))
//                                            .cornerRadius(10)
//                                        Text(msg.timestamp?.timeAgoString() ?? "")
//                                            .font(.caption2)
//                                            .foregroundColor(.secondary)
//                                            .padding(.top, 2)
//                                    }
//                                } else {
//                                    VStack(alignment: .leading) {
//                                        Text(participantName)
//                                            .font(.caption)
//                                            .foregroundColor(.secondary)
//                                        Text(msg.text ?? "")
//                                            .padding()
//                                            .background(Color.gray.opacity(0.2))
//                                            .cornerRadius(10)
//                                        Text(msg.timestamp?.timeAgoString() ?? "")
//                                            .font(.caption2)
//                                            .foregroundColor(.secondary)
//                                            .padding(.top, 2)
//                                    }
//                                    Spacer()
//                                }
//                            }
//                        }
//                    }
//                    .padding()
//                }
//                .onAppear {
//                    // load existing messages
//                    messages = ChatService.fetchMessages(
//                        for: sessionID,
//                        context: viewContext
//                    )
//                    // mark others' messages as read
//                    ChatService.markMessagesAsRead(
//                        for: sessionID,
//                        from: currentUser,
//                        context: viewContext
//                    )
//                }
//            }
//
//            Divider()
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 12) {
//                    ForEach(aiPrompts, id: \.self) { prompt in
//                        Button(prompt) {
//                            messageText = prompt
//                        }
//                        .padding(.horizontal, 12)
//                        .padding(.vertical, 6)
//                        .background(Color.gray.opacity(0.2))
//                        .cornerRadius(10)
//                    }
//                }
//                .padding(.horizontal)
//            }
//            .padding(.top)
//
//            HStack {
//                TextField("Type a message…", text: $messageText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                Button("Send") {
//                    sendMessage()
//                }
//                .disabled(messageText.trimmingCharacters(in: .whitespaces).isEmpty)
//            }
//            .padding()
//        }
//        .navigationTitle(participantName)
//        .onAppear {
//            participantName = ChatService.participantName(
//                for: sessionID,
//                currentUser: currentUser,
//                context: viewContext
//            )
//        }
//    }
//
//    private func sendMessage() {
//        let text = messageText.trimmingCharacters(in: .whitespaces)
//        guard !text.isEmpty else { return }
//
//        ChatService.createMessage(
//            text,
//            from: currentUser,
//            sessionID: sessionID,
//            context: viewContext
//        ) {
//            // clear input & reload
//            messageText = ""
//            messages = ChatService.fetchMessages(
//                for: sessionID,
//                context: viewContext
//            )
//        }
//    }
//}

//
//import SwiftUI
//
//struct ChatView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    let sessionID: String
//    let currentUser: String  // "owner" or "finder"
//
//    @State private var messages: [ChatMessage] = []
//    @State private var messageText = ""
//
//    /// Display name of your chat partner (the "other" user)
//    private var partnerName: String {
//        ChatService.participantName(
//            for: sessionID,
//            currentUser: currentUser,
//            context: viewContext
//        )
//    }
//
//    var body: some View {
//        VStack(spacing: 0) {
//            ScrollViewReader { scroll in
//                ScrollView {
//                    VStack(spacing: 12) {
//                        ForEach(messages, id: \.id) { msg in
//                            messageRow(for: msg)
//                        }
//                    }
//                    .padding()
//                }
//                .onAppear {
//                    loadMessages()
//                }
//                .onChange(of: messages.count) { _ in
//                    // scroll to bottom when new message arrives
//                    if let last = messages.last {
//                        withAnimation {
//                            scroll.scrollTo(last.id, anchor: .bottom)
//                        }
//                    }
//                }
//            }
//
//            Divider()
//
//            // Quick prompts
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 12) {
//                    ForEach(aiPrompts, id: \.self) { prompt in
//                        Button(prompt) {
//                            messageText = prompt
//                        }
//                        .padding(.horizontal, 12)
//                        .padding(.vertical, 6)
//                        .background(Color(.systemGray5))
//                        .cornerRadius(10)
//                    }
//                }
//                .padding(.horizontal)
//                .padding(.vertical, 6)
//            }
//
//            // Input field + send
//            HStack {
//                TextField("Type a message…", text: $messageText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                Button("Send") {
//                    sendMessage()
//                }
//                .disabled(messageText.trimmingCharacters(in: .whitespaces).isEmpty)
//            }
//            .padding()
//        }
//        .navigationTitle(partnerName)
//        .navigationBarTitleDisplayMode(.inline)
//    }
//
//    private func loadMessages() {
//        messages = ChatService.fetchMessages(for: sessionID, context: viewContext)
//        ChatService.markMessagesAsRead(for: sessionID, from: currentUser, context: viewContext)
//    }
//
//    private func sendMessage() {
//        let text = messageText.trimmingCharacters(in: .whitespaces)
//        guard !text.isEmpty else { return }
//
//        ChatService.createMessage(
//            text,
//            from: currentUser,
//            sessionID: sessionID,
//            context: viewContext
//        ) {
//            messageText = ""
//            loadMessages()
//        }
//    }
//
//    @ViewBuilder
//    private func messageRow(for msg: ChatMessage) -> some View {
//        let isMe = msg.senderType == currentUser
//        HStack {
//            if isMe { Spacer() }
//
//            VStack(alignment: isMe ? .trailing : .leading, spacing: 4) {
//                // Sender label
//                Text(isMe ? "You" : partnerName)
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//
//                // Bubble
//                Text(msg.text ?? "")
//                    .padding()
//                    .background(isMe
//                        ? Color.accentColor.opacity(0.2)
//                        : Color(.systemGray5)
//                    )
//                    .cornerRadius(10)
//
//                // Timestamp
//                Text(msg.timestamp?.timeAgoString() ?? "")
//                    .font(.caption2)
//                    .foregroundColor(.secondary)
//            }
//
//            if !isMe { Spacer() }
//        }
//        .id(msg.id)
//    }
//}

//
//import SwiftUI
//
//struct ChatView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    let sessionID: String
//
//    @State private var messages: [ChatMessage] = []
//    @State private var messageText = ""
//
//    // display name of the person you're chatting with
//    private var partnerName: String {
//        ChatService.partnerName(
//            for: sessionID,
//            currentUserEmail: currentUserEmail,
//            context: viewContext
//        )
//    }
//
//    var body: some View {
//        VStack(spacing: 0) {
//            ScrollViewReader { scroll in
//                ScrollView {
//                    VStack(spacing: 12) {
//                        ForEach(messages, id: \.id) { msg in
//                            messageRow(msg)
//                        }
//                    }
//                    .padding()
//                }
//                .onAppear(perform: loadMessages)
//                .onChange(of: messages.count) { _ in
//                    // scroll to bottom
//                    if let last = messages.last {
//                        withAnimation {
//                            scroll.scrollTo(last.id, anchor: .bottom)
//                        }
//                    }
//                }
//            }
//
//            Divider()
//
//            // Quick prompts
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 12) {
//                    ForEach(aiPrompts, id: \.self) { prompt in
//                        Button(prompt) { messageText = prompt }
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 6)
//                            .background(Color(.systemGray5))
//                            .cornerRadius(10)
//                    }
//                }
//                .padding(.horizontal)
//                .padding(.vertical, 6)
//            }
//
//            // Input & send
//            HStack {
//                TextField("Type a message…", text: $messageText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                Button("Send") { sendMessage() }
//                    .disabled(messageText.trimmingCharacters(in: .whitespaces).isEmpty)
//            }
//            .padding()
//        }
//        .navigationTitle(partnerName)
//        .navigationBarTitleDisplayMode(.inline)
//    }
//
//    private func loadMessages() {
//        messages = ChatService.fetchMessages(for: sessionID, context: viewContext)
//        ChatService.markMessagesAsRead(
//            for: sessionID,
//            from: currentUserEmail,
//            context: viewContext
//        )
//    }
//
//    private func sendMessage() {
//        let text = messageText.trimmingCharacters(in: .whitespaces)
//        guard !text.isEmpty else { return }
//        ChatService.createMessage(
//            text,
//            from: currentUserEmail,
//            sessionID: sessionID,
//            context: viewContext
//        ) {
//            messageText = ""
//            loadMessages()
//        }
//    }
//
//    @ViewBuilder
//    private func messageRow(_ msg: ChatMessage) -> some View {
//        let isMe = msg.senderType == currentUserEmail
//        HStack {
//            if isMe { Spacer() }
//
//            VStack(alignment: isMe ? .trailing : .leading, spacing: 4) {
//                // label
//                Text(isMe ? "You" : partnerName)
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//
//                // bubble
//                Text(msg.text ?? "")
//                    .padding()
//                    .background(isMe
//                        ? Color.accentColor.opacity(0.2)
//                        : Color(.systemGray5)
//                    )
//                    .cornerRadius(10)
//
//                // timestamp
//                Text(msg.timestamp?.timeAgoString() ?? "")
//                    .font(.caption2)
//                    .foregroundColor(.secondary)
//            }
//
//            if !isMe { Spacer() }
//        }
//        .id(msg.id)
//    }
//}

//
//
//import SwiftUI
//import CoreData
//
//struct ChatView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    let sessionID: String
//    @State private var partnerName = "Chat"
//    @State private var messages: [ChatMessage] = []
//    @State private var messageText = ""
//
//    // Example canned AI prompts
//    private let ownerPrompts  = [
//      "Where exactly can I pick this up?", "Thank you for finding my item!"
//    ]
//    private let finderPrompts = [
//      "Can you confirm your Northeastern ID number?", "When did you lose it?"
//    ]
//
//    var body: some View {
//        VStack {
//            ScrollViewReader { scroll in
//                ScrollView {
//                    VStack(spacing: 12) {
//                        ForEach(messages, id: \.id) { msg in
//                            HStack(alignment: .top) {
//                                // If this message came from _you_, right-align blue bubble
//                                if msg.senderEmail == currentUserEmail {
//                                    Spacer()
//                                    VStack(alignment: .trailing) {
//                                        Text("You")
//                                          .font(.caption)
//                                          .foregroundColor(.secondary)
//                                        Text(msg.text ?? "")
//                                          .padding()
//                                          .background(Color.blue.opacity(0.2))
//                                          .cornerRadius(10)
//                                        Text(msg.timestamp?.timeAgoString() ?? "")
//                                          .font(.caption2)
//                                          .foregroundColor(.secondary)
//                                    }
//                                }
//                                // Otherwise, left-align gray bubble
//                                else {
//                                    VStack(alignment: .leading) {
//                                        Text(partnerName)
//                                          .font(.caption)
//                                          .foregroundColor(.secondary)
//                                        Text(msg.text ?? "")
//                                          .padding()
//                                          .background(Color.gray.opacity(0.2))
//                                          .cornerRadius(10)
//                                        Text(msg.timestamp?.timeAgoString() ?? "")
//                                          .font(.caption2)
//                                          .foregroundColor(.secondary)
//                                          .padding(.top, 2)
//                                    }
//                                    Spacer()
//                                }
//                            }
//                        }
//                    }
//                    .padding()
//                    .onChange(of: messages.count) { _ in
//                        // scroll to bottom whenever a new message arrives
//                        if let last = messages.last {
//                            scroll.scrollTo(last.id, anchor: .bottom)
//                        }
//                    }
//                }
//                .onAppear {
//                    reloadChat()
//                }
//            }
//
//            Divider()
//
//            // Show AI prompts relevant to your role
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 12) {
//                    ForEach(currentUserEmail == ownerEmail ? ownerPrompts : finderPrompts, id: \.self) { prompt in
//                        Button { messageText = prompt }
//                        label: {
//                          Text(prompt)
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 6)
//                            .background(Color.gray.opacity(0.2))
//                            .cornerRadius(10)
//                        }
//                    }
//                }
//                .padding(.horizontal)
//            }
//            .padding(.top)
//
//            // Input field + send
//            HStack {
//                TextField("Type a message…", text: $messageText)
//                  .textFieldStyle(RoundedBorderTextFieldStyle())
//                Button("Send") {
//                    sendMessage()
//                }
//                .disabled(messageText.trimmingCharacters(in: .whitespaces).isEmpty)
//            }
//            .padding()
//        }
//        .navigationTitle(partnerName)
//    }
//
//    /// convenience to parse the sessionID and fetch the owner's email
//    private var ownerEmail: String {
//        let pieces = sessionID.split(separator: "_").map(String.init)
//        guard pieces.count == 2,
//              let uuid = UUID(uuidString: pieces[0])
//        else { return "" }
//        let req: NSFetchRequest<LostItem> = LostItem.fetchRequest()
//        req.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
//        if let lost = (try? viewContext.fetch(req))?.first {
//            return lost.ownerEmail ?? ""
//        }
//        return ""
//    }
//
//    private func reloadChat() {
//        messages = ChatService.fetchMessages(for: sessionID, context: viewContext)
//        ChatService.markMessagesAsRead(
//          for: sessionID,
//          currentUserEmail: currentUserEmail,
//          context: viewContext
//        )
//        partnerName = ChatService.partnerName(
//          for: sessionID,
//          currentUserEmail: currentUserEmail,
//          context: viewContext
//        )
//    }
//
//    private func sendMessage() {
//        let trimmed = messageText.trimmingCharacters(in: .whitespaces)
//        guard !trimmed.isEmpty else { return }
//
//        ChatService.createMessage(
//          trimmed,
//          fromEmail: currentUserEmail,
//          sessionID: sessionID,
//          context: viewContext
//        ) {
//            messageText = ""
//            reloadChat()
//        }
//    }
//}

//
//import SwiftUI
//import CoreData
//
//struct ChatView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    let sessionID: String
//    let currentUserType: String    // "owner" or "finder"
//
//    @State private var messages     = [ChatMessage]()
//    @State private var messageText  = ""
//    @State private var partnerName  = "Chat"
//
//    // Example AI prompts for each role
//    private var aiPrompts: [String] {
//        currentUserType == "owner"
//        ? ["Where can I pick this up?", "Thanks for finding this!"]
//        : ["Any idea whose item this is?", "Can you confirm your ID?"]
//    }
//
//    var body: some View {
//        VStack {
//            ScrollViewReader { scroll in
//                ScrollView {
//                    VStack(spacing: 12) {
//                        ForEach(messages, id: \.id) { msg in
//                            HStack {
//                                if msg.senderType == currentUserType {
//                                    Spacer()
//                                    VStack(alignment: .trailing) {
//                                        Text("You")
//                                          .font(.caption)
//                                          .foregroundColor(.secondary)
//                                        Text(msg.text ?? "")
//                                          .padding()
//                                          .background(Color.blue.opacity(0.2))
//                                          .cornerRadius(10)
//                                        Text(msg.timestamp?.timeAgoString() ?? "")
//                                          .font(.caption2)
//                                          .foregroundColor(.secondary)
//                                          .padding(.top, 2)
//                                    }
//                                } else {
//                                    VStack(alignment: .leading) {
//                                        Text(partnerName)
//                                          .font(.caption)
//                                          .foregroundColor(.secondary)
//                                        Text(msg.text ?? "")
//                                          .padding()
//                                          .background(Color.gray.opacity(0.2))
//                                          .cornerRadius(10)
//                                        Text(msg.timestamp?.timeAgoString() ?? "")
//                                          .font(.caption2)
//                                          .foregroundColor(.secondary)
//                                          .padding(.top, 2)
//                                    }
//                                    Spacer()
//                                }
//                            }
//                            .id(msg.id)
//                        }
//                    }
//                    .padding()
//                    .onChange(of: messages.count) { _ in
//                        if let last = messages.last {
//                            scroll.scrollTo(last.id, anchor: .bottom)
//                        }
//                    }
//                }
//                .onAppear(perform: reloadChat)
//            }
//
//            Divider()
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 12) {
//                    ForEach(aiPrompts, id: \.self) { p in
//                        Button { messageText = p }
//                        label: {
//                          Text(p)
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 6)
//                            .background(Color.gray.opacity(0.2))
//                            .cornerRadius(10)
//                        }
//                    }
//                }
//                .padding(.horizontal)
//            }
//            .padding(.top)
//
//            HStack {
//                TextField("Type a message…", text: $messageText)
//                  .textFieldStyle(RoundedBorderTextFieldStyle())
//                Button("Send") {
//                    sendMessage()
//                }
//                .disabled(messageText.trimmingCharacters(in: .whitespaces).isEmpty)
//            }
//            .padding()
//        }
//        .navigationTitle(partnerName)
//    }
//
//    private func reloadChat() {
//        messages = ChatService.fetchMessages(
//          for: sessionID,
//          context: viewContext
//        )
//        ChatService.markMessagesAsRead(
//          for: sessionID,
//          currentUserType: currentUserType,
//          context: viewContext
//        )
//        partnerName = ChatService.partnerName(
//          for: sessionID,
//          currentUserType: currentUserType,
//          context: viewContext
//        )
//    }
//
//    private func sendMessage() {
//        let txt = messageText.trimmingCharacters(in: .whitespaces)
//        guard !txt.isEmpty else { return }
//        ChatService.createMessage(
//          txt,
//          from: currentUserType,
//          sessionID: sessionID,
//          context: viewContext
//        ) {
//            messageText = ""
//            reloadChat()
//        }
//    }
//}
import SwiftUI
import CoreData

struct ChatView: View {
    @Environment(\.managedObjectContext) private var viewContext

    let sessionID: String
    let currentUserType: String   // "owner" or "finder"

    @State private var messageText = ""
    @State private var messages: [ChatMessage] = []

    /// Your canned AI prompts
    private let aiPrompts = [
        "Hi! I think this item might be mine.",
        "Can you share more details about the item?",
        "Where and when did you find it?",
        "Thanks for reporting this!",
        "How can I collect the item?"
    ]

    var body: some View {
        VStack {
            // MARK: – Message list
            ScrollViewReader { scroll in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(messages, id: \.id) { msg in
                            messageRow(msg)
                        }
                    }
                    .padding()
                }
                .onAppear {
                    loadMessages()
                }
                .onChange(of: messages.count) { _ in
                    // auto-scroll to bottom
                    if let last = messages.last {
                        withAnimation {
                            scroll.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }

            Divider()

            // MARK: – Inline AI prompts
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(aiPrompts, id: \.self) { prompt in
                        Button(prompt) {
                            messageText = prompt
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
            }

            // MARK: – Input bar
            HStack {
                TextField("Type a message…", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Send") {
                    sendMessage()
                }
                .disabled(messageText.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding()
        }
        .navigationTitle(ChatService.partnerName(
            for: sessionID,
            currentUserType: currentUserType,
            context: viewContext
        ))
    }

    // MARK: – Helpers

    private func messageRow(_ msg: ChatMessage) -> some View {
        HStack(alignment: .bottom) {
            if msg.senderType == currentUserType {
                Spacer()
                VStack(alignment: .trailing) {
                    Text("You")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(msg.text ?? "")
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                    Text(msg.timestamp?.timeAgoString() ?? "")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 24, height: 24)
                            .overlay(Image(systemName: "person.fill").foregroundColor(.white))
                        Text(ChatService.partnerName(
                            for: sessionID,
                            currentUserType: currentUserType,
                            context: viewContext
                        ))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    Text(msg.text ?? "")
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    Text(msg.timestamp?.timeAgoString() ?? "")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
        }
        .id(msg.id)
    }

    private func loadMessages() {
        messages = ChatService.fetchMessages(for: sessionID, context: viewContext)
        ChatService.markMessagesAsRead(
            for: sessionID,
            currentUserType: currentUserType,
            context: viewContext
        )
    }

    private func sendMessage() {
        let trimmed = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        ChatService.createMessage(
            trimmed,
            from: currentUserType,
            sessionID: sessionID,
            context: viewContext
        ) {
            messageText = ""
            loadMessages()
        }
    }
}
