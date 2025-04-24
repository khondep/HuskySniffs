////
////  ReportLostView.swift
////  LostAndFoundHub
////
////  Created by Purvang Khonde on 4/4/25.
////
//import SwiftUI
//
//#if canImport(UIKit)
//import UIKit
//#endif
//
//
//struct ReportLostView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @State private var title = ""
//    @State private var desc = ""
//    @State private var location = ""
//    @State private var image: UIImage?
//    @State private var showingPicker = false
//
//    var body: some View {
//        NavigationView {
//            Form {
//                TextField("Title", text: $title)
//                TextField("Description", text: $desc)
//                TextField("Location", text: $location)
//
//                if let image = image {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 150)
//                }
//
//                Button("Choose Image") {
//                    showingPicker = true
//                }
//
//                Button("Submit") {
//                    addLostItem()
//                }
//            }
//            .navigationTitle("Report Lost Item")
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//        }
//    }
//
//    private func addLostItem() {
//        let newItem = LostItem(context: viewContext)
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
//            title = ""
//            desc = ""
//            location = ""
//            image = nil
//        } catch {
//            print("Failed to save: \(error)")
//        }
//    }
//}
//

//import SwiftUI
//
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct ReportLostView: View {
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
//                    TextField("Location Lost", text: $location)
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
//                Button(action: addLostItem) {
//                    Label("Submit Lost Report", systemImage: "plus")
//                }
//                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
//            }
//            .navigationTitle("Report Lost Item")
//            #if canImport(UIKit)
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            #endif
//            .alert(isPresented: $showSuccessAlert) {
//                Alert(
//                    title: Text("Success"),
//                    message: Text("Lost item report saved."),
//                    dismissButton: .default(Text("OK"), action: clearForm)
//                )
//            }
//        }
//    }
//
//    private func addLostItem() {
//        let newItem = LostItem(context: viewContext)
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
//            print("Failed to save lost item: \(error)")
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
//struct ReportLostView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
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
//                    TextField("Location Lost", text: $location)
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
//                Button(action: addLostItem) {
//                    Label("Submit Lost Report", systemImage: "plus")
//                }
//                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
//            }
//            .navigationTitle("Report Lost Item")
//            #if canImport(UIKit)
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            #endif
//            .alert(isPresented: $showSuccessAlert) {
//                Alert(
//                    title: Text("Success"),
//                    message: Text("Lost item report saved."),
//                    dismissButton: .default(Text("OK"), action: clearForm)
//                )
//            }
//        }
//    }
//
//    private func addLostItem() {
//        let newItem = LostItem(context: viewContext)
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
//            print("Failed to save lost item: \(error)")
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
//struct ReportLostView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @State private var title = ""
//    @State private var desc = ""
//    @State private var location = ""
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
//                    TextField("Location Lost (e.g., Snell Library, Dining Hall)", text: $location)
//                }
//
//                Section(header: Text("Tap to Pin Location")) {
//                    Map(coordinateRegion: $region, annotationItems: [selectedCoordinate]) { coord in
//                        MapMarker(coordinate: coord, tint: .blue)
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
//                Button(action: addLostItem) {
//                    Label("Submit Lost Report", systemImage: "plus")
//                }
//                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
//            }
//            .navigationTitle("Report Lost Item")
//            #if canImport(UIKit)
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            #endif
//            .alert(isPresented: $showSuccessAlert) {
//                Alert(
//                    title: Text("Success"),
//                    message: Text("Lost item report saved."),
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
//    private func addLostItem() {
//        let newItem = LostItem(context: viewContext)
//        newItem.id = UUID()
//        newItem.title = title
//        newItem.desc = desc
//        newItem.location = location
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
//            print("Failed to save lost item: \(error)")
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
//
//
//struct ReportLostView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @State private var title = ""
//    @State private var desc = ""
//    @State private var location = ""
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
//                    TextField("Location Lost (e.g., ISEC, Library)", text: $location)
//                }
//
//                Section(header: Text("Tap to Pin Location")) {
//                    Map(position: $cameraPosition) {
//                        Marker("Lost Here", coordinate: selectedCoordinate)
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
//                Button(action: addLostItem) {
//                    Label("Submit Lost Report", systemImage: "plus")
//                }
//                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
//            }
//            .navigationTitle("Report Lost Item")
//            #if canImport(UIKit)
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            #endif
//            .alert(isPresented: $showSuccessAlert) {
//                Alert(
//                    title: Text("Success"),
//                    message: Text("Lost item report saved."),
//                    dismissButton: .default(Text("OK"), action: clearForm)
//                )
//            }
//        }
//    }
//
//    private func addLostItem() {
//        let newItem = LostItem(context: viewContext)
//        newItem.id = UUID()
//        newItem.title = title
//        newItem.desc = desc
//        newItem.location = location
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
//            print("Failed to save lost item: \(error)")
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

//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct ReportLostView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @State private var title = ""
//    @State private var desc = ""
//    @State private var location = ""
//
//    @State private var selectedCoordinate = CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892)
//    @State private var cameraPosition: MapCameraPosition = .region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//        )
//    )
//
//    @StateObject private var locationManager = LocationManager()
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
//                    TextField("Location Lost (e.g., ISEC, Library)", text: $location)
//                        .onAppear {
//                            if let current = locationManager.lastKnownPlacemark {
//                                location = current.name ?? ""
//                            }
//                        }
//                }
//
//                Section(header: Text("Tap to Pin Location")) {
//                    Map(position: $cameraPosition) {
//                        Marker("Lost Here", coordinate: selectedCoordinate)
//                    }
//                    .frame(height: 200)
//                    .onAppear {
//                        if let userLocation = locationManager.lastKnownCoordinate {
//                            selectedCoordinate = userLocation
//                            cameraPosition = .region(MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)))
//                        }
//                    }
//                    .gesture(DragGesture().onEnded { _ in
//                        if case let .region(region) = cameraPosition {
//                            selectedCoordinate = region.center
//                        }
//                    
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
//                Button(action: addLostItem) {
//                    Label("Submit Lost Report", systemImage: "plus")
//                }
//                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
//            }
//            .navigationTitle("Report Lost Item")
//            #if canImport(UIKit)
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            #endif
//            .alert(isPresented: $showSuccessAlert) {
//                Alert(
//                    title: Text("Success"),
//                    message: Text("Lost item report saved."),
//                    dismissButton: .default(Text("OK"), action: clearForm)
//                )
//            }
//        }
//    }
//
//    private func addLostItem() {
//        let newItem = LostItem(context: viewContext)
//        newItem.id = UUID()
//        newItem.title = title
//        newItem.desc = desc
//        newItem.location = location
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
//            print("Failed to save lost item: \(error)")
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
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let manager = CLLocationManager()
//
//    @Published var lastKnownCoordinate: CLLocationCoordinate2D?
//    @Published var lastKnownPlacemark: CLPlacemark?
//
//    override init() {
//        super.init()
//        manager.delegate = self
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let latest = locations.last else { return }
//        DispatchQueue.main.async {
//            self.lastKnownCoordinate = latest.coordinate
//            self.fetchPlacemark(for: latest)
//        }
//    }
//
//    private func fetchPlacemark(for location: CLLocation) {
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, _ in
//            if let first = placemarks?.first {
//                DispatchQueue.main.async {
//                    self.lastKnownPlacemark = first
//                }
//            }
//        }
//    }
//}
//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct ReportLostView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @State private var title = ""
//    @State private var desc = ""
//    @State private var location = ""
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
//    @State private var showMapPicker = false
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Item Details")) {
//                    TextField("Title", text: $title)
//                    TextField("Description", text: $desc)
//                    TextField("Location Lost (e.g., ISEC, Library)", text: $location)
//                }
//
//                Section(header: Text("Tap to Pin Location")) {
//                    Button("Pick Location on Campus Map") {
//                        showMapPicker = true
//                    }
//
//                    Map(position: $cameraPosition) {
//                        Marker("Lost Here", coordinate: selectedCoordinate)
//                    }
//                    .frame(height: 200)
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
//                Button(action: addLostItem) {
//                    Label("Submit Lost Report", systemImage: "plus")
//                }
//                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
//            }
//            .navigationTitle("Report Lost Item")
//            #if canImport(UIKit)
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            #endif
//            .sheet(isPresented: $showMapPicker) {
//                CampusMapPickerView(selectedCoordinate: $selectedCoordinate, locationName: $location)
//            }
//            .alert(isPresented: $showSuccessAlert) {
//                Alert(
//                    title: Text("Success"),
//                    message: Text("Lost item report saved."),
//                    dismissButton: .default(Text("OK"), action: clearForm)
//                )
//            }
//        }
//    }
//
//    private func addLostItem() {
//        let newItem = LostItem(context: viewContext)
//        newItem.id = UUID()
//        newItem.title = title
//        newItem.desc = desc
//        newItem.location = location
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
//            print("Failed to save lost item: \(error)")
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
//
//struct CampusMapPickerView: View {
//    @Environment(\.dismiss) private var dismiss
//    @Binding var selectedCoordinate: CLLocationCoordinate2D
//    @Binding var locationName: String
//
//    @State private var cameraPosition: MapCameraPosition = .region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//        )
//    )
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 20) {
//                Text("Tap the map to select a location")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                Map(position: $cameraPosition) {
//                    Marker("Selected", coordinate: selectedCoordinate)
//                }
//                .frame(height: 300)
//                .cornerRadius(10)
//                .padding()
//
//                Button("Confirm Location") {
//                    if case let .region(region) = cameraPosition {
//                        selectedCoordinate = region.center
//                        reverseGeocode(region.center)
//                    }
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//            .padding()
//        }
//    }
//
//    private func reverseGeocode(_ coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                locationName = [place.name, place.locality].compactMap { $0 }.joined(separator: ", ")
//            }
//        }
//    }
//}
//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct ReportLostView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    @State private var title = ""
//    @State private var desc = ""
//    @State private var location = ""
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
//    @State private var showMapPicker = false
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Item Details")) {
//                    TextField("Title", text: $title)
//                    TextField("Description", text: $desc)
//                    TextField("Location Lost (e.g., ISEC, Library)", text: $location)
//                }
//
//                Section(header: Text("Tap to Pin Location")) {
//                    Button("Pick Location on Campus Map") {
//                        showMapPicker = true
//                    }
//
//                    Map(position: $cameraPosition) {
//                        Marker("Lost Here", coordinate: selectedCoordinate)
//                    }
//                    .frame(height: 200)
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
//                Button(action: addLostItem) {
//                    Label("Submit Lost Report", systemImage: "plus")
//                }
//                .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
//            }
//            .navigationTitle("Report Lost Item")
//            #if canImport(UIKit)
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            #endif
//            .sheet(isPresented: $showMapPicker) {
//                CampusMapPickerView(selectedCoordinate: $selectedCoordinate, locationName: $location)
//            }
//            .alert(isPresented: $showSuccessAlert) {
//                Alert(
//                    title: Text("Success"),
//                    message: Text("Lost item report saved."),
//                    dismissButton: .default(Text("OK"), action: clearForm)
//                )
//            }
//        }
//    }
//
//    private func addLostItem() {
//        let newItem = LostItem(context: viewContext)
//        newItem.id = UUID()
//        newItem.title = title
//        newItem.desc = desc
//        newItem.location = location
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
//            print("Failed to save lost item: \(error)")
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

//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//#if canImport(UIKit)
//import UIKit
//#endif
//
//struct ReportLostView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @AppStorage("currentUserEmail") private var currentUserEmail: String = ""
//
//    // form fields
//    @State private var title = ""
//    @State private var desc = ""
//    @State private var location = ""
//
//    // map state
//    @State private var selectedCoordinate = CLLocationCoordinate2D(
//        latitude: 42.3398, longitude: -71.0892
//    )
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
//    // alerts & sheets
//    @State private var showSuccessAlert = false
//    @State private var showMapPicker = false
//
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section("Item Details") {
//                    TextField("Title", text: $title)
//                        .autocorrectionDisabled(true)
//                        .textInputAutocapitalization(.words)
//
//                    TextField("Description", text: $desc)
//                        .autocorrectionDisabled(true)
//
//                    TextField("Location Lost (e.g., ISEC, Library)", text: $location)
//                        .autocorrectionDisabled(true)
//                }
//
//                Section("Tap to Pin Location") {
//                    Button("Pick on Campus Map…") {
//                        showMapPicker = true
//                    }
//                    Map(
//                        position: $cameraPosition,
//                        interactionModes: .all,
//                        showsUserLocation: true
//                    ) {
//                        Marker("Here", coordinate: selectedCoordinate)
//                    }
//                    .frame(height: 200)
//                    .cornerRadius(8)
//                    .mapControls {
//                        MapUserLocationButton()
//                    }
//                    // whenever the user drags the map, update our pin
//                    .onChange(of: cameraPosition) { newPos in
//                        if case .region(let region) = newPos {
//                            selectedCoordinate = region.center
//                        }
//                    }
//                }
//
//                #if canImport(UIKit)
//                Section("Image") {
//                    if let img = image {
//                        Image(uiImage: img)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 150)
//                            .cornerRadius(8)
//                    }
//                    Button("Choose Image…") {
//                        showingPicker = true
//                    }
//                }
//                #endif
//
//                Section {
//                    Button {
//                        addLostItem()
//                    } label: {
//                        Label("Submit Lost Report", systemImage: "plus.circle.fill")
//                    }
//                    .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
//                    .tint(.red)
//                }
//            }
//            .navigationTitle("Report Lost Item")
//            // MARK: — sheets & alerts
//            .sheet(isPresented: $showMapPicker) {
//                CampusMapPickerView(
//                    selectedCoordinate: $selectedCoordinate,
//                    locationName: $location
//                )
//            }
//            #if canImport(UIKit)
//            .sheet(isPresented: $showingPicker) {
//                ImagePicker(image: $image)
//            }
//            #endif
//            .alert("Success", isPresented: $showSuccessAlert) {
//                Button("OK", role: .cancel) { clearForm() }
//            } message: {
//                Text("Your lost-item report has been submitted.")
//            }
//            // dismiss keyboard accessory to avoid constraints warning
//            .toolbar {
//                ToolbarItem(placement: .keyboard) {
//                    Button("Done") {
//                        #if canImport(UIKit)
//                        UIApplication.shared.sendAction(
//                            #selector(UIResponder.resignFirstResponder),
//                            to: nil, from: nil, for: nil
//                        )
//                        #endif
//                    }
//                }
//            }
//        }
//    }
//
//    private func addLostItem() {
//        let newItem = LostItem(context: viewContext)
//        newItem.id = UUID()
//        newItem.title = title
//        newItem.desc = desc
//        newItem.location = location
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
//            print("Failed to save lost item: \(error)")
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
//        // reset map
//        selectedCoordinate = cameraPosition.region.center
//    }
//}


import SwiftUI
import MapKit
import CoreLocation

#if canImport(UIKit)
import UIKit
#endif

/// Tiny Identifiable wrapper for a single pin on the map.
private struct MappableCoordinate: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct ReportLostView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("currentUserEmail") private var currentUserEmail = ""

    // MARK: – Form fields
    @State private var title = ""
    @State private var desc = ""
    @State private var location = ""

    // MARK: – Map state
    @State private var selectedCoordinate = CLLocationCoordinate2D(
        latitude: 42.3398,
        longitude: -71.0892
    )
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )

    #if canImport(UIKit)
    @State private var image: UIImage?
    @State private var showingImagePicker = false
    #endif

    @State private var showingMapPicker = false
    @State private var showSuccessAlert = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Item Details") {
                    TextField("Title", text: $title)
                        .autocorrectionDisabled(true)
                    TextField("Description", text: $desc)
                        .autocorrectionDisabled(true)
                    TextField("Location Lost", text: $location)
                        .autocorrectionDisabled(true)
                }

                Section("Campus Map") {
                    Button("Pick on Campus Map…") {
                        showingMapPicker = true
                    }

                    Map(
                        coordinateRegion: $region,
                        interactionModes: .all,
                        showsUserLocation: true,
                        annotationItems: [ MappableCoordinate(coordinate: selectedCoordinate) ]
                    ) { item in
                        MapMarker(coordinate: item.coordinate, tint: .red)
                    }
                    .frame(height: 200)
                    .cornerRadius(8)
                }

                #if canImport(UIKit)
                Section("Image") {
                    if let img = image {
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(8)
                    }
                    Button("Choose Image…") {
                        showingImagePicker = true
                    }
                }
                #endif

                Section {
                    Button {
                        saveLostItem()
                    } label: {
                        Label("Submit Lost Report", systemImage: "checkmark.circle.fill")
                    }
                    .tint(.red)
                    .disabled(title.isEmpty || desc.isEmpty || location.isEmpty)
                }
            }
            .navigationTitle("Report Lost Item")
            .neuBranded()
            .sheet(isPresented: $showingMapPicker) {
                CampusMapPickerView(
                    selectedCoordinate: $selectedCoordinate,
                    locationName: $location
                )
            }
            #if canImport(UIKit)
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $image)
            }
            #endif
            .alert("Success", isPresented: $showSuccessAlert) {
                Button("OK", action: resetForm)
            } message: {
                Text("Your lost‐item report was saved.")
            }
        }
    }

    private func saveLostItem() {
        let item = LostItem(context: viewContext)
        item.id = UUID()
        item.title = title
        item.desc = desc
        item.location = location
        item.date = Date()
        item.ownerEmail = currentUserEmail
        item.latitude = selectedCoordinate.latitude
        item.longitude = selectedCoordinate.longitude

        #if canImport(UIKit)
        if let img = image {
            item.imageData = img.jpegData(compressionQuality: 0.8)
        }
        #endif

        do {
            try viewContext.save()
            showSuccessAlert = true
        } catch {
            print("Failed to save lost item:", error)
        }
    }

    private func resetForm() {
        title = ""
        desc = ""
        location = ""
        selectedCoordinate = region.center
        #if canImport(UIKit)
        image = nil
        #endif
    }
}
