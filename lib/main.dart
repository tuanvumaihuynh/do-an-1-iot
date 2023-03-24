import 'package:do_an_1_iot/core/providers/home_provider.dart';
import 'package:do_an_1_iot/core/providers/user_provider.dart';
import 'package:do_an_1_iot/ui/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:do_an_1_iot/ui/views/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Device orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Status bar setting
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
      statusBarIconBrightness: Brightness.dark));
  // Initilize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Remove Splash Screen
    FlutterNativeSplash.remove();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: ((context) => UserProvider()),
          ),
          ChangeNotifierProvider(
            create: ((context) => HomeProvider()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          // TODO: Implement dark mode?
          themeMode: ThemeMode.light,
          // TODO: Need to check launch first time?
          home: const WidgetTree(),
        ));
  }
}
