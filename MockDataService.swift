//
//  MockDataService.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//

//import CoreData
//import Foundation
//#if canImport(UIKit)
//import UIKit
//#endif
//
//class MockDataService {
//    static func insertMockDataIfNeeded(context: NSManagedObjectContext) {
//        let alreadyInserted = UserDefaults.standard.bool(forKey: "didInsertMockData")
//        guard !alreadyInserted else { return }
//
//        // MARK: LOST ITEMS
//        let lost1 = LostItem(context: context)
//        lost1.id = UUID()
//        lost1.title = "Red Leather Wallet"
//        lost1.desc = "A small red leather wallet with cards and some cash inside. Lost near the campus library."
//        lost1.location = "Library"
//        lost1.date = Date().addingTimeInterval(-3600 * 24)
//
//        let lost2 = LostItem(context: context)
//        lost2.id = UUID()
//        lost2.title = "Silver Fossil Watch"
//        lost2.desc = "Analog silver Fossil watch, possibly lost near the dining hall."
//        lost2.location = "Dining Hall"
//        lost2.date = Date().addingTimeInterval(-3600 * 30)
//
//        let lost3 = LostItem(context: context)
//        lost3.id = UUID()
//        lost3.title = "Laptop Charger"
//        lost3.desc = "Black Dell charger left in a group study room on the 2nd floor."
//        lost3.location = "Study Room"
//        lost3.date = Date().addingTimeInterval(-3600 * 48)
//
//        let lost4 = LostItem(context: context)
//        lost4.id = UUID()
//        lost4.title = "Canvas Tote Bag"
//        lost4.desc = "Beige tote bag with notebooks and personal stationery. Lost in Auditorium."
//        lost4.location = "Auditorium"
//        lost4.date = Date().addingTimeInterval(-3600 * 72)
//
//        // MARK: FOUND ITEMS
//        let found1 = FoundItem(context: context)
//        found1.id = UUID()
//        found1.title = "Red Wallet"
//        found1.desc = "Red leather wallet found near library steps. Contains student ID."
//        found1.location = "Library"
//        found1.date = Date().addingTimeInterval(-3600 * 3)
//
//        let found2 = FoundItem(context: context)
//        found2.id = UUID()
//        found2.title = "Watch"
//        found2.desc = "Found silver watch at dining hall. No strap, just the face."
//        found2.location = "Dining Hall"
//        found2.date = Date().addingTimeInterval(-3600 * 5)
//
//        let found3 = FoundItem(context: context)
//        found3.id = UUID()
//        found3.title = "Black Charger"
//        found3.desc = "Black Dell charger picked up in Study Room 2C."
//        found3.location = "Study Room"
//        found3.date = Date().addingTimeInterval(-3600 * 6)
//
//        let found4 = FoundItem(context: context)
//        found4.id = UUID()
//        found4.title = "Tote Bag"
//        found4.desc = "Canvas tote bag left behind during seminar in Auditorium."
//        found4.location = "Auditorium"
//        found4.date = Date().addingTimeInterval(-3600 * 2)
//
//        let found5 = FoundItem(context: context)
//        found5.id = UUID()
//        found5.title = "Phone Case"
//        found5.desc = "Black phone case with stickers found in the cafeteria."
//        found5.location = "Cafeteria"
//        found5.date = Date().addingTimeInterval(-3600 * 10)
//
//        // Optional: Add sample image from SF Symbols
//        #if canImport(UIKit)
//        if let image = UIImage(systemName: "photo"), let data = image.jpegData(compressionQuality: 0.6) {
//            [lost1, lost2, lost3, lost4].forEach { $0.imageData = data }
//            [found1, found2, found3, found4, found5].forEach { $0.imageData = data }
//        }
//        #endif
//
//        do {
//            try context.save()
//            UserDefaults.standard.set(true, forKey: "didInsertMockData")
//            print("✅ Mock data inserted.")
//        } catch {
//            print("❌ Failed to insert mock data: \(error)")
//        }
//    }
//}


//import CoreData
//import Foundation
//#if canImport(UIKit)
//import UIKit
//#endif
//
//class MockDataService {
//    static func insertMockDataIfNeeded(context: NSManagedObjectContext) {
//        let alreadyInserted = UserDefaults.standard.bool(forKey: "didInsertMockData")
//        guard !alreadyInserted else { return }
//
//        // MARK: LOST ITEMS
//        let lost1 = LostItem(context: context)
//        lost1.id = UUID()
//        lost1.title = "Red Leather Wallet"
//        lost1.desc = "A small red leather wallet with cards and some cash inside. Lost near the campus library."
//        lost1.location = "Library"
//        lost1.date = Date().addingTimeInterval(-3600 * 24)
//
//        let lost2 = LostItem(context: context)
//        lost2.id = UUID()
//        lost2.title = "Silver Fossil Watch"
//        lost2.desc = "Analog silver Fossil watch, possibly lost near the dining hall."
//        lost2.location = "Dining Hall"
//        lost2.date = Date().addingTimeInterval(-3600 * 30)
//
//        let lost3 = LostItem(context: context)
//        lost3.id = UUID()
//        lost3.title = "Laptop Charger"
//        lost3.desc = "Black Dell charger left in a group study room on the 2nd floor."
//        lost3.location = "Study Room"
//        lost3.date = Date().addingTimeInterval(-3600 * 48)
//
//        let lost4 = LostItem(context: context)
//        lost4.id = UUID()
//        lost4.title = "Canvas Tote Bag"
//        lost4.desc = "Beige tote bag with notebooks and personal stationery. Lost in Auditorium."
//        lost4.location = "Auditorium"
//        lost4.date = Date().addingTimeInterval(-3600 * 72)
//
//        // MARK: FOUND ITEMS
//        let found1 = FoundItem(context: context)
//        found1.id = UUID()
//        found1.title = "Red Wallet"
//        found1.desc = "Red leather wallet found near library steps. Contains student ID."
//        found1.location = "Library"
//        found1.date = Date().addingTimeInterval(-3600 * 3)
//
//        let found2 = FoundItem(context: context)
//        found2.id = UUID()
//        found2.title = "Watch"
//        found2.desc = "Found silver watch at dining hall. No strap, just the face."
//        found2.location = "Dining Hall"
//        found2.date = Date().addingTimeInterval(-3600 * 5)
//
//        let found3 = FoundItem(context: context)
//        found3.id = UUID()
//        found3.title = "Black Charger"
//        found3.desc = "Black Dell charger picked up in Study Room 2C."
//        found3.location = "Study Room"
//        found3.date = Date().addingTimeInterval(-3600 * 6)
//
//        let found4 = FoundItem(context: context)
//        found4.id = UUID()
//        found4.title = "Tote Bag"
//        found4.desc = "Canvas tote bag left behind during seminar in Auditorium."
//        found4.location = "Auditorium"
//        found4.date = Date().addingTimeInterval(-3600 * 2)
//
//        let found5 = FoundItem(context: context)
//        found5.id = UUID()
//        found5.title = "Phone Case"
//        found5.desc = "Black phone case with stickers found in the cafeteria."
//        found5.location = "Cafeteria"
//        found5.date = Date().addingTimeInterval(-3600 * 10)
//
//        // Optional: Add sample image from SF Symbols
//        #if canImport(UIKit)
//        let imageNames = ["wallet.pass", "watchface.analog", "bolt", "bag", "iphone.gen3"]
//        let lostImages = imageNames.prefix(4)
//        let foundImages = imageNames
//
//        for (index, imageName) in lostImages.enumerated() {
//            if let image = UIImage(systemName: imageName), let data = image.jpegData(compressionQuality: 0.6) {
//                [lost1, lost2, lost3, lost4][index].imageData = data
//            }
//        }
//
//        for (index, imageName) in foundImages.enumerated() {
//            if let image = UIImage(systemName: imageName), let data = image.jpegData(compressionQuality: 0.6) {
//                [found1, found2, found3, found4, found5][index].imageData = data
//            }
//        }
//        #endif
//
//        do {
//            try context.save()
//            UserDefaults.standard.set(true, forKey: "didInsertMockData")
//            print("✅ Mock data inserted.")
//        } catch {
//            print("❌ Failed to insert mock data: \(error)")
//        }
//    }
//}


