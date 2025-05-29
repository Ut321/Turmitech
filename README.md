Kitchen Discovery App - Flutter Clean Architecture
A modern Flutter application for discovering local kitchens and meal plans, built with clean architecture principles and beautiful UI design.
🍽️ Features
Core Features

Kitchen Discovery: Browse local kitchens with ratings, addresses, and reviews
Meal Plan Management: Explore featured meal plans with detailed information
Real-time Search: Instantly filter kitchens and meal plans
Favorite Management: Save your favorite kitchens with heart toggle
Offline Support: Access cached data when offline
Network Monitoring: Real-time connectivity status indicator

UI Features

Beautiful Design: Modern card-based interface with smooth animations
Tab Navigation: Easy switching between Discover, Subscriptions, and Profile
Coming Soon Pages: Professional placeholder screens for future features
Responsive Layout: Optimized for different screen sizes
Material Design: Consistent theming throughout the app

🚀 Quick Setup
Prerequisites

Flutter SDK 3.0+
Node.js 16+
Android Studio/VS Code with Flutter extensions

Installation & Run

# 1. Clone repository
git clone https://github.com/yourusername/kitchen-app.git
cd kitchen-app

# 2. Install Flutter dependencies
flutter pub get

# 3. Install JSON Server globally
npm install -g json-server

# 4. Create db.json file (copy content below)

# 5. Start Mock API Server
json-server --watch db.json --port 3000 --host 0.0.0.0

# 6. Run the app
flutter run

 Mock API Setup
Create db.json in project root:


{
  "kitchens": [
    {
      "id": "1",
      "name": "Daily Homestyle Meals",
      "address": "123 Main St, Toronto, ON M5G 1Z4",
      "rating": 4.6,
      "image": "https://images.unsplash.com/photo-1559847844-5315695dadae?w=400&h=300&fit=crop",
      "isFavorite": true
    },
    {
      "id": "2",
      "name": "Mediterranean Delights",
      "address": "456 Oak Ave, Toronto, ON M4K 2R1",
      "rating": 4.8,
      "image": "https://images.unsplash.com/photo-1559847844-5315695dadae?w=400&h=300&fit=crop",
      "isFavorite": false
    },
    {
      "id": "3",
      "name": "Asian Fusion Kitchen",
      "address": "789 Pine St, Toronto, ON M5V 3T8",
      "rating": 4.4,
      "image": "https://images.unsplash.com/photo-1559847844-5315695dadae?w=400&h=300&fit=crop",
      "isFavorite": true
    },
    {
      "id": "4",
      "name": "Healthy Bites",
      "address": "321 Elm St, Toronto, ON M6H 1A2",
      "rating": 4.7,
      "image": "https://images.unsplash.com/photo-1546549032-9571cd6b27df?w=400&h=300&fit=crop",
      "isFavorite": false
    }
  ],
  "mealPlans": [
    {
      "id": "101",
      "title": "Meal Plan 2",
      "itemsCount": 8,
      "kitchenName": "Daily Homestyle Meals",
      "image": "https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=400&h=300&fit=crop"
    },
    {
      "id": "102",
      "title": "Mediterranean Week",
      "itemsCount": 12,
      "kitchenName": "Mediterranean Delights",
      "image": "https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&h=300&fit=crop"
    },
    {
      "id": "103",
      "title": "Asian Fusion Special",
      "itemsCount": 10,
      "kitchenName": "Asian Fusion Kitchen",
      "image": "https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=400&h=300&fit=crop"
    },
    {
      "id": "104",
      "title": "Healthy Living Plan",
      "itemsCount": 14,
      "kitchenName": "Healthy Bites",
      "image": "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&h=300&fit=crop"
    },
    {
      "id": "105",
      "title": "Comfort Food Bundle",
      "itemsCount": 6,
      "kitchenName": "Daily Homestyle Meals",
      "image": "https://images.unsplash.com/photo-1574484284002-952d92456975?w=400&h=300&fit=crop"
    }
  ]
}








Platform Configuration
The app automatically detects your platform and uses the correct API URL:

Android Emulator: http://10.0.2.2:3000
iOS Simulator: http://localhost:3000
Physical Device: http://YOUR_COMPUTER_IP:3000 // NOTE use same network when run


For Physical Device Testing:

Find your computer's IP address:

# Windows
ipconfig

# macOS/Linux
ifconfig


Start server with IP binding:

json-server --watch db.json --port 3000 --host 0.0.0.0


Architecture
Built with Clean Architecture principles:


Architecture Layers:

Domain Layer: Pure business logic and entities
Data Layer: Data sources and repository implementations
Presentation Layer: UI components and state management

Development Commands

# Development
flutter run                    # Run app
flutter hot-reload            # Hot reload (r key)
flutter hot-restart           # Hot restart (R key)

# Testing
flutter test                  # Run all tests
flutter test --coverage      # Run with coverage

# Building
flutter build apk --release   # Build Android APK
flutter build ios --release   # Build iOS

# Debugging
flutter run --debug           # Debug mode
flutter run --verbose         # Verbose logging
flutter doctor               # Check setup
flutter clean                # Clean build files

Dependencies
Core Dependencies

dependencies:
  flutter_riverpod: ^2.4.9      # State management
  dartz: ^0.10.1                # Functional programming
  get_it: ^7.6.4                # Dependency injection
  http: ^1.1.0                  # HTTP client
  equatable: ^2.0.5             # Value equality
  connectivity_plus: ^6.1.4     # Network connectivity

Troubleshooting
Common Issues & Solutions
1. Connection Refused Error
Error: Connection refused (errno = 111)

Solution:

Ensure JSON server is running: json-server --watch db.json --port 3000 --host 0.0.0.0
Check API URL in api_constants.dart

2.JSON Server Command Not Found
json-server: command not found

Solution: npm install -g json-server


Current Features
✅ Kitchen discovery with beautiful cards
✅ Meal plan browsing
✅ Real-time search functionality
✅ Favorite management
✅ Offline data caching
✅ Network status monitoring
✅ Tab navigation
✅ Clean architecture implementation
✅ Responsive design


 Coming Soon
🔄 Subscriptions: Manage meal subscriptions and recurring orders
🔄 Profile Management: User account settings and preferences
🔄 Order History: Track your meal orders
🔄 Push Notifications: Get updates on new kitchens and deals



Happy Coding! 🚀
