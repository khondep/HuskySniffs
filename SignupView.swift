//
//  SignupView.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//

//
//import SwiftUI
//import CoreData
//
//struct SignupView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @Environment(\.dismiss) private var dismiss
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @State private var name: String = ""
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var profileImage: UIImage?
//    @State private var showingImagePicker = false
//    @State private var errorMessage: String?
//    @State private var isRegistered = false
//    @State private var staySignedIn = true
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Profile Photo")) {
//                    HStack {
//                        Spacer()
//                        Button(action: { showingImagePicker = true }) {
//                            if let profileImage = profileImage {
//                                Image(uiImage: profileImage)
//                                    .resizable()
//                                    .scaledToFill()
//                                    .frame(width: 100, height: 100)
//                                    .clipShape(Circle())
//                            } else {
//                                Image(systemName: "person.crop.circle.badge.plus")
//                                    .resizable()
//                                    .frame(width: 100, height: 100)
//                                    .foregroundColor(.gray)
//                            }
//                        }
//                        Spacer()
//                    }
//                }
//
//                Section(header: Text("Details")) {
//                    TextField("Full Name", text: $name)
//                    TextField("Email (@northeastern.edu)", text: $email)
//                        .keyboardType(.emailAddress)
//                        .autocapitalization(.none)
//                    SecureField("Password", text: $password)
//                    Toggle("Stay signed in", isOn: $staySignedIn)
//                }
//
//                if let errorMessage = errorMessage {
//                    Text(errorMessage)
//                        .foregroundColor(.red)
//                }
//
//                Button("Create Account") {
//                    registerUser()
//                }
//                .disabled(name.isEmpty || email.isEmpty || password.isEmpty || !email.hasSuffix("@northeastern.edu"))
//            }
//            .navigationTitle("Sign Up")
//            .sheet(isPresented: $showingImagePicker) {
//                ImagePicker(image: $profileImage)
//            }
//            .alert("Account Created", isPresented: $isRegistered) {
//                Button("OK") { dismiss() }
//            } message: {
//                Text("You can now log in with your credentials.")
//            }
//        }
//    }
//
//    private func registerUser() {
//        let newUser = UserProfile(context: viewContext)
//        newUser.id = UUID()
//        newUser.name = name
//        newUser.email = email
//        newUser.password = password
//
//        if let img = profileImage {
//            newUser.imageData = img.jpegData(compressionQuality: 0.8)
//        }
//
//        do {
//            try viewContext.save()
//            if staySignedIn {
//                currentUserEmail = email
//            }
//            isRegistered = true
//        } catch {
//            errorMessage = "Failed to save user: \(error.localizedDescription)"
//        }
//    }
//}
//
//struct LoginView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var loginFailed = false
//    @State private var staySignedIn = true
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Email")) {
//                    TextField("Email", text: $email)
//                        .keyboardType(.emailAddress)
//                        .autocapitalization(.none)
//                }
//                Section(header: Text("Password")) {
//                    SecureField("Password", text: $password)
//                }
//                Toggle("Stay signed in", isOn: $staySignedIn)
//
//                Button("Login") {
//                    authenticateUser()
//                }
//
//                if loginFailed {
//                    Text("Invalid credentials. Please try again.")
//                        .foregroundColor(.red)
//                }
//            }
//            .navigationTitle("Login")
//        }
//    }
//
//    private func authenticateUser() {
//        let request: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
//        request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
//
//        do {
//            let result = try viewContext.fetch(request)
//            if let user = result.first {
//                if staySignedIn {
//                    currentUserEmail = user.email ?? ""
//                }
//            } else {
//                loginFailed = true
//            }
//        } catch {
//            loginFailed = true
//        }
//    }
//}
//
//struct UserProfileView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @FetchRequest(
//        entity: UserProfile.entity(),
//        sortDescriptors: []
//    ) var users: FetchedResults<UserProfile>
//
//    var currentUser: UserProfile? {
//        users.first(where: { $0.email == currentUserEmail })
//    }
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                if let user = currentUser {
//                    if let imageData = user.imageData, let img = UIImage(data: imageData) {
//                        Image(uiImage: img)
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 120, height: 120)
//                            .clipShape(Circle())
//                    } else {
//                        Image(systemName: "person.circle")
//                            .resizable()
//                            .frame(width: 120, height: 120)
//                            .foregroundColor(.gray)
//                    }
//
//                    Text(user.name ?? "Unknown")
//                        .font(.title2)
//                    Text(user.email ?? "")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                } else {
//                    Text("No user logged in.")
//                        .foregroundColor(.gray)
//                }
//            }
//            .navigationTitle("My Profile")
//            .padding()
//        }
//    }
//}

