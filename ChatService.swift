//
//  ChatService.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//
//
//import Foundation
//import CoreData
//
//class ChatService {
//
//    @discardableResult
//    static func createMessage(_ text: String, from senderType: String, sessionID: String, context: NSManagedObjectContext, completion: (() -> Void)? = nil) -> ChatMessage? {
//        let message = ChatMessage(context: context)
//        message.id = UUID()
//        message.text = text
//        message.timestamp = Date()
//        message.senderType = senderType
//        message.sessionID = sessionID
//        message.isRead = false
//
//        do {
//            try context.save()
//            completion?()
//            return message
//        } catch {
//            print("❌ Failed to save message: \(error.localizedDescription)")
//            return nil
//        }
//    }
//
//    static func fetchMessages(for sessionID: String, context: NSManagedObjectContext) -> [ChatMessage] {
//        let request: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        request.predicate = NSPredicate(format: "sessionID == %@", sessionID)
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: true)]
//
//        do {
//            return try context.fetch(request)
//        } catch {
//            print("❌ Failed to fetch messages: \(error.localizedDescription)")
//            return []
//        }
//    }
//
//    static func latestMessage(for sessionID: String, context: NSManagedObjectContext) -> ChatMessage? {
//        let request: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        request.predicate = NSPredicate(format: "sessionID == %@", sessionID)
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: false)]
//        request.fetchLimit = 1
//
//        do {
//            return try context.fetch(request).first
//        } catch {
//            print("❌ Failed to fetch latest message: \(error.localizedDescription)")
//            return nil
//        }
//    }
//
//    static func markMessagesAsRead(for sessionID: String, from senderType: String, context: NSManagedObjectContext) {
//        let request: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
//            NSPredicate(format: "sessionID == %@", sessionID),
//            NSPredicate(format: "senderType != %@", senderType),
//            NSPredicate(format: "isRead == NO")
//        ])
//
//        do {
//            let unreadMessages = try context.fetch(request)
//            for message in unreadMessages {
//                message.isRead = true
//            }
//            try context.save()
//        } catch {
//            print("❌ Failed to mark messages as read: \(error.localizedDescription)")
//        }
//    }
//
//    static func requireClaimVerification(for foundItemClue: String?, userInput: String) -> Bool {
//        guard let clue = foundItemClue, !clue.isEmpty else { return true } // No clue means auto-pass
//        return clue.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == userInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
//    }
//}




