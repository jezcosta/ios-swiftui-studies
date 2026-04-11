# AppMusica 🎵

An iOS music application developed as a study project in a course on **iOS Programming**.

## 📱 Description

AppMusica is an application that allows users to search, view, and play music previews from the iTunes API. The app offers a premium audio playback experience with intuitive controls and an elegant interface.

## ✨ Main Features

- **🔍 Music Search**: Search for artists, songs, or albums in real-time
- **▶️ Audio Playback**: Play music previews with play/pause controls
- **❤️ Favorites**: Save your favorite songs locally with SwiftData
- **🎚️ Premium Player**: Modern interface with progress bar and time control
- **📊 NowPlayingBar**: Smooth visualization of playing music at the bottom
- **🎨 Elegant Design**: Interface with glassmorphism and modern gradients

## 🛠️ Technologies Used

### Frameworks & Libraries
- **SwiftUI**: Declarative user interface
- **Combine**: Reactivity and state change observation
- **SwiftData**: Local data persistence (Favorites)
- **AVFoundation**: Audio playback

### Architecture
- **MVVM**: Model-View-ViewModel
- **Environment Objects**: Global state management (AuthFlow, HomeFlow)

### APIs
- **iTunes Search API**: For real-time music search

## 📁 Project Structure

```
AppMusica/
├── AppMusicaApp.swift              # Application entry point
├── Component/
│   ├── NowPlayingBar.swift         # Premium player component at bottom
│   ├── BottomSearchbar.swift       # Bottom search bar
│   ├── PasswordField.swift         # Custom password field
│   └── TextGlassField.swift        # Text field with glassmorphism
├── Model/
│   ├── Music.swift                 # Music model (SwiftData)
│   ├── MusicResponse.swift         # iTunes API response
│   └── UserAccount.swift           # User model
├── Navigation/
│   ├── AppState.swift              # Global state management
│   ├── RootView.swift              # App root view
│   └── Flows/
│       ├── AuthFlowView.swift      # Authentication flow
│       └── HomeFlowView.swift      # Main flow
├── View/
│   ├── MusicListView.swift         # Music list with search
│   ├── PlayerView.swift            # Fullscreen player
│   ├── LoginView.swift             # Login screen
│   ├── RegisterView.swift          # Registration screen
│   ├── HomeView.swift              # Home screen
│   ├── FavoritesView.swift         # Favorite songs
│   └── ProfileView.swift           # User profile
├── ViewModel/
│   ├── LoginViewModel.swift        # Authentication logic
│   └── PlayerViewModel.swift       # Audio player logic
└── Assets.xcassets/                # Visual resources
```

## 🎯 Key Learning Points

### SwiftUI
- ✅ Building declarative interfaces
- ✅ State management with `@State`, `@ObservedObject`, `@EnvironmentObject`
- ✅ Custom modifiers and view builders
- ✅ Animations and transitions

### Combine
- ✅ Using `@Published` for reactivity
- ✅ Observing state changes in real-time
- ✅ Observer pattern with ObservableObject

### SwiftData
- ✅ Local data persistence
- ✅ Queries with `@Query`
- ✅ Models with `@Model`

### AVFoundation
- ✅ Audio session configuration
- ✅ Audio playback with `AVPlayer`
- ✅ Time observation and end-of-playback events
- ✅ Play/pause control

### Networking
- ✅ HTTP requests with `URLSession`
- ✅ JSON decoding
- ✅ Error handling

## 🚀 How to Run

### Requirements
- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd AppMusica
```

2. Open the project in Xcode:
```bash
open AppMusica.xcodeproj
```

3. Select the desired simulator or connect a device

4. Press `Cmd + R` to build and run

## 💡 Implementation Highlights

### Custom UI/UX Design 🎨
All UI layouts, components, and design decisions were personally structured and implemented:
- **NowPlayingBar**: Designed with glassmorphism effects, custom gradients, and premium shadows
- **PlayerView**: Full custom layout with modern gradients and intuitive controls
- **Color Scheme**: Hand-crafted color palette with consistency across the app
- **Animations**: Smooth transitions and micro-interactions designed for better UX
- Every component was thoughtfully designed to create a cohesive and premium experience

### PlayerViewModel - Audio Management
```swift
- Audio session configuration for continuous playback
- Periodic observers for time updates
- Automatic end-of-playback handling
- Proper cleanup to prevent memory leaks
```

### NowPlayingBar - Premium Interface
```swift
- Glassmorphism with shadow effects
- Subtle and refined gradients
- Smooth play/pause animations
- Perfect integration with PlayerView
```

### MusicListView - Real-time Search
```swift
- 500ms debounce on requests
- Automatic player synchronization with music changes
- Favorites support with local persistence
- Responsive and smooth interface
```

## 🎓 iOS Concepts Learned

- ✅ App Navigation with Navigation Stack
- ✅ Sheet presentations and modal views
- ✅ Safe Area insets
- ✅ Environment variables
- ✅ ViewBuilder patterns
- ✅ Async/await with Tasks
- ✅ View lifecycle
- ✅ Memory management with weak references

## 🔧 Future Improvements

- [ ] Backend authentication
- [ ] Cloud synchronization for favorites
- [ ] Offline mode
- [ ] Custom playlists
- [ ] Music sharing
- [ ] Home Screen widget
- [ ] Push notifications

## 📝 Developer Notes

This project was developed as a practical study applying the concepts learned in the **Swift and iOS Programming with SwiftUI** course, covering everything from basic concepts to advanced architecture patterns and state management.

**Important**: Beyond the course content, all UI/UX design, layout structure, and visual components were personally designed and implemented. This includes:
- Custom component creation with premium aesthetics
- Glassmorphism and gradient effects
- Color theory and design decisions
- Responsive layout design
- Animation and interaction design

This demonstrates not only Swift/iOS programming skills but also UI/UX design thinking and implementation capability.

The code maintains best development practices such as:
- Clear separation of concerns
- Clear naming conventions
- Inline documentation where necessary
- Appropriate error handling
- Safe memory management

## 📚 Useful Resources

- [Apple SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [SwiftData Guide](https://developer.apple.com/documentation/swiftdata)
- [Combine Documentation](https://developer.apple.com/documentation/combine)
- [AVFoundation Guide](https://developer.apple.com/documentation/avfoundation)

---

**Developed with ❤️ as a study project in Swift and iOS Programming**
