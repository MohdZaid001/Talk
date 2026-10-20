# 💬 Talk — Real-Time Chat App

**Talk** is a chat application built with Flutter and Firebase. My goal is to create a simple, clean messaging experience with real-time conversations, contact management, and dark mode.

I'm continuously improving Talk and welcome contributions from other developers! 🚀

## 📸 Screenshots


| Home Screen | Chat Screen |
|:---:|:---:|
| ![Home Screen](screenshots/3.png) | ![Chat Screen](screenshots/6.png) |

| Login Screen | App Menu |
|:---:|:---:|
| ![Login Screen](screenshots/1.png) | ![App Menu](screenshots/5.png) |

## ✨ Features

- [x] 🔐 **Authentication** — Register and log in using email and password.
- [x] 💬 **Real-Time Messaging** — Send and receive messages using Cloud Firestore.
- [x] 👥 **Contact Management** — Add and remove contacts.
- [x] 🌗 **Dark Mode** — Switch between light and dark themes.
- [x] 🔎 **User Discovery** — Browse registered users and add contacts.
- [x] 🧩 **Reusable Widgets** — Shared components for chat bubbles, buttons, dialogs, and more.

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| 🐦 Flutter & Dart | App development |
| 🔥 Firebase Authentication | User authentication |
| ☁️ Cloud Firestore | User data and real-time messaging |
| 🎨 Provider | Theme state management |
| 💾 SharedPreferences | Local contact storage |

## 📁 Project Structure

```text
lib/
├── components/          # Reusable UI widgets
├── models/              # Message data model
├── pages/               # App screens
├── services/
│   ├── auth/            # Authentication logic
│   ├── chat/            # Chat and user streams
│   └── contact_storage.dart
├── themes/              # Light/dark themes and provider
├── firebase_options.dart
└── main.dart             # App entry point
```

## 🚀 Getting Started

### Prerequisites

- [ ] Install the [Flutter SDK](https://docs.flutter.dev/get-started/install).
- [ ] Set up an editor such as [VS Code](https://code.visualstudio.com/) or Android Studio.
- [ ] Create a [Firebase project](https://console.firebase.google.com/).

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/MohdZaid001/Talk.git
cd Talk
```

**2. Install dependencies**

```bash
flutter pub get
```

**3. Configure Firebase**

Connect the project to your own Firebase project using the [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup). Enable Email/Password Authentication and configure Cloud Firestore with appropriate security rules.

**4. Run the app**

```bash
flutter run
```
## 🗺️ Upcoming Features

These are ideas I'm planning to work on next:

- [ ] 🎨 Improve the overall UI and user experience.
- [ ] 🖼️ Profile pictures and customizable profiles.
- [ ] 📎 Image and file sharing.
- [ ] 🔔 Push notifications for new messages.
- [ ] ✓✓ Message timestamps and read receipts.
- [ ] 🔍 Better contact search and chat organization.
- [ ] 🖼️ Send pics also.

Have another idea? Feel free to suggest it!

## 🤝 Contributing

I'd love to have other developers contribute to Talk! Whether you're fixing a bug, improving the UI, or suggesting a new feature, every useful contribution is welcome.

### How to contribute

**1. Find something to work on**

- [ ] Check the existing [Issues](https://github.com/MohdZaid001/Talk/issues).
- [ ] Look for a bug or feature you'd like to work on.
- [ ] For bigger changes, open an issue first to discuss your idea.

**2. Fork and clone the repository**

Click **Fork** on GitHub, then clone your fork:

```bash
git clone https://github.com/YOUR-USERNAME/Talk.git
cd Talk
```

**3. Create a branch**

```bash
git checkout -b feature/main
```

For bug fixes, you can use `fix/your-bug-name`.

**4. Make your changes**

- [ ] Keep the code clean and easy to understand.
- [ ] Follow the existing Flutter and Dart code style.
- [ ] Test your changes before submitting.
- [ ] Avoid committing secrets or private Firebase credentials.

**5. Commit and push**

```bash
git add .
git commit -m "Add: describe your changes"
git push origin feature/your-feature-name
```

**6. Open a Pull Request**

Go to your fork on GitHub and click **Compare & pull request**. Explain what you changed, why you changed it, and any testing you performed.

I'll review contributions and discuss any changes that may be needed.

### Contribution ideas 💡

Not sure where to start? You could help with:

- Improving the chat interface.
- Fixing bugs and handling edge cases.
- Adding profile customisation.
- Improving accessibility.
- Writing documentation or testing existing features.

## 🐛 Found a Bug?

Please [open an issue](https://github.com/MohdZaid001/Talk/issues/new) with a clear description of the problem and steps to reproduce it. Screenshots are helpful when the issue involves the UI.

## 📌 Project Status

**Status: Active Development 🟢**

Talk is a working project that I'm continuing to improve. Some features listed above are planned and may change as development progresses.

⭐ If you find Talk interesting, consider giving the repository a star.

**Repository:** [MohdZaid001/Talk](https://github.com/MohdZaid001/Talk)

## 👨‍💻 About Me

Hi! I'm a developer learning and building with Flutter, Dart, and Firebase. I created Talk as a hands-on project to improve my mobile development skills and explore real-time applications.

I'm still experimenting, and adding new features. If you're interested in the project, feel free to explore the code, share feedback, or contribute!

**Mohd Zaid**

- GitHub: [@MohdZaid001](https://github.com/MohdZaid001)

---

Built with Flutter and Firebase.