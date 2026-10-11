# Talk 💬

**A real-time messaging application built with Flutter, Dart, and Firebase.**

Talk is a cross-platform chat application designed to provide a simple messaging experience with Firebase Authentication, Cloud Firestore, and a customizable interface.

The project is currently under development, with a focus on reliable authentication, real-time communication, and a clean application architecture.

## ✨ Features

### Implemented functionality

- **User Authentication** — Email and password registration and login using Firebase Authentication.
- **Real-Time Messaging** — Send and receive text messages through Cloud Firestore streams.
- **Light and Dark Themes** — Switch between light and dark interface themes.
- **One-to-One Conversations** — Messages between two users are stored in a shared conversation room.
- **User Directory** — View registered users and open a conversation.

- **Reusable UI Components** — Shared widgets for text fields, buttons, user tiles, chat bubbles, and navigation.

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform application UI |
| Dart | Application programming language |
| Firebase Core | Firebase initialization |
| Firebase Authentication | User registration and login |
| Cloud Firestore | User profiles and real-time messages |
| Provider | Theme state management |
| Material Design | UI components and styling |

## 📁 Project Structure

```text
Talk/
├── android/                 # Android platform files
├── ios/                     # iOS platform files
├── linux/                   # Linux platform scaffold
├── macos/                   # macOS platform files
├── web/                     # Web platform files
├── windows/                 # Windows platform files
├── lib/
│   ├── components/          # Reusable UI components
│   ├── models/              # Message data model
│   ├── pages/               # Home, login, register, and chat screens
│   ├── services/
│   │   ├── auth/             # Authentication logic
│   │   └── chat/             # Chat and Firestore operations
│   ├── themes/              # Light and dark themes
│   ├── firebase_options.dart
│   └── main.dart
├── firebase.json
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

## 🚀 Getting Started

### Prerequisites

Before running Talk, install:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- [Git](https://git-scm.com/downloads)
- Android Studio, VS Code, or another supported Flutter IDE
- A Firebase project

### 1. Clone the repository

```bash
git clone https://github.com/MohdZaid001/Talk.git
cd Talk
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

1. Create a project in the [Firebase Console](https://console.firebase.google.com/).
2. Register the required application platforms in your Firebase project.
3. Enable **Email/Password** sign-in under Authentication.
4. Create a Cloud Firestore database.
5. Configure FlutterFire for the platforms you intend to support.

Install the FlutterFire CLI if necessary, then run:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Review the generated Firebase configuration before running the application. Ensure that the Firebase project, application IDs, and enabled services match your setup.

### 4. Run the application

Connect a device, start an emulator, or select a supported target.

```bash
flutter devices
flutter run
```

**Platform note:** The current Firebase options file does not configure Linux. Run the application on a configured platform, or add and verify Linux Firebase configuration before targeting Linux.

## 🗄️ Data Model

The current implementation uses Cloud Firestore for user profiles and conversation messages.

### Users

Collection: `Users`

Each user document is identified by the Firebase Authentication UID.

| Field | Purpose |
|---|---|
| `uid` | User identifier |
| `email` | Registered email address |

### Chat Rooms

Collection: `chat_rooms`

Each conversation room uses a deterministic ID derived from the two participant UIDs, sorted and joined with an underscore.

Subcollection: `messages`

| Field | Purpose |
|---|---|
| `senderId` | UID of the message sender |
| `senderEmail` | Sender's email address |
| `reciverId` | Recipient UID |
| `message` | Text message content |
| `timestamp` | Firestore timestamp |

The current schema uses `reciverId` as its field name. Consider migrating it to `receiverId` consistently across the model, service, database, and security rules before a larger deployment.


## 🤝 Contributing

Contributions and suggestions are welcome.

1. Fork the repository.
2. Create a feature branch.
3. Make your changes.
4. Run `flutter analyze` and `flutter test`.
5. Submit a pull request describing the changes.

## 👨‍💻 Author

**Mohd Zaid**

- GitHub: [@MohdZaid001](https://github.com/MohdZaid001)

---

Built with Flutter and Firebase.