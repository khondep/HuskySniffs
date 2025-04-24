//
//  NotificationsView.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/23/25.
//

import SwiftUI
import CoreData

struct NotificationEntry: Identifiable {
    let id: UUID
    let message: String
    let date: Date
}

struct NotificationsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
      sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
    ) private var lostItems: FetchedResults<LostItem>

    @FetchRequest(
      sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
    ) private var foundItems: FetchedResults<FoundItem>

    private var feed: [NotificationEntry] {
        let lostFeed = lostItems.compactMap { item -> NotificationEntry? in
            guard let id = item.id,
                  let title = item.title,
                  let owner = item.ownerEmail
            else { return nil }
            return .init(
                id: id,
                message: "🔴 Lost: “\(title)” reported by \(owner)",
                date: item.date ?? Date()
            )
        }
        let foundFeed = foundItems.compactMap { item -> NotificationEntry? in
            guard let id = item.id,
                  let title = item.title,
                  let finder = item.finderEmail
            else { return nil }
            return .init(
                id: id,
                message: "🟢 Found: “\(title)” reported by \(finder)",
                date: item.date ?? Date()
            )
        }
        return (lostFeed + foundFeed)
            .sorted { $0.date > $1.date }
    }

    var body: some View {
        List(feed) { entry in
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.message)
                Text(entry.date, style: .time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Notifications")
        .neuBranded()
    }
}
