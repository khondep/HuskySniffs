//
//  ProfileView.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//

//
//
//import SwiftUI
//
//struct ProfileView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @FetchRequest(entity: LostItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)])
//    var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(entity: FoundItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)])
//    var foundItems: FetchedResults<FoundItem>
//
//    @State private var editingLost: LostItem?
//    @State private var editingFound: FoundItem?
//
//    var body: some View {
//        NavigationView {
//            List {
//                Section(header: Text("Your Lost Items")) {
////                    let userLostItems = lostItems.filter { $0.ownerEmail == currentUserEmail }
//                    let userLostItems = lostItems.filter { $0.ownerEmail == currentUserEmail }
//                    if userLostItems.isEmpty {
//                        Text("You haven’t reported any lost items yet.")
//                            .foregroundColor(.gray)
//                            .font(.caption)
//                    } else {
//                        ForEach(userLostItems, id: \.id) { item in
//                            VStack(alignment: .leading) {
//                                Text(item.title ?? "No Title")
//                                    .font(.headline)
//                                Text(item.location ?? "")
//                                    .font(.subheadline)
//                            }
//                            .onTapGesture {
//                                editingLost = item
//                            }
//                        }
//                        .onDelete { indexSet in
//                            indexSet.map { userLostItems[$0] }.forEach(viewContext.delete)
//                            try? viewContext.save()
//                        }
//                    }
//                }
//
//                Section(header: Text("Your Found Items")) {
//                    let userFoundItems = foundItems.filter { $0.ownerEmail == currentUserEmail }
//
//                    if userFoundItems.isEmpty {
//                        Text("You haven’t reported any found items yet.")
//                            .foregroundColor(.gray)
//                            .font(.caption)
//                    } else {
//                        ForEach(userFoundItems, id: \.id) { item in
//                            VStack(alignment: .leading) {
//                                Text(item.title ?? "No Title")
//                                    .font(.headline)
//                                Text(item.location ?? "")
//                                    .font(.subheadline)
//                            }
//                            .onTapGesture {
//                                editingFound = item
//                            }
//                        }
//                        .onDelete { indexSet in
//                            indexSet.map { userFoundItems[$0] }.forEach(viewContext.delete)
//                            try? viewContext.save()
//                        }
//                    }
//                }
//            }
//            .navigationTitle("My Reports")
//            .sheet(item: $editingLost) { EditLostItemView(item: $0) }
//            .sheet(item: $editingFound) { EditFoundItemView(item: $0) }
//        }
//    }
//}


//import SwiftUI
//
//struct ProfileView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @FetchRequest(entity: LostItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)])
//    var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(entity: FoundItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)])
//    var foundItems: FetchedResults<FoundItem>
//
//    @FetchRequest(entity: UserProfile.entity(), sortDescriptors: [])
//    var users: FetchedResults<UserProfile>
//
//    @State private var editingLost: LostItem?
//    @State private var editingFound: FoundItem?
//    @State private var showEditProfile = false
//    @State private var newName: String = ""
//    @State private var newPassword: String = ""
//
//    var currentUser: UserProfile? {
//        users.first(where: { $0.email == currentUserEmail })
//    }
//
//    var body: some View {
//        NavigationView {
//            List {
//                Section(header: Text("Settings")) {
//                    if let user = currentUser {
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Email: \(user.email ?? "")")
//                                .font(.subheadline)
//
//                            Button("Edit Name & Password") {
//                                newName = user.name ?? ""
//                                newPassword = user.password ?? ""
//                                showEditProfile = true
//                            }
//
//                            Button("Logout") {
//                                currentUserEmail = ""
//                            }
//                            .foregroundColor(.red)
//                        }
//                    }
//                }
//
//                Section(header: Text("Your Lost Items")) {
//                    let userLostItems = lostItems.filter { $0.ownerEmail == currentUserEmail }
//                    if userLostItems.isEmpty {
//                        Text("You haven’t reported any lost items yet.")
//                            .foregroundColor(.gray)
//                            .font(.caption)
//                    } else {
//                        ForEach(userLostItems, id: \.id) { item in
//                            VStack(alignment: .leading) {
//                                Text(item.title ?? "No Title")
//                                    .font(.headline)
//                                Text(item.location ?? "")
//                                    .font(.subheadline)
//                            }
//                            .onTapGesture {
//                                editingLost = item
//                            }
//                        }
//                        .onDelete { indexSet in
//                            indexSet.map { userLostItems[$0] }.forEach(viewContext.delete)
//                            try? viewContext.save()
//                        }
//                    }
//                }
//
//                Section(header: Text("Your Found Items")) {
//                    let userFoundItems = foundItems.filter { $0.ownerEmail == currentUserEmail }
//                    if userFoundItems.isEmpty {
//                        Text("You haven’t reported any found items yet.")
//                            .foregroundColor(.gray)
//                            .font(.caption)
//                    } else {
//                        ForEach(userFoundItems, id: \.id) { item in
//                            VStack(alignment: .leading) {
//                                Text(item.title ?? "No Title")
//                                    .font(.headline)
//                                Text(item.location ?? "")
//                                    .font(.subheadline)
//                            }
//                            .onTapGesture {
//                                editingFound = item
//                            }
//                        }
//                        .onDelete { indexSet in
//                            indexSet.map { userFoundItems[$0] }.forEach(viewContext.delete)
//                            try? viewContext.save()
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Profile & Settings")
//            .sheet(item: $editingLost) { EditLostItemView(item: $0) }
//            .sheet(item: $editingFound) { EditFoundItemView(item: $0) }
//            .sheet(isPresented: $showEditProfile) {
//                NavigationView {
//                    Form {
//                        Section(header: Text("Update Account")) {
//                            TextField("Full Name", text: $newName)
//                            SecureField("New Password", text: $newPassword)
//                        }
//                        Button("Save Changes") {
//                            if let user = currentUser {
//                                user.name = newName
//                                user.password = newPassword
//                                try? viewContext.save()
//                                showEditProfile = false
//                            }
//                        }
//                    }
//                    .navigationTitle("Edit Profile")
//                    .toolbar {
//                        ToolbarItem(placement: .cancellationAction) {
//                            Button("Cancel") { showEditProfile = false }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}

//import CoreData
//import SwiftUI
//
//struct ProfileView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//    @AppStorage("appTheme") private var appTheme: String = "system"
//
//    @FetchRequest(entity: LostItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)])
//    var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(entity: FoundItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)])
//    var foundItems: FetchedResults<FoundItem>
//
//    @FetchRequest(entity: UserProfile.entity(), sortDescriptors: [])
//    var users: FetchedResults<UserProfile>
//
//    @State private var editingLost: LostItem?
//    @State private var editingFound: FoundItem?
//    @State private var showEditProfile = false
//    @State private var showThemeSettings = false
//    @State private var selectedImage: UIImage?
//    @State private var showImagePicker = false
//
//    var currentUser: UserProfile? {
//        users.first(where: { $0.email == currentUserEmail })
//    }
//
//    var body: some View {
//        NavigationStack {
//            List {
//                if let user = currentUser {
//                    Section {
//                        HStack {
//                            Spacer()
//                            Button(action: { showImagePicker = true }) {
//                                if let data = user.imageData, let image = UIImage(data: data) {
//                                    Image(uiImage: image)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 100, height: 100)
//                                        .clipShape(Circle())
//                                        .shadow(radius: 4)
//                                } else {
//                                    Image(systemName: "person.crop.circle.fill")
//                                        .resizable()
//                                        .frame(width: 100, height: 100)
//                                        .foregroundColor(.gray)
//                                }
//                            }
//                            Spacer()
//                        }
//                    }
//                }
//
//                Section(header: Text("App Settings")) {
//                    NavigationLink(destination: AccountInfoView(user: currentUser, viewContext: viewContext)) {
//                        Label("Account Info", systemImage: "person.crop.circle")
//                    }
//                    NavigationLink(destination: ThemeSettingsView()) {
//                        Label("Appearance", systemImage: "paintbrush")
//                    }
//                    Button(role: .destructive) {
//                        currentUserEmail = ""
//                    } label: {
//                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
//                    }
//                }
//
//                Section(header: Text("Your Lost Items")) {
//                    let userLostItems = lostItems.filter { $0.ownerEmail == currentUserEmail }
//                    if userLostItems.isEmpty {
//                        Text("You haven’t reported any lost items yet.")
//                            .foregroundColor(.gray)
//                            .font(.caption)
//                    } else {
//                        ForEach(userLostItems, id: \.id) { item in
//                            VStack(alignment: .leading) {
//                                Text(item.title ?? "No Title")
//                                    .font(.headline)
//                                Text(item.location ?? "")
//                                    .font(.subheadline)
//                            }
//                            .onTapGesture {
//                                editingLost = item
//                            }
//                        }
//                        .onDelete { indexSet in
//                            indexSet.map { userLostItems[$0] }.forEach(viewContext.delete)
//                            try? viewContext.save()
//                        }
//                    }
//                }
//
//                Section(header: Text("Your Found Items")) {
//                    let userFoundItems = foundItems.filter { $0.ownerEmail == currentUserEmail }
//                    if userFoundItems.isEmpty {
//                        Text("You haven’t reported any found items yet.")
//                            .foregroundColor(.gray)
//                            .font(.caption)
//                    } else {
//                        ForEach(userFoundItems, id: \.id) { item in
//                            VStack(alignment: .leading) {
//                                Text(item.title ?? "No Title")
//                                    .font(.headline)
//                                Text(item.location ?? "")
//                                    .font(.subheadline)
//                            }
//                            .onTapGesture {
//                                editingFound = item
//                            }
//                        }
//                        .onDelete { indexSet in
//                            indexSet.map { userFoundItems[$0] }.forEach(viewContext.delete)
//                            try? viewContext.save()
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Profile & Settings")
//            .sheet(item: $editingLost) { EditLostItemView(item: $0) }
//            .sheet(item: $editingFound) { EditFoundItemView(item: $0) }
//            .sheet(isPresented: $showImagePicker) {
//                ImagePicker(image: Binding(
//                    get: { selectedImage },
//                    set: { newImage in
//                        selectedImage = newImage
//                        if let data = newImage?.jpegData(compressionQuality: 0.8) {
//                            currentUser?.imageData = data
//                            try? viewContext.save()
//                        }
//                    }
//                ))
//            }
//        }
//    }
//}
//
//// MARK: - Dedicated Pages
//
//struct AccountInfoView: View {
//    var user: UserProfile?
//    let viewContext: NSManagedObjectContext
//    @State private var newName: String = ""
//    @State private var newPassword: String = ""
//    @Environment(\.dismiss) private var dismiss
//
//    var body: some View {
//        Form {
//            Section(header: Text("Account Info")) {
//                TextField("Full Name", text: Binding(
//                    get: { newName.isEmpty ? (user?.name ?? "") : newName },
//                    set: { newName = $0 }
//                ))
//                SecureField("New Password", text: $newPassword)
//            }
//            Button("Save Changes") {
//                if let user = user {
//                    user.name = newName
//                    if !newPassword.isEmpty {
//                        user.password = newPassword
//                    }
//                    try? viewContext.save()
//                    dismiss()
//                }
//            }
//        }
//        .navigationTitle("Edit Account")
//    }
//}
//
//struct ThemeSettingsView: View {
//    @AppStorage("appTheme") private var appTheme: String = "system"
//
//    var body: some View {
//        Form {
//            Section(header: Text("Theme")) {
//                Picker("Appearance", selection: $appTheme) {
//                    Text("System Default").tag("system")
//                    Text("Light Mode").tag("light")
//                    Text("Dark Mode").tag("dark")
//                }
//                .pickerStyle(.segmented)
//
//                Text("Current preview:")
//                    .font(.caption)
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(appTheme == "dark" ? Color.black : appTheme == "light" ? Color.white : Color(UIColor.systemBackground))
//                    .frame(height: 50)
//                    .overlay(Text(appTheme.capitalized).foregroundColor(appTheme == "dark" ? .white : .black))
//                    .padding(.vertical, 8)
//            }
//        }
//        .navigationTitle("Appearance")
//    }
//}



//
//import SwiftUI
//import CoreData
//
//struct ProfileView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//    @AppStorage("appTheme") private var appTheme: String = "system"
//
//    @FetchRequest(entity: LostItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)])
//    var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(entity: FoundItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)])
//    var foundItems: FetchedResults<FoundItem>
//
//    @FetchRequest(entity: UserProfile.entity(), sortDescriptors: [])
//    var users: FetchedResults<UserProfile>
//
//    @State private var editingLost: LostItem?
//    @State private var editingFound: FoundItem?
//    @State private var showEditProfile = false
//    @State private var showThemeSettings = false
//    @State private var selectedImage: UIImage?
//    @State private var showImagePicker = false
//
//    var currentUser: UserProfile? {
//        users.first(where: { $0.email == currentUserEmail })
//    }
//
//    var body: some View {
//        NavigationStack {
//            List {
//                if let user = currentUser {
//                    Section {
//                        HStack {
//                            Spacer()
//                            Button(action: { showImagePicker = true }) {
//                                if let data = user.imageData, let image = UIImage(data: data) {
//                                    Image(uiImage: image)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 100, height: 100)
//                                        .clipShape(Circle())
//                                        .shadow(radius: 4)
//                                } else {
//                                    Image(systemName: "person.crop.circle.fill")
//                                        .resizable()
//                                        .frame(width: 100, height: 100)
//                                        .foregroundColor(.gray)
//                                }
//                            }
//                            Spacer()
//                        }
//                    }
//                }
//
//                Section(header: Text("App Settings")) {
//                    NavigationLink(destination: AccountInfoView(user: currentUser, viewContext: viewContext, onDelete: {
//                        currentUserEmail = ""
//                    })) {
//                        Label("Account Info", systemImage: "person.crop.circle")
//                    }
//                    NavigationLink(destination: ThemeSettingsView()) {
//                        Label("Appearance", systemImage: "paintbrush")
//                    }
//                    Button(role: .destructive) {
//                        currentUserEmail = ""
//                    } label: {
//                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
//                    }
//                }
//
//                Section(header: Text("Your Lost Items")) {
//                    let userLostItems = lostItems.filter { $0.ownerEmail == currentUserEmail }
//                    if userLostItems.isEmpty {
//                        Text("You haven’t reported any lost items yet.")
//                            .foregroundColor(.gray)
//                            .font(.caption)
//                    } else {
//                        ForEach(userLostItems, id: \.id) { item in
//                            VStack(alignment: .leading) {
//                                Text(item.title ?? "No Title")
//                                    .font(.headline)
//                                Text(item.location ?? "")
//                                    .font(.subheadline)
//                            }
//                            .onTapGesture {
//                                editingLost = item
//                            }
//                        }
//                        .onDelete { indexSet in
//                            indexSet.map { userLostItems[$0] }.forEach(viewContext.delete)
//                            try? viewContext.save()
//                        }
//                    }
//                }
//
//                Section(header: Text("Your Found Items")) {
//                    let userFoundItems = foundItems.filter { $0.ownerEmail == currentUserEmail }
//                    if userFoundItems.isEmpty {
//                        Text("You haven’t reported any found items yet.")
//                            .foregroundColor(.gray)
//                            .font(.caption)
//                    } else {
//                        ForEach(userFoundItems, id: \.id) { item in
//                            VStack(alignment: .leading) {
//                                Text(item.title ?? "No Title")
//                                    .font(.headline)
//                                Text(item.location ?? "")
//                                    .font(.subheadline)
//                            }
//                            .onTapGesture {
//                                editingFound = item
//                            }
//                        }
//                        .onDelete { indexSet in
//                            indexSet.map { userFoundItems[$0] }.forEach(viewContext.delete)
//                            try? viewContext.save()
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Profile & Settings")
//            .sheet(item: $editingLost) { EditLostItemView(item: $0) }
//            .sheet(item: $editingFound) { EditFoundItemView(item: $0) }
//            .sheet(isPresented: $showImagePicker) {
//                ImagePicker(image: Binding(
//                    get: { selectedImage },
//                    set: { newImage in
//                        selectedImage = newImage
//                        if let data = newImage?.jpegData(compressionQuality: 0.8) {
//                            currentUser?.imageData = data
//                            try? viewContext.save()
//                        }
//                    }
//                ))
//            }
//        }
//    }
//}
//
//// MARK: - Account Info View
//
//struct AccountInfoView: View {
//    var user: UserProfile?
//    let viewContext: NSManagedObjectContext
//    var onDelete: () -> Void
//    @Environment(\.dismiss) private var dismiss
//
//    @State private var name: String = ""
//    @State private var email: String = ""
//    @State private var newPassword: String = ""
//    @State private var confirmPassword: String = ""
//    @State private var showPassword = false
//    @State private var showConfirmPassword = false
//    @State private var errorMessage: String = ""
//    @State private var showSuccessAlert = false
//    @State private var showDeleteConfirmation = false
//
//    var body: some View {
//        Form {
//            Section(header: Text("Personal Info")) {
//                TextField("Full Name", text: $name)
//                TextField("Email", text: $email)
//                    .keyboardType(.emailAddress)
//                    .autocapitalization(.none)
//                    .onChange(of: email) { _ in validateFields() }
//            }
//
//            Section(header: Text("Reset Password")) {
//                HStack {
//                    if showPassword {
//                        TextField("New Password", text: $newPassword)
//                    } else {
//                        SecureField("New Password", text: $newPassword)
//                    }
//                    Button(action: { showPassword.toggle() }) {
//                        Image(systemName: showPassword ? "eye.slash" : "eye")
//                    }
//                }
//                HStack {
//                    if showConfirmPassword {
//                        TextField("Confirm Password", text: $confirmPassword)
//                    } else {
//                        SecureField("Confirm Password", text: $confirmPassword)
//                    }
//                    Button(action: { showConfirmPassword.toggle() }) {
//                        Image(systemName: showConfirmPassword ? "eye.slash" : "eye")
//                    }
//                }
//                if !errorMessage.isEmpty {
//                    Text(errorMessage).foregroundColor(.red)
//                }
//            }
//
//            Section {
//                Button("Save Changes") {
//                    guard isValidEmail(email) else {
//                        errorMessage = "Invalid email format."
//                        return
//                    }
//                    guard newPassword == confirmPassword else {
//                        errorMessage = "Passwords do not match."
//                        return
//                    }
//                    if !newPassword.isEmpty && newPassword.count < 6 {
//                        errorMessage = "Password must be at least 6 characters."
//                        return
//                    }
//                    if let user = user {
//                        user.name = name
//                        user.email = email
//                        if !newPassword.isEmpty {
//                            user.password = newPassword
//                        }
//                        try? viewContext.save()
//                        showSuccessAlert = true
//                        errorMessage = ""
//                    }
//                }
//            }
//
//            Section(footer: Text("Deleting your account will remove all your data.")) {
//                Button("Delete Account", role: .destructive) {
//                    showDeleteConfirmation = true
//                }
//            }
//        }
//        .navigationTitle("Account Info")
//        .onAppear {
//            name = user?.name ?? ""
//            email = user?.email ?? ""
//        }
//        .alert("Profile Updated", isPresented: $showSuccessAlert) {
//            Button("OK") { dismiss() }
//        }
//        .confirmationDialog("Are you sure you want to delete your account?", isPresented: $showDeleteConfirmation, titleVisibility: .visible) {
//            Button("Delete Account", role: .destructive) {
//                if let user = user {
//                    viewContext.delete(user)
//                    try? viewContext.save()
//                    onDelete()
//                    dismiss()
//                }
//            }
//            Button("Cancel", role: .cancel) {}
//        }
//    }
//
//    private func validateFields() {
//        if !isValidEmail(email) {
//            errorMessage = "Invalid email format."
//        } else {
//            errorMessage = ""
//        }
//    }
//
//    private func isValidEmail(_ email: String) -> Bool {
//        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
//        return emailPredicate.evaluate(with: email)
//    }
//}
//
//struct ThemeSettingsView: View {
//    @AppStorage("appTheme") private var appTheme: String = "system"
//
//    var body: some View {
//        Form {
//            Section(header: Text("Theme")) {
//                Picker("Appearance", selection: $appTheme) {
//                    Text("System Default").tag("system")
//                    Text("Light Mode").tag("light")
//                    Text("Dark Mode").tag("dark")
//                }
//                .pickerStyle(.segmented)
//
//                Text("Current preview:")
//                    .font(.caption)
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(appTheme == "dark" ? Color.black : appTheme == "light" ? Color.white : Color(UIColor.systemBackground))
//                    .frame(height: 50)
//                    .overlay(Text(appTheme.capitalized).foregroundColor(appTheme == "dark" ? .white : .black))
//                    .padding(.vertical, 8)
//            }
//        }
//        .navigationTitle("Appearance")
//    }
//}

import SwiftUI
import CoreData

// MARK: - Northeastern Theme Colors
extension Color {
    /// Dynamic background: white in light mode, black in dark mode
    static var neuBackground: Color { Color(UIColor { traits in
        traits.userInterfaceStyle == .dark ? .black : .white
    }) }

}

import SwiftUI
import CoreData

struct ProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
    @AppStorage("appTheme") private var appTheme: String = "system"

    @FetchRequest(entity: LostItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)])
    var lostItems: FetchedResults<LostItem>

    @FetchRequest(entity: FoundItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)])
    var foundItems: FetchedResults<FoundItem>

    @FetchRequest(entity: UserProfile.entity(), sortDescriptors: [])
    var users: FetchedResults<UserProfile>

    @State private var editingLost: LostItem?
    @State private var editingFound: FoundItem?
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?

    var currentUser: UserProfile? {
        users.first(where: { $0.email == currentUserEmail })
    }

    var body: some View {
        NavigationStack {
            List {
                if let user = currentUser {
                    Section {
                        HStack {
                            Spacer()
                            Button { showImagePicker = true } label: {
                                if let data = user.imageData, let image = UIImage(data: data) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .shadow(radius: 4)
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.gray)
                                }
                            }
                            Spacer()
                        }
                        .listRowBackground(Color.neuBackground)
                    }
                }

                Section(header: Text("App Settings").foregroundColor(.neuRed)) {
                    NavigationLink(destination: AccountInfoView(user: currentUser, viewContext: viewContext, onDelete: { currentUserEmail = "" })) {
                        Label("Account Info", systemImage: "person.crop.circle")
                    }
                    NavigationLink(destination: ThemeSettingsView()) {
                        Label("Appearance", systemImage: "paintbrush")
                    }
                    Button(role: .destructive) {
                        currentUserEmail = ""
                    } label: {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                }
                .listRowBackground(Color.neuBackground)

                Section(header: Text("Your Lost Items").foregroundColor(.neuRed)) {
                    let userLost = lostItems.filter { $0.ownerEmail == currentUserEmail }
                    if userLost.isEmpty {
                        Text("No lost items yet.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(userLost, id: \ .id) { item in
                            VStack(alignment: .leading) {
                                Text(item.title ?? "No Title").font(.headline)
                                Text(item.location ?? "").font(.subheadline)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture { editingLost = item }
                        }
                        .onDelete { offsets in
                            offsets.map { userLost[$0] }.forEach(viewContext.delete)
                            try? viewContext.save()
                        }
                    }
                }
                .listRowBackground(Color.neuBackground)

                Section(header: Text("Your Found Items").foregroundColor(.neuRed)) {
                    let userFound = foundItems.filter { $0.finderEmail == currentUserEmail }
                    if userFound.isEmpty {
                        Text("No found items yet.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(userFound, id: \ .id) { item in
                            VStack(alignment: .leading) {
                                Text(item.title ?? "No Title").font(.headline)
                                Text(item.location ?? "").font(.subheadline)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture { editingFound = item }
                        }
                        .onDelete { offsets in
                            offsets.map { userFound[$0] }.forEach(viewContext.delete)
                            try? viewContext.save()
                        }
                    }
                }
                .listRowBackground(Color.neuBackground)
            }
            .listStyle(InsetGroupedListStyle())
            .scrollContentBackground(.hidden)
            .background(Color.neuBackground)
            .foregroundColor(Color.neuText)
            .navigationTitle("Profile & Settings")
            .neuBranded()
            .sheet(item: $editingLost) { EditLostItemView(item: $0) }
            .sheet(item: $editingFound) { EditFoundItemView(item: $0) }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: Binding(
                    get: { selectedImage },
                    set: { newImage in
                        selectedImage = newImage
                        if let data = newImage?.jpegData(compressionQuality: 0.8) {
                            currentUser?.imageData = data
                            try? viewContext.save()
                        }
                    }
                ))
            }
        }
        .accentColor(.neuRed)
    }
}

// MARK: - Account Info View
struct AccountInfoView: View {
    var user: UserProfile?
    let viewContext: NSManagedObjectContext
    var onDelete: () -> Void
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var email = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var errorMessage = ""
    @State private var showSuccessAlert = false
    @State private var showDeleteConfirmation = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Personal Info") {
                    TextField("Full Name", text: $name)
                        .foregroundColor(.neuText)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundColor(.neuText)
                }
                Section("Reset Password") {
                    HStack {
                        if showPassword {
                            TextField("New Password", text: $newPassword)
                        } else {
                            SecureField("New Password", text: $newPassword)
                        }
                        Button { showPassword.toggle() } label: {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundColor(.neuRed)
                        }
                    }
                    HStack {
                        if showConfirmPassword {
                            TextField("Confirm Password", text: $confirmPassword)
                        } else {
                            SecureField("Confirm Password", text: $confirmPassword)
                        }
                        Button { showConfirmPassword.toggle() } label: {
                            Image(systemName: showConfirmPassword ? "eye.slash" : "eye")
                                .foregroundColor(.neuRed)
                        }
                    }
                    if !errorMessage.isEmpty {
                        Text(errorMessage).foregroundColor(.red)
                    }
                }
                Section {
                    Button("Save Changes") {
                        // validation and save
                    }
                    .tint(.neuRed)
                }
                Section(footer: Text("Deleting your account will remove all your data.")) {
                    Button("Delete Account", role: .destructive) {
                        showDeleteConfirmation = true
                    }
                }
            }
            .tint(.neuRed)
            .scrollContentBackground(.hidden)
            .background(Color.neuBackground)
            .navigationTitle("Account Info")
            .onAppear {
                name = user?.name ?? ""
                email = user?.email ?? ""
            }
            .alert("Profile Updated", isPresented: $showSuccessAlert) {
                Button("OK") { dismiss() }
            }
            .confirmationDialog("Are you sure you want to delete your account?", isPresented: $showDeleteConfirmation) {
                Button("Delete Account", role: .destructive) {
                    if let u = user {
                        viewContext.delete(u)
                        try? viewContext.save()
                        onDelete()
                        dismiss()
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
        .accentColor(.neuRed)
    }
}

// MARK: - Theme Settings View
struct ThemeSettingsView: View {
    @AppStorage("appTheme") private var appTheme: String = "system"

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Theme")) {
                    Picker("Appearance", selection: $appTheme) {
                        Text("System Default").tag("system")
                        Text("Light Mode").tag("light")
                        Text("Dark Mode").tag("dark")
                    }
                    .pickerStyle(.segmented)

                    Text("Preview background")
                        .foregroundColor(.neuText)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            Color(UIColor { traits in
                                switch appTheme {
                                case "light": return .white
                                case "dark": return .black
                                default: return traits.userInterfaceStyle == .dark ? .black : .white
                                }
                            })
                        )
                        .frame(height: 50)
                        .overlay(
                            Text(appTheme.capitalized)
                                .foregroundColor(appTheme == "dark" ? .white : .black)
                        )
                }
            }
            .tint(.neuRed)
            .scrollContentBackground(.hidden)
            .background(Color.neuBackground)
            .navigationTitle("Appearance")
        }
        .accentColor(.neuRed)
    }
}
