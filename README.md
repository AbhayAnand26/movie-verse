# 🎬 Movie Verse

**Movie Verse** is a Flutter-based movie and TV show discovery app that allows users to explore, search, and save their favorite shows in a beautiful, modern interface.
It uses the **[TVMaze API](https://www.tvmaze.com/api)** to fetch real-time show data, and **Hive** for offline storage — making it fast, lightweight, and user-friendly.

---

## 🚀 Features

* 🔍 **Search Shows** — Instantly search for TV shows by title using TVMaze API.
* 📺 **Show Details** — View detailed info like name, image, genre, language, and summary.
* ❤️ **Favorites** — Save your favorite shows locally for offline viewing.
* 📦 **Offline Storage** — Uses Hive for efficient local data saving.
* 🌐 **Real-Time Data** — Fetches trending and searched shows from the TVMaze API.
* 🎬 **Lottie Animations** — Smooth, beautiful animations for loading and empty states.
* 💡 **State Management** — Handled efficiently using Provider.

---

## 🧱 Tech Stack

| Component            | Tool                                     |
| -------------------- | ---------------------------------------- |
| **Framework**        | Flutter                                  |
| **Language**         | Dart                                     |
| **State Management** | Provider                                 |
| **Local Database**   | Hive & Hive Flutter                      |
| **Networking**       | HTTP                                     |
| **Animations**       | Lottie                                   |
| **API Source**       | [TVMaze API](https://www.tvmaze.com/api) |

---

## 🔑 API Integration

This app uses the **TVMaze API** for fetching data about TV shows.
It does **not** require an API key — you can make requests directly.

### 🧰 Example API Endpoints

| Purpose                | Endpoint                                      |
| ---------------------- | --------------------------------------------- |
| Search shows           | `https://api.tvmaze.com/search/shows?q=QUERY` |
| Get show details by ID | `https://api.tvmaze.com/shows/{id}`           |
| Get all shows          | `https://api.tvmaze.com/shows`                |

Example:

```dart
final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=breaking'));
```

---

## 📁 Folder Structure

```
movie_verse/
├── assets/
│   ├── loading.json
│   ├── empty.json
├── lib/
│   ├── main.dart
│   ├── components/
│   │   └──show_details_page.dart
│   ├── models/
│   │   └── show_models.dart
│   ├── helpers/
│   │   ├── api_helper.dart
│   │   └── hive_helper.dart
│   ├── providers/
│   │   ├── favorites_provider.dart
│   │   └── theme_provider.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── search_screen.dart
│   │   ├── favorite_Screen.dart
│   │   └── settings_screen.dart
│   └── widgets/
├── pubspec.yaml
└── README.md
```

---

## ⚙️ Installation & Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/AbhayAnand26/movie_verse.git
```

### Step 2: Navigate into the Project

```bash
cd movie_verse
```

### Step 3: Install Dependencies

```bash
flutter pub get
```

### Step 4: Run the App

```bash
flutter run
```

---

## 🧩 Dependencies

| Package         | Version  | Description                  |
| --------------- | -------- | ---------------------------- |
| flutter         | SDK      | Flutter framework            |
| cupertino_icons | ^1.0.8   | iOS-style icons              |
| hive            | ^2.2.3   | Lightweight local database   |
| hive_flutter    | ^1.1.0   | Hive integration for Flutter |
| provider        | ^6.1.5+1 | State management             |
| http            | ^1.5.0   | For API requests             |
| lottie          | ^3.3.2   | For animations               |

---

## 🖼️ Assets

| File                  | Purpose                                                    |
| --------------------- | ---------------------------------------------------------- |
| `assets/loading.json` | Displayed while fetching data                              |
| `assets/empty.json`   | Displayed when no data is found or favorites list is empty |

---

## 📱 Screens

| Page                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| 🏠 **Home Page**      | Displays trending or featured TV shows.              |
| 🔍 **Search Page**    | Allows searching for shows using the TVMaze API.     |
| ❤️ **Favorites Page** | Shows locally saved favorite shows (stored in Hive). |

---

## 🧑‍💻 Author

**Abhay Anand**
📧 [abhayanand261215@gmail.com]
💻 GitHub: [https://github.com/AbhayAnand26](https://github.com/AbhayAnand26)

---

## 📄 License

This project is created for educational purposes and not intended for commercial use.
API data is provided by **[TVMaze](https://www.tvmaze.com/)**.

---
