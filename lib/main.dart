import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'controllers/auth_controller.dart';
import 'controllers/favorite_controller.dart';
import 'controllers/product_controller.dart';
import 'models/show_model.dart';
import 'services/auth_service.dart';
import 'utils/app_theme.dart';
import 'views/auth/login_view.dart';
import 'views/home/main_nav_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inisialisasi Hive database untuk fitur favorit
  await Hive.initFlutter();
  Hive.registerAdapter(ShowAdapter());
  await Hive.openBox<ShowModel>('favorites');

  // 2. Cek session login dari SharedPreferences
  final authService = AuthService();
  final bool loggedIn = await authService.isLoggedIn();

  runApp(MainApp(isLoggedIn: loggedIn));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;

  const MainApp({
    super.key,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    // Dependency Injection menggunakan GetX
    Get.put(AuthController());
    Get.put(FavoriteController());
    Get.put(ProductController());

    return GetMaterialApp(
      title: 'NontonSkuy!',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: isLoggedIn ? '/home' : '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginView(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/home',
          page: () => const MainNavView(),
          transition: Transition.fadeIn,
        ),
      ],
    );
  }
}
