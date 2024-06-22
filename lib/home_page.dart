import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/paths.dart';
import 'package:swifty_companion/school_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List entries = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
    return Consumer<SchoolModel?>(builder: (context, school, child) {
      return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.surface,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.

          leading: Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
                onPressed: () async {
                  await school?.logout();
                  if (context.mounted) {
                    Navigator.pushNamed(context, Paths.login);
                  }
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text("Logout")),
          ),

          leadingWidth: 300,
        ),

        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 50,
                        child: Center(child: Text('Entry ${entries[index]}')),
                      );
                    }),
              ),
              const SizedBox(
                height: 40,
                child: SearchBar(),
              )
            ],
          ),
        )),
// This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}