//// ChatService.swift
//
//import Foundation
//import CoreData
//
//class ChatService {
//
//    @discardableResult
//    static func createMessage(
//        _ text: String,
//        from senderType: String,
//        sessionID: String,
//        context: NSManagedObjectContext,
//        completion: (() -> Void)? = nil
//    ) -> ChatMessage? {
//        let message = ChatMessage(context: context)
//        message.id = UUID()
//        message.text = text
//        message.timestamp = Date()
//        message.senderType = senderType
//        message.sessionID = sessionID
//        message.isRead = false
//
//        do {
//            try context.save()
//            completion?()
//            return message
//        } catch {
//            print("❌ Failed to save message: \(error.localizedDescription)")
//            return nil
//        }
//    }
//
//    static func fetchMessages(
//        for sessionID: String,
//        context: NSManagedObjectContext
//    ) -> [ChatMessage] {
//        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        req.predicate = NSPredicate(format: "sessionID == %@", sessionID)
//        req.sortDescriptors = [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: true)]
//        do {
//            return try context.fetch(req)
//        } catch {
//            print("❌ Failed to fetch messages: \(error)")
//            return []
//        }
//    }
//
//    static func latestMessage(
//        for sessionID: String,
//        context: NSManagedObjectContext
//    ) -> ChatMessage? {
//        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        req.predicate = NSPredicate(format: "sessionID == %@", sessionID)
//        req.sortDescriptors = [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: false)]
//        req.fetchLimit = 1
//        return (try? context.fetch(req))?.first
//    }
//
//    static func markMessagesAsRead(
//        for sessionID: String,
//        from senderType: String,
//        context: NSManagedObjectContext
//    ) {
//        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        req.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
//            NSPredicate(format: "sessionID == %@", sessionID),
//            NSPredicate(format: "senderType != %@", senderType),
//            NSPredicate(format: "isRead == NO")
//        ])
//        do {
//            let unread = try context.fetch(req)
//            unread.forEach { $0.isRead = true }
//            try context.save()
//        } catch {
//            print("❌ Failed to mark messages read: \(error)")
//        }
//    }
//
//    /// Given a sessionID like "lostUUID_foundUUID" and whether you're the "owner" or "finder",
//    /// looks up the *other* party's email in the matching LostItem/FoundItem and then resolves
//    /// that to a UserProfile.name (or falls back to the email).
//    static func participantName(
//        for sessionID: String,
//        currentUser: String,
//        context: NSManagedObjectContext
//    ) -> String {
//        let parts = sessionID.split(separator: "_")
//        guard parts.count == 2 else { return sessionID }
//
//        let lostUUID = UUID(uuidString: String(parts[0]))
//        let foundUUID = UUID(uuidString: String(parts[1]))
//
//        // if I'm the owner, the other is the finder; if I'm finder, other is owner
//        var emailToLookup: String?
//
//        if currentUser == "owner", let fID = foundUUID {
//            let req: NSFetchRequest<FoundItem> = FoundItem.fetchRequest()
//            req.predicate = NSPredicate(format: "id == %@", fID as CVarArg)
//            req.fetchLimit = 1
//            if let found = try? context.fetch(req).first {
//                emailToLookup = found.finderEmail
//            }
//        } else if currentUser == "finder", let lID = lostUUID {
//            let req: NSFetchRequest<LostItem> = LostItem.fetchRequest()
//            req.predicate = NSPredicate(format: "id == %@", lID as CVarArg)
//            req.fetchLimit = 1
//            if let lost = try? context.fetch(req).first {
//                emailToLookup = lost.ownerEmail
//            }
//        }
//
//        if let email = emailToLookup {
//            let userReq: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
//            userReq.predicate = NSPredicate(format: "email == %@", email)
//            userReq.fetchLimit = 1
//            if let profile = try? context.fetch(userReq).first,
//               let name = profile.name, !name.isEmpty {
//                return name
//            }
//            return email
//        }
//
//        return "Unknown"
//    }
//
//    static func requireClaimVerification(
//        for foundItemClue: String?,
//        userInput: String
//    ) -> Bool {
//        guard let clue = foundItemClue, !clue.isEmpty else { return true }
//        return clue.trimmingCharacters(in: .whitespacesAndNewlines)
//            .lowercased() ==
//            userInput.trimmingCharacters(in: .whitespacesAndNewlines)
//                .lowercased()
//    }
//}


//
//import Foundation
//import CoreData
//
//class ChatService {
//
//    @discardableResult
//    static func createMessage(
//        _ text: String,
//        from senderType: String,
//        sessionID: String,
//        context: NSManagedObjectContext,
//        completion: (() -> Void)? = nil
//    ) -> ChatMessage? {
//        let message = ChatMessage(context: context)
//        message.id = UUID()
//        message.text = text
//        message.timestamp = Date()
//        message.senderType = senderType  // e.g. "owner" or "finder"
//        message.sessionID = sessionID
//        message.isRead = false
//
//        do {
//            try context.save()
//            completion?()
//            return message
//        } catch {
//            print("❌ Failed to save message: \(error)")
//            return nil
//        }
//    }
//
//    static func fetchMessages(
//        for sessionID: String,
//        context: NSManagedObjectContext
//    ) -> [ChatMessage] {
//        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        req.predicate = NSPredicate(format: "sessionID == %@", sessionID)
//        req.sortDescriptors = [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: true)]
//        do {
//            return try context.fetch(req)
//        } catch {
//            print("❌ Failed to fetch messages: \(error)")
//            return []
//        }
//    }
//
//    static func latestMessage(
//        for sessionID: String,
//        context: NSManagedObjectContext
//    ) -> ChatMessage? {
//        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        req.predicate = NSPredicate(format: "sessionID == %@", sessionID)
//        req.sortDescriptors = [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: false)]
//        req.fetchLimit = 1
//        do {
//            return try context.fetch(req).first
//        } catch {
//            print("❌ Failed to fetch latest message: \(error)")
//            return nil
//        }
//    }
//
//    static func markMessagesAsRead(
//        for sessionID: String,
//        from senderType: String,
//        context: NSManagedObjectContext
//    ) {
//        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        req.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
//            NSPredicate(format: "sessionID == %@", sessionID),
//            NSPredicate(format: "senderType != %@", senderType),
//            NSPredicate(format: "isRead == NO")
//        ])
//        do {
//            let unread = try context.fetch(req)
//            unread.forEach { $0.isRead = true }
//            try context.save()
//        } catch {
//            print("❌ Failed to mark messages as read: \(error)")
//        }
//    }
//
//    /// Given a sessionID like "<lostUUID>_<foundUUID>" and which side you are,
//    /// returns the other party's display name (from UserProfile).
//    static func participantName(
//        for sessionID: String,
//        currentUser: String,        // "owner" or "finder"
//        context: NSManagedObjectContext
//    ) -> String {
//        let parts = sessionID.split(separator: "_", maxSplits: 1).map(String.init)
//        guard parts.count == 2,
//              let lostUUID = UUID(uuidString: parts[0]),
//              let foundUUID = UUID(uuidString: parts[1])
//        else { return "Chat" }
//
//        // Fetch LostItem to get ownerEmail
//        let lostReq: NSFetchRequest<LostItem> = LostItem.fetchRequest()
//        lostReq.predicate = NSPredicate(format: "id == %@", lostUUID as CVarArg)
//        // Fetch FoundItem to get finderEmail
//        let foundReq: NSFetchRequest<FoundItem> = FoundItem.fetchRequest()
//        foundReq.predicate = NSPredicate(format: "id == %@", foundUUID as CVarArg)
//
//        do {
//            let lostItems = try context.fetch(lostReq)
//            let foundItems = try context.fetch(foundReq)
//            guard let lost = lostItems.first, let found = foundItems.first else {
//                return "Chat"
//            }
//
//            // Decide which email belongs to the *other* party
//            let otherEmail = (currentUser == "owner")
//                ? (found.finderEmail ?? "")
//                : (lost.ownerEmail   ?? "")
//
//            // Now look up that user's profile
//            let profReq: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
//            profReq.predicate = NSPredicate(format: "email == %@", otherEmail)
//            if let profile = try context.fetch(profReq).first {
//                return profile.name ?? otherEmail
//            }
//            return otherEmail
//        } catch {
//            print("❌ participantName lookup failed:", error)
//            return "Chat"
//        }
//    }
//}

