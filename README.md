# Flutter News App

Flutter News App is my first Flutter project, a simple yet powerful news reader application that fetches real-time headlines from the NewsAPI. Built as part of my journey into Flutter & Dart, this app showcases key Flutter features and best practices like state management, networking, and responsive UI.

## Features

- **Country-based Headlines**: Browse top headlines by selecting from a list of countries.
- **Search & Sort**: Search for articles by keyword and sort results by popularity or publish date.
- **Infinite Scroll & Pull-to-Refresh**: Seamless pagination and pull-to-refresh support.
- **Article Details**: View full article content, "Read More" links (opens in external browser), share articles, and bookmark favorites.
- **Empty & Loading States**: Custom views for loading indicators and empty results.

## Screenshots

Home Screen | Search & Sort
:---:|:---:
![Home Screen](<img width="250" alt="Image" src="https://github.com/user-attachments/assets/d6c906f5-4348-46ab-931b-dc0d220b48bc" />) | ![Search & Sort](<img width="250" alt="Image" src="https://github.com/user-attachments/assets/4dfd45d0-18f9-4492-abb4-6291ac31ca2c" />)

Detail Page | Bookmark
:---:|:---:
![Detail Page](<img width="250" alt="Image" src="https://github.com/user-attachments/assets/2c8f22c9-1036-486a-90d4-16abb917a0ee" />) | ![Bookmarks & Share](<img width="250" alt="Image" src="https://github.com/user-attachments/assets/be6e38f4-d6d6-4f74-80b2-7ed05dec649b" />)

Bookmark Edit | Pagination
:---:|:---:
![Bookmark Edit](<img width="250" alt="Image" src="https://github.com/user-attachments/assets/d1762ad4-6a4c-482b-ad33-dcde5423d297" />) | ![Pagination](<img width="250" alt="Image" src="https://github.com/user-attachments/assets/4b43a974-08fd-4d33-84b4-2a1d98dab701" />)

## Technologies & Packages

- **Flutter & Dart**: Core framework and language.
- **Provider**: State management for clean MVVM architecture.
- **http**: Networking to fetch data from NewsAPI.
- **url_launcher**: Open external links in browser.
- **share_plus**: Share article links with other apps.
- **intl**: Date formatting localized for readability.

## Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/ozguncanbey/flutter-news-app.git
   cd flutter-news-app
   ```
2. **Configure API Key**
   - Open `lib/config/config.dart` and replace `apiKey` with your NewsAPI key.
3. **Install dependencies**
   ```bash
   flutter pub get
   ```
4. **Run the app**
   ```bash
   flutter run
   ```
---
