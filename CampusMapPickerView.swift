//
//  CampusMapPickerView.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/21/25.
//

//
//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//struct CampusMapPickerView: View {
//    @Environment(\.dismiss) private var dismiss
//    @Binding var selectedCoordinate: CLLocationCoordinate2D
//    @Binding var locationName: String
//
//    @StateObject private var locationManager = LocationManager()
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//    )
//
//    let predefinedLocations: [NamedLocation] = [
//        NamedLocation(name: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3399, longitude: -71.0888), isLost: true),
//        NamedLocation(name: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3386, longitude: -71.0903), isLost: true),
//        NamedLocation(name: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.3395, longitude: -71.0879), isLost: true),
//        NamedLocation(name: "Found Item", coordinate: CLLocationCoordinate2D(latitude: 42.3402, longitude: -71.0895), isLost: false)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 20) {
//                Text("Drag or zoom the map, then tap Confirm")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                ZStack {
//                    Map(coordinateRegion: $region,
//                        interactionModes: [.all],
//                        showsUserLocation: true,
//                        annotationItems: predefinedLocations) { location in
//                        MapAnnotation(coordinate: location.coordinate) {
//                            VStack {
//                                Image(systemName: location.isLost ? "mappin.circle.fill" : "location.circle.fill")
//                                    .resizable()
//                                    .foregroundColor(location.isLost ? .red : .blue)
//                                    .frame(width: 30, height: 30)
//                                Text(location.name)
//                                    .font(.caption2)
//                            }
//                        }
//                    }
//                    .cornerRadius(12)
//                    .frame(height: 350)
//                }
//
//                Button("Confirm Location") {
//                    selectedCoordinate = region.center
//                    reverseGeocode(coordinate: region.center)
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//                .padding(.top)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//            .padding()
//        }
//    }
//
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                locationName = [place.name, place.locality].compactMap { $0 }.joined(separator: ", ")
//            } else {
//                locationName = "Unknown Location"
//            }
//        }
//    }
//}
//
//// MARK: - Model for Annotations
//struct NamedLocation: Identifiable {
//    let id = UUID()
//    let name: String
//    let coordinate: CLLocationCoordinate2D
//    let isLost: Bool
//}
//
//// MARK: - Location Manager
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let manager = CLLocationManager()
//
//    override init() {
//        super.init()
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
//    }
//}
//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//struct CampusMapPickerView: View {
//    @Environment(\.dismiss) private var dismiss
//    @Binding var selectedCoordinate: CLLocationCoordinate2D
//    @Binding var locationName: String
//
//    @StateObject private var locationManager = LocationManager()
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//    )
//
//    let predefinedLocations: [NamedLocation] = [
//        NamedLocation(name: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3399, longitude: -71.0888), isLost: true),
//        NamedLocation(name: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3386, longitude: -71.0903), isLost: true),
//        NamedLocation(name: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.3395, longitude: -71.0879), isLost: true),
//        NamedLocation(name: "Found Item", coordinate: CLLocationCoordinate2D(latitude: 42.3402, longitude: -71.0895), isLost: false)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 20) {
//                Text("Drag or zoom the map, then tap Confirm")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                ZStack {
//                    Map(coordinateRegion: $region,
//                        interactionModes: [.all],
//                        showsUserLocation: true,
//                        annotationItems: predefinedLocations) { location in
//                        MapAnnotation(coordinate: location.coordinate) {
//                            VStack {
//                                Image(systemName: location.isLost ? "mappin.circle.fill" : "location.circle.fill")
//                                    .resizable()
//                                    .foregroundColor(location.isLost ? .red : .blue)
//                                    .frame(width: 30, height: 30)
//                                Text(location.name)
//                                    .font(.caption2)
//                            }
//                        }
//                    }
//                    .cornerRadius(12)
//                    .frame(height: 350)
//                }
//
//                Button("Confirm Location") {
//                    selectedCoordinate = region.center
//                    reverseGeocode(coordinate: region.center)
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//                .padding(.top)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//            .padding()
//        }
//    }
//
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                locationName = [place.name, place.locality].compactMap { $0 }.joined(separator: ", ")
//            } else {
//                locationName = "Unknown Location"
//            }
//        }
//    }
//}
//
//// MARK: - Model for Annotations
//struct NamedLocation: Identifiable {
//    let id = UUID()
//    let name: String
//    let coordinate: CLLocationCoordinate2D
//    let isLost: Bool
//}
//
//// MARK: - Location Manager
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let manager = CLLocationManager()
//
//    override init() {
//        super.init()
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
//    }
//}


//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//struct NamedLocation: Identifiable {
//    let id = UUID()
//    let name: String
//    let coordinate: CLLocationCoordinate2D
//    let isLost: Bool
//}
//
//struct CampusMapPickerView: View {
//    @Environment(\.dismiss) private var dismiss
//    @Binding var selectedCoordinate: CLLocationCoordinate2D
//    @Binding var locationName: String
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//    )
//    
//    @State private var showUserLocation = true
//
//    // Predefined landmark pins
//    let predefinedLocations: [NamedLocation] = [
//        NamedLocation(name: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), isLost: true),
//        NamedLocation(name: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), isLost: false),
//        NamedLocation(name: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), isLost: true),
//        NamedLocation(name: "Behrakis Center", coordinate: CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), isLost: false),
//        NamedLocation(name: "Marino Center", coordinate: CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), isLost: true)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 20) {
//                Text("Drag the map or tap a pin to select location")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                Map(coordinateRegion: $region, interactionModes: [.all], showsUserLocation: showUserLocation, annotationItems: predefinedLocations) { location in
//                    MapAnnotation(coordinate: location.coordinate) {
//                        VStack {
//                            Image(systemName: location.isLost ? "mappin.and.ellipse" : "pin")
//                                .foregroundColor(location.isLost ? .red : .blue)
//                                .onTapGesture {
//                                    selectedCoordinate = location.coordinate
//                                    locationName = location.name
//                                }
//                            Text(location.name)
//                                .font(.caption2)
//                        }
//                    }
//                }
//                .frame(height: 350)
//                .cornerRadius(12)
//                .onAppear {
//                    selectedCoordinate = region.center
//                    reverseGeocode(coordinate: region.center)
//                }
//                .gesture(DragGesture(minimumDistance: 0).onEnded { _ in
//                    selectedCoordinate = region.center
//                    reverseGeocode(coordinate: region.center)
//                })
//
//                Button("Confirm Location") {
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//                .padding(.top)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//            .padding()
//        }
//    }
//
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                let parts = [place.name, place.locality]
//                locationName = parts.compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("\u274C Geocoding failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}

