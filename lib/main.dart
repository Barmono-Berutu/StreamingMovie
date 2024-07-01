import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:streaming_app/firebase_options.dart';
import 'package:streaming_app/page/login_data/auth_page.dart';
import 'package:streaming_app/provider/Theme_prov.dart';
import 'package:streaming_app/provider/details_provider.dart';
import 'package:streaming_app/provider/discover_provider.dart';
import 'package:streaming_app/provider/genre_details_provider.dart';
import 'package:streaming_app/provider/genre_provider.dart';
import 'package:streaming_app/provider/playing_provider.dart';
import 'package:streaming_app/provider/upcoming.dart';
import 'package:streaming_app/provider/search.dart';
import 'package:streaming_app/provider/simpan_provider.dart';
import 'package:streaming_app/provider/top_rated_provider.dart';
import 'package:streaming_app/provider/vidio_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Memulai splash screen
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  runApp(const MyApp());

  // Menghapus splash screen setelah aplikasi mulai
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Discover()),
        ChangeNotifierProvider(create: (_) => Upcoming()),
        ChangeNotifierProvider(create: (_) => nowPlaying()),
        ChangeNotifierProvider(create: (_) => topRated()),
        ChangeNotifierProvider(create: (_) => Details()),
        ChangeNotifierProvider(create: (_) => Simpan()),
        ChangeNotifierProvider(create: (_) => Search()),
        ChangeNotifierProvider(create: (_) => VidioProv()),
        ChangeNotifierProvider(create: (_) => Genres()),
        ChangeNotifierProvider(create: (_) => GenreDetailsProv()),
        ChangeNotifierProvider(create: (_) => ThemeProv()),
      ],
      child: Consumer<ThemeProv>(builder: (context, value, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AnimatedSplashScreen(
            splash: "lib/gambar/1.gif",
            nextScreen: Auth_Page(),
            splashIconSize: 2000.0,
            centered: true,
            backgroundColor: Colors.black,
            duration: 3100,
          ),
          theme: value.themeData,
        );
      }),
    );
  }
}
