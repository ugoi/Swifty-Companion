import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          future: Future.delayed(
              Duration(seconds: 2), () async => await school.initialRoute),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MaterialApp(
                theme: ThemeData(
                  useMaterial3: true,

                  // Define the default brightness and colors.
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Color(0xFF41C9C9),
                    // ···
                    brightness: Brightness.dark,
                  ),

                  // Define the default `TextTheme`. Use this to specify the default
                  // text styling for headlines, titles, bodies of text, and more.
                ),
                initialRoute: snapshot.data,
                routes: {
                  Paths.login: (context) => const LoginPage(),
                  Paths.home: (context) => HomePage(),
                  Paths.splash: (context) => const SplashPage(),
                },
              );
            } else {
              return SplashPage();
            }
          });
    });
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   void _incrementCounter() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SchoolModel>(builder: (context, school, child) {
//       return FutureBuilder(
//           future: Future.delayed(
//               Duration(seconds: 2), () async => await school.initialRoute),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return MaterialApp(
//                 darkTheme: ThemeData(
//                     brightness: Brightness.dark,
//                     colorScheme: ColorScheme.fromSeed(
//                         seedColor: Color.fromARGB(1, 255, 0, 0))),
//                 themeMode: ThemeMode.dark,
//                 initialRoute: snapshot.data,
//                 routes: {
//                   Paths.login: (context) => const LoginPage(),
//                   Paths.home: (context) => HomePage(),
//                   Paths.splash: (context) => const SplashPage(),
//                 },
//               );
//             } else {
//               return SplashPage();
//             }
//           });
//     });
//   }
// }