//
//import Foundation
//import CoreData
//
//class ChatService {
//
//    @discardableResult
//    static func createMessage(
//        _ text: String,
//        from senderEmail: String,
//        sessionID: String,
//        context: NSManagedObjectContext,
//        completion: (() -> Void)? = nil
//    ) -> ChatMessage? {
//        let msg = ChatMessage(context: context)
//        msg.id         = UUID()
//        msg.text       = text
//        msg.timestamp  = Date()
//        msg.senderType = senderEmail       // now storing the email
//        msg.sessionID  = sessionID
//        msg.isRead     = false
//
//        do {
//            try context.save()
//            completion?()
//            return msg
//        } catch {
//            print("❌ Failed to save message:", error)
//            return nil
//        }
//    }
//
//    static func fetchMessages(
//        for sessionID: String,
//        context: NSManagedObjectContext
//    ) -> [ChatMessage] {
//        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        req.predicate       = NSPredicate(format: "sessionID == %@", sessionID)
//        req.sortDescriptors = [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: true)]
//        return (try? context.fetch(req)) ?? []
//    }
//
//    static func markMessagesAsRead(
//        for sessionID: String,
//        from currentEmail: String,
//        context: NSManagedObjectContext
//    ) {
//        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        req.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
//            NSPredicate(format: "sessionID == %@", sessionID),
//            NSPredicate(format: "senderType != %@", currentEmail),
//            NSPredicate(format: "isRead == NO")
//        ])
//        do {
//            let unread = try context.fetch(req)
//            unread.forEach { $0.isRead = true }
//            try context.save()
//        } catch {
//            print("❌ Failed to mark read:", error)
//        }
//    }
//
//    /// Given a sessionID "<lostUUID>_<foundUUID>" and your own email,
//    /// returns the partner’s display name.
//    static func partnerName(
//        for sessionID: String,
//        currentUserEmail: String,
//        context: NSManagedObjectContext
//    ) -> String {
//        let parts = sessionID.split(separator: "_", maxSplits: 1).map(String.init)
//        guard parts.count == 2,
//              let lostUUID  = UUID(uuidString: parts[0]),
//              let foundUUID = UUID(uuidString: parts[1])
//        else { return "Chat" }
//
//        // 1) load LostItem to get ownerEmail
//        let lossReq: NSFetchRequest<LostItem> = LostItem.fetchRequest()
//        lossReq.predicate = NSPredicate(format: "id == %@", lostUUID as CVarArg)
//
//        // 2) load FoundItem to get finderEmail
//        let foundReq: NSFetchRequest<FoundItem> = FoundItem.fetchRequest()
//        foundReq.predicate = NSPredicate(format: "id == %@", foundUUID as CVarArg)
//
//        do {
//            guard
//                let lost = try context.fetch(lossReq).first,
//                let found = try context.fetch(foundReq).first
//            else {
//                return "Chat"
//            }
//
//            // pick whichever email is not yours
//            let partnerEmail = (lost.ownerEmail == currentUserEmail)
//                ? (found.finderEmail ?? "")
//                : (lost.ownerEmail ?? "")
//
//            // look up that user’s profile:
//            let profReq: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
//            profReq.predicate = NSPredicate(format: "email == %@", partnerEmail)
//            if let prof = try context.fetch(profReq).first {
//                return prof.name ?? partnerEmail
//            }
//            return partnerEmail
//        } catch {
//            print("❌ partnerName lookup failed:", error)
//            return "Chat"
//        }
//    }
//}


