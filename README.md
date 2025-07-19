# 📱 Flutter Scientific Calculator App

A sleek, fully functional **scientific calculator app** built with **Flutter**, featuring basic and advanced operations, result precision handling, and persistent history. Developed using **Riverpod** for state management and **SharedPreferences** for local storage.

---

## ✨ Features

- ✅ Basic arithmetic operations: `+`, `-`, `×`, `÷`, `=`, `AC`, `()`, `⌫`
- 🔬 Scientific functions: `sin`, `cos`, `tan`, `log`, `√`, `x²`, `π`, `%`
- 🧮 Precise floating-point result formatting (e.g., `100/3 = 33.3333333333`)
- 🧠 Expression & result history with **persistent storage**
- 🧹 Clear history button
- 🔄 Toggle between **Basic** and **Scientific** modes
- 💡 Clean and intuitive UI with `HapticFeedback`

---

## 📸 Screenshots

| Basic Mode | Scientific Mode | History |
|------------|------------------|---------|
| ![](screenshots/basic_mode.png) | ![](screenshots/scientific_mode.png) | ![](screenshots/history.png) |

---

## 🧑‍💻 Tech Stack

- **Flutter** 3.x
- **Riverpod** for state management
- **SharedPreferences** for persistent storage
- **Dart Math Parser** (custom or `math_expressions`)
- Custom calculator button widgets

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK installed: [Flutter Setup](https://flutter.dev/docs/get-started/install)
- A connected device or emulator

### Installation

```bash
git clone https://github.com/Phillip4reall/Calculator-app.git
cd flutter-scientific-calculator
flutter pub get
flutter run

