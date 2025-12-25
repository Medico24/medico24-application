# Medico24 🏥

A comprehensive health companion mobile application built with Flutter, designed to provide seamless healthcare services and accessibility features for all users.

## 📱 About

Medico24 is a modern healthcare application that brings medical services to your fingertips. With features ranging from appointment booking to prescription management, and special accessibility options for specially-abled users, Medico24 aims to make healthcare accessible to everyone.

## ✨ Features

### Core Features
- 🔐 **Firebase Authentication** - Secure Google Sign-In integration
- 📍 **Location Management** - Save and manage multiple addresses with location permissions
- 👤 **User Profiles** - Comprehensive user profile management with health records
- 📅 **Appointments** - Schedule and manage medical appointments
- 💊 **Prescriptions & Medicines** - Track prescriptions and medicine orders
- 🏪 **Pharmacy Integration** - Browse and order from nearby pharmacies
- 🏃 **Activity Tracking** - Monitor health and fitness activities

### Accessibility Features
- ♿ **Specially Abled Support** - Customizable settings for users with special needs:
  - Hearing assistance levels (None, Mild, Moderate, Severe)
  - Vision assistance levels (None, Mild, Moderate, Severe)
  - Mobility assistance levels (None, Mild, Moderate, Severe)
  - Older person mode with enhanced UI
- 🎨 **Visual Indicators** - Vibrant color-coded icons showing active accessibility settings
- 💾 **Persistent Settings** - All accessibility preferences saved locally using Drift

### User Experience
- 🎯 **Intuitive Navigation** - 6-tab navigation with smooth page transitions
- 📜 **Smart Scroll Behavior** - Auto-hiding top bar for immersive content viewing
- 🌈 **Modern UI** - Material 3 design with custom color palette and Outfit font
- ⚡ **Fast & Responsive** - Optimized performance with local database caching

## 🛠️ Tech Stack

### Framework & Language
- **Flutter** 3.10.4+
- **Dart** 3.10.4+

### State Management & Navigation
- **GoRouter** 14.6.2 - Declarative routing with custom transitions

### Backend & Authentication
- **Firebase Core** 4.3.0
- **Firebase Auth** 6.1.3
- **Google Sign-In** 7.2.0

### Local Database
- **Drift** 2.22.0 - Type-safe SQLite wrapper
- **SQLite3 Flutter Libs** 0.5.0
- **Path Provider** 2.1.5

### UI & Design
- **Google Fonts** 6.2.1 (Outfit font family)
- **Flutter SVG** 2.0.14
- Material 3 Design System

### Utilities
- **Permission Handler** 11.3.1 - Location and other permissions
- **Flutter Dotenv** 5.2.1 - Environment variable management

## 🎨 Design System

### Color Palette
- **Primary Red**: #E23744 (with 9 shades: red100-red900)
- **Yellow**: #F8D149
- **Blue**: #2781E7
- **Teal**: #009999
- **Coal**: #1C1C1C (Text)
- **Grey**: #4F4F4F (Secondary text)

### Typography
- **Font Family**: Outfit (via Google Fonts)
- Material 3 text styles with custom weights

## 🚀 Getting Started

For detailed setup instructions, please see [CONTRIBUTING.md](CONTRIBUTING.md).

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/rohansen856/medico24
   cd medico24
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate database code**
   ```bash
   dart run build_runner build
   ```

4. **Configure Firebase**
   - Create `.env` file with Firebase credentials
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)

5. **Run the app**
   ```bash
   flutter run
   ```

## 📸 Screenshots

- Splash Screen with fade animation (2.3s)
- Home Screen with 6-tab navigation
- Profile with accessibility indicators
- Location management with saved addresses
- Accessibility settings with dynamic save button

## 🔒 Security

- Firebase Authentication for secure user management
- Environment variables for sensitive credentials
- No hardcoded API keys or secrets
- Local data encryption via SQLite

## 📄 License

This project is proprietary and confidential. See [LICENSE](LICENSE) for details.

## 👥 Authors

Developed with ❤️ by the Medico24 team

## 🤝 Contributing

This is a closed-source project. For internal contribution guidelines, please see [CONTRIBUTING.md](CONTRIBUTING.md).

---

**Version**: 1.0.0+1  
**Last Updated**: December 28, 2025  
**Flutter SDK**: >=3.10.4