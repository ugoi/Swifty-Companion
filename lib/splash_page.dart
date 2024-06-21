import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/icons.dart';
import 'package:swifty_companion/school_model.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<SchoolModel?>(builder: (context, school, child) {
      return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            body: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: logo42,
                  ),
                  Container(
                    child: const Text(
                      'Swifty Companion',
                      textDirection: TextDirection.ltr,
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