//import CoreData
//import Foundation
//#if canImport(UIKit)
//import UIKit
//#endif
//
//class MockDataService {
//    static func insertMockDataIfNeeded(context: NSManagedObjectContext) {
//        let alreadyInserted = UserDefaults.standard.bool(forKey: "didInsertMockData")
//        guard !alreadyInserted else { return }
//
//        // MARK: LOST ITEMS
//        let lost1 = LostItem(context: context)
//        lost1.id = UUID()
//        lost1.title = "Red Leather Wallet"
//        lost1.desc = "A small red leather wallet with cards and some cash inside. Lost near the campus library."
//        lost1.location = "Library"
//        lost1.date = Date().addingTimeInterval(-3600 * 24)
//
//        let lost2 = LostItem(context: context)
//        lost2.id = UUID()
//        lost2.title = "Silver Fossil Watch"
//        lost2.desc = "Analog silver Fossil watch, possibly lost near the dining hall."
//        lost2.location = "Dining Hall"
//        lost2.date = Date().addingTimeInterval(-3600 * 30)
//
//        let lost3 = LostItem(context: context)
//        lost3.id = UUID()
//        lost3.title = "Laptop Charger"
//        lost3.desc = "Black Dell charger left in a group study room on the 2nd floor."
//        lost3.location = "Study Room"
//        lost3.date = Date().addingTimeInterval(-3600 * 48)
//
//        let lost4 = LostItem(context: context)
//        lost4.id = UUID()
//        lost4.title = "Canvas Tote Bag"
//        lost4.desc = "Beige tote bag with notebooks and personal stationery. Lost in Auditorium."
//        lost4.location = "Auditorium"
//        lost4.date = Date().addingTimeInterval(-3600 * 72)
//
//        // MARK: FOUND ITEMS
//        let found1 = FoundItem(context: context)
//        found1.id = UUID()
//        found1.title = "Red Wallet"
//        found1.desc = "Red leather wallet found near library steps. Contains student ID."
//        found1.location = "Library"
//        found1.date = Date().addingTimeInterval(-3600 * 3)
//
//        let found2 = FoundItem(context: context)
//        found2.id = UUID()
//        found2.title = "Watch"
//        found2.desc = "Found silver watch at dining hall. No strap, just the face."
//        found2.location = "Dining Hall"
//        found2.date = Date().addingTimeInterval(-3600 * 5)
//
//        let found3 = FoundItem(context: context)
//        found3.id = UUID()
//        found3.title = "Black Charger"
//        found3.desc = "Black Dell charger picked up in Study Room 2C."
//        found3.location = "Study Room"
//        found3.date = Date().addingTimeInterval(-3600 * 6)
//
//        let found4 = FoundItem(context: context)
//        found4.id = UUID()
//        found4.title = "Tote Bag"
//        found4.desc = "Canvas tote bag left behind during seminar in Auditorium."
//        found4.location = "Auditorium"
//        found4.date = Date().addingTimeInterval(-3600 * 2)
//
//        let found5 = FoundItem(context: context)
//        found5.id = UUID()
//        found5.title = "Phone Case"
//        found5.desc = "Black phone case with stickers found in the cafeteria."
//        found5.location = "Cafeteria"
//        found5.date = Date().addingTimeInterval(-3600 * 10)
//
//        // MARK: Image Data
//        #if canImport(UIKit)
//        let lostIcons = ["wallet.pass", "watchface.analog", "bolt.fill", "bag.fill"]
//        let foundIcons = ["wallet.pass", "watchface.analog", "bolt.fill", "bag.fill", "iphone.gen3"]
//
//        let lostItems = [lost1, lost2, lost3, lost4]
//        for (index, iconName) in lostIcons.enumerated() {
//            if let img = UIImage(systemName: iconName),
//               let data = img.jpegData(compressionQuality: 0.7) {
//                lostItems[index].imageData = data
//            }
//        }
//
//        let foundItems = [found1, found2, found3, found4, found5]
//        for (index, iconName) in foundIcons.enumerated() {
//            if let img = UIImage(systemName: iconName),
//               let data = img.jpegData(compressionQuality: 0.7) {
//                foundItems[index].imageData = data
//            }
//        }
//        #endif
//
//        do {
//            try context.save()
//            UserDefaults.standard.set(true, forKey: "didInsertMockData")
//            print("✅ Mock data with images inserted.")
//        } catch {
//            print("❌ Failed to insert mock data: \(error)")
//        }
//    }
//}

