# antripe_flutter_assignment

# Contact List App (API + Categorized + Debounced Search)

A Flutter mobile application that fetches contacts from an API, displays them in categorized sections, and provides a debounced search functionality to optimize performance. Built with  GetX for reactive state management.

---

## 🛠 Flutter Version

- Flutter SDK: 3.38.8
- Dart: 3.10.7
- Compatible with Android & iOS

---

## ⚡ Setup Steps

1. Clone the repository:


    git clone https://github.com/Nazmul2957/antripe_flutter_assignment.git

2 . Navigate to the project folder:

    cd <antripe_flutter_assignment>

3 . Install dependencies:


    flutter pub get

4 . Run the app on a connected device or emulator:


    flutter run

| Library                                             | Version | Purpose                                                           |
| --------------------------------------------------- | ------- | ----------------------------------------------------------------- |
| [get](https://pub.dev/packages/get)                 | ^4.7.3  | State management, reactive UI updates, navigation                 |
| [flutter_svg](https://pub.dev/packages/flutter_svg) | ^2.2.3  | Render SVG icons efficiently (e.g., search icon, category icons)  |
| [dio](https://pub.dev/packages/dio)                 | ^5.9.1  | API requests with error handling and interceptors                 |
| [equatable](https://pub.dev/packages/equatable)     | ^2.0.8  | Simplify model class equality comparisons for clean data handling |

💬 Notes

Categories come from API or can be mapped locally.

Debounced search avoids unnecessary rebuilds or API filtering on each keystroke.