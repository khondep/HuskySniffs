//
//  ReportFoundView.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//

//import SwiftUI
//
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct ReportFoundView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @State private var title = ""
//    @State private var desc = ""
//    @State private var location = ""
//    @State private var image: UIImage?
//    @State private var showingPicker = false
//    @State private var showSuccessAlert = false
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Item Details")) {
//                    TextField("Title", text: $title)
//                    TextField("Description", text: $desc)
//                    TextField("Location Found", text: $location)
//                }
//
//                Section(header: Text("Image")) {
//                    if let image = image {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 150)
//                    }
//
//                    Button("Choose Image") {
//                        showingPicker = true
//                    }
//                }
//
//                Button(action: addFoundItem) {
//                    Label("Submit Found Report", systemImage: "plus")
//                }
//                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty || image == nil)
//            }
//            .navigationTitle("Report Found Item")
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            .alert(isPresented: $showSuccessAlert) {
//                Alert(
//                    title: Text("Success"),
//                    message: Text("Found item report saved."),
//                    dismissButton: .default(Text("OK"), action: clearForm)
//                )
//            }
//        }
//    }
//
//    private func addFoundItem() {
//        let newItem = FoundItem(context: viewContext)
//        newItem.id = UUID()
//        newItem.title = title
//        newItem.desc = desc
//        newItem.location = location
//        newItem.date = Date()
//        if let img = image {
//            newItem.imageData = img.jpegData(compressionQuality: 0.8)
//        }
//
//        do {
//            try viewContext.save()
//            showSuccessAlert = true
//        } catch {
//            print("Failed to save found item: \(error)")
//        }
//    }
//
//    private func clearForm() {
//        title = ""
//        desc = ""
//        location = ""
//        image = nil
//    }
//}
//


//import SwiftUI
//
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct ReportFoundView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @State private var title = ""
//    @State private var desc = ""
//    @State private var location = ""
//    
//    #if canImport(UIKit)
//    @State private var image: UIImage?
//    @State private var showingPicker = false
//    #endif
//
//    @State private var showSuccessAlert = false
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Item Details")) {
//                    TextField("Title", text: $title)
//                    TextField("Description", text: $desc)
//                    TextField("Location Found", text: $location)
//                }
//
//                #if canImport(UIKit)
//                Section(header: Text("Image")) {
//                    if let image = image {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 150)
//                    }
//
//                    Button("Choose Image") {
//                        showingPicker = true
//                    }
//                }
//                #endif
//
//                Button(action: addFoundItem) {
//                    Label("Submit Found Report", systemImage: "plus")
//                }
//                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
//            }
//            .navigationTitle("Report Found Item")
//            #if canImport(UIKit)
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            #endif
//            .alert(isPresented: $showSuccessAlert) {
//                Alert(
//                    title: Text("Success"),
//                    message: Text("Found item report saved."),
//                    dismissButton: .default(Text("OK"), action: clearForm)
//                )
//            }
//        }
//    }
//
//    private func addFoundItem() {
//        let newItem = FoundItem(context: viewContext)
//        newItem.id = UUID()
//        newItem.title = title
//        newItem.desc = desc
//        newItem.location = location
//        newItem.date = Date()
//
//        #if canImport(UIKit)
//        if let img = image {
//            newItem.imageData = img.jpegData(compressionQuality: 0.8)
//        }
//        #endif
//
//        do {
//            try viewContext.save()
//            showSuccessAlert = true
//        } catch {
//            print("Failed to save found item: \(error)")
//        }
//    }
//
//    private func clearForm() {
//        title = ""
//        desc = ""
//        location = ""
//        #if canImport(UIKit)
//        image = nil
//        #endif
//    }
//}



//import SwiftUI
//
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct ReportFoundView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//    
//
//    @State private var title = ""
//    @State private var desc = ""
//    @State private var location = ""
//
//    #if canImport(UIKit)
//    @State private var image: UIImage?
//    @State private var showingPicker = false
//    #endif
//
//    @State private var showSuccessAlert = false
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Item Details")) {
//                    TextField("Title", text: $title)
//                    TextField("Description", text: $desc)
//                    TextField("Location Found", text: $location)
//                }
//
//                #if canImport(UIKit)
//                Section(header: Text("Image")) {
//                    if let image = image {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 150)
//                    }
//
//                    Button("Choose Image") {
//                        showingPicker = true
//                    }
//                }
//                #endif
//
//                Button(action: addFoundItem) {
//                    Label("Submit Found Report", systemImage: "plus")
//                }
//                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
//            }
//            .navigationTitle("Report Found Item")
//            #if canImport(UIKit)
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            #endif
//            .alert(isPresented: $showSuccessAlert) {
//                Alert(
//                    title: Text("Success"),
//                    message: Text("Found item report saved."),
//                    dismissButton: .default(Text("OK"), action: clearForm)
//                )
//            }
//        }
//    }
//
//    private func addFoundItem() {
//        let newItem = FoundItem(context: viewContext)
//        newItem.id = UUID()
//        newItem.title = title
//        newItem.desc = desc
//        newItem.location = location
//        newItem.date = Date()
//        newItem.ownerEmail = currentUserEmail
//
//        #if canImport(UIKit)
//        if let img = image {
//            newItem.imageData = img.jpegData(compressionQuality: 0.8)
//        }
//        #endif
//
//        do {
//            try viewContext.save()
//            showSuccessAlert = true
//        } catch {
//            print("Failed to save found item: \(error)")
//        }
//    }
//
//    private func clearForm() {
//        title = ""
//        desc = ""
//        location = ""
//        #if canImport(UIKit)
//        image = nil
//        #endif
//    }
//}

//import SwiftUI
//import MapKit
//
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct ReportFoundView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @State private var title = ""
//    @State private var desc = ""
//    @State private var location = ""
//    @State private var verificationClue = ""
//
//    @State private var selectedCoordinate = CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892)
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//    )
//
//    #if canImport(UIKit)
//    @State private var image: UIImage?
//    @State private var showingPicker = false
//    #endif
//
//    @State private var showSuccessAlert = false
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Item Details")) {
//                    TextField("Title", text: $title)
//                    TextField("Description", text: $desc)
//                    TextField("Location Found (e.g., ISEC, Library)", text: $location)
//                    TextField("Optional clue for verification", text: $verificationClue)
//                }
//
//                Section(header: Text("Tap to Pin Location")) {
//                    Map(coordinateRegion: $region, annotationItems: [selectedCoordinate]) { coord in
//                        MapMarker(coordinate: coord, tint: .red)
//                    }
//                    .frame(height: 200)
//                    .gesture(DragGesture(minimumDistance: 0).onEnded { value in
//                        let locationInView = value.location
//                        let mapCoord = convertTapToCoordinate(locationInView)
//                        selectedCoordinate = mapCoord
//                    })
//                }
//
//                #if canImport(UIKit)
//                Section(header: Text("Image")) {
//                    if let image = image {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 150)
//                    }
//
//                    Button("Choose Image") {
//                        showingPicker = true
//                    }
//                }
//                #endif
//
//                Button(action: addFoundItem) {
//                    Label("Submit Found Report", systemImage: "plus")
//                }
//                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
//            }
//            .navigationTitle("Report Found Item")
//            #if canImport(UIKit)
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            #endif
//            .alert(isPresented: $showSuccessAlert) {
//                Alert(
//                    title: Text("Success"),
//                    message: Text("Found item report saved."),
//                    dismissButton: .default(Text("OK"), action: clearForm)
//                )
//            }
//        }
//    }
//
//    private func convertTapToCoordinate(_ tapLocation: CGPoint) -> CLLocationCoordinate2D {
//        // Placeholder logic — ideally use a MapKit view to convert screen point to coordinate
//        return region.center
//    }
//
//    private func addFoundItem() {
//        let newItem = FoundItem(context: viewContext)
//        newItem.id = UUID()
//        newItem.title = title
//        newItem.desc = desc
//        newItem.location = location
//        newItem.verificationClue = verificationClue
//        newItem.date = Date()
//        newItem.ownerEmail = currentUserEmail
//        newItem.latitude = selectedCoordinate.latitude
//        newItem.longitude = selectedCoordinate.longitude
//
//        #if canImport(UIKit)
//        if let img = image {
//            newItem.imageData = img.jpegData(compressionQuality: 0.8)
//        }
//        #endif
//
//        do {
//            try viewContext.save()
//            showSuccessAlert = true
//        } catch {
//            print("Failed to save found item: \(error)")
//        }
//    }
//
//    private func clearForm() {
//        title = ""
//        desc = ""
//        location = ""
//        verificationClue = ""
//        #if canImport(UIKit)
//        image = nil
//        #endif
//    }
//}
//
//extension CLLocationCoordinate2D: Identifiable {
//    public var id: String {
//        "\(latitude)-\(longitude)"
//    }
//}

//import SwiftUI
//import MapKit
//
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct MappableCoordinate: Identifiable {
//    let coordinate: CLLocationCoordinate2D
//    var id: String { "\(coordinate.latitude)-\(coordinate.longitude)" }
//}
//
//struct ReportFoundView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @State private var title = ""
//    @State private var desc = ""
//    @State private var location = ""
//    @State private var verificationClue = ""
//
//    @State private var selectedCoordinate = CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892)
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//    )
//
//    #if canImport(UIKit)
//    @State private var image: UIImage?
//    @State private var showingPicker = false
//    #endif
//
//    @State private var showSuccessAlert = false
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Item Details")) {
//                    TextField("Title", text: $title)
//                    TextField("Description", text: $desc)
//                    TextField("Location Found (e.g., ISEC, Library)", text: $location)
//                    TextField("Optional clue for verification", text: $verificationClue)
//                }
//
//                Section(header: Text("Tap to Pin Location")) {
//                    Map(position: $region) {
//                        Marker("Found Here", coordinate: selectedCoordinate)
//                    }
//                    .frame(height: 200)
//                    .gesture(DragGesture(minimumDistance: 0).onEnded { _ in
//                        // Simulate tap update with current center
//                        selectedCoordinate = region.center
//                    })
//                }
//
//                #if canImport(UIKit)
//                Section(header: Text("Image")) {
//                    if let image = image {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 150)
//                    }
//
//                    Button("Choose Image") {
//                        showingPicker = true
//                    }
//                }
//                #endif
//
//                Button(action: addFoundItem) {
//                    Label("Submit Found Report", systemImage: "plus")
//                }
//                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
//            }
//            .navigationTitle("Report Found Item")
//            #if canImport(UIKit)
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            #endif
//            .alert(isPresented: $showSuccessAlert) {
//                Alert(
//                    title: Text("Success"),
//                    message: Text("Found item report saved."),
//                    dismissButton: .default(Text("OK"), action: clearForm)
//                )
//            }
//        }
//    }
//
//    private func addFoundItem() {
//        let newItem = FoundItem(context: viewContext)
//        newItem.id = UUID()
//        newItem.title = title
//        newItem.desc = desc
//        newItem.location = location
//        newItem.verificationClue = verificationClue
//        newItem.date = Date()
//        newItem.ownerEmail = currentUserEmail
//        newItem.latitude = selectedCoordinate.latitude
//        newItem.longitude = selectedCoordinate.longitude
//
//        #if canImport(UIKit)
//        if let img = image {
//            newItem.imageData = img.jpegData(compressionQuality: 0.8)
//        }
//        #endif
//
//        do {
//            try viewContext.save()
//            showSuccessAlert = true
//        } catch {
//            print("Failed to save found item: \(error)")
//        }
//    }
//
//    private func clearForm() {
//        title = ""
//        desc = ""
//        location = ""
//        verificationClue = ""
//        #if canImport(UIKit)
//        image = nil
//        #endif
//    }
//}



//import SwiftUI
//import MapKit
//
//#if canImport(UIKit)
//import UIKit
//#endif
//
//
//
//struct ReportFoundView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @State private var title = ""
//    @State private var desc = ""
//    @State private var location = ""
//    @State private var verificationClue = ""
//
//    @State private var selectedCoordinate = CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892)
//    @State private var cameraPosition: MapCameraPosition = .region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//        )
//    )
//
//    #if canImport(UIKit)
//    @State private var image: UIImage?
//    @State private var showingPicker = false
//    #endif
//
//    @State private var showSuccessAlert = false
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Item Details")) {
//                    TextField("Title", text: $title)
//                    TextField("Description", text: $desc)
//                    TextField("Location Found (e.g., ISEC, Library)", text: $location)
//                    TextField("Optional clue for verification", text: $verificationClue)
//                }
//
//                Section(header: Text("Tap to Pin Location")) {
//                    Map(position: $cameraPosition) {
//                        Marker("Found Here", coordinate: selectedCoordinate)
//                    }
//                    .frame(height: 200)
//                    .gesture(DragGesture(minimumDistance: 0).onEnded { _ in
//                        if case let .region(region) = cameraPosition {
//                            selectedCoordinate = region.center
//                        }
//                    })
//                }
//
//                #if canImport(UIKit)
//                Section(header: Text("Image")) {
//                    if let image = image {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 150)
//                    }
//
//                    Button("Choose Image") {
//                        showingPicker = true
//                    }
//                }
//                #endif
//
//                Button(action: addFoundItem) {
//                    Label("Submit Found Report", systemImage: "plus")
//                }
//                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
//            }
//            .navigationTitle("Report Found Item")
//            #if canImport(UIKit)
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            #endif
//            .alert(isPresented: $showSuccessAlert) {
//                Alert(
//                    title: Text("Success"),
//                    message: Text("Found item report saved."),
//                    dismissButton: .default(Text("OK"), action: clearForm)
//                )
//            }
//        }
//    }
//
//    private func addFoundItem() {
//        let newItem = FoundItem(context: viewContext)
//        newItem.id = UUID()
//        newItem.title = title
//        newItem.desc = desc
//        newItem.location = location
//        newItem.verificationClue = verificationClue
//        newItem.date = Date()
//        newItem.ownerEmail = currentUserEmail
//        newItem.latitude = selectedCoordinate.latitude
//        newItem.longitude = selectedCoordinate.longitude
//
//        #if canImport(UIKit)
//        if let img = image {
//            newItem.imageData = img.jpegData(compressionQuality: 0.8)
//        }
//        #endif
//
//        do {
//            try viewContext.save()
//            showSuccessAlert = true
//        } catch {
//            print("Failed to save found item: \(error)")
//        }
//    }
//
//    private func clearForm() {
//        title = ""
//        desc = ""
//        location = ""
//        verificationClue = ""
//        #if canImport(UIKit)
//        image = nil
//        #endif
//    }
//}

//
//import SwiftUI
//import MapKit
//
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct ReportFoundView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @State private var title = ""
//    @State private var desc = ""
//    @State private var location = ""
//    @State private var verificationClue = ""
//
//    @State private var selectedCoordinate = CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892)
//    @State private var cameraPosition: MapCameraPosition = .region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//        )
//    )
//
//    #if canImport(UIKit)
//    @State private var image: UIImage?
//    @State private var showingPicker = false
//    #endif
//
//    @State private var showSuccessAlert = false
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Item Details")) {
//                    TextField("Title", text: $title)
//                    TextField("Description", text: $desc)
//                    TextField("Location Found (e.g., ISEC, Library)", text: $location)
//                    TextField("Optional clue for verification", text: $verificationClue)
//                }
//
//                Section(header: Text("Tap to Pin Location")) {
//                    Map(position: $cameraPosition) {
//                        Marker("Found Here", coordinate: selectedCoordinate)
//                    }
//                    .frame(height: 200)
//                    .gesture(DragGesture(minimumDistance: 0).onEnded { _ in
//                        updateCoordinateFromCamera()
//                    })
//                }
//
//                #if canImport(UIKit)
//                Section(header: Text("Image")) {
//                    if let image = image {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 150)
//                    }
//
//                    Button("Choose Image") {
//                        showingPicker = true
//                    }
//                }
//                #endif
//
//                Button(action: addFoundItem) {
//                    Label("Submit Found Report", systemImage: "plus")
//                }
//                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
//            }
//            .navigationTitle("Report Found Item")
//            #if canImport(UIKit)
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            #endif
//            .alert(isPresented: $showSuccessAlert) {
//                Alert(
//                    title: Text("Success"),
//                    message: Text("Found item report saved."),
//                    dismissButton: .default(Text("OK"), action: clearForm)
//                )
//            }
//        }
//    }
//
//    private func updateCoordinateFromCamera() {
//        if case let .region(region) = cameraPosition {
//            selectedCoordinate = region.center
//        }
//    }
//
//    private func addFoundItem() {
//        let newItem = FoundItem(context: viewContext)
//        newItem.id = UUID()
//        newItem.title = title
//        newItem.desc = desc
//        newItem.location = location
//        newItem.verificationClue = verificationClue
//        newItem.date = Date()
//        newItem.ownerEmail = currentUserEmail
//        newItem.latitude = selectedCoordinate.latitude
//        newItem.longitude = selectedCoordinate.longitude
//
//        #if canImport(UIKit)
//        if let img = image {
//            newItem.imageData = img.jpegData(compressionQuality: 0.8)
//        }
//        #endif
//
//        do {
//            try viewContext.save()
//            showSuccessAlert = true
//        } catch {
//            print("Failed to save found item: \(error)")
//        }
//    }
//
//    private func clearForm() {
//        title = ""
//        desc = ""
//        location = ""
//        verificationClue = ""
//        #if canImport(UIKit)
//        image = nil
//        #endif
//    }
//}

import SwiftUI
import MapKit

#if canImport(UIKit)
import UIKit
#endif

struct ReportFoundView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""

    @State private var title = ""
    @State private var desc = ""
    @State private var location = ""
    @State private var verificationClue = ""

    @State private var selectedCoordinate = CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892)
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
    )

    #if canImport(UIKit)
    @State private var image: UIImage?
    @State private var showingPicker = false
    #endif

    @State private var showSuccessAlert = false
    @State private var showMapPicker = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Item Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $desc)
                    TextField("Location Found (e.g., ISEC, Library)", text: $location)
                    TextField("Optional clue for verification", text: $verificationClue)
                }

                Section(header: Text("Tap to Pin Location")) {
                    Button("Pick Location on Campus Map") {
                        showMapPicker = true
                    }

                    Map(position: $cameraPosition) {
                        Marker("Found Here", coordinate: selectedCoordinate)
                    }
                    .frame(height: 200)
                }

                #if canImport(UIKit)
                Section(header: Text("Image")) {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }

                    Button("Choose Image") {
                        showingPicker = true
                    }
                }
                #endif

                Button(action: addFoundItem) {
                    Label("Submit Found Report", systemImage: "plus")
                }
                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
            }
            .navigationTitle("Report Found Item")
            .neuBranded()
            #if canImport(UIKit)
            .sheet(isPresented: $showingPicker) {
                ImagePicker(image: $image)
            }
            #endif
            .sheet(isPresented: $showMapPicker) {
                CampusMapPickerView(
                    selectedCoordinate: $selectedCoordinate,
                    locationName: $location
                )
            }
            .alert(isPresented: $showSuccessAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text("Found item report saved."),
                    dismissButton: .default(Text("OK"), action: clearForm)
                )
            }
        }
    }

    private func addFoundItem() {
        let newItem = FoundItem(context: viewContext)
        newItem.id = UUID()
        newItem.title = title
        newItem.desc = desc
        newItem.location = location
        newItem.verificationClue = verificationClue
        newItem.date = Date()
        newItem.finderEmail = currentUserEmail
        newItem.latitude = selectedCoordinate.latitude
        newItem.longitude = selectedCoordinate.longitude

        #if canImport(UIKit)
        if let img = image {
            newItem.imageData = img.jpegData(compressionQuality: 0.8)
        }
        #endif

        do {
            try viewContext.save()
            showSuccessAlert = true
        } catch {
            print("Failed to save found item: \(error)")
        }
    }

    private func clearForm() {
        title = ""
        desc = ""
        location = ""
        verificationClue = ""
        #if canImport(UIKit)
        image = nil
        #endif
    }
}