//
//import CoreData
//import Foundation
//#if canImport(UIKit)
//import UIKit
//#endif
//
//class MockDataService {
//    static func insertMockDataFromMockAPI(context: NSManagedObjectContext) {
//        let alreadyInserted = UserDefaults.standard.bool(forKey: "didInsertMockDataFromAPI")
//        guard !alreadyInserted else { return }
//
//        let lostItemsURL = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/lostItems")!
//        let foundItemsURL = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/foundItems")!
//
//        let dispatchGroup = DispatchGroup()
//
//        dispatchGroup.enter()
//        URLSession.shared.dataTask(with: lostItemsURL) { data, _, error in
//            defer { dispatchGroup.leave() }
//            guard let data = data, error == nil else { return }
//            do {
//                let items = try JSONDecoder().decode([RemoteItem].self, from: data)
//                for remote in items {
//                    let item = LostItem(context: context)
//                    item.id = UUID()
//                    item.title = remote.title
//                    item.desc = remote.desc
//                    item.location = remote.location
//                    item.date = ISO8601DateFormatter().date(from: remote.date) ?? Date()
//                    if let url = URL(string: remote.imageURL),
//                       let imgData = try? Data(contentsOf: url) {
//                        item.imageData = imgData
//                    }
//                }
//            } catch {
//                print("❌ LostItems API decode failed: \(error)")
//            }
//        }.resume()
//
//        dispatchGroup.enter()
//        URLSession.shared.dataTask(with: foundItemsURL) { data, _, error in
//            defer { dispatchGroup.leave() }
//            guard let data = data, error == nil else { return }
//            do {
//                let items = try JSONDecoder().decode([RemoteItem].self, from: data)
//                for remote in items {
//                    let item = FoundItem(context: context)
//                    item.id = UUID()
//                    item.title = remote.title
//                    item.desc = remote.desc
//                    item.location = remote.location
//                    item.date = ISO8601DateFormatter().date(from: remote.date) ?? Date()
//                    if let url = URL(string: remote.imageURL),
//                       let imgData = try? Data(contentsOf: url) {
//                        item.imageData = imgData
//                    }
//                }
//            } catch {
//                print("❌ FoundItems API decode failed: \(error)")
//            }
//        }.resume()
//
//        dispatchGroup.notify(queue: .main) {
//            do {
//                try context.save()
//                UserDefaults.standard.set(true, forKey: "didInsertMockDataFromAPI")
//                print("✅ MockAPI data saved to Core Data")
//            } catch {
//                print("❌ Failed to save Core Data: \(error)")
//            }
//        }
//    }
//}
//
//struct RemoteItem: Codable {
//    var id: String
//    var title: String
//    var desc: String
//    var location: String
//    var date: String
//    var imageURL: String
//}


//import CoreData
//import Foundation
//#if canImport(UIKit)
//import UIKit
//#endif
//
//class MockDataService {
//    /// Pulls lost & found items from your MockAPI and writes them into Core Data
//    static func insertMockDataFromMockAPI() {
//        let defaultsKey = "didInsertMockDataFromAPI"
//        guard !UserDefaults.standard.bool(forKey: defaultsKey) else {
//            print("⚠️ Mock data already imported, skipping.")
//            return
//        }
//
//        let lostItemsURL  = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/lostItems")!
//        let foundItemsURL = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/foundItems")!
//
//        // 1) Grab a background context from your PersistenceController
//        let container = PersistenceController.shared.container
//        let bgContext = container.newBackgroundContext()
//
//        // 2) Fetch lost items
//        URLSession.shared.dataTask(with: lostItemsURL) { data, resp, err in
//            guard let data = data, err == nil else {
//                print("❌ LostItems API error:", err ?? "unknown")
//                return
//            }
//
//            do {
//                let remoteLost = try JSONDecoder().decode([RemoteItem].self, from: data)
//                bgContext.perform {
//                    print("📥 Importing \(remoteLost.count) lost items…")
//                    for r in remoteLost {
//                        let item = LostItem(context: bgContext)
//                        item.id       = UUID()
//                        item.title    = r.title
//                        item.desc     = r.desc
//                        item.location = r.location
//                        item.date     = ISO8601DateFormatter().date(from: r.date) ?? Date()
//                        if let url = URL(string: r.imageURL),
//                           let imgData = try? Data(contentsOf: url) {
//                            item.imageData = imgData
//                        }
//                    }
//                    do {
//                        try bgContext.save()
//                        print("✅ Saved lost items to Core Data")
//                    } catch {
//                        print("❌ Failed saving lost items:", error)
//                    }
//                }
//            } catch {
//                print("❌ LostItems JSON decode failed:", error)
//            }
//        }.resume()
//
//        // 3) Fetch found items
//        URLSession.shared.dataTask(with: foundItemsURL) { data, resp, err in
//            guard let data = data, err == nil else {
//                print("❌ FoundItems API error:", err ?? "unknown")
//                return
//            }
//
//            do {
//                let remoteFound = try JSONDecoder().decode([RemoteItem].self, from: data)
//                bgContext.perform {
//                    print("📥 Importing \(remoteFound.count) found items…")
//                    for r in remoteFound {
//                        let item = FoundItem(context: bgContext)
//                        item.id              = UUID()
//                        item.title           = r.title
//                        item.desc            = r.desc
//                        item.location        = r.location
//                        item.date            = ISO8601DateFormatter().date(from: r.date) ?? Date()
//                        if let url = URL(string: r.imageURL),
//                           let imgData = try? Data(contentsOf: url) {
//                            item.imageData = imgData
//                        }
//                    }
//                    do {
//                        try bgContext.save()
//                        print("✅ Saved found items to Core Data")
//
//                        // 4) Now that both batches are saved, flip the flag on the main context
//                        DispatchQueue.main.async {
//                            UserDefaults.standard.set(true, forKey: defaultsKey)
//                            print("🔖 Marked mock‐API data as imported.")
//                        }
//                    } catch {
//                        print("❌ Failed saving found items:", error)
//                    }
//                }
//            } catch {
//                print("❌ FoundItems JSON decode failed:", error)
//            }
//        }.resume()
//    }
//}
//
///// Codable mirror of your API’s JSON
//struct RemoteItem: Codable {
//    let id:       String
//    let title:    String
//    let desc:     String
//    let location: String
//    let date:     String   // must be ISO8601
//    let imageURL: String
//}

