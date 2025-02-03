# Food Delivery App

A Flutter project for a food delivery application.

## Features

- Browse a variety of food items categorized by type (Burgers, Pizza, Pasta, Salads, Desserts, Drinks)
- Add food items to the cart with optional add-ons
- View cart summary and total price
- Generate a receipt for the cart items
- Backend powered by Supabase for real-time data synchronization and user authentication
- Real-time notifications system
- Multiple delivery addresses management
- Modern and responsive UI
- User authentication with Supabase
- Search functionality
- Order tracking

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

### State Management
- Provider pattern for state management
- Multiple providers:
  - Restaurant: Cart and orders management
  - MyNotification: Notifications handling

### Services
- NotifService: Push notification management
- SupabaseConfig: Backend services and authentication

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

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [Supabase](https://supabase.com/)