import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/environment.dart';
import 'package:swifty_companion/pages/search_page.dart';
import 'package:swifty_companion/logging_setup.dart';
import 'package:swifty_companion/pages/login_page.dart';
import 'package:swifty_companion/paths.dart';
import 'package:swifty_companion/change_notifier/school_model.dart';
import 'package:swifty_companion/pages/splash_page.dart';
import 'package:swifty_companion/service/school_service_facade.dart';
import 'package:swifty_companion/theme/theme.dart';

Future main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Just here in case, I dont know if it's needed.
  setupLogging();
  await Environment.init();
  final schoolServiceFacade = await SchoolServiceFacade.create();
  runApp(ChangeNotifierProvider(
    create: (context) => SchoolModel(schoolServiceFacade: schoolServiceFacade),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<SchoolModel>(builder: (context, school, child) {
      return MaterialApp(
        theme: darkMode,
        initialRoute: PathEnum.splash.path,
        onGenerateRoute: (settings) {
          if (settings.name == PathEnum.login.path) {
            return _createLoginPageRoute();
          } else if (settings.name == PathEnum.search.path) {
            return MaterialPageRoute(builder: (context) => const SearchPage());
          } else if (settings.name == PathEnum.splash.path) {
            return MaterialPageRoute(builder: (context) => const SplashPage());
          } else {
            return null;
          }
        },
      );
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
