import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/custom_icons.dart';
import 'package:swifty_companion/change_notifier/school_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      final school = Provider.of<SchoolModel>(context, listen: false);
      school.initialRoute().then((value) {
        Navigator.pushReplacementNamed(context, value.path);
      });
    });
  }

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
                  SvgPicture.asset(
                    CustomIcons.logo42,
                    semanticsLabel: 'Acme Logo',
                    fit: BoxFit.scaleDown,
                    height: 60,
                    width: 60,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                  ),
                  Text(
                    'Swifty Companion',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 24),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