//
//import CoreData
//import Foundation
//
//class ChatService {
//    /// Create a new message in Core Data, tagging it with the sender's email
//    @discardableResult
//    static func createMessage(
//        _ text: String,
//        fromEmail: String,
//        sessionID: String,
//        context: NSManagedObjectContext,
//        completion: (() -> Void)? = nil
//    ) -> ChatMessage? {
//        let message = ChatMessage(context: context)
//        message.id = UUID()
//        message.text = text
//        message.timestamp = Date()
//        message.sessionID = sessionID
//        message.senderEmail = fromEmail
//        message.isRead = false
//
//        do {
//            try context.save()
//            completion?()
//            return message
//        } catch {
//            print("❌ Failed to save message: \(error)")
//            return nil
//        }
//    }
//
//    /// Fetch all messages for a session, sorted oldest→newest
//    static func fetchMessages(
//        for sessionID: String,
//        context: NSManagedObjectContext
//    ) -> [ChatMessage] {
//        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        req.predicate = NSPredicate(format: "sessionID == %@", sessionID)
//        req.sortDescriptors = [
//          NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: true)
//        ]
//        do {
//            return try context.fetch(req)
//        } catch {
//            print("❌ Failed to fetch messages: \(error)")
//            return []
//        }
//    }
//
//    /// Mark any messages _not_ from `currentUserEmail` as read
//    static func markMessagesAsRead(
//        for sessionID: String,
//        currentUserEmail: String,
//        context: NSManagedObjectContext
//    ) {
//        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        req.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
//          NSPredicate(format: "sessionID == %@", sessionID),
//          NSPredicate(format: "senderEmail != %@", currentUserEmail),
//          NSPredicate(format: "isRead == NO")
//        ])
//        do {
//            let unread = try context.fetch(req)
//            unread.forEach { $0.isRead = true }
//            try context.save()
//        } catch {
//            print("❌ Failed to mark messages read: \(error)")
//        }
//    }
//
//    /// Given "lostUUID_foundUUID" and your email, return the OTHER party's email
//    static func partnerName(
//      for sessionID: String,
//      currentUserEmail: String,
//      context: NSManagedObjectContext
//    ) -> String {
//        let parts = sessionID.split(separator: "_").map(String.init)
//        guard parts.count == 2,
//              let lostUUID = UUID(uuidString: parts[0]),
//              let foundUUID = UUID(uuidString: parts[1])
//        else { return "Chat" }
//
//        // Fetch the two items
//        let lostReq: NSFetchRequest<LostItem> = LostItem.fetchRequest()
//        lostReq.predicate = NSPredicate(format: "id == %@", lostUUID as CVarArg)
//        let foundReq: NSFetchRequest<FoundItem> = FoundItem.fetchRequest()
//        foundReq.predicate = NSPredicate(format: "id == %@", foundUUID as CVarArg)
//
//        do {
//            let losts  = try context.fetch(lostReq)
//            let founds = try context.fetch(foundReq)
//            if let lost = losts.first, let found = founds.first {
//                // If _you_ are the owner of lost, partner is the finder, otherwise partner is the owner.
//                if lost.ownerEmail == currentUserEmail {
//                    return found.finderEmail ?? "Finder"
//                } else {
//                    return lost.ownerEmail  ?? "Owner"
//                }
//            }
//        } catch {
//            print("❌ partnerName lookup failed: \(error)")
//        }
//        return "Chat"
//    }
//}


//
//import CoreData
//import Foundation
//
//class ChatService {
//    @discardableResult
//    static func createMessage(
//        _ text: String,
//        from senderType: String,        // "owner" or "finder"
//        sessionID: String,
//        context: NSManagedObjectContext,
//        completion: (() -> Void)? = nil
//    ) -> ChatMessage? {
//        let msg = ChatMessage(context: context)
//        msg.id = UUID()
//        msg.text = text
//        msg.timestamp = Date()
//        msg.senderType = senderType
//        msg.sessionID = sessionID
//        msg.isRead = false
//
//        do {
//            try context.save()
//            completion?()
//            return msg
//        } catch {
//            print("❌ Failed to save message:", error)
//            return nil
//        }
//    }
//
//    static func fetchMessages(
//        for sessionID: String,
//        context: NSManagedObjectContext
//    ) -> [ChatMessage] {
//        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        req.predicate = NSPredicate(format: "sessionID == %@", sessionID)
//        req.sortDescriptors = [
//          NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: true)
//        ]
//        return (try? context.fetch(req)) ?? []
//    }
//
//    static func markMessagesAsRead(
//        for sessionID: String,
//        currentUserType: String,
//        context: NSManagedObjectContext
//    ) {
//        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
//        req.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
//          NSPredicate(format: "sessionID == %@", sessionID),
//          NSPredicate(format: "senderType != %@", currentUserType),
//          NSPredicate(format: "isRead == NO")
//        ])
//        if let unread = try? context.fetch(req) {
//            unread.forEach { $0.isRead = true }
//            try? context.save()
//        }
//    }
//
//    /// Splits "lostUUID_foundUUID", looks up both items, and returns the *other* party’s email.
//    static func partnerName(
//        for sessionID: String,
//        currentUserType: String,
//        context: NSManagedObjectContext
//    ) -> String {
//        let parts = sessionID.split(separator: "_").map(String.init)
//        guard parts.count == 2,
//              let lostUUID  = UUID(uuidString: parts[0]),
//              let foundUUID = UUID(uuidString: parts[1])
//        else { return "Chat" }
//
//        // Fetch lost item
//        let lossReq: NSFetchRequest<LostItem> = LostItem.fetchRequest()
//        lossReq.predicate = NSPredicate(format: "id == %@", lostUUID as CVarArg)
//        // Fetch found item
//        let foundReq: NSFetchRequest<FoundItem> = FoundItem.fetchRequest()
//        foundReq.predicate = NSPredicate(format: "id == %@", foundUUID as CVarArg)
//
//        do {
//            let losts  = try context.fetch(lossReq)
//            let finds = try context.fetch(foundReq)
//            if let lost = losts.first, let found = finds.first {
//                switch currentUserType {
//                case "owner":  return found.finderEmail ?? "Finder"
//                case "finder": return lost.ownerEmail  ?? "Owner"
//                default:       return "Chat"
//                }
//            }
//        } catch {
//            print("❌ partnerName lookup failed:", error)
//        }
//        return "Chat"
//    }
//}



import CoreData
import Foundation

class ChatService {
    @discardableResult
    static func createMessage(
        _ text: String,
        from senderType: String,        // "owner" or "finder"
        sessionID: String,
        context: NSManagedObjectContext,
        completion: (() -> Void)? = nil
    ) -> ChatMessage? {
        let msg = ChatMessage(context: context)
        msg.id = UUID()
        msg.text = text
        msg.timestamp = Date()
        msg.senderType = senderType
        msg.sessionID = sessionID
        msg.isRead = false

        do {
            try context.save()
            completion?()
            return msg
        } catch {
            print("❌ Failed to save message:", error)
            return nil
        }
    }

    /// Fetch all messages for a session, sorted oldest→newest
    static func fetchMessages(
        for sessionID: String,
        context: NSManagedObjectContext
    ) -> [ChatMessage] {
        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
        req.predicate = NSPredicate(format: "sessionID == %@", sessionID)
        req.sortDescriptors = [
          NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: true)
        ]
        return (try? context.fetch(req)) ?? []
    }

    /// Mark all messages *not* from me as read
    static func markMessagesAsRead(
        for sessionID: String,
        currentUserType: String,
        context: NSManagedObjectContext
    ) {
        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
        req.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
          NSPredicate(format: "sessionID == %@", sessionID),
          NSPredicate(format: "senderType != %@", currentUserType),
          NSPredicate(format: "isRead == NO")
        ])
        if let unread = try? context.fetch(req) {
            unread.forEach { $0.isRead = true }
            try? context.save()
        }
    }

    /// Delete *all* messages in this session
    static func deleteSession(
        _ sessionID: String,
        context: NSManagedObjectContext
    ) {
        let req: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
        req.predicate = NSPredicate(format: "sessionID == %@", sessionID)
        if let msgs = try? context.fetch(req) {
            msgs.forEach(context.delete)
            try? context.save()
        }
    }

    /// Given sessionID = "lostUUID_foundUUID", return the *other* party’s email
    static func partnerName(
        for sessionID: String,
        currentUserType: String,
        context: NSManagedObjectContext
    ) -> String {
        let parts = sessionID.split(separator: "_").map(String.init)
        guard parts.count == 2,
              let lostUUID  = UUID(uuidString: parts[0]),
              let foundUUID = UUID(uuidString: parts[1])
        else { return "Chat" }

        // fetch lost & found
        let lossReq: NSFetchRequest<LostItem> = LostItem.fetchRequest()
        lossReq.predicate = NSPredicate(format: "id == %@", lostUUID as CVarArg)
        let foundReq: NSFetchRequest<FoundItem> = FoundItem.fetchRequest()
        foundReq.predicate = NSPredicate(format: "id == %@", foundUUID as CVarArg)

        do {
            let losts  = try context.fetch(lossReq)
            let finds = try context.fetch(foundReq)
            if let lost = losts.first, let found = finds.first {
                switch currentUserType {
                case "owner":  return found.finderEmail ?? "Finder"
                case "finder": return lost.ownerEmail  ?? "Owner"
                default:       return "Chat"
                }
            }
        } catch {
            print("❌ partnerName lookup failed:", error)
        }
        return "Chat"
    }
}