//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//struct CampusMapPickerView: View {
//    @Environment(\.dismiss) private var dismiss
//    @Binding var selectedCoordinate: CLLocationCoordinate2D
//    @Binding var locationName: String
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//    )
//
//    @StateObject private var locationManager = LocationManager()
//
//    var predefinedLocations: [(name: String, coordinate: CLLocationCoordinate2D, color: Color)] = [
//        ("Snell Library", CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), .red),
//        ("ISEC", CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), .orange),
//        ("Curry Center", CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), .yellow),
//        ("Behrakis Health Sciences", CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), .green),
//        ("Marino Center", CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), .blue)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Map(position: $region) {
//                    // User's current location
//                    UserAnnotation()
//
//                    // Custom annotation for selected pin
//                    Annotation("Selected", coordinate: selectedCoordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                            .foregroundColor(.red)
//                            .shadow(radius: 4)
//                    }
//
//                    // Predefined Locations
//                    ForEach(predefinedLocations, id: \.name) { place in
//                        Annotation(place.name, coordinate: place.coordinate) {
//                            VStack {
//                                Image(systemName: "building.columns.fill")
//                                    .resizable()
//                                    .frame(width: 20, height: 20)
//                                    .foregroundColor(place.color)
//                                Text(place.name)
//                                    .font(.caption)
//                                    .fixedSize()
//                            }
//                            .onTapGesture {
//                                selectedCoordinate = place.coordinate
//                                locationName = place.name
//                            }
//                        }
//                    }
//                }
//                .mapControls {
//                    MapCompass()
//                    MapUserLocationButton()
//                    MapPitchToggle()
//                }
//                .frame(height: 350)
//                .clipShape(RoundedRectangle(cornerRadius: 16))
//                .padding()
//
//                Button("Confirm Location") {
//                    selectedCoordinate = region.center
//                    reverseGeocode(coordinate: selectedCoordinate)
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//                .padding()
//
//                Spacer()
//            }
//            .navigationTitle("Select Location on Campus")
//            .onAppear {
//                region.center = selectedCoordinate
//                locationManager.requestLocationAccess()
//            }
//        }
//    }
//
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                let parts = [place.name, place.locality]
//                locationName = parts.compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("❌ Reverse geocode failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}
//
//// MARK: - Location Manager
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let manager = CLLocationManager()
//
//    override init() {
//        super.init()
//        manager.delegate = self
//    }
//
//    func requestLocationAccess() {
//        manager.requestWhenInUseAuthorization()
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        if manager.authorizationStatus == .authorizedWhenInUse {
//            manager.startUpdatingLocation()
//        }
//    }
//}

//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//struct CampusMapPickerView: View {
//    @Environment(\.dismiss) private var dismiss
//    @Binding var selectedCoordinate: CLLocationCoordinate2D
//    @Binding var locationName: String
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//    )
//
//    @State private var mapType: MKMapType = .standard
//    @State private var pinScale: CGFloat = 0.1
//    @StateObject private var locationManager = LocationManager()
//
//    var predefinedLocations: [(name: String, coordinate: CLLocationCoordinate2D, color: Color)] = [
//        ("Snell Library", CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), .red),
//        ("ISEC", CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), .orange),
//        ("Curry Center", CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), .yellow),
//        ("Behrakis", CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), .green),
//        ("Marino Center", CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), .blue)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Picker("Map Style", selection: $mapType) {
//                    Text("Standard").tag(MKMapType.standard)
//                    Text("Hybrid").tag(MKMapType.hybrid)
//                    Text("Satellite").tag(MKMapType.satellite)
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding(.horizontal)
//
//                ZStack {
//                    // Optional: Custom campus map image overlay
//                    Image("CampusOverlay")
//                        .resizable()
//                        .scaledToFill()
//                        .opacity(0.25)
//                        .edgesIgnoringSafeArea(.all)
//
//                    Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .none, annotationItems: predefinedLocations + [("Selected", selectedCoordinate, .red)]) { location in
//                        MapAnnotation(coordinate: location.1) {
//                            VStack {
//                                Image(systemName: location.0 == "Selected" ? "mappin.circle.fill" : "building.columns")
//                                    .resizable()
//                                    .frame(width: 28, height: 28)
//                                    .foregroundColor(location.2)
//                                    .scaleEffect(location.0 == "Selected" ? pinScale : 1.0)
//                                    .onAppear {
//                                        if location.0 == "Selected" {
//                                            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.3)) {
//                                                pinScale = 1.0
//                                            }
//                                        }
//                                    }
//                                if location.0 != "Selected" {
//                                    Text(location.0)
//                                        .font(.caption)
//                                        .background(Color.white.opacity(0.7))
//                                        .clipShape(RoundedRectangle(cornerRadius: 4))
//                                }
//                            }
//                            .onTapGesture {
//                                selectedCoordinate = location.1
//                                locationName = location.0
//                            }
//                        }
//                    }
//                    .mapStyle(mapType)
//                    .frame(height: 350)
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
//                    .padding(.horizontal)
//                }
//
//                Button("Confirm Location") {
//                    selectedCoordinate = region.center
//                    reverseGeocode(coordinate: selectedCoordinate)
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//                .padding()
//
//                Spacer()
//            }
//            .navigationTitle("Select Location")
//            .onAppear {
//                locationManager.requestLocationAccess()
//                region.center = selectedCoordinate
//            }
//        }
//    }
//
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                let parts = [place.name, place.locality]
//                locationName = parts.compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("❌ Reverse geocode failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let manager = CLLocationManager()
//
//    override init() {
//        super.init()
//        manager.delegate = self
//    }
//
//    func requestLocationAccess() {
//        manager.requestWhenInUseAuthorization()
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        if manager.authorizationStatus == .authorizedWhenInUse {
//            manager.startUpdatingLocation()
//        }
//    }
//}


//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//struct CampusMapPickerView: View {
//    @Environment(\.dismiss) private var dismiss
//    @Binding var selectedCoordinate: CLLocationCoordinate2D
//    @Binding var locationName: String
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//    )
//
//    @State private var lastRegionCenter = CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892)
//    @State private var mapStyle: MapDisplayStyle = .standard
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 20) {
//                Text("Tap Confirm after centering the location")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                Picker("Map Style", selection: $mapStyle) {
//                    ForEach(MapDisplayStyle.allCases, id: \.self) { style in
//                        Text(style.label).tag(style)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding(.horizontal)
//
//                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, annotationItems: [MapItem(id: UUID(), title: "Selected", coordinate: selectedCoordinate, isLost: true)]) { item in
//                    MapAnnotation(coordinate: item.coordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                            .foregroundColor(item.isLost ? .red : .green)
//                            .shadow(radius: 3)
//                            .animation(.easeInOut(duration: 0.3), value: item.coordinate)
//                    }
//                }
//                .mapStyle(mapStyle.mapType)
//                .frame(height: 300)
//                .cornerRadius(12)
//                .onAppear {
//                    selectedCoordinate = region.center
//                    reverseGeocode(coordinate: region.center)
//                }
//                .onReceive(Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()) { _ in
//                    if region.center.latitude != selectedCoordinate.latitude ||
//                        region.center.longitude != selectedCoordinate.longitude {
//                        selectedCoordinate = region.center
//                        reverseGeocode(coordinate: region.center)
//                    }
//                }
//
//                Button("Confirm Location") {
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
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                let parts = [place.name, place.locality]
//                locationName = parts.compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("❌ Geocoding failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}
//
//enum MapDisplayStyle: String, CaseIterable, Hashable {
//    case standard
//    case hybrid
//    case satellite
//
//    var mapType: MKMapType {
//        switch self {
//        case .standard: return .standard
//        case .hybrid: return .hybrid
//        case .satellite: return .satellite
//        }
//    }
//
//    var label: String {
//        switch self {
//        case .standard: return "Standard"
//        case .hybrid: return "Hybrid"
//        case .satellite: return "Satellite"
//        }
//    }
//}
//
//


//import SwiftUI
//import MapKit
//import CoreLocation
//
//
//
//// MARK: - CampusMapPickerView
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
//    @State private var mapStyle: MapStyle = .standard
//    @State private var showBlueDot = true
//
//    // Predefined campus landmarks
//    let predefinedLocations = [
//        MapItem(title: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), isLost: true),
//        MapItem(title: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), isLost: true),
//        MapItem(title: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), isLost: true),
//        MapItem(title: "Behrakis Center", coordinate: CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), isLost: false),
//        MapItem(title: "Marino Center", coordinate: CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), isLost: false)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                Picker("Map Style", selection: $mapStyle) {
//                    Text("Standard").tag(MapStyle.standard)
//                    Text("Hybrid").tag(MapStyle.hybrid)
//                    Text("Imagery").tag(MapStyle.imagery)
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                Map(position: $cameraPosition, style: mapStyle) {
//                    Annotation("Selected", coordinate: selectedCoordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.red)
//                            .shadow(radius: 3)
//                            .animation(.easeInOut(duration: 0.3), value: selectedCoordinate)
//                    }
//
//                    ForEach(predefinedLocations) { item in
//                        Annotation(item.title, coordinate: item.coordinate) {
//                            VStack {
//                                Image(systemName: item.isLost ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
//                                    .foregroundColor(item.isLost ? .orange : .green)
//                                Text(item.title)
//                                    .font(.caption)
//                                    .foregroundColor(.primary)
//                            }
//                        }
//                    }
//                }
//                .mapControls {
//                    MapUserLocationButton()
//                    MapCompass()
//                    MapPitchToggle()
//                }
//                .frame(height: 350)
//                .cornerRadius(12)
//                .padding()
//                .onChange(of: cameraPosition) { newPosition in
//                    if case let .region(region) = newPosition {
//                        selectedCoordinate = region.center
//                        reverseGeocode(coordinate: region.center)
//                    }
//                }
//
//                Button("Confirm Location") {
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//        }
//    }
//
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                locationName = [place.name, place.locality].compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("Reverse geocoding failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}


//import SwiftUI
//import MapKit
//import CoreLocation
//
//
//
//// MARK: - Extend MapStyle to be Hashable for Picker compatibility
//extension MapStyle: Hashable {
//    public static func == (lhs: MapStyle, rhs: MapStyle) -> Bool {
//        String(describing: lhs) == String(describing: rhs)
//    }
//
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(String(describing: self))
//    }
//}
//
//// MARK: - Campus Map Picker
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
//    @State private var mapStyle: MapStyle = .standard
//
//    let predefinedLocations = [
//        MapItem(title: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), isLost: true),
//        MapItem(title: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), isLost: true),
//        MapItem(title: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), isLost: true),
//        MapItem(title: "Behrakis Center", coordinate: CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), isLost: false),
//        MapItem(title: "Marino Center", coordinate: CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), isLost: false)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                Picker("Map Style", selection: $mapStyle) {
//                    Text("Standard").tag(MapStyle.standard)
//                    Text("Hybrid").tag(MapStyle.hybrid)
//                    Text("Satellite").tag(MapStyle.imagery)
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                Map(position: $cameraPosition, style: mapStyle) {
//                    // Selected Marker
//                    Annotation("Selected", coordinate: selectedCoordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.red)
//                            .shadow(radius: 3)
//                            .animation(.easeInOut, value: selectedCoordinate)
//                    }
//
//                    // Predefined Landmarks
//                    ForEach(predefinedLocations) { item in
//                        Annotation(item.title, coordinate: item.coordinate) {
//                            VStack(spacing: 4) {
//                                Image(systemName: item.isLost ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
//                                    .foregroundColor(item.isLost ? .orange : .green)
//                                    .imageScale(.large)
//                                Text(item.title)
//                                    .font(.caption2)
//                                    .multilineTextAlignment(.center)
//                            }
//                        }
//                    }
//                }
//                .mapControls {
//                    MapUserLocationButton()
//                    MapCompass()
//                    MapScaleView()
//                    MapPitchToggle()
//                }
//                .frame(height: 350)
//                .cornerRadius(12)
//                .padding(.horizontal)
//                .onChange(of: cameraPosition) { newPosition in
//                    if case let .region(region) = newPosition {
//                        selectedCoordinate = region.center
//                        reverseGeocode(coordinate: region.center)
//                    }
//                }
//
//                Button("Confirm Location") {
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//        }
//    }
//
//    // MARK: Reverse Geocoding
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                locationName = [place.name, place.locality].compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("❌ Reverse geocoding failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}
//
//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//// MARK: - MapStyleWrapper for safe use in Picker
//enum MapStyleOption: String, CaseIterable, Hashable {
//    case standard = "Standard"
//    case hybrid = "Hybrid"
//    case imagery = "Satellite"
//
//    var style: MapStyle {
//        switch self {
//        case .standard: return .standard
//        case .hybrid: return .hybrid
//        case .imagery: return .imagery
//        }
//    }
//}
//
//
//
//// MARK: - CampusMapPickerView
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
//    @State private var mapStyle: MapStyleOption = .standard
//
//    // Predefined locations
//    let predefinedLocations = [
//        MapItem(title: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), isLost: true),
//        MapItem(title: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), isLost: true),
//        MapItem(title: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), isLost: true),
//        MapItem(title: "Behrakis Center", coordinate: CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), isLost: false),
//        MapItem(title: "Marino Center", coordinate: CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), isLost: false)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                Picker("Map Style", selection: $mapStyle) {
//                    ForEach(MapStyleOption.allCases, id: \.self) { style in
//                        Text(style.rawValue).tag(style)
//                    }
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                Map(position: $cameraPosition, style: mapStyle.style) {
//                    // User Pin
//                    Annotation("Selected", coordinate: selectedCoordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.red)
//                            .shadow(radius: 3)
//                    }
//
//                    // Campus Pins
//                    ForEach(predefinedLocations) { item in
//                        Annotation(item.title, coordinate: item.coordinate) {
//                            VStack(spacing: 4) {
//                                Image(systemName: item.isLost ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
//                                    .foregroundColor(item.isLost ? .orange : .green)
//                                    .imageScale(.large)
//                                Text(item.title)
//                                    .font(.caption2)
//                                    .multilineTextAlignment(.center)
//                            }
//                        }
//                    }
//                }
//                .mapControls {
//                    MapUserLocationButton()
//                    MapCompass()
//                    MapScaleView()
//                }
//                .frame(height: 350)
//                .cornerRadius(12)
//                .padding(.horizontal)
//                .onChange(of: cameraPosition) { newPosition in
//                    if case let .region(region) = newPosition {
//                        selectedCoordinate = region.center
//                        reverseGeocode(coordinate: region.center)
//                    }
//                }
//
//                Button("Confirm Location") {
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//        }
//    }
//
//    // MARK: Reverse Geocoding
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                locationName = [place.name, place.locality].compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("❌ Reverse geocoding failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}
//
//import SwiftUI
//import MapKit
//import CoreLocation
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
//    @State private var mapStyle: MapStyle = .standard
//
//    let predefinedLocations: [MapItem] = [
//        MapItem(id: UUID(), title: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), isLost: true),
//        MapItem(id: UUID(), title: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), isLost: true),
//        MapItem(id: UUID(), title: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), isLost: true),
//        MapItem(id: UUID(), title: "Behrakis Center", coordinate: CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), isLost: false),
//        MapItem(id: UUID(), title: "Marino Center", coordinate: CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), isLost: false)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                Picker("Map Style", selection: $mapStyle) {
//                    Text("Standard").tag(MapStyle.standard)
//                    Text("Hybrid").tag(MapStyle.hybrid)
//                    Text("Imagery").tag(MapStyle.imagery)
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                Map(position: $cameraPosition, style: mapStyle) {
//                    Annotation("Selected", coordinate: selectedCoordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.red)
//                            .shadow(radius: 3)
//                    }
//
//                    ForEach(predefinedLocations) { item in
//                        Annotation(item.title, coordinate: item.coordinate) {
//                            VStack {
//                                Image(systemName: item.isLost ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
//                                    .foregroundColor(item.isLost ? .orange : .green)
//                                Text(item.title)
//                                    .font(.caption)
//                            }
//                        }
//                    }
//                }
//                .mapControls {
//                    MapUserLocationButton()
//                    MapCompass()
//                    MapPitchToggle()
//                    MapScaleView()
//                }
//                .frame(height: 350)
//                .cornerRadius(12)
//                .padding()
//                .onChange(of: cameraPosition) { newPosition in
//                    if case let .region(region) = newPosition {
//                        selectedCoordinate = region.center
//                        reverseGeocode(coordinate: region.center)
//                    }
//                }
//
//                Button("Confirm Location") {
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//        }
//    }
//
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
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
//// MARK: - Enum for Map Style Picker
//enum MapDisplayStyle: String, CaseIterable, Hashable {
//    case standard
//    case hybrid
//    case imagery
//
//    var mapStyle: MapStyle {
//        switch self {
//        case .standard: return .standard
//        case .hybrid: return .hybrid
//        case .imagery: return .imagery
//        }
//    }
//}
//
//// MARK: - CampusMapPickerView
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
//    @State private var selectedMapStyle: MapDisplayStyle = .standard
//
//    // MARK: - Predefined campus landmarks
//    let predefinedLocations = [
//        MapItem(id: UUID(), title: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), isLost: true),
//        MapItem(id: UUID(), title: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), isLost: true),
//        MapItem(id: UUID(), title: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), isLost: true),
//        MapItem(id: UUID(), title: "Behrakis Center", coordinate: CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), isLost: false),
//        MapItem(id: UUID(), title: "Marino Center", coordinate: CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), isLost: false)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                // Picker for map style
//                Picker("Map Style", selection: $selectedMapStyle) {
//                    ForEach(MapDisplayStyle.allCases, id: \.self) { style in
//                        Text(style.rawValue.capitalized).tag(style)
//                    }
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                // Map with annotations
//                Map(position: $cameraPosition, style: selectedMapStyle.mapStyle) {
//                    // Pin user-selected coordinate
//                    Annotation("Selected", coordinate: selectedCoordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.red)
//                            .shadow(radius: 3)
//                            .animation(.easeInOut, value: selectedCoordinate)
//                    }
//
//                    // Predefined campus pins
//                    ForEach(predefinedLocations) { item in
//                        Annotation(item.title, coordinate: item.coordinate) {
//                            VStack(spacing: 2) {
//                                Image(systemName: item.isLost ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
//                                    .foregroundColor(item.isLost ? .orange : .green)
//                                Text(item.title)
//                                    .font(.caption2)
//                                    .foregroundColor(.primary)
//                            }
//                        }
//                    }
//                }
//                .mapControls {
//                    MapUserLocationButton()
//                    MapCompass()
//                    MapPitchToggle()
//                    MapScaleView()
//                }
//                .frame(height: 350)
//                .cornerRadius(12)
//                .padding()
//                .onChange(of: cameraPosition) { newPosition in
//                    if case let .region(region) = newPosition {
//                        selectedCoordinate = region.center
//                        reverseGeocode(coordinate: region.center)
//                    }
//                }
//
//                Button("Confirm Location") {
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//            .onAppear {
//                reverseGeocode(coordinate: selectedCoordinate)
//            }
//        }
//    }
//
//    // MARK: - Reverse Geocode
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                let parts = [place.name, place.locality]
//                locationName = parts.compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("❌ Reverse geocoding failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}


//import SwiftUI
//import MapKit
//import CoreLocation
//
//// MARK: - Equatable extension for CLLocationCoordinate2D
//extension CLLocationCoordinate2D: Equatable {
//    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
//        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
//    }
//}
//
//// MARK: - CampusMapPickerView
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
//    @State private var showBlueDot = true
//    @State private var mapStyle: MapStyle = .standard
//
//    let predefinedLocations: [MapItem] = [
//        MapItem(id: UUID(), title: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), isLost: true),
//        MapItem(id: UUID(), title: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), isLost: true),
//        MapItem(id: UUID(), title: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), isLost: true),
//        MapItem(id: UUID(), title: "Behrakis Center", coordinate: CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), isLost: false),
//        MapItem(id: UUID(), title: "Marino Center", coordinate: CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), isLost: false)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                Picker("Map Style", selection: $mapStyle) {
//                    Text("Standard").tag(MapStyle.standard)
//                    Text("Hybrid").tag(MapStyle.hybrid)
//                    Text("Imagery").tag(MapStyle.imagery)
//                }
//                .pickerStyle(.segmented)
//                .padding(.horizontal)
//
//                Map(position: $cameraPosition, style: mapStyle) {
//                    Annotation("Selected", coordinate: selectedCoordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.red)
//                    }
//
//                    ForEach(predefinedLocations) { item in
//                        Annotation(item.title, coordinate: item.coordinate) {
//                            VStack {
//                                Image(systemName: item.isLost ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
//                                    .foregroundColor(item.isLost ? .orange : .green)
//                                Text(item.title)
//                                    .font(.caption)
//                                    .foregroundColor(.primary)
//                            }
//                        }
//                    }
//                }
//                .mapControls {
//                    MapUserLocationButton()
//                    MapCompass()
//                    MapPitchToggle()
//                    MapScaleView()
//                }
//                .frame(height: 350)
//                .cornerRadius(12)
//                .padding()
//                .onChange(of: cameraPosition) { newPosition in
//                    if case let .region(region) = newPosition {
//                        selectedCoordinate = region.center
//                        reverseGeocode(coordinate: region.center)
//                    }
//                }
//
//                Button("Confirm Location") {
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//        }
//    }
//
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                locationName = [place.name, place.locality].compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("Reverse geocoding failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}


//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//// MARK: - Equatable extension for CLLocationCoordinate2D
//extension CLLocationCoordinate2D: Equatable {
//    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
//        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
//    }
//}
//
//// MARK: - CampusMapPickerView
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
//    // Predefined Northeastern landmarks
//    let predefinedLocations: [MapItem] = [
//        MapItem(id: UUID(), title: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), isLost: true),
//        MapItem(id: UUID(), title: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), isLost: true),
//        MapItem(id: UUID(), title: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), isLost: true),
//        MapItem(id: UUID(), title: "Behrakis Center", coordinate: CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), isLost: false),
//        MapItem(id: UUID(), title: "Marino Center", coordinate: CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), isLost: false)
//    ]
//    
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                // Live map with default standard style
//                Map(position: $cameraPosition) {
//                    Annotation("Selected", coordinate: selectedCoordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.red)
//                    }
//                    
//                    ForEach(predefinedLocations) { item in
//                        Annotation(item.title, coordinate: item.coordinate) {
//                            VStack {
//                                Image(systemName: item.isLost ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
//                                    .foregroundColor(item.isLost ? .orange : .green)
//                                Text(item.title)
//                                    .font(.caption)
//                                    .foregroundColor(.primary)
//                            }
//                        }
//                    }
//                }
//                .mapControls {
//                    MapUserLocationButton()
//                    MapCompass()
//                    MapPitchToggle()
//                    MapScaleView()
//                }
//                .frame(height: 350)
//                .cornerRadius(12)
//                .padding()
//                .onChange(of: cameraPosition) { newPosition in
//                    if let region = (cameraPosition as? MapCameraPosition.Region)?.region {
//                        selectedCoordinate = region.center
//                        reverseGeocode(coordinate: region.center)
//                    }
//                    
//                    Button("Confirm Location") {
//                        dismiss()
//                    }
//                    .buttonStyle(.borderedProminent)
//                    
//                    Spacer()
//                }
//                .navigationTitle("Campus Map")
//            }
//        }
//
//    
//        private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//                if let place = placemarks?.first {
//                    locationName = [place.name, place.locality].compactMap { $0 }.joined(separator: ", ")
//                } else if let error = error {
//                    print("❌ Reverse geocoding failed: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//}



//import SwiftUI
//import MapKit
//import CoreLocation
//
//extension CLLocationCoordinate2D: Equatable {
//    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
//        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
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
//    let predefinedLocations: [MapItem] = [
//        MapItem(id: UUID(), title: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), isLost: true),
//        MapItem(id: UUID(), title: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), isLost: true),
//        MapItem(id: UUID(), title: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), isLost: true),
//        MapItem(id: UUID(), title: "Behrakis Center", coordinate: CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), isLost: false),
//        MapItem(id: UUID(), title: "Marino Center", coordinate: CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), isLost: false)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                Text("Center the location and tap Confirm")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                Map(position: $cameraPosition) {
//                    Annotation("Selected", coordinate: selectedCoordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.red)
//                    }
//
//                    ForEach(predefinedLocations) { item in
//                        Annotation(item.title, coordinate: item.coordinate) {
//                            VStack {
//                                Image(systemName: item.isLost ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
//                                    .foregroundColor(item.isLost ? .orange : .green)
//                                Text(item.title)
//                                    .font(.caption)
//                            }
//                        }
//                    }
//                }
//                .mapControls {
//                    MapUserLocationButton()
//                    MapCompass()
//                    MapScaleView()
//                }
//                .frame(height: 350)
//                .cornerRadius(12)
//                .padding()
//                .onChange(of: cameraPosition) { newPosition in
//                    switch newPosition {
//                    case .region( let region):
//                        selectedCoordinate = region.center
//                        reverseGeocode(coordinate: region.center)
//                    default:
//                        break
//                    }
//                }
//                Button("Confirm Location") {
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//        }
//    }
//
//    // ✅ FIX: Must be outside the ViewBuilder
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                locationName = [place.name, place.locality].compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("Reverse geocoding failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}


//import SwiftUI
//import MapKit
//import CoreLocation
//
//// MARK: - CLLocationCoordinate2D Equatable
//extension CLLocationCoordinate2D: Equatable {
//    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
//        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
//    }
//}
//
//// MARK: - CampusMapPickerView
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
//    let predefinedLocations: [MapItem] = [
//        MapItem(id: UUID(), title: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), isLost: true),
//        MapItem(id: UUID(), title: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), isLost: true),
//        MapItem(id: UUID(), title: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), isLost: true),
//        MapItem(id: UUID(), title: "Behrakis Center", coordinate: CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), isLost: false),
//        MapItem(id: UUID(), title: "Marino Center", coordinate: CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), isLost: false)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                Text("Center the map and tap Confirm")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                Map(position: $cameraPosition) {
//                    Annotation("Selected", coordinate: selectedCoordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.red)
//                    }
//
//                    ForEach(predefinedLocations) { item in
//                        Annotation(item.title, coordinate: item.coordinate) {
//                            VStack(spacing: 4) {
//                                Image(systemName: item.isLost ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
//                                    .foregroundColor(item.isLost ? .orange : .green)
//                                Text(item.title)
//                                    .font(.caption2)
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(.primary)
//                            }
//                        }
//                    }
//                }
//                .mapControls {
//                    MapUserLocationButton()
//                    MapCompass()
//                    MapScaleView()
//                }
//                .frame(height: 350)
//                .cornerRadius(12)
//                .padding(.horizontal)
//                .onChange(of: cameraPosition, perform: updateCoordinateFromCamera)
//
//                Button("Confirm Location") {
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//        }
//    }
//
//    private func updateCoordinateFromCamera(_ newPosition: MapCameraPosition) {
//        if case .region(let region) = newPosition{
//            selectedCoordinate = region.center
//            reverseGeocode(coordinate: region.center)
//        }
//    }
//
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                locationName = [place.name, place.locality].compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("Reverse geocoding failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}


//import SwiftUI
//import MapKit
//import CoreLocation
//
//// MARK: - CLLocationCoordinate2D Equatable
//extension CLLocationCoordinate2D: Equatable {
//    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
//        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
//    }
//}
//
//// MARK: - CampusMapPickerView
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
//    let predefinedLocations: [MapItem] = [
//        MapItem(id: UUID(), title: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), isLost: true),
//        MapItem(id: UUID(), title: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), isLost: true),
//        MapItem(id: UUID(), title: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), isLost: true),
//        MapItem(id: UUID(), title: "Behrakis Center", coordinate: CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), isLost: false),
//        MapItem(id: UUID(), title: "Marino Center", coordinate: CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), isLost: false)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                Text("Center the map and tap Confirm")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                Map(position: $cameraPosition) {
//                    Annotation("Selected", coordinate: selectedCoordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.red)
//                    }
//
//                    ForEach(predefinedLocations) { item in
//                        Annotation(item.title, coordinate: item.coordinate) {
//                            VStack(spacing: 4) {
//                                Image(systemName: item.isLost ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
//                                    .foregroundColor(item.isLost ? .orange : .green)
//                                Text(item.title)
//                                    .font(.caption2)
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(.primary)
//                            }
//                        }
//                    }
//                }
//                .mapControls {
//                    MapUserLocationButton()
//                    MapCompass()
//                    MapScaleView()
//                }
//                .frame(height: 350)
//                .cornerRadius(12)
//                .padding(.horizontal)
//                .onChange(of: cameraPosition) { newPosition in
//                    if case .region(let region) = newPosition {
//                        selectedCoordinate = region.center
//                        reverseGeocode(coordinate: region.center)
//                    }
//                }
//
//                Button("Confirm Location") {
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//        }
//    }
//
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                locationName = [place.name, place.locality].compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("Reverse geocoding failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}


//import SwiftUI
//import MapKit
//import CoreLocation
//
//// MARK: - CLLocationCoordinate2D Equatable
//extension CLLocationCoordinate2D: Equatable {
//    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
//        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
//    }
//}
//
//// MARK: - CampusMapPickerView
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
//    let predefinedLocations: [MapItem] = [
//        MapItem(id: UUID(), title: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), isLost: true),
//        MapItem(id: UUID(), title: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), isLost: true),
//        MapItem(id: UUID(), title: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), isLost: true),
//        MapItem(id: UUID(), title: "Behrakis Center", coordinate: CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), isLost: false),
//        MapItem(id: UUID(), title: "Marino Center", coordinate: CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), isLost: false)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                Text("Center the map and tap Confirm")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                Map(position: $cameraPosition) {
//                    Annotation("Selected", coordinate: selectedCoordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.red)
//                    }
//
//                    ForEach(predefinedLocations) { item in
//                        Annotation(item.title, coordinate: item.coordinate) {
//                            VStack(spacing: 4) {
//                                Image(systemName: item.isLost ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
//                                    .foregroundColor(item.isLost ? .orange : .green)
//                                Text(item.title)
//                                    .font(.caption2)
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(.primary)
//                            }
//                        }
//                    }
//                }
//                .mapControls {
//                    MapUserLocationButton()
//                    MapCompass()
//                    MapScaleView()
//                }
//                .frame(height: 350)
//                .cornerRadius(12)
//                .padding(.horizontal)
//                .onChange(of: cameraPosition, perform: updateCoordinateFromCamera)
//
//                Button("Confirm Location") {
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//        }
//    }
//
//    // MARK: - Coordinate + Geocoding Helpers
//    private func updateCoordinateFromCamera(_ newPosition: MapCameraPosition) {
//        switch newPosition {
//        case .region(let region):
//            selectedCoordinate = region.center
//            reverseGeocode(coordinate: region.center)
//        default:
//            break
//        }
//    }
//
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                locationName = [place.name, place.locality].compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("Reverse geocoding failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}


//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//// MARK: - CLLocationCoordinate2D Equatable
//extension CLLocationCoordinate2D: Equatable {
//    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
//        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
//    }
//}
//
//// MARK: - CampusMapPickerView
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
//    // Predefined Northeastern locations
//    let predefinedLocations: [MapItem] = [
//        MapItem(id: UUID(), title: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), isLost: true),
//        MapItem(id: UUID(), title: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), isLost: true),
//        MapItem(id: UUID(), title: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), isLost: true),
//        MapItem(id: UUID(), title: "Behrakis Center", coordinate: CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), isLost: false),
//        MapItem(id: UUID(), title: "Marino Center", coordinate: CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), isLost: false)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                Text("Center the map and tap Confirm")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                Map(position: $cameraPosition) {
//                    Annotation("Selected", coordinate: selectedCoordinate) {
//                        Image(systemName: "mappin.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.red)
//                    }
//
//                    ForEach(predefinedLocations) { item in
//                        Annotation(item.title, coordinate: item.coordinate) {
//                            VStack(spacing: 4) {
//                                Image(systemName: item.isLost ? "exclamationmark.circle.fill" : "checkmark.circle.fill")
//                                    .foregroundColor(item.isLost ? .orange : .green)
//                                Text(item.title)
//                                    .font(.caption2)
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(.primary)
//                            }
//                        }
//                    }
//                }
//                .mapControls {
//                    MapUserLocationButton()
//                    MapCompass()
//                    MapScaleView()
//                }
//                .frame(height: 350)
//                .cornerRadius(12)
//                .padding(.horizontal)
//                .onChange(of: cameraPosition, perform: updateCoordinateFromCamera)
//
//                Button("Confirm Location") {
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//        }
//    }
//
//    // MARK: - Helpers
//
//    private func updateCoordinateFromCamera(_ newPosition: MapCameraPosition) {
//        if case .region(let region) = newPosition {
//            selectedCoordinate = region.center
//            reverseGeocode(coordinate: region.center)
//        }
//    }
//
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                locationName = [place.name, place.locality].compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("Reverse geocoding failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}

//
//import SwiftUI
//import MapKit
//import CoreLocation
//
//// MARK: - CLLocationCoordinate2D Equatable
//extension CLLocationCoordinate2D: Equatable {
//    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
//        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
//    }
//}
//
//// MARK: - CampusMapPickerView
//struct CampusMapPickerView: View {
//    @Environment(\.dismiss) private var dismiss
//    @Binding var selectedCoordinate: CLLocationCoordinate2D
//    @Binding var locationName: String
//
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
//        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//    )
//
//    let predefinedLocations: [MapItem] = [
//        MapItem(id: UUID(), title: "Snell Library", coordinate: CLLocationCoordinate2D(latitude: 42.3334, longitude: -71.0806), isLost: true),
//        MapItem(id: UUID(), title: "ISEC", coordinate: CLLocationCoordinate2D(latitude: 42.3377, longitude: -71.0870), isLost: true),
//        MapItem(id: UUID(), title: "Curry Student Center", coordinate: CLLocationCoordinate2D(latitude: 42.33906, longitude: -71.0874986), isLost: true),
//        MapItem(id: UUID(), title: "Behrakis Center", coordinate: CLLocationCoordinate2D(latitude: 42.3369994, longitude: -71.0913747), isLost: false),
//        MapItem(id: UUID(), title: "Marino Center", coordinate: CLLocationCoordinate2D(latitude: 42.3401925, longitude: -71.0903077), isLost: false)
//    ]
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                Text("Drag map and tap Confirm")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: predefinedLocations + [MapItem(id: UUID(), title: "Selected", coordinate: selectedCoordinate, isLost: true)]) { item in
//                    MapAnnotation(coordinate: item.coordinate) {
//                        VStack(spacing: 4) {
//                            Image(systemName: item.title == "Selected" ? "mappin.circle.fill" : (item.isLost ? "exclamationmark.circle.fill" : "checkmark.circle.fill"))
//                                .foregroundColor(item.title == "Selected" ? .red : (item.isLost ? .orange : .green))
//                                .font(.title)
//                            if item.title != "Selected" {
//                                Text(item.title)
//                                    .font(.caption2)
//                                    .multilineTextAlignment(.center)
//                            }
//                        }
//                    }
//                }
//                .frame(height: 350)
//                .cornerRadius(12)
//                .padding(.horizontal)
//                .onAppear {
//                    updateSelectedCoordinate(from: region.center)
//                }
//                .onChange(of: region.center) { newCenter in
//                    updateSelectedCoordinate(from: newCenter)
//                }
//
//                Button("Confirm Location") {
//                    dismiss()
//                }
//                .buttonStyle(.borderedProminent)
//
//                Spacer()
//            }
//            .navigationTitle("Campus Map")
//        }
//    }
//
//    private func updateSelectedCoordinate(from center: CLLocationCoordinate2D) {
//        selectedCoordinate = center
//        reverseGeocode(coordinate: center)
//    }
//
//    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            if let place = placemarks?.first {
//                locationName = [place.name, place.locality].compactMap { $0 }.joined(separator: ", ")
//            } else if let error = error {
//                print("Reverse geocoding failed: \(error.localizedDescription)")
//            }
//        }
//    }
//}
import SwiftUI
import MapKit
import CoreLocation

#if canImport(UIKit)
import UIKit
#endif

// MARK: – Make core types Equatable so SwiftUI onChange works
extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center == rhs.center && lhs.span.latitudeDelta == rhs.span.latitudeDelta && lhs.span.longitudeDelta == rhs.span.longitudeDelta
    }
}

// MARK: – Simple model for your major campus landmarks
private struct CampusLandmark {
    let name: String
    let coordinate: CLLocationCoordinate2D
}

// A single center‐pin annotation
private struct CenterPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct CampusMapPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedCoordinate: CLLocationCoordinate2D
    @Binding var locationName: String

    // 1) Initialize on NEU Boston center
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42.3398, longitude: -71.0892),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )

    // 2) Your list of major Northeastern landmarks
    private let landmarks: [CampusLandmark] = [
        .init(name: "Snell Library",     coordinate: .init(latitude: 42.3334,   longitude: -71.0806)),
        .init(name: "ISEC",              coordinate: .init(latitude: 42.3377,   longitude: -71.0870)),
        .init(name: "Curry Student Ctr", coordinate: .init(latitude: 42.33906,  longitude: -71.0874986)),
        .init(name: "Behrakis Center",   coordinate: .init(latitude: 42.3369994,longitude: -71.0913747)),
        .init(name: "Marino Center",     coordinate: .init(latitude: 42.3401925,longitude: -71.0903077))
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Drag the map to position the pin,\nthen tap Confirm")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)

                // 3) A Map with a single annotation at its center
                Map(
                    coordinateRegion: $region,
                    interactionModes: .all,
                    showsUserLocation: true,
                    annotationItems: [CenterPin(coordinate: region.center)]
                ) { pin in
                    MapMarker(coordinate: pin.coordinate, tint: .red)
                }
                .frame(height: 300)
                .cornerRadius(12)
                .padding(.horizontal)
                // 4) Watch the entire region for changes
                .onChange(of: region) { newRegion in
                    detectLandmark(at: newRegion.center)
                }

                Button("Confirm Location") {
                    // 5) Save final coordinate
                    selectedCoordinate = region.center

                    // if we already snapped to a landmark name, skip reverse
                    if locationName.isEmpty {
                        reverseGeocode(region.center) { name in
                            if let name = name {
                                locationName = name
                            }
                            dismiss()
                        }
                    } else {
                        dismiss()
                    }
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .navigationTitle("Campus Map")
            .padding(.top)
        }
    }

    /// If within 100 m of a known landmark, assign its name
    private func detectLandmark(at coordinate: CLLocationCoordinate2D) {
        let loc = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        if let nearest = landmarks.min(by: { lhs, rhs in
            let d1 = loc.distance(from: CLLocation(latitude: lhs.coordinate.latitude,  longitude: lhs.coordinate.longitude))
            let d2 = loc.distance(from: CLLocation(latitude: rhs.coordinate.latitude,  longitude: rhs.coordinate.longitude))
            return d1 < d2
        }) {
            let distance = loc.distance(from:
                CLLocation(latitude: nearest.coordinate.latitude, longitude: nearest.coordinate.longitude)
            )
            if distance <= 100 {
                locationName = nearest.name
                return
            }
        }
        // otherwise clear so we can reverse‐geocode on Confirm
        locationName = ""
    }

    /// One‐time reverse‐geocode when Confirmed
    private func reverseGeocode(_ coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
        let loc = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(loc) { placemarks, error in
            guard let place = placemarks?.first else {
                print("❌ Reverse geocode error:", error?.localizedDescription ?? "none")
                completion(nil)
                return
            }
            let parts = [place.name, place.locality].compactMap { $0 }
            completion(parts.joined(separator: ", "))
        }
    }
}
