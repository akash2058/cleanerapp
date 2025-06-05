import 'package:binbookingapp/providers/cleaner_app_provider.dart';
import 'package:binbookingapp/view/no_internet/no_internet_provider.dart';
import 'package:binbookingapp/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  clearAppCache();
  runApp(
    MultiProvider(
      providers: [
        ...getProviders(),
        ChangeNotifierProvider(create: (_) => InternetProvider()),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: Size(430, 923),
        child: const MyApp(),
      ),
    ),
  );
}

Future<void> clearAppCache() async {
  try {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
      print('✅ Cache cleared.');
    }
  } catch (e) {
    print('⚠️ Error clearing cache: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const SplashScreen(),
    );
  }
}
