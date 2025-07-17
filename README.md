# Civic24

![Civic24 Banner](.github/banner.png)

[![style: analysis](https://img.shields.io/badge/style-flutter_analysis-blue.svg)](https://dart.dev/guides/language/analysis-options)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)


**Civic24** is a mobile platform that empowers people to report civic-related issues in their communities and engage with fellow citizens through feedback and discussion.

This directly aligns with **SDG Goal 11: Sustainable Cities and Communities**, which aims to make urban areas inclusive, safe, resilient, and sustainable.

Civic24 uses **Google’s Generative AI** to validate submitted posts and images, ensuring that only genuinely civic-related content gets shared.

And the best part? It’s **Open Source**. 🧑🏾‍💻

[Civic24 Design Case Study](https://www.behance.net/gallery/229296271/Civic24-Mobile-App-Design-UIUX-Case-Study)

---

## Description
This repository contains the source code for the **Civic24** mobile applications, including:
- **Citizen App**: The main user-facing app that enables individuals to report civic issues, view updates, and participate in public conversations.
- **Admin App**: A web-based dashboard for government officials and administrators to review reports, manage feedback, and oversee community activity.
- **Shared Packages**: Modular Dart packages used across both apps to ensure consistent design, localization, and functionality:
  - `components/`: Reusable UI widgets.
  - `styles/`: Design system and typography.
  - `services/`: Firebase/Supabase integrations.
  - `localization/`, `utils/`, `models/`, etc.

This monorepo is managed using **Melos** to handle interdependencies between packages efficiently.

---

## 🚀 Requirements

Make sure the following tools are installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Melos](https://melos.invertase.dev/)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- [Supabase CLI](https://supabase.com/docs/guides/cli)
- [Git](https://git-scm.com/)
- [VS Code](https://code.visualstudio.com/)

---

## 📦 Getting Started

```bash
git clone https://github.com/Civic24HQ/civic24
cd civic24
dart pub global activate melos
melos clean
melos bootstrap
```

This will link all workspace dependencies across apps and packages.

---

## Project Structure

```
civic24/
├── apps/
│   ├── citizen/          # Main user-facing app
│   └── admin/            # Admin dashboard
│
├── packages/
│   ├── assets/           # Images and Fonts Setup
│   ├── components/       # Reusable UI Widgets
│   ├── constants/        # Static Variables and constants
│   ├── localization/     # i18n Setup
│   ├── models/           # Data Models
│   ├── rules/            # Flutter Linter Rules Setup
│   ├── services/         # Firebase, Supabase, API Integrations
│   ├── styles/           # Design System and Typography
│   └── utils/            # Utility Methods
│
├── melos.yaml
├── pubspec.yaml
└── README.md
```

---

## Melos Workspace

### **Common Commands**

```bash
melos bootstrap            # Link and install all packages
melos clean                # Clean all builds
melos flutter:format       # Run custom format script for apps and packages
melos localization:intl    # Generate localization files
melos flutter:build        # Runs build for all apps and packages
melos flutter:analyze      # Static code analysis for apps and packages
```

---

## Firebase & Supabase

- Firebase is used for push notifications (FCM), analytics, and crash reporting.
- Supabase is used for real-time PostgreSQL database, authentication, and storage.

---

## Developer Guidelines

- Follow the Flutter linter rules in `packages/rules/analysis_options.yaml`
- Use consistent commit naming: `feat:`, `fix:`, `chore:`, `refactor:`
- Document all new features in PR Description
- Write unit and widget tests where necessary

---

## 📱 Download Civic24 App (Preview Builds)

You can test the latest preview builds of the Civic24 mobile apps without setting up a development environment.

### 🔽 Download from Releases
Go to the official [Releases page](https://github.com/Civic24HQ/civic24/releases/) to download:

- `.apk` file for Android
- `.ipa` file for iOS (TestFlight or manual install)

Each release contains build artifacts generated from our CI pipelines.

---

## Contribution

1. Fork the repository
2. Create a new branch from `develop`: `git checkout -b feat/amazing-feature`
3. Make your changes, test locally and write a clear well-commented code
4. Run the following commands:
```bash
  melos clean
  melos bootstrap
  melos run flutter:format
  melos run localization:intl
  melos run flutter:build
  melos run flutter:analyze
```
5. Commit your changes: `git commit -m 'Add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Open a Pull Request with a clear description and screenshots if necessary

---

## Contact & Community

For feedback, ideas or contributions kindly open an issue or connect with me on Twitter [@CalebJesusegun](https://x.com/CalebJesusegun).

Let's build Civic24 together 🌍