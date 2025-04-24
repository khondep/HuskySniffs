//
//  LostAndFoundHubApp.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//



//import SwiftUI
//
//
//@main
//struct LostAndFoundHubApp: App {
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        WindowGroup {
//            RootView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                .onAppear {
//                    MockDataService.insertMockDataFromMockAPI(context: persistenceController.container.viewContext)
//                }
//        }
//    }
//}


//import SwiftUI
//
//@main
//struct LostAndFoundHubApp: App {
//    // Persist the user's chosen theme: "system", "light", or "dark"
//    @AppStorage("appTheme") private var appTheme: String = "system"
//    
//    let persistenceController = PersistenceController.shared
//
//    /// Maps stored string to SwiftUI ColorScheme
//    private var preferredScheme: ColorScheme? {
//        switch appTheme {
//        case "light": return .light
//        case "dark": return .dark
//        default: return nil
//        }
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            RootView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                // Global accent tint for Northeastern red
//                .accentColor(.neuRed)
//                // Force light/dark or respect system
//                .preferredColorScheme(preferredScheme)
//                .onAppear {
//                    // Pull in mock data from your mock API
//                    MockDataService.insertMockDataFromMockAPI(context: persistenceController.container.viewContext)
//                }
//        }
//    }
//}

// MARK: - Helper: Make sure you have a Color+Theme.swift defining .neuRed
// extension Color {
//     static let neuRed = Color("HuskyRed")
//     // ... other colors
// }



//import SwiftUI
//
//@main
//struct LostAndFoundHubApp: App {
//    // Persist the user's chosen theme: "system", "light", or "dark"
//    @AppStorage("appTheme") private var appTheme: String = "system"
//    
//    let persistenceController = PersistenceController.shared
//
//    /// Maps stored string to SwiftUI ColorScheme
//    private var preferredScheme: ColorScheme? {
//        switch appTheme {
//        case "light": return .light
//        case "dark": return .dark
//        default:     return nil
//        }
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            RootView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                // Global accent tint for Northeastern red
//                .accentColor(.neuRed)
//                // Force light/dark or respect system
//                .preferredColorScheme(preferredScheme)
//                .onAppear {
//                    // Pull in mock data from your mock API
//                    MockDataService.insertMockDataFromMockAPI()
//                }
//        }
//    }
//}


import SwiftUI

//@main
//struct LostAndFoundHubApp: App {
//    // Persist the user's chosen theme: "system", "light", or "dark"
//    @AppStorage("appTheme") private var appTheme: String = "system"
//    
//    let persistenceController = PersistenceController.shared
//
//    /// Maps stored string to SwiftUI ColorScheme
//    private var preferredScheme: ColorScheme? {
//        switch appTheme {
//        case "light": return .light
//        case "dark":  return .dark
//        default:      return nil
//        }
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            RootView()
//                .environment(\.managedObjectContext,
//                             persistenceController.container.viewContext)
//                .accentColor(.neuRed)                     // your custom red
//                .preferredColorScheme(preferredScheme)    // force or respect system
//                .onAppear {
//                    #if DEBUG
//                    // DEV ONLY: force re‐import each launch
//                    UserDefaults.standard.removeObject(
//                      forKey: "didInsertMockDataFromAPI"
//                    )
//                    #endif
//
//                    // now pull in mock‐API data
//                    MockDataService.insertMockDataFromMockAPI()
//                }
//        }
//    }
//}
//
//@main
//struct LostAndFoundHubApp: App {
//    @AppStorage("appTheme") private var appTheme: String = "system"
//    let persistenceController = PersistenceController.shared
//
//    private var preferredScheme: ColorScheme? {
//        switch appTheme {
//        case "light": return .light
//        case "dark":  return .dark
//        default:      return nil
//        }
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            RootView()
//                .environment(
//                  \.managedObjectContext,
//                  persistenceController.container.viewContext
//                )
//                .accentColor(.neuRed)
//                .preferredColorScheme(preferredScheme)
//                .onAppear {
//                    // pass your main context here so the background importer
//                    // can spawn a child context off of it
//                    MockDataService.insertMockDataFromMockAPI(
//                        context: persistenceController.container.viewContext
//                    )
//                }
//        }
//    }
//}




//@main
//struct LostAndFoundHubApp: App {
//    // Persist the user's chosen theme: "system", "light", or "dark"
//    @AppStorage("appTheme") private var appTheme: String = "system"
//    
//    let persistenceController = PersistenceController.shared
//
//    /// Maps stored string to SwiftUI ColorScheme
//    private var preferredScheme: ColorScheme? {
//        switch appTheme {
//        case "light": return .light
//        case "dark": return .dark
//        default:     return nil
//        }
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            RootView()
//                .environment(\.managedObjectContext,
//                             persistenceController.container.viewContext)
//                // Global accent tint for Northeastern red
//                .accentColor(.neuRed)
//                // Force light/dark or respect system
//                .preferredColorScheme(preferredScheme)
//                .onAppear {
//                    // ⚠️ This takes NO arguments now
//                    MockDataService.insertMockDataFromMockAPI()
//                }
//        }
//    }
//}



@main
struct LostAndFoundHubApp: App {
    // Persist the user's chosen theme: "system", "light", or "dark"
    @AppStorage("appTheme") private var appTheme: String = "system"
    
    let persistenceController = PersistenceController.shared

    /// Maps stored string to SwiftUI ColorScheme
    private var preferredScheme: ColorScheme? {
        switch appTheme {
        case "light": return .light
        case "dark":  return .dark
        default:      return nil
        }
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(
                    \.managedObjectContext,
                    persistenceController.container.viewContext
                )
                // Global accent tint for Northeastern red
                .accentColor(.neuRed)
                // Force light/dark or respect system
                .preferredColorScheme(preferredScheme)
                .onAppear {
                    // Make sure the main context picks up background saves:
                    persistenceController
                        .container
                        .viewContext
                        .automaticallyMergesChangesFromParent = true

                    // Pull in mock data from your mock API
                    MockDataService.importMockAPIData(
                        into: persistenceController.container
                    )
                }
        }
    }
}
