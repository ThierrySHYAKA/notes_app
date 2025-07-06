# Flutter Notes App

A simple and elegant notes application built with Flutter and Firebase, allowing users to create, edit, delete, and manage their personal notes with secure authentication.

## Features

- **User Authentication**: Secure sign-in/sign-up with Firebase Auth
- **Personal Notes**: Create, edit, and delete notes
- **Real-time Sync**: Notes are synchronized across devices using Firestore
- **Responsive Design**: Works on both Android and iOS devices
- **Secure Data**: Each user can only access their own notes

## Screenshots

<!-- Add screenshots of your app here -->
*Coming soon...*

## Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (>=3.0.0)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- [Firebase CLI](https://firebase.google.com/docs/cli) (optional, for advanced Firebase operations)

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ThierrySHYAKA/notes_app.git
   cd notes_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication (Email/Password)
   - Enable Firestore Database
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files to the project

4. **Configure Firebase**
   - Replace the Firebase configuration files in:
     - `android/app/google-services.json`
     - `ios/Runner/GoogleService-Info.plist`

## Firebase Setup Details

### Authentication
1. Go to Firebase Console → Authentication → Sign-in method
2. Enable "Email/Password" provider

### Firestore Database
1. Go to Firebase Console → Firestore Database
2. Create database in production mode
3. Update security rules:
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /notes/{document} {
         allow read, write: if request.auth != null && request.auth.uid == resource.data.userId;
         allow create: if request.auth != null && request.auth.uid == request.resource.data.userId;
       }
     }
   }
   ```

### Firestore Index
The app requires a composite index for efficient querying:
1. Go to Firebase Console → Firestore Database → Indexes
2. Create a composite index with:
   - Collection ID: `notes`
   - Fields: `userId` (Ascending), `timestamp` (Descending)

## Running the App

1. **Start an emulator or connect a device**
   ```bash
   flutter devices
   ```

2. **Run the app**
   ```bash
   flutter run
   ```

   Or for a specific device:
   ```bash
   flutter run -d <device_id>
   ```

## Project Structure

```
lib/
├── main.dart              # App entry point
├── models/                # Data models
├── screens/               # UI screens
├── services/              # Firebase services
├── widgets/               # Reusable widgets
└── utils/                 # Utility functions
```

## Key Dependencies

- `flutter`: SDK for building the app
- `firebase_core`: Firebase core functionality
- `firebase_auth`: User authentication
- `cloud_firestore`: NoSQL database
- `provider`: State management (if used)

## Troubleshooting

### Common Issues

1. **Permission Denied Error**
   - Check Firestore security rules
   - Ensure user is authenticated before accessing data

2. **Index Error**
   - Create the required composite index in Firebase Console
   - Wait for index to build (may take a few minutes)

3. **Build Errors**
   - Run `flutter clean` and `flutter pub get`
   - Check that Firebase configuration files are properly added

### Debug Commands

```bash
# Clean build files
flutter clean

# Get dependencies
flutter pub get

# Run with verbose output
flutter run -v

# Build APK
flutter build apk
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/ThierrySHYAKA/notes_app.git/issues) section
2. Create a new issue with detailed description
3. Contact: [t.shyaka1@alustudent.com]

## Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Contributors and testers

---
