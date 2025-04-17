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
[<img width="200" alt="Image" src="https://github.com/user-attachments/assets/d6c906f5-4348-46ab-931b-dc0d220b48bc" />](https://private-user-images.githubusercontent.com/138692325/434703660-ac2bee2f-05ec-438c-8fec-dce6132aa9a1.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDQ4Nzc5MzcsIm5iZiI6MTc0NDg3NzYzNywicGF0aCI6Ii8xMzg2OTIzMjUvNDM0NzAzNjYwLWFjMmJlZTJmLTA1ZWMtNDM4Yy04ZmVjLWRjZTYxMzJhYTlhMS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNDE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDQxN1QwODEzNTdaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1jOTYxZWUyN2NkZGYyY2IxMGYwN2VkMzk2YWRhNzdmODJiNmRkZWVkZGZmZWZiYzU0MDQwNTBiOGVhZWM5OGJkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.FQldqoQlmiRORmf4lobSMJ26Q3_-GJAutNeWC2VuaPc) | [<img width="200" alt="Image" src="https://github.com/user-attachments/assets/d6c906f5-4348-46ab-931b-dc0d220b48bc" />](https://private-user-images.githubusercontent.com/138692325/434703660-ac2bee2f-05ec-438c-8fec-dce6132aa9a1.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDQ4Nzc5MzcsIm5iZiI6MTc0NDg3NzYzNywicGF0aCI6Ii8xMzg2OTIzMjUvNDM0NzAzNjYwLWFjMmJlZTJmLTA1ZWMtNDM4Yy04ZmVjLWRjZTYxMzJhYTlhMS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNDE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDQxN1QwODEzNTdaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1jOTYxZWUyN2NkZGYyY2IxMGYwN2VkMzk2YWRhNzdmODJiNmRkZWVkZGZmZWZiYzU0MDQwNTBiOGVhZWM5OGJkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.FQldqoQlmiRORmf4lobSMJ26Q3_-GJAutNeWC2VuaPc)


Detail Page | Bookmark
:---:|:---:
[<img width="200" alt="Image" src="https://github.com/user-attachments/assets/d6c906f5-4348-46ab-931b-dc0d220b48bc" />](https://private-user-images.githubusercontent.com/138692325/434703660-ac2bee2f-05ec-438c-8fec-dce6132aa9a1.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDQ4Nzc5MzcsIm5iZiI6MTc0NDg3NzYzNywicGF0aCI6Ii8xMzg2OTIzMjUvNDM0NzAzNjYwLWFjMmJlZTJmLTA1ZWMtNDM4Yy04ZmVjLWRjZTYxMzJhYTlhMS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNDE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDQxN1QwODEzNTdaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1jOTYxZWUyN2NkZGYyY2IxMGYwN2VkMzk2YWRhNzdmODJiNmRkZWVkZGZmZWZiYzU0MDQwNTBiOGVhZWM5OGJkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.FQldqoQlmiRORmf4lobSMJ26Q3_-GJAutNeWC2VuaPc) | [<img width="200" alt="Image" src="https://github.com/user-attachments/assets/d6c906f5-4348-46ab-931b-dc0d220b48bc" />](https://private-user-images.githubusercontent.com/138692325/434703660-ac2bee2f-05ec-438c-8fec-dce6132aa9a1.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDQ4Nzc5MzcsIm5iZiI6MTc0NDg3NzYzNywicGF0aCI6Ii8xMzg2OTIzMjUvNDM0NzAzNjYwLWFjMmJlZTJmLTA1ZWMtNDM4Yy04ZmVjLWRjZTYxMzJhYTlhMS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNDE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDQxN1QwODEzNTdaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1jOTYxZWUyN2NkZGYyY2IxMGYwN2VkMzk2YWRhNzdmODJiNmRkZWVkZGZmZWZiYzU0MDQwNTBiOGVhZWM5OGJkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.FQldqoQlmiRORmf4lobSMJ26Q3_-GJAutNeWC2VuaPc)

Bookmark Edit | Pagination
:---:|:---:
[<img width="200" alt="Image" src="https://github.com/user-attachments/assets/d6c906f5-4348-46ab-931b-dc0d220b48bc" />](https://private-user-images.githubusercontent.com/138692325/434703660-ac2bee2f-05ec-438c-8fec-dce6132aa9a1.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDQ4Nzc5MzcsIm5iZiI6MTc0NDg3NzYzNywicGF0aCI6Ii8xMzg2OTIzMjUvNDM0NzAzNjYwLWFjMmJlZTJmLTA1ZWMtNDM4Yy04ZmVjLWRjZTYxMzJhYTlhMS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNDE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDQxN1QwODEzNTdaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1jOTYxZWUyN2NkZGYyY2IxMGYwN2VkMzk2YWRhNzdmODJiNmRkZWVkZGZmZWZiYzU0MDQwNTBiOGVhZWM5OGJkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.FQldqoQlmiRORmf4lobSMJ26Q3_-GJAutNeWC2VuaPc) | [<img width="200" alt="Image" src="https://github.com/user-attachments/assets/d6c906f5-4348-46ab-931b-dc0d220b48bc" />](https://private-user-images.githubusercontent.com/138692325/434703660-ac2bee2f-05ec-438c-8fec-dce6132aa9a1.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDQ4Nzc5MzcsIm5iZiI6MTc0NDg3NzYzNywicGF0aCI6Ii8xMzg2OTIzMjUvNDM0NzAzNjYwLWFjMmJlZTJmLTA1ZWMtNDM4Yy04ZmVjLWRjZTYxMzJhYTlhMS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNDE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDQxN1QwODEzNTdaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1jOTYxZWUyN2NkZGYyY2IxMGYwN2VkMzk2YWRhNzdmODJiNmRkZWVkZGZmZWZiYzU0MDQwNTBiOGVhZWM5OGJkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.FQldqoQlmiRORmf4lobSMJ26Q3_-GJAutNeWC2VuaPc)

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