import SwiftUI
import CoreData

struct SignupView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var profileImage: UIImage?
    @State private var showingImagePicker = false
    @State private var errorMessage: String?
    @State private var isRegistered = false
    @State private var staySignedIn = true

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Photo")) {
                    HStack {
                        Spacer()
                        Button(action: { showingImagePicker = true }) {
                            if let profileImage = profileImage {
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.crop.circle.badge.plus")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                }

                Section(header: Text("Details")) {
                    TextField("Full Name", text: $name)
                    TextField("Email (@northeastern.edu)", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                    Toggle("Stay signed in", isOn: $staySignedIn)
                }

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }

                Button("Create Account") {
                    registerUser()
                }
                .disabled(name.isEmpty || email.isEmpty || password.isEmpty || !email.hasSuffix("@northeastern.edu"))
                .foregroundColor(.white)
                .padding()
                .background(Color(red: 0.8, green: 0, blue: 0))
                .cornerRadius(8)
            }
            .navigationTitle("Sign Up")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $profileImage)
            }
            .alert("Account Created", isPresented: $isRegistered) {
                Button("OK") { dismiss() }
            } message: {
                Text("You can now log in with your credentials.")
            }
        }
    }

    private func registerUser() {
        let newUser = UserProfile(context: viewContext)
        newUser.id = UUID()
        newUser.name = name
        newUser.email = email
        newUser.password = password

        if let img = profileImage {
            newUser.imageData = img.jpegData(compressionQuality: 0.8)
        }

        do {
            try viewContext.save()
            if staySignedIn {
                currentUserEmail = email
            }
            isRegistered = true
        } catch {
            errorMessage = "Failed to save user: \(error.localizedDescription)"
        }
    }
}

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginFailed = false
    @State private var staySignedIn = true

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Email")) {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                Section(header: Text("Password")) {
                    SecureField("Password", text: $password)
                }
                Toggle("Stay signed in", isOn: $staySignedIn)

                Button("Login") {
                    authenticateUser()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color(red: 0.8, green: 0, blue: 0))
                .cornerRadius(8)

                if loginFailed {
                    Text("Invalid credentials. Please try again.")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Login")
        }
    }

    private func authenticateUser() {
        let request: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)

        do {
            let result = try viewContext.fetch(request)
            if let user = result.first {
                if staySignedIn {
                    currentUserEmail = user.email ?? ""
                }
            } else {
                loginFailed = true
            }
        } catch {
            loginFailed = true
        }
    }
}

struct UserProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""

    @FetchRequest(
        entity: UserProfile.entity(),
        sortDescriptors: []
    ) var users: FetchedResults<UserProfile>

    var currentUser: UserProfile? {
        users.first(where: { $0.email == currentUserEmail })
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let user = currentUser {
                    if let imageData = user.imageData, let img = UIImage(data: imageData) {
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.gray)
                    }

                    Text(user.name ?? "Unknown")
                        .font(.title2)
                    Text(user.email ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } else {
                    Text("No user logged in.")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("My Profile")
            .padding()
        }
    }
}

