# Food Delivery App

A modern Flutter-based food delivery application with real-time order tracking and Supabase backend integration.

## Project Status

🚧 **Currently in Development** 🚧

Current Version: 0.1.0

## Features

- Browse a variety of food items categorized by type (Burgers, Pizza, Pasta, Salads, Desserts, Drinks)
- Add food items to the cart with optional add-ons
- View cart summary and total price
- Backend powered by Supabase for real-time data synchronization
- Real-time order tracking with live map integration
- Multiple payment methods (Credit Card, PayPal, Apple Pay, Google Pay)
- Dark/Light theme support
- Offline mode capability
- Order scheduling for future delivery
- Group ordering feature

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/Darrylwin/food_delivery.git
   ```
2. Navigate to the project directory:
   ```sh
   cd food_delivery
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```

### Running the App

1. Connect a device or start an emulator.
2. Run the app:
   ```sh
   flutter run
   ```

## Project Structure

```
lib/
├── backend/              # Database and API configuration
├── components/           # Reusable UI widgets
│   ├── cart/            # Cart related components
│   └── common/          # Common UI elements
├── models/              # Data models and providers
├── pages/              # Application screens
│   ├── auth/          # Authentication pages
│   └── navigation/    # Main app navigation
├── services/          # Business logic and services
│   ├── auth/         # Authentication services
│   └── notifications/# Notification handling
└── main.dart         # Application entry point
```

## Technical Details

### State Management
- Provider pattern for state management
- Multiple providers:
  - Restaurant: Cart and orders management
  - MyNotification: Notifications handling
  - UserPreferences: App settings and user preferences
  - OrderTracking: Real-time order location updates
  - PaymentProvider: Payment processing management

### Services
- NotifService: Push notification management
- SupabaseConfig: Backend services and authentication
- LocationService: Real-time GPS tracking
- PaymentService: Payment gateway integration
- CacheService: Offline data management

## Technical Stack

- Flutter: Frontend framework
- Dart: Programming language
- Supabase: Backend as a Service
- Provider: State management
- Local Notifications
- Material Design

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

### Collaborators

- [MrJojono](https://github.com/MrJojono)

### Contact

Project Maintainer: [Darrylwin](https://github.com/Darrylwin)

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [Supabase](https://supabase.com/)
- [Provider](https://pub.dev/packages/provider) - State Management
- [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)
- [Material Design Icons](https://material.io/icons/)
- All the contributors who help improve this project