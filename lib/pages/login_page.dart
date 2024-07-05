import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/custom_icons.dart';
import 'package:swifty_companion/paths.dart';
import 'package:swifty_companion/change_notifier/school_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<SchoolModel>(builder: (context, school, child) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SvgPicture.asset(
                        CustomIcons.logo42,
                        semanticsLabel: 'Acme Logo',
                        fit: BoxFit.scaleDown,
                        height: 60,
                        width: 60,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary,
                            BlendMode.srcIn),
                      ),
                    ),
                    Text(
                      'Swifty Companion',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 24),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary),
                      icon: Icon(
                        Icons.school,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      label: Text(
                        "Continue with 42",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.surface),
                      ),
                      onPressed: () async {
                        await school?.login();
                        if (context.mounted) {
                          Navigator.pushNamed(context, PathEnum.search.path);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