//
//import CoreData
//import Foundation
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct RemoteItem: Codable {
//    let id: String
//    let title: String
//    let desc: String
//    let location: String
//    let date: String     // ISO8601
//    let imageURL: String
//}
//
//class MockDataService {
//    /// Fetches `/lostItems` and `/foundItems` from your MockAPI,
//    /// writes them into Core Data on a background context,
//    /// then marks a flag to avoid re-importing.
//    static func insertMockDataFromMockAPI() {
//        let defaultsKey = "didInsertMockDataFromAPI"
//        guard !UserDefaults.standard.bool(forKey: defaultsKey) else {
//            print("⚠️ Mock data already imported, skipping.")
//            return
//        }
//
//        let base = "https://67fed17f58f18d7209ef601f.mockapi.io"
//        guard let lostURL  = URL(string: "\(base)/lostItems"),
//              let foundURL = URL(string: "\(base)/foundItems")
//        else {
//            print("❌ Invalid MockAPI URL")
//            return
//        }
//
//        let container = PersistenceController.shared.container
//        let bgContext = container.newBackgroundContext()
//        bgContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//
//        let group = DispatchGroup()
//
//        func fetchAndSave<T: NSManagedObject>(
//            url: URL,
//            decodeType: [RemoteItem].Type,
//            create: @escaping (RemoteItem) -> T
//        ) {
//            group.enter()
//            URLSession.shared.dataTask(with: url) { data, resp, error in
//                defer { group.leave() }
//                if let error = error {
//                    print("❌ Network error:", error)
//                    return
//                }
//                if let http = resp as? HTTPURLResponse,
//                   !(200..<300).contains(http.statusCode) {
//                    print("❌ HTTP \(http.statusCode) from", url)
//                    return
//                }
//                guard let data = data else {
//                    print("❌ No data from", url)
//                    return
//                }
//                do {
//                    let remoteItems = try JSONDecoder().decode(decodeType, from: data)
//                    bgContext.performAndWait {
//                        print("📥 Importing \(remoteItems.count) from \(url.lastPathComponent)…")
//                        for r in remoteItems {
//                            let item = create(r)
//                            item.setValue(UUID(), forKey: "id")
//                            item.setValue(r.title,     forKey: "title")
//                            item.setValue(r.desc,      forKey: "desc")
//                            item.setValue(r.location,  forKey: "location")
//                            let date = ISO8601DateFormatter().date(from: r.date) ?? Date()
//                            item.setValue(date,        forKey: "date")
//                            if let imgURL = URL(string: r.imageURL),
//                               let imgData = try? Data(contentsOf: imgURL) {
//                                item.setValue(imgData, forKey: "imageData")
//                            }
//                        }
//                        do {
//                            try bgContext.save()
//                            print("✅ Saved \(url.lastPathComponent) to Core Data")
//                        } catch {
//                            print("❌ Core Data save failed:", error)
//                        }
//                    }
//                } catch {
//                    print("❌ JSON decode failed for", url, error)
//                }
//            }.resume()
//        }
//
//        // Kick off the two fetches:
//        fetchAndSave(url: lostURL, decodeType: [RemoteItem].self) { r in
//            LostItem(context: bgContext)
//        }
//        fetchAndSave(url: foundURL, decodeType: [RemoteItem].self) { r in
//            FoundItem(context: bgContext)
//        }
//
//        // Once both done, flip the flag on the main queue
//        group.notify(queue: .main) {
//            UserDefaults.standard.set(true, forKey: defaultsKey)
//            print("🔖 Marked mock-API data as imported.")
//        }
//    }
//}

//
//import CoreData
//import Foundation
//#if canImport(UIKit)
//import UIKit
//#endif
//
//class MockDataService {
//    /// Pulls lost & found items from your MockAPI and writes them into Core Data
//    static func insertMockDataFromMockAPI() {
//        let defaultsKey = "didInsertMockDataFromAPI"
//
//        // Only run once in production; we're resetting in DEBUG above
//        guard !UserDefaults.standard.bool(forKey: defaultsKey) else {
//            print("⚠️ Mock data already imported, skipping.")
//            return
//        }
//
//        let container = PersistenceController.shared.container
//        let bgContext = container.newBackgroundContext()
//
//        // 0) Delete any pre-existing LostItem/FoundItem to avoid duplicates
//        bgContext.performAndWait {
//            let deleteLost = NSBatchDeleteRequest(fetchRequest: LostItem.fetchRequest())
//            let deleteFound = NSBatchDeleteRequest(fetchRequest: FoundItem.fetchRequest())
//            do {
//                try bgContext.execute(deleteLost)
//                try bgContext.execute(deleteFound)
//                print("🗑️ Cleared out old LostItem & FoundItem records.")
//            } catch {
//                print("❌ Failed to clear old items:", error)
//            }
//        }
//
//        let lostItemsURL  = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/lostItems")!
//        let foundItemsURL = URL(string: "https://67fed17f58f18f18d7209ef601f.mockapi.io/foundItems")!
//
//        let dispatchGroup = DispatchGroup()
//
//        // 1) Fetch lost items
//        dispatchGroup.enter()
//        URLSession.shared.dataTask(with: lostItemsURL) { data, _, error in
//            defer { dispatchGroup.leave() }
//            guard let data = data, error == nil else {
//                print("❌ LostItems API error:", error ?? "unknown")
//                return
//            }
//            do {
//                let remoteLost = try JSONDecoder().decode([RemoteItem].self, from: data)
//                bgContext.perform {
//                    print("📥 Importing \(remoteLost.count) lost items…")
//                    for r in remoteLost {
//                        let item = LostItem(context: bgContext)
//                        item.id       = UUID() // you could instead use UUID(uuidString: r.id)
//                        item.title    = r.title
//                        item.desc     = r.desc
//                        item.location = r.location
//                        item.date     = ISO8601DateFormatter().date(from: r.date) ?? Date()
//                        if let url = URL(string: r.imageURL),
//                           let imgData = try? Data(contentsOf: url) {
//                            item.imageData = imgData
//                        }
//                    }
//                }
//            } catch {
//                print("❌ LostItems JSON decode failed:", error)
//            }
//        }.resume()
//
//        // 2) Fetch found items
//        dispatchGroup.enter()
//        URLSession.shared.dataTask(with: foundItemsURL) { data, _, error in
//            defer { dispatchGroup.leave() }
//            guard let data = data, error == nil else {
//                print("❌ FoundItems API error:", error ?? "unknown")
//                return
//            }
//            do {
//                let remoteFound = try JSONDecoder().decode([RemoteItem].self, from: data)
//                bgContext.perform {
//                    print("📥 Importing \(remoteFound.count) found items…")
//                    for r in remoteFound {
//                        let item = FoundItem(context: bgContext)
//                        item.id       = UUID()
//                        item.title    = r.title
//                        item.desc     = r.desc
//                        item.location = r.location
//                        item.date     = ISO8601DateFormatter().date(from: r.date) ?? Date()
//                        if let url = URL(string: r.imageURL),
//                           let imgData = try? Data(contentsOf: url) {
//                            item.imageData = imgData
//                        }
//                    }
//                }
//            } catch {
//                print("❌ FoundItems JSON decode failed:", error)
//            }
//        }.resume()
//
//        // 3) When both network calls finish, save & flip the flag
//        dispatchGroup.notify(queue: .main) {
//            bgContext.perform {
//                do {
//                    try bgContext.save()
//                    UserDefaults.standard.set(true, forKey: defaultsKey)
//                    print("✅ MockAPI data saved to Core Data")
//                } catch {
//                    print("❌ Failed to save Core Data:", error)
//                }
//            }
//        }
//    }
//}
//
///// Codable mirror of your API’s JSON
//struct RemoteItem: Codable {
//    let id:       String
//    let title:    String
//    let desc:     String
//    let location: String
//    let date:     String   // ISO8601
//    let imageURL: String
//}
//
//import CoreData
//import Foundation
//#if canImport(UIKit)
//import UIKit
//#endif
//
//class MockDataService {
//    /// Pulls lost & found items from your MockAPI and writes them into Core Data
//    static func insertMockDataFromMockAPI() {
//        let defaultsKey = "didInsertMockDataFromAPI"
//        guard !UserDefaults.standard.bool(forKey: defaultsKey) else {
//            print("⚠️ Mock data already imported, skipping.")
//            return
//        }
//
//        let container = PersistenceController.shared.container
//        let bgContext = container.newBackgroundContext()
//
//        // 0) Wipe out any existing items so we don't duplicate
//        bgContext.performAndWait {
//            let deleteLost  = NSBatchDeleteRequest(fetchRequest: LostItem.fetchRequest())
//            let deleteFound = NSBatchDeleteRequest(fetchRequest: FoundItem.fetchRequest())
//            do {
//                try bgContext.execute(deleteLost)
//                try bgContext.execute(deleteFound)
//                print("🗑️ Cleared out old LostItem & FoundItem records.")
//            } catch {
//                print("❌ Failed to clear old items:", error)
//            }
//        }
//
//        // 1) Set up your two URLs
//        let lostItemsURL  = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/lostItems")!
//        let foundItemsURL = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/foundItems")!
//
//        let dispatchGroup = DispatchGroup()
//
//        // 2) Fetch & decode LostItems
//        dispatchGroup.enter()
//        URLSession.shared.dataTask(with: lostItemsURL) { data, _, error in
//            defer { dispatchGroup.leave() }
//            guard let data = data, error == nil else {
//                print("❌ LostItems API error:", error ?? "unknown")
//                return
//            }
//            do {
//                let remoteLost = try JSONDecoder().decode([RemoteItem].self, from: data)
//                bgContext.perform {
//                    print("📥 Importing \(remoteLost.count) lost items…")
//                    for r in remoteLost {
//                        let item = LostItem(context: bgContext)
//                        // Use the API's id if possible, else fall back to a new UUID
//                        item.id       = UUID(uuidString: r.id) ?? UUID()
//                        item.title    = r.title
//                        item.desc     = r.desc
//                        item.location = r.location
//                        item.date     = ISO8601DateFormatter().date(from: r.date) ?? Date()
//                        if let url = URL(string: r.imageURL),
//                           let imgData = try? Data(contentsOf: url) {
//                            item.imageData = imgData
//                        }
//                    }
//                }
//            } catch {
//                print("❌ LostItems JSON decode failed:", error)
//            }
//        }.resume()
//
//        // 3) Fetch & decode FoundItems
//        dispatchGroup.enter()
//        URLSession.shared.dataTask(with: foundItemsURL) { data, _, error in
//            defer { dispatchGroup.leave() }
//            guard let data = data, error == nil else {
//                print("❌ FoundItems API error:", error ?? "unknown")
//                return
//            }
//            do {
//                let remoteFound = try JSONDecoder().decode([RemoteItem].self, from: data)
//                bgContext.perform {
//                    print("📥 Importing \(remoteFound.count) found items…")
//                    for r in remoteFound {
//                        let item = FoundItem(context: bgContext)
//                        item.id       = UUID(uuidString: r.id) ?? UUID()
//                        item.title    = r.title
//                        item.desc     = r.desc
//                        item.location = r.location
//                        item.date     = ISO8601DateFormatter().date(from: r.date) ?? Date()
//                        if let url = URL(string: r.imageURL),
//                           let imgData = try? Data(contentsOf: url) {
//                            item.imageData = imgData
//                        }
//                    }
//                }
//            } catch {
//                print("❌ FoundItems JSON decode failed:", error)
//            }
//        }.resume()
//
//        // 4) When both network calls finish, save once and flip the flag
//        dispatchGroup.notify(queue: .main) {
//            bgContext.perform {
//                do {
//                    try bgContext.save()
//                    UserDefaults.standard.set(true, forKey: defaultsKey)
//                    print("✅ MockAPI data saved to Core Data")
//                } catch {
//                    print("❌ Failed to save Core Data:", error)
//                }
//            }
//        }
//    }
//}
//
///// Codable mirror of your API’s JSON
//struct RemoteItem: Codable {
//    let id:       String
//    let title:    String
//    let desc:     String
//    let location: String
//    let date:     String   // ISO8601
//    let imageURL: String
//}

//
//import CoreData
//import Foundation
//#if canImport(UIKit)
//import UIKit
//#endif
//
//class MockDataService {
//    /// Call this once on app-launch (e.g. in your App.onAppear).
//    /// It will clear out any existing LostItem / FoundItem,
//    /// fetch both endpoints, decode, save, and mark itself done.
//    static func importMockAPIData(into container: NSPersistentContainer) {
//        #if DEBUG
//        // allow repeated imports during development
//        UserDefaults.standard.set(false, forKey: "didImportMockAPIData")
//        #endif
//
//        let already = UserDefaults.standard.bool(forKey: "didImportMockAPIData")
//        guard !already else {
//            print("⚠️ MockAPI import skipped (alreadyDone).")
//            return
//        }
//
//        let bg = container.newBackgroundContext()
//        bg.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//
//        // 1) Wipe out old items to avoid duplicates
//        bg.performAndWait {
//            let deleteLost  = NSBatchDeleteRequest(fetchRequest: LostItem.fetchRequest())
//            let deleteFound = NSBatchDeleteRequest(fetchRequest: FoundItem.fetchRequest())
//            do {
//                try bg.execute(deleteLost)
//                try bg.execute(deleteFound)
//                print("🗑️ Cleared old LostItem + FoundItem rows.")
//            } catch {
//                print("❌ Failed to clear old items:", error)
//            }
//        }
//
//        let lostURL  = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/lostItems")!
//        let foundURL = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/foundItems")!
//
//        let group = DispatchGroup()
//
//        func fetch<T: Decodable>(_ url: URL, into creator: @escaping (RemoteItem) -> NSManagedObject) {
//            group.enter()
//            URLSession.shared.dataTask(with: url) { data, _, err in
//                defer { group.leave() }
//                guard let d = data, err == nil else {
//                    print("❌ \(url.lastPathComponent) error:", err ?? "unknown")
//                    return
//                }
//                do {
//                    let arr = try JSONDecoder().decode([RemoteItem].self, from: d)
//                    bg.perform {
//                        print("📥 Importing \(arr.count) \(url.lastPathComponent)…")
//                        for r in arr {
//                            let obj = creator(r)
//                            obj.setValue(UUID(), forKey: "id")
//                            obj.setValue(r.title,    forKey: "title")
//                            obj.setValue(r.desc,     forKey: "desc")
//                            obj.setValue(r.location, forKey: "location")
//                            obj.setValue(
//                                ISO8601DateFormatter().date(from: r.date) ?? Date(),
//                                forKey: "date"
//                            )
//                            if let u = URL(string: r.imageURL),
//                               let imgData = try? Data(contentsOf: u) {
//                                obj.setValue(imgData, forKey: "imageData")
//                            }
//                            // If you’ve added latitude/longitude to your model:
//                            if let lat = r.latitude, let lng = r.longitude {
//                                obj.setValue(lat, forKey: "latitude")
//                                obj.setValue(lng, forKey: "longitude")
//                            }
//                        }
//                    }
//                } catch {
//                    print("❌ \(url.lastPathComponent) decode failed:", error)
//                }
//            }.resume()
//        }
//
//        // Kick off both requests
//        fetch(lostURL)  { RemoteItem in LostItem(context: bg)  }
//        fetch(foundURL) { RemoteItem in FoundItem(context: bg) }
//
//        // When both done, save & mark flag
//        group.notify(queue: .main) {
//            bg.perform {
//                do {
//                    try bg.save()
//                    UserDefaults.standard.set(true, forKey: "didImportMockAPIData")
//                    print("✅ MockAPI data saved to Core Data")
//                } catch {
//                    print("❌ Saving to Core Data failed:", error)
//                }
//            }
//        }
//    }
//}
//
///// Codable mirror of your MockAPI JSON.
///// Note latitude/longitude are optional here.
//struct RemoteItem: Codable {
//    let id:       String
//    let title:    String
//    let desc:     String
//    let location: String
//    let date:     String          // ISO8601
//    let imageURL: String
//    let latitude: Double?
//    let longitude: Double?
//}

// MockDataService.swift

//
//
//import CoreData
//import Foundation
//#if canImport(UIKit)
//import UIKit
//#endif
//
///// Mirrors the JSON structure from your mock API.
//struct RemoteItem: Codable {
//    let id:       String
//    let title:    String
//    let desc:     String
//    let location: String
//    let date:     String   // ISO8601 timestamp
//    let imageURL: String
//}
//
//class MockDataService {
//    /// Pulls lost & found items from your MockAPI and writes them into Core Data exactly once.
//    static func importMockAPIData(into container: NSPersistentContainer) {
//        let defaultsKey = "didInsertMockDataFromAPI"
//        guard !UserDefaults.standard.bool(forKey: defaultsKey) else {
//            print("⚠️ Mock data already imported, skipping.")
//            return
//        }
//
//        let bgContext = container.newBackgroundContext()
//        bgContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//
//        // 1) Clear out any old items to avoid duplicates.
//        bgContext.performAndWait {
//            do {
//                try bgContext.execute(NSBatchDeleteRequest(fetchRequest: LostItem.fetchRequest()))
//                try bgContext.execute(NSBatchDeleteRequest(fetchRequest: FoundItem.fetchRequest()))
//                print("🗑️ Cleared old LostItem & FoundItem records.")
//            } catch {
//                print("❌ Failed to clear old items:", error)
//            }
//        }
//
//        // Endpoints
//        let lostItemsURL  = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/")!
//        let foundItemsURL = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/")!
//
//        let group = DispatchGroup()
//
//        // Fetch & decode lost items
//        group.enter()
//        URLSession.shared.dataTask(with: lostItemsURL) { data, _, err in
//            defer { group.leave() }
//            guard let data = data, err == nil else {
//                print("❌ LostItems API error:", err ?? "unknown")
//                return
//            }
//            do {
//                let remote = try JSONDecoder().decode([RemoteItem].self, from: data)
//                bgContext.perform {
//                    for r in remote {
//                        let item = LostItem(context: bgContext)
//                        item.id       = UUID(uuidString: r.id) ?? UUID()
//                        item.title    = r.title
//                        item.desc     = r.desc
//                        item.location = r.location
//                        item.date     = ISO8601DateFormatter().date(from: r.date) ?? Date()
//                        if let url = URL(string: r.imageURL),
//                           let d   = try? Data(contentsOf: url) {
//                            item.imageData = d
//                        }
//                    }
//                    print("📥 Imported \(remote.count) lost items.")
//                }
//            } catch {
//                print("❌ LostItems JSON decode failed:", error)
//            }
//        }.resume()
//
//        // Fetch & decode found items
//        group.enter()
//        URLSession.shared.dataTask(with: foundItemsURL) { data, _, err in
//            defer { group.leave() }
//            guard let data = data, err == nil else {
//                print("❌ FoundItems API error:", err ?? "unknown")
//                return
//            }
//            do {
//                let remote = try JSONDecoder().decode([RemoteItem].self, from: data)
//                bgContext.perform {
//                    for r in remote {
//                        let item = FoundItem(context: bgContext)
//                        item.id       = UUID(uuidString: r.id) ?? UUID()
//                        item.title    = r.title
//                        item.desc     = r.desc
//                        item.location = r.location
//                        item.date     = ISO8601DateFormatter().date(from: r.date) ?? Date()
//                        if let url = URL(string: r.imageURL),
//                           let d   = try? Data(contentsOf: url) {
//                            item.imageData = d
//                        }
//                    }
//                    print("📥 Imported \(remote.count) found items.")
//                }
//            } catch {
//                print("❌ FoundItems JSON decode failed:", error)
//            }
//        }.resume()
//
//        // Once both are done, save in background and flip the flag on the main context
//        group.notify(queue: .main) {
//            bgContext.perform {
//                do {
//                    try bgContext.save()
//                    UserDefaults.standard.set(true, forKey: defaultsKey)
//                    print("✅ MockAPI data saved to Core Data")
//                } catch {
//                    print("❌ Failed to save Core Data:", error)
//                }
//            }
//        }
//    }
//}

//
//import CoreData
//import Foundation
//#if canImport(UIKit)
//import UIKit
//#endif
//
///// Mirrors the JSON for lost items from your mock API.
//struct RemoteLostItem: Codable {
//    let id:       String
//    let title:    String
//    let desc:     String
//    let location: String
//    let date:     String   // ISO8601
//    let imageURL: String
//}
//
///// Mirrors the JSON for found items from your mock API.
///// (We’ve added latitude, longitude, finderEmail & verificationClue here.)
//struct RemoteFoundItem: Codable {
//    let id:               String
//    let title:            String
//    let desc:             String
//    let location:         String
//    let date:             String   // ISO8601
//    let imageURL:         String
//    let latitude:         Double
//    let longitude:        Double
//    let finderEmail:      String
//    let verificationClue: String?
//}
//
//class MockDataService {
//    /// Pulls lost & found items from MockAPI (once), and if the found-items endpoint
//    /// comes back empty, seeds a few hard-coded “found” items so your list isn’t blank.
//    static func importMockAPIData(into container: NSPersistentContainer) {
//        let defaultsKey = "didInsertMockDataFromAPI"
//        guard !UserDefaults.standard.bool(forKey: defaultsKey) else {
//            print("⚠️ Mock data already imported, skipping.")
//            return
//        }
//
//        let bg = container.newBackgroundContext()
//        bg.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//
//        // 1) Clear old records to avoid duplicates
//        bg.performAndWait {
//            do {
//                try bg.execute(NSBatchDeleteRequest(fetchRequest: LostItem.fetchRequest()))
//                try bg.execute(NSBatchDeleteRequest(fetchRequest: FoundItem.fetchRequest()))
//                print("🗑️ Cleared old LostItem & FoundItem records.")
//            } catch {
//                print("❌ Failed to clear old items:", error)
//            }
//        }
//
//        // 2) Prepare your two endpoints
//        let lostURL  = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/lostItems")!
//        let foundURL = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/foundItems")!
//
//        let group = DispatchGroup()
//
//        // 3) Fetch Lost Items
//        group.enter()
//        URLSession.shared.dataTask(with: lostURL) { data, _, err in
//            defer { group.leave() }
//            guard let data = data, err == nil else {
//                print("❌ LostItems API error:", err ?? "unknown")
//                return
//            }
//            do {
//                let remote = try JSONDecoder().decode([RemoteLostItem].self, from: data)
//                bg.perform {
//                    for r in remote {
//                        let item = LostItem(context: bg)
//                        item.id       = UUID(uuidString: r.id) ?? UUID()
//                        item.title    = r.title
//                        item.desc     = r.desc
//                        item.location = r.location
//                        item.date     = ISO8601DateFormatter().date(from: r.date) ?? Date()
//                        if let url = URL(string: r.imageURL),
//                           let d   = try? Data(contentsOf: url) {
//                            item.imageData = d
//                        }
//                    }
//                    print("📥 Imported \(remote.count) lost items.")
//                }
//            } catch {
//                print("❌ LostItems JSON decode failed:", error)
//            }
//        }.resume()
//
//        // 4) Fetch Found Items
//        group.enter()
//        URLSession.shared.dataTask(with: foundURL) { data, _, err in
//            defer { group.leave() }
//            guard let data = data, err == nil else {
//                print("❌ FoundItems API error:", err ?? "unknown")
//                return
//            }
//            do {
//                let remote = try JSONDecoder().decode([RemoteFoundItem].self, from: data)
//                bg.perform {
//                    if remote.isEmpty {
//                        // fallback to hard-coded mock data
//                        seedFallbackFoundItems(in: bg)
//                        print("⚠️ API returned 0 found-items; used fallback mock data.")
//                    } else {
//                        for r in remote {
//                            let item = FoundItem(context: bg)
//                            item.id               = UUID(uuidString: r.id) ?? UUID()
//                            item.title            = r.title
//                            item.desc             = r.desc
//                            item.location         = r.location
//                            item.date             = ISO8601DateFormatter().date(from: r.date) ?? Date()
//                            item.latitude         = r.latitude
//                            item.longitude        = r.longitude
//                            item.finderEmail       = r.finderEmail
//                            item.verificationClue = r.verificationClue
//                            if let url = URL(string: r.imageURL),
//                               let d   = try? Data(contentsOf: url) {
//                                item.imageData = d
//                            }
//                        }
//                        print("📥 Imported \(remote.count) found items.")
//                    }
//                }
//            } catch {
//                print("❌ FoundItems JSON decode failed:", error)
//                bg.perform { seedFallbackFoundItems(in: bg) }
//            }
//        }.resume()
//
//        // 5) When both are done, save & mark the flag
//        group.notify(queue: .main) {
//            bg.perform {
//                do {
//                    try bg.save()
//                    UserDefaults.standard.set(true, forKey: defaultsKey)
//                    print("✅ MockAPI + fallback data saved to Core Data")
//                } catch {
//                    print("❌ Failed to save Core Data:", error)
//                }
//            }
//        }
//    }
//
//    /// Hard-coded fallback found items so your Found tab never stays empty.
//    private static func seedFallbackFoundItems(in ctx: NSManagedObjectContext) {
//        let examples: [RemoteFoundItem] = [
//            .init(
//              id: "a1",
//              title: "Red Leather Wallet",
//              desc: "Small wallet found by Snell Library entrance.",
//              location: "Snell Library Entrance",
//              date: ISO8601DateFormatter().string(from: Date().addingTimeInterval(-3600)),
//              imageURL: "https://i.imgur.com/2nCt3Sb.jpg",
//              latitude: 42.3334,
//              longitude: -71.0806,
//              finderEmail: "alice@northeastern.edu",
//              verificationClue: "Northeastern ID"
//            ),
//            .init(
//              id: "a2",
//              title: "Silver Watch Face",
//              desc: "Watch face found in Curry Student Center.",
//              location: "Curry Student Center",
//              date: ISO8601DateFormatter().string(from: Date().addingTimeInterval(-7200)),
//              imageURL: "https://i.imgur.com/6Xo8rQk.jpg",
//              latitude: 42.33906,
//              longitude: -71.08750,
//              finderEmail: "bob@northeastern.edu",
//              verificationClue: nil
//            )
//        ]
//        
//
//        for r in examples {
//            let item = FoundItem(context: ctx)
//            item.id               = UUID(uuidString: r.id) ?? UUID()
//            item.title            = r.title
//            item.desc             = r.desc
//            item.location         = r.location
//            item.date             = ISO8601DateFormatter().date(from: r.date) ?? Date()
//            item.latitude         = r.latitude
//            item.longitude        = r.longitude
//            item.finderEmail       = r.finderEmail
//            item.verificationClue = r.verificationClue
//            if let url = URL(string: r.imageURL),
//               let d   = try? Data(contentsOf: url) {
//                item.imageData = d
//            }
//        }
//    }
//}


import CoreData
import Foundation
#if canImport(UIKit)
import UIKit
#endif

/// Mirrors the JSON for lost items from your mock API.
struct RemoteLostItem: Codable {
    let id:       String
    let title:    String
    let desc:     String
    let location: String
    let date:     String   // ISO8601
    let imageURL: String
}

/// Mirrors the JSON for found items from your mock API.
/// (Includes extra lat/long, finder email and optional clue.)
struct RemoteFoundItem: Codable {
    let id:               String
    let title:            String
    let desc:             String
    let location:         String
    let date:             String   // ISO8601
    let imageURL:         String
    let latitude:         Double
    let longitude:        Double
    let finderEmail:      String
    let verificationClue: String?
}

class MockDataService {
    /// Pulls lost & found items from MockAPI (once), seeds fallback if Found is empty.
    static func importMockAPIData(into container: NSPersistentContainer) {
        let defaultsKey = "didInsertMockDataFromAPI"
        guard !UserDefaults.standard.bool(forKey: defaultsKey) else {
            print("⚠️ Mock data already imported, skipping.")
            return
        }

        let bg = container.newBackgroundContext()
        bg.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        // 1) Clear old records to avoid duplicates
        bg.performAndWait {
            do {
                try bg.execute(NSBatchDeleteRequest(fetchRequest: LostItem.fetchRequest()))
                try bg.execute(NSBatchDeleteRequest(fetchRequest: FoundItem.fetchRequest()))
                print("🗑️ Cleared old LostItem & FoundItem records.")
            } catch {
                print("❌ Failed to clear old items:", error)
            }
        }

        // 2) Endpoints
        let lostURL  = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/lostItems")!
        let foundURL = URL(string: "https://67fed17f58f18d7209ef601f.mockapi.io/foundItems")!

        let group = DispatchGroup()

        // 3) Fetch Lost Items
        group.enter()
        URLSession.shared.dataTask(with: lostURL) { data, _, err in
            defer { group.leave() }
            guard let data = data, err == nil else {
                print("❌ LostItems API error:", err ?? "unknown")
                return
            }
            do {
                let remote = try JSONDecoder().decode([RemoteLostItem].self, from: data)
                bg.perform {
                    for r in remote {
                        let item = LostItem(context: bg)
                        item.id       = UUID(uuidString: r.id) ?? UUID()
                        item.title    = r.title
                        item.desc     = r.desc
                        item.location = r.location
                        item.date     = ISO8601DateFormatter().date(from: r.date) ?? Date()
                        if let url = URL(string: r.imageURL),
                           let d   = try? Data(contentsOf: url) {
                            item.imageData = d
                        }
                    }
                    print("📥 Imported \(remote.count) lost items.")
                }
            } catch {
                print("❌ LostItems JSON decode failed:", error)
            }
        }.resume()

        // 4) Fetch Found Items
        group.enter()
        URLSession.shared.dataTask(with: foundURL) { data, _, err in
            defer { group.leave() }
            guard let data = data, err == nil else {
                print("❌ FoundItems API error:", err ?? "unknown")
                return
            }
            do {
                let remote = try JSONDecoder().decode([RemoteFoundItem].self, from: data)
                bg.perform {
                    if remote.isEmpty {
                        // no API results → fallback
                        seedFallbackFoundItems(in: bg)
                        print("⚠️ API returned 0 found-items; used fallback mock data.")
                    } else {
                        for r in remote {
                            let item = FoundItem(context: bg)
                            item.id               = UUID(uuidString: r.id) ?? UUID()
                            item.title            = r.title
                            item.desc             = r.desc
                            item.location         = r.location
                            item.date             = ISO8601DateFormatter().date(from: r.date) ?? Date()
                            item.latitude         = r.latitude
                            item.longitude        = r.longitude
                            item.finderEmail      = r.finderEmail
                            item.verificationClue = r.verificationClue
                            if let url = URL(string: r.imageURL),
                               let d   = try? Data(contentsOf: url) {
                                item.imageData = d
                            }
                        }
                        print("📥 Imported \(remote.count) found items.")
                    }
                }
            } catch {
                print("❌ FoundItems JSON decode failed:", error)
                bg.perform { seedFallbackFoundItems(in: bg) }
            }
        }.resume()

        // 5) Save all and mark flag
        group.notify(queue: .main) {
            bg.perform {
                do {
                    try bg.save()
                    UserDefaults.standard.set(true, forKey: defaultsKey)
                    print("✅ MockAPI + fallback data saved to Core Data")
                } catch {
                    print("❌ Failed to save Core Data:", error)
                }
            }
        }
    }

    /// Hard-coded fallback so your “Found” list never stays empty.
    private static func seedFallbackFoundItems(in ctx: NSManagedObjectContext) {
        let examples: [RemoteFoundItem] = [
            .init(
              id: "a1",
              title: "Red Leather Wallet",
              desc: "Small wallet found by Snell Library entrance.",
              location: "Snell Library Entrance",
              date: ISO8601DateFormatter().string(from: Date().addingTimeInterval(-3600)),
              imageURL: "https://i.imgur.com/2nCt3Sb.jpg",
              latitude: 42.3334,
              longitude: -71.0806,
              finderEmail: "alice@northeastern.edu",
              verificationClue: "Contains NEU ID"
            ),
            .init(
              id: "a2",
              title: "Silver Watch Face",
              desc: "Watch face found in Curry Student Center.",
              location: "Curry Student Center",
              date: ISO8601DateFormatter().string(from: Date().addingTimeInterval(-7200)),
              imageURL: "https://i.imgur.com/6Xo8rQk.jpg",
              latitude: 42.33906,
              longitude: -71.08750,
              finderEmail: "bob@northeastern.edu",
              verificationClue: nil
            )
        ]

        for r in examples {
            let item = FoundItem(context: ctx)
            item.id               = UUID(uuidString: r.id) ?? UUID()
            item.title            = r.title
            item.desc             = r.desc
            item.location         = r.location
            item.date             = ISO8601DateFormatter().date(from: r.date) ?? Date()
            item.latitude         = r.latitude
            item.longitude        = r.longitude
            item.finderEmail      = r.finderEmail
            item.verificationClue = r.verificationClue
            if let url = URL(string: r.imageURL),
               let d   = try? Data(contentsOf: url) {
                item.imageData = d
            }
        }
    }
}
