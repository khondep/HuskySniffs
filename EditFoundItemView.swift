//
//  EditFoundItemView.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

struct EditFoundItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @ObservedObject var item: FoundItem

    @State private var title: String = ""
    @State private var desc: String = ""
    @State private var location: String = ""

    #if canImport(UIKit)
    @State private var image: UIImage?
    @State private var showingPicker = false
    #endif

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Update Found Info")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $desc)
                    TextField("Location", text: $location)
                }

                #if canImport(UIKit)
                Section(header: Text("Image")) {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }

                    Button("Choose New Image") {
                        showingPicker = true
                    }
                }
                #endif
            }
            .navigationTitle("Edit Found Item")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        updateItem()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            #if canImport(UIKit)
            .sheet(isPresented: $showingPicker) {
                ImagePicker(image: $image)
            }
            #endif
            .onAppear {
                title = item.title ?? ""
                desc = item.desc ?? ""
                location = item.location ?? ""
                #if canImport(UIKit)
                if let data = item.imageData {
                    image = UIImage(data: data)
                }
                #endif
            }
        }
    }

    private func updateItem() {
        item.title = title
        item.desc = desc
        item.location = location
        item.date = Date()

        #if canImport(UIKit)
        if let image = image {
            item.imageData = image.jpegData(compressionQuality: 0.8)
        }
        #endif

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Update failed: \(error)")
        }
    }
}
