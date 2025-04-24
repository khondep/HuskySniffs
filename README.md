🐾 HuskySniffs

![image](https://github.com/user-attachments/assets/16ddd6b1-a085-45d2-ab85-442223a8fe88)




HuskySniffs is a SwiftUI-based iOS application built for Northeastern University campus that simplifies reporting, browsing, and recovering lost and found items. It combines Core Data persistence, MapKit integration, and AI-powered matching to provide a seamless experience for both item owners and finders.

📦 Features

Report Lost/Found Items

Capture title, description, photo, and precise campus location via an interactive map picker.

Automatically reverse-geocode to major campus landmarks.

Browse Mode

Lost tab: View a list of reported lost items.

Found tab: View a list of items reported as found by other users.

Map tab: See real-time pins for both lost (🔴) and found (🟢) items centered on Northeastern’s campus.

Re-center button to return map view to default campus region.

Smart AI Matches

Automatically suggests potential matches between lost and found reports based on title, description keywords, and location.

In-App Chat

Dedicated chat sessions for each matched pair, with unread message tracking and AI-driven quick prompts.

Displays partner name (finder or owner) instead of raw session IDs.

Notifications

Notification center to track when new items are reported, lost, or found.

Theming & Branding

Northeastern red accent and dynamic HuskySniffs logo that adapts to light/dark mode.

🚀 Quick Start

Clone the repo:

git clone https://github.com/your-org/HuskySniffs.git
cd HuskySniffs

Open in Xcode:

open HuskySniffs.xcodeproj

Install dependencies: None (all core frameworks: SwiftUI, CoreData, MapKit).

Run on Simulator or Device:

Select a target (e.g., iPhone 14) and hit Run (⌘R).

🏗 Architecture

MVVM + SwiftUI: Views driven by @State, @FetchRequest and observable view models.

Core Data: Local persistence for LostItem, FoundItem, and ChatMessage entities.

MapKit: Campus map with MapAnnotation and MapMarker for geolocations.

Networking: MockDataService fetches and seeds data from MockAPI endpoints, with fallback hard‑coded seed data.

AI Matching: MatchingService computes text and keyword overlaps to find candidate matches.

ChatService: Manages creation, fetching, and read‑status marking of chat messages.

🤝 Contributing

Fork the repository.

Create your feature branch (git checkout -b feature/MyFeature).

Commit your changes (git commit -am 'Add MyFeature').

Push to the branch (git push origin feature/MyFeature).

Open a Pull Request.

Please follow Swift API design guidelines and include unit tests for new features.

