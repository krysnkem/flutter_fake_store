# Flutter Fake Store

A Flutter application demonstrating a modern e-commerce app structure, built using the FakeStoreAPI. This project showcases product browsing, viewing details, cart management, wishlist functionality, and user authentication.

## Overview

Flutter Fake Store is designed to serve as a practical example of building a feature-rich mobile application with Flutter. It emphasizes a clean architecture, state management using BLoC, and efficient data handling.

## Features

*   **User Authentication:** Login functionality.
*   **Product Listing:** Displays a list of products fetched from the API with infinite scrolling.
*   **Product Details:** Shows detailed information for each product.
*   **Shopping Cart:** Allows users to add, remove, and update quantities of products in their cart.
*   **Wishlist:** Enables users to mark products as favorites.
*   **Responsive UI:** Adapts to different screen sizes (though primarily designed for mobile).
*   **State Management:** Utilizes the BLoC pattern for predictable state management.
*   **Navigation:** Uses `go_router` for a declarative routing solution.
*   **Dependency Injection:** Leverages `injectable` and `get_it` for managing dependencies.

## Architecture

The application follows a clean architecture pattern, separating concerns into distinct layers. This promotes maintainability, testability, and scalability.

**UI (Presentation Layer) -> BLoC (Business Logic Layer) -> Repository (Data Layer) -> API Client / Cache (Data Sources)**

1.  **UI (Presentation Layer):**
    *   Located primarily in `lib/presentation/pages/` and `lib/presentation/widgets/`.
    *   Composed of Flutter widgets that render the user interface.
    *   Responds to user interactions (e.g., button taps, gestures).
    *   Listens to state changes from BLoCs and rebuilds accordingly.
    *   Dispatches events to BLoCs to trigger business logic.
    *   Examples: `ProductsPage`, `CartPage`, `ProductListItem`, `WishlistItem`.

2.  **BLoC (Business Logic Layer):**
    *   Located in `lib/presentation/blocs/`.
    *   Stands for Business Logic Component.
    *   Receives events from the UI layer.
    *   Interacts with the Repository layer to fetch or manipulate data.
    *   Manages the state of different features (e.g., `ProductsBloc`, `CartBloc`, `WishlistBloc`, `AuthBloc`).
    *   Emits new states to the UI layer, causing it to re-render with new data or in a new state (e.g., loading, error).

3.  **Repository (Data Layer):**
    *   Located in `lib/data/repositories/`.
    *   Acts as a single source of truth for data.
    *   Abstracts the data sources from the BLoCs. The BLoC doesn't know or care if the data comes from a network API, a local database, or a cache.
    *   Contains logic to decide where to fetch data from (e.g., try cache first, then API).
    *   Transforms data from data sources into a format usable by the BLoCs (often using Data Models).
    *   Example: `DataRepository`.

4.  **API Client / Cache (Data Sources):**
    *   **API Client:**
        *   Located in `lib/data/network/` (or similar).
        *   Responsible for making network requests to the backend API (e.g., FakeStoreAPI).
        *   Handles HTTP methods (GET, POST, PUT, DELETE), request/response serialization/deserialization.
        *   Often uses libraries like `dio` or `http`.
    *   **Cache (Local Data Storage):**
        *   Could involve using `shared_preferences` for simple key-value storage, or a local database like `sqflite` or `isar` for more complex structured data.
        *   The `DataRepository` would interact with this layer to store and retrieve cached data. (While not explicitly detailed in the provided files, this is where it would fit).

## Key Libraries & Technologies

*   **Flutter:** UI toolkit for building natively compiled applications.
*   **BLoC / flutter_bloc:** State management library for separating business logic from UI.
*   **go_router:** Declarative routing package for Flutter.
*   **injectable & get_it:** Dependency injection framework for managing dependencies.
*   **dio (implied):** A powerful HTTP client for Dart, used for making API requests.
*   **equatable:** Simplifies equality comparisons for BLoC states and events.
*   **cached_network_image:** For displaying images from the internet and keeping them in the cache.

## Setup & Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/krysnkem/flutter_fake_store.git
    cd flutter_fake_store
    ```
2.  **Install Flutter dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the code generator (for `injectable` and other generated files):**
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
4.  **Run the app:**
    ```bash
    flutter run
    ```

## Folder Structure (Simplified)

```text
flutter_fake_store/
├── lib/
│   ├── core/                 # Core utilities, constants, routing, theme, extensions
│   ├── data/                 # Data layer
│   │   ├── models/           # Data models (e.g., Product, CartItem)
│   │   ├── api/              # API client, network-related code
|   |   |-- cache/            # Cache-related code
│   │   └── repositories/     # Repository implementations
│   ├── presentation/         # Presentation layer (UI and BLoCs)
│   │   ├── blocs/            # BLoC classes
│   │   ├── pages/            # Screen/Page widgets
│   │   └── widgets/          # Reusable UI components
│   ├── main.dart             # Main application entry point
│   └── injection/            # Dependency injection setup
├── test/                     # Unit and widget tests
└── ...                       # Other project files (android, ios, pubspec.yaml, etc.)
```