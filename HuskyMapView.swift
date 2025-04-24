//
//  HuskyMapView.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/21/25.
//

//import SwiftUI
//import MapKit
//import CoreData
//
//struct HuskyMapView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        entity: LostItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//        entity: FoundItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) var foundItems: FetchedResults<FoundItem>
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
//
//    @State private var selectedItem: FoundItem?
//    
//    var allPins: [FoundItem] {
//        foundItems.filter { item in
//            item.latitude != 0 && item.longitude != 0
//        }
//    }
//    var body: some View {
//        NavigationStack {
//            Map(coordinateRegion: $region, annotationItems: allPins) { item in
//                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)) {
//                    VStack(spacing: 4) {
//                        Image(systemName: "mappin.circle.fill")
//                            .foregroundColor(.red)
//                            .font(.title)
//                            .onTapGesture {
//                                selectedItem = item
//                            }
//                        Text(item.title ?? "")
//                            .font(.caption2)
//                    }
//                }
//            }
//            .edgesIgnoringSafeArea(.all)
//            .sheet(item: $selectedItem) { item in
//                VStack(spacing: 16) {
//                    if let data = item.imageData, let image = UIImage(data: data) {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 150)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//
//                    Text(item.title ?? "")
//                        .font(.title2)
//                        .bold()
//                    Text(item.desc ?? "")
//                        .font(.body)
//                        .multilineTextAlignment(.center)
//                    Text("Found at: \(item.location ?? "Unknown")")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//
//                    NavigationLink(destination: ChatView(
//                        sessionID: UUID().uuidString, // or a logic to match Lost-Found
//                        currentUser: "owner"
//                    )) {
//                        Text("Claim This Item")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                }
//                .padding()
//            }
//            .navigationTitle("Husky Map")
//        }
//    }
//}
//
//// Preview
//struct HuskyMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        HuskyMapView()
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
//
//import SwiftUI
//import MapKit
//
//struct HuskyMapView: View {
//    @FetchRequest(
//        entity: LostItem.entity(),
//        sortDescriptors: []
//    ) var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//        entity: FoundItem.entity(),
//        sortDescriptors: []
//    ) var foundItems: FetchedResults<FoundItem>
//
//    @State private var selectedItem: MapItem?
//    @State private var cameraPosition: MapCameraPosition = .region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//        )
//    )
//
//    var allMapItems: [MapItem] {
//        let lost = lostItems.compactMap { MapItem(from: $0, type: .lost) }
//        let found = foundItems.compactMap { MapItem(from: $0, type: .found) }
//        return lost + found
//    }
//
//    var body: some View {
//        NavigationStack {
//            Map(position: $cameraPosition, selection: $selectedItem) {
//                ForEach(allMapItems) { item in
//                    Marker(item.title, coordinate: item.coordinate)
//                }
//            }
//            .mapStyle(.standard)
//            .navigationTitle("Husky Map")
//            .sheet(item: $selectedItem) { item in
//                VStack(spacing: 16) {
//                    Text(item.title)
//                        .font(.title2)
//                    Text(item.description)
//                        .font(.body)
//                    Text("Location: \(item.location)")
//                        .foregroundColor(.secondary)
//
//                    if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
//                        Image(uiImage: uiImage)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 150)
//                    }
//
//                    Button("Claim This Item") {
//                        // Optionally navigate to ChatView or trigger claim logic
//                    }
//                    .buttonStyle(.borderedProminent)
//
//                    Spacer()
//                }
//                .padding()
//            }
//        }
//    }
//}
//
//// MARK: - MapItem Adapter
//
//struct MapItem: Identifiable, Hashable {
//    enum ItemType { case lost, found }
//
//    var id: String
//    var title: String
//    var description: String
//    var location: String
//    var coordinate: CLLocationCoordinate2D
//    var type: ItemType
//    var imageData: Data?
//
//    init?(from item: LostItem, type: ItemType) {
//        guard let id = item.id?.uuidString,
//              let title = item.title,
//              let desc = item.desc,
//              let location = item.location else { return nil }
//
//        self.id = id
//        self.title = title
//        self.description = desc
//        self.location = location
//        self.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
//        self.type = type
//        self.imageData = item.imageData
//    }
//
//    init?(from item: FoundItem, type: ItemType) {
//        guard let id = item.id?.uuidString,
//              let title = item.title,
//              let desc = item.desc,
//              let location = item.location else { return nil }
//
//        self.id = id
//        self.title = title
//        self.description = desc
//        self.location = location
//        self.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
//        self.type = type
//        self.imageData = item.imageData
//    }
//}
//import SwiftUI
//import MapKit
//
//struct MapItem: Identifiable, Hashable {
//    let id: UUID
//    let title: String
//    let coordinate: CLLocationCoordinate2D
//    let isLost: Bool
//
//    static func == (lhs: MapItem, rhs: MapItem) -> Bool {
//        return lhs.id == rhs.id
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}
//
//struct HuskyMapView: View {
//    @FetchRequest(
//        entity: LostItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//        entity: FoundItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) var foundItems: FetchedResults<FoundItem>
//
//    @State private var selectedItem: MapItem?
//    @State private var cameraPosition: MapCameraPosition = .region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//        )
//    )
//
//    var body: some View {
//        NavigationStack {
//            Map(position: $cameraPosition, selection: $selectedItem) {
//                ForEach(mapItems) { item in
//                    Marker(item.title, coordinate: item.coordinate)
//                }
//            }
//            .mapControls { MapUserLocationButton() }
//            .navigationTitle("Husky Map")
//            .sheet(item: $selectedItem) { item in
//                VStack(spacing: 16) {
//                    Text(item.title)
//                        .font(.title2)
//                    Text(item.isLost ? "Lost Item" : "Found Item")
//                        .foregroundColor(item.isLost ? .red : .green)
//                        .font(.headline)
//                }
//                .padding()
//            }
//        }
//    }
//
//    private var mapItems: [MapItem] {
//        let lost: [MapItem] = lostItems.compactMap {
//            guard let id = $0.id, let title = $0.title else { return nil }
//            return MapItem(id: id, title: title, coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude), isLost: true)
//        }
//
//        let found: [MapItem] = foundItems.compactMap {
//            guard let id = $0.id, let title = $0.title else { return nil }
//            return MapItem(id: id, title: title, coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude), isLost: false)
//        }
//
//        return lost + found
//    }
//}


//import SwiftUI
//import MapKit
//
//struct MapItem: Identifiable, Hashable, Equatable {
//    let id: UUID
//    let title: String
//    let coordinate: CLLocationCoordinate2D
//    let isLost: Bool
//
//    static func == (lhs: MapItem, rhs: MapItem) -> Bool {
//        lhs.id == rhs.id
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}


//
//// MARK: - HuskyMapView.swift
//import SwiftUI
//import MapKit
//
//
//
//struct HuskyMapView: View {
//    @FetchRequest(
//        entity: LostItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
//    ) var lostItems: FetchedResults<LostItem>
//
//    @FetchRequest(
//        entity: FoundItem.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
//    ) var foundItems: FetchedResults<FoundItem>
//
//    @State private var selectedItem: MapItem?
//    @State private var cameraPosition: MapCameraPosition = .region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//        )
//    )
//
//    var body: some View {
//        NavigationStack {
//            Map(position: $cameraPosition, selection: $selectedItem) {
//                ForEach(mapItems) { item in
//                    Marker(item.title, coordinate: item.coordinate)
//                        .tint(item.isLost ? .red : .green)
//                }
//            }
//            .mapControls {
//                MapUserLocationButton()
//                MapCompass()
//                MapPitchToggle()
//                MapScaleView()
//            }
//            .navigationTitle("Husky Map")
//            .sheet(item: $selectedItem) { item in
//                VStack(spacing: 16) {
//                    Text(item.title)
//                        .font(.title2)
//                    Text(item.isLost ? "Lost Item" : "Found Item")
//                        .foregroundColor(item.isLost ? .red : .green)
//                        .font(.headline)
//                }
//                .padding()
//            }
//        }
//    }
//
//    private var mapItems: [MapItem] {
//        let lost: [MapItem] = lostItems.compactMap {
//            guard let id = $0.id, let title = $0.title else { return nil }
//            return MapItem(id: id, title: title, coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude), isLost: true)
//        }
//
//        let found: [MapItem] = foundItems.compactMap {
//            guard let id = $0.id, let title = $0.title else { return nil }
//            return MapItem(id: id, title: title, coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude), isLost: false)
//        }
//
//        return lost + found
//    }
//}

import SwiftUI
import MapKit

struct HuskyMapView: View {
    @FetchRequest(
        entity: LostItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \LostItem.date, ascending: false)]
    ) var lostItems: FetchedResults<LostItem>

    @FetchRequest(
        entity: FoundItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FoundItem.date, ascending: false)]
    ) var foundItems: FetchedResults<FoundItem>

    @State private var selectedItem: MapItem?
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
    )

    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition, selection: $selectedItem) {
                ForEach(mapItems) { item in
                    Marker(item.title, coordinate: item.coordinate)
                        .tint(item.isLost ? .red : .green)
                }
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapPitchToggle()
                MapScaleView()
            }
            .navigationTitle("Husky Map")
            .sheet(item: $selectedItem) { item in
                VStack(spacing: 16) {
                    Text(item.title)
                        .font(.title2)
                    Text(item.isLost ? "Lost Item" : "Found Item")
                        .foregroundColor(item.isLost ? .red : .green)
                        .font(.headline)
                }
                .padding()
            }
        }
    }

    private var mapItems: [MapItem] {
        let lost: [MapItem] = lostItems.compactMap {
            guard let id = $0.id, let title = $0.title else { return nil }
            return MapItem(id: id, title: title, coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude), isLost: true)
        }

        let found: [MapItem] = foundItems.compactMap {
            guard let id = $0.id, let title = $0.title else { return nil }
            return MapItem(id: id, title: title, coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude), isLost: false)
        }

        return lost + found
    }
}
