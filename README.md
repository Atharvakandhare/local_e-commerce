# Local E-commerce Cart

A Flutter-based local e-commerce cart application built using
Bloc for state management and Hive for local data persistence.

## Features

- Product listing
- Add products to cart
- Remove products from cart
- Increase/decrease quantity
- Dynamic cart total
- Hive local persistence
- Bloc state management
- Bottom navigation
- Snackbar feedback
- Responsive Material 3 UI

## Tech Stack

- Flutter
- Dart
- flutter_bloc
- Hive
- Hive Flutter
- Equatable
- Material 3

## Architecture

The application follows a layered structure:

- Models
- Data
- Services
- Bloc
- Screens
- Widgets

## Setup 

Before running the project, make sure you have the following installed:

Flutter SDK
Dart SDK
Android Studio or an Android device/emulator
VS Code or another IDE
Git

Verify your Flutter installation:

flutter doctor

Make sure there are no critical issues in the Flutter environment.

Check Flutter version:

flutter --version
Getting Started
1. Clone the Repository

Clone the project from GitHub:
- git clone https://github.com/Atharvakandhare/local_e-commerce.git

Navigate into the project:
- cd local_e-commerce
- 
2. Install Dependencies

Get all Flutter project dependencies:
- flutter pub get
- 
3. Verify the Project

Run Flutter's analyzer:
- flutter analyze

4. Connect a Device

You can run the application using:
- Android Emulator
- Physical Android device
- iOS Simulator
- Physical iOS device

Check available devices:
- flutter devices
- 
5. Run the Application

Start the application using:
- flutter run or run directly main.dart using start button

To run on a specific device:
- flutter run -d <device-id>

Example:
- flutter run -d emulator-5554
