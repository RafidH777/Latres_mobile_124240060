# NontonSkuy! - Aplikasi TV Shows (Latihan Responsi Praktikum Mobile)

Aplikasi mobile untuk streaming & eksplorasi informasi TV Series/Shows yang terintegrasi dengan API publik TVMaze (`https://api.tvmaze.com/shows`), dilengkapi fitur autentikasi sesi, penyimpanan lokal favorit berbasis Hive, navigasi antarmuka modern, dan state management GetX.

---

## 📱 Fitur Utama & Kriteria Penilaian

### 1. Login Page (15%)
- Input **Username [NIM]** dan **Password: `123`**.
- Validasi form interaktif dengan umpan balik visual (GetX Snackbar).
- Penyimpanan status login dan session username menggunakan **SharedPreferences**.
- Auto-redirect jika user telah login sebelumnya (persistent login session).
- Tombol **Logout** menghapus session dari SharedPreferences dan mengarahkan kembali ke halaman login.

### 2. Home Page / Daftar Shows (30%)
- **BottomNavigationBar** terstruktur untuk navigasi 3 halaman utama: **Beranda**, **Favorit**, dan **Profil**.
- Data dinamis diambil dari endpoint TVMaze: `https://api.tvmaze.com/shows`.
- Tampilan **Grid 2 Kolom** rapi dengan informasi:
  1. Poster Gambar (`image`)
  2. Judul Show (`name`)
  3. Rating (`rating.average` dengan ikon bintang ⭐)
- Dilengkapi **Loading Indicator** dan penanganan error/retry.
- Logika fetch & parsing API terpisah rapi di dalam `lib/services/api_services.dart`.
- Navigasi ke Halaman Detail ketika show di-klik.

### 3. Detail Page (25%)
- Mengambil detail show spesifik dari endpoint: `https://api.tvmaze.com/shows/{id}`.
- Menampilkan informasi detail lengkap:
  1. Poster besar / Gambar
  2. Judul Show
  3. Rating Show
  4. Genre Show
  5. Summary/Overview (HTML tags dibersihkan secara rapi)
- **Tombol Favorit**: Menggunakan ikon hati untuk menambah/menghapus show dari daftar favorit.
- **Tombol Back**: Untuk kembali ke halaman sebelumnya.

### 4. Favorite Page (20%)
- Menampilkan daftar TV show favorit yang disimpan pengguna.
- Penyimpanan lokal persisten menggunakan database NoSQL **Hive** (`Hive.openBox<ShowModel>('favorites')`) dengan custom `ShowAdapter`.
- Fitur **Hapus Favorit** dengan dialog konfirmasi dan ikon tempat sampah merah.
- Klik pada item favorit langsung mengarahkan ke halaman detail show terkait.

### 5. Profile Page (10%)
- Menampilkan avatar pengguna dan **Username [NIM]** yang diambil dari **SharedPreferences**.
- Menampilkan kartu **Kesan** dan **Pesan** selama praktikum mobile.
- Tombol **Logout** fungsional dengan dialog konfirmasi.

---

## 🛠️ Arsitektur & Teknologi

- **Framework**: Flutter (Dart)
- **State Management & Routing**: GetX (`GetMaterialApp`, `GetxController`, `Obx`, `Get.to()`, `Get.snackbar()`)
- **HTTP Client**: `http` package
- **Local Storage (Session)**: `shared_preferences`
- **Local Database (Favorites)**: `hive` & `hive_flutter`
- **Theme**: Dark Modern Entertainment UI (Netflix/Dark style)

---

## 📁 Struktur Direktori

```
lib/
├── controllers/
│   ├── auth_controller.dart        # Controller GetX autentikasi & session
│   ├── favorite_controller.dart    # Controller GetX favorit (Hive)
│   └── product_controller.dart     # Controller GetX TV shows list & filter
├── models/
│   ├── product_model.dart          # ShowModel & TypeAdapter Hive
│   ├── show_model.dart             # Model export & alias
│   └── user_model.dart             # UserModel
├── services/
│   ├── api_services.dart           # Service HTTP API TVMaze (fetch & parse)
│   ├── auth_service.dart           # Service SharedPreferences
│   └── favorite_service.dart       # Service database Hive
├── utils/
│   └── app_theme.dart              # Konfigurasi Dark Theme & styling
├── views/
│   ├── auth/
│   │   ├── login_view.dart         # Halaman Login
│   │   └── register_view.dart      # Info/Register view
│   ├── detail/
│   │   └── product_detail.dart     # Halaman Detail Show
│   └── home/
│       ├── main_nav_view.dart      # Container BottomNavigationBar
│       ├── product_list_view.dart  # Halaman Home (Grid Shows)
│       ├── wishlist_view.dart      # Halaman Favorit
│       └── profile_view.dart       # Halaman Profil
└── main.dart                       # Inisialisasi Hive, Session & Root App
```
