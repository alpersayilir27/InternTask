import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_task/firebase_options.dart';
import 'package:intern_task/product/constants/app_constants.dart';

import 'view/splash/splash_view.dart';

Future<void> main(List<String> args) async {
  // init firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  // run app

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: "intern_task for Mimiqit",
        navigatorKey: AppConstants.navigatorKey,
        home: const SplashView(),
      ),
    );
  }
}
