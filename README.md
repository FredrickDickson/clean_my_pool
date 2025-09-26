
---

# 🏊 CleanMyPool

**CleanMyPool** is a Flutter-based **marketplace application** that connects **pool owners** with **professional pool cleaners**.
With a **sleek Material Design** and **Scandinavian minimalist aesthetic**, the app provides a seamless multi-platform experience (iOS, Android, and Web).

Customers can book services and pay securely, cleaners can manage jobs and earnings, and admins can oversee the platform via a web dashboard.

---

## ✨ Features

### 👤 Customer App

* Browse and hire professional cleaners
* Search and filter by location, rating, or service type
* Secure payments via **Paystack** (Card & Mobile Money)
* Track bookings and job progress

### 🧹 Cleaner App

* Accept or decline booking requests
* Manage active jobs and mark completion
* View transaction history and wallet balance

### 🖥️ Admin Web Dashboard

* Manage customers, cleaners, and bookings
* Handle disputes efficiently
* View analytics in sortable & filterable tables

### ⚙️ Core Tech

* **Authentication**: Supabase Auth
* **Payments**: Paystack integration
* **State Management**: Riverpod
* **Cross-Platform**: iOS, Android, and Web with Flutter

---

## 🚀 Getting Started

### ✅ Prerequisites

* [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.0.0 or higher)
* Android Studio or Xcode for builds
* A code editor (VS Code recommended)
* Internet connection for dependencies

---

### 🔧 Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/cleanmypool.git
   cd cleanmypool
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure environment**

   * **Paystack**:

     * Get API keys from [Paystack Dashboard](https://dashboard.paystack.com).
     * Add them in `lib/services/payment_service.dart` (`_publicKey`, `_secretKey`).
     * ⚠️ Use **server-side verification** in production.

   * **Supabase**:

     * Create a project at [Supabase.io](https://supabase.io).
     * Copy your **Project URL** and **Anon Key**.
     * Update them in `lib/services/supabase_service.dart` and initialize in `main.dart`.

   * **Android setup**:

     * Update `android/app/src/main/kotlin/.../MainActivity.kt` to use:

       ```kotlin
       class MainActivity: FlutterFragmentActivity()
       ```

       (required for Paystack compatibility).

4. **Run the app**

   * Mobile:

     ```bash
     flutter run
     ```
   * Web (Admin Dashboard):

     ```bash
     flutter run -d chrome --web-port=8080
     ```

---

## 📂 Project Structure

```
lib/
 ┣ core/        # App-wide utilities (routing, constants)
 ┣ features/    # Feature modules (auth, customer, cleaner, admin)
 ┣ models/      # Data models (User, Booking, Payment, etc.)
 ┣ services/    # Business logic (Supabase, Paystack)
 ┣ utils/       # Helper functions
 ┣ widgets/     # Reusable UI components
```

---

## 📖 Usage

* **Customer** → Log in → Select service → Pick date & time → Pay securely.
* **Cleaner** → Accept/Decline job → Complete service → Get paid.
* **Admin** → Access dashboard → Manage users/bookings → View analytics.

---

## 🤝 Contributing

We welcome contributions!

1. Fork the repo
2. Create a feature branch:

   ```bash
   git checkout -b feature/new-feature
   ```
3. Commit changes:

   ```bash
   git commit -m "Add new feature"
   ```
4. Push to branch:

   ```bash
   git push origin feature/new-feature
   ```
5. Open a Pull Request 🚀

---

## 📜 License

Licensed under the **MIT License**.
See the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

* [Flutter](https://flutter.dev) for the framework
* [Paystack](https://paystack.com) for payments
* [Supabase](https://supabase.io) for backend services
* [Riverpod](https://riverpod.dev) for state management

---

📅 *Last updated: September 26, 2025*

---

Would you like me to also **add screenshots / mockups section** in the README (so it looks more professional for GitHub/portfolio), or keep it purely text for now?
