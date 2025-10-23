# Pokemon Test

**English:** A Flutter application that showcases Pokemon generations, details, and favorites with offline persistence powered by Hive.

**Bahasa Indonesia:** Aplikasi Flutter yang menampilkan generasi, detail, serta daftar favorit Pokemon dengan penyimpanan offline menggunakan Hive.

---

## English

### Requirements
- Flutter SDK 3.9.2 or newer
- Dart SDK bundled with Flutter
- Android Studio or Xcode for mobile builds, plus required platform SDKs
- An emulator/simulator or a physical device connected via USB (with debugging enabled)

### Setup
1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd pokemon_test
   ```
2. **Install dependencies**
   ```bash
   flutter pub get
   ```
3. **Generate code (for Hive adapters and JSON models)**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. **(Optional) Configure launcher icons**
   ```bash
   dart run flutter_launcher_icons
   ```

### Running the App
- Run on the last connected device (mobile, web, or desktop):
  ```bash
  flutter run
  ```
- Specify a platform/device:
  - Android emulator: `flutter run -d emulator-5554`
  - iOS simulator: `flutter run -d ios`
  - Web (Chrome): `flutter run -d chrome`
  - Windows/macOS/Linux desktop: `flutter run -d windows`

### Testing
- Run the full test suite:
  ```bash
  flutter test
  ```
- Run a specific test file:
  ```bash
  flutter test test/features/pokemon_generation/presentation/cubit/pokemon_cubit_test.dart
  ```

### Project Highlights
- Feature-driven folder structure under `lib/features`
- State management with `bloc`/`flutter_bloc`
- Local persistence with `hive_ce` and generated adapters
- Typed models generated via `json_serializable`
- Navigation handled through `go_router`

### Troubleshooting
- **Command not found / version mismatch:** run `flutter --version` to confirm you are using Flutter 3.9.2+.
- **Build runner conflicts:** rerun `dart run build_runner build --delete-conflicting-outputs`.
- **Missing platform dependencies:** open the project in Android Studio/Xcode and install any suggested SDK components.

---

## Bahasa Indonesia

### Kebutuhan Sistem
- Flutter SDK versi 3.9.2 atau lebih baru
- Dart SDK (sudah termasuk di dalam Flutter)
- Android Studio atau Xcode untuk build mobile, serta SDK platform terkait
- Emulator/simulator atau perangkat fisik yang terhubung via USB (aktifkan debugging)

### Langkah Instalasi
1. **Klon repositori**
   ```bash
   git clone <repository-url>
   cd pokemon_test
   ```
2. **Pasang dependensi**
   ```bash
   flutter pub get
   ```
3. **Bangun kode hasil generate (adapter Hive dan model JSON)**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. **(Opsional) Atur ikon peluncur aplikasi**
   ```bash
   dart run flutter_launcher_icons
   ```

### Menjalankan Aplikasi
- Jalankan pada perangkat terakhir yang terdeteksi (mobile, web, atau desktop):
  ```bash
  flutter run
  ```
- Tentukan perangkat/platform tertentu:
  - Emulator Android: `flutter run -d emulator-5554`
  - Simulator iOS: `flutter run -d ios`
  - Web (Chrome): `flutter run -d chrome`
  - Desktop Windows/macOS/Linux: `flutter run -d windows`

### Menjalankan Pengujian
- Jalankan seluruh test:
  ```bash
  flutter test
  ```
- Jalankan test tertentu:
  ```bash
  flutter test test/features/pokemon_generation/presentation/cubit/pokemon_cubit_test.dart
  ```

### Sorotan Proyek
- Struktur folder berbasis fitur di `lib/features`
- Manajemen state menggunakan `bloc`/`flutter_bloc`
- Penyimpanan lokal dengan `hive_ce` dan adapter otomatis
- Model bertipe kuat yang dihasilkan lewat `json_serializable`
- Navigasi menggunakan `go_router`

### Pemecahan Masalah
- **Perintah tidak ditemukan / versi tidak cocok:** jalankan `flutter --version` untuk memastikan memakai Flutter 3.9.2+.
- **Konflik build_runner:** jalankan ulang `dart run build_runner build --delete-conflicting-outputs`.
- **Dependensi platform belum terpasang:** buka proyek di Android Studio/Xcode dan ikuti rekomendasi instalasi SDK.

---

Maintained with ❤️ by the Pokemon Test team.
