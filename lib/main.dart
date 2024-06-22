import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/environment.dart';
import 'package:swifty_companion/home_page.dart';
import 'package:swifty_companion/logging_setup.dart';
import 'package:swifty_companion/login_page.dart';
import 'package:swifty_companion/paths.dart';
import 'package:swifty_companion/school_model.dart';
import 'package:swifty_companion/school_repository_factory.dart';
import 'package:swifty_companion/splash_page.dart';

Future main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Just here in case, I dont know if it's needed.
  setupLogging();
  await Environment.init();
  final schoolRepository = await SchoolRepositoryFactory.createRepository();
  runApp(ChangeNotifierProvider(
    create: (context) => SchoolModel(schoolRepository: schoolRepository),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<SchoolModel>(builder: (context, school, child) {
      return FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2),
              () async => await school.initialRoute),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MaterialApp(
                theme: ThemeData(
                  useMaterial3: true,

                  // Define the default brightness and colors.
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color(0xFF41C9C9),
                    // ···
                    brightness: Brightness.dark,
                  ),

                  // Define the default `TextTheme`. Use this to specify the default
                  // text styling for headlines, titles, bodies of text, and more.
                ),
                initialRoute: snapshot.data,
                // routes: {
                //   Paths.login: (context) => const LoginPage(),
                //   Paths.home: (context) => const HomePage(),
                //   Paths.splash: (context) => const SplashPage(),
                // },

                onGenerateRoute: (settings) {
                  switch (settings.name) {
                    case Paths.login:
                      return _createLoginPageRoute();
                    case Paths.home:
                      return MaterialPageRoute(
                          builder: (context) => const HomePage());
                    case Paths.splash:
                      return MaterialPageRoute(
                          builder: (context) => const SplashPage());
                    default:
                      return null;
                  }
                },
              );
            } else {
              return const SplashPage();
            }
          });
    });
  }
}

Route _createLoginPageRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
