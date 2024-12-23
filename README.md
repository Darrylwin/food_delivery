# Food Delivery App

A Flutter project for a food delivery application.

## Features

- Browse a variety of food items categorized by type (Burgers, Pizza, Pasta, Salads, Desserts, Drinks)
- Add food items to the cart with optional add-ons
- View cart summary and total price
- Generate a receipt for the cart items
- Backend powered by Supabase for real-time data synchronization and user authentication

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

- `lib/models`: Contains the data models for the app (e.g., `food.dart`, `cart_item.dart`, `restaurant.dart`).
- `lib/screens`: Contains the UI screens for the app.
- `lib/widgets`: Contains reusable UI components.
- `lib/services`: Contains Supabase configuration and API services.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

### Collaborators

- [MrJojono](https://github.com/MrJojono)

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [Supabase](https://supabase.com/)