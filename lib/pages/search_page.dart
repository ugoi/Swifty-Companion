import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/paths.dart';
import 'package:swifty_companion/change_notifier/school_model.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

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
          backgroundColor: Theme.of(context).colorScheme.surface,
          scrolledUnderElevation: 0.0,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
                onPressed: () async {
                  await school?.logout();
                  if (context.mounted) {
                    Navigator.pushNamed(context, PathEnum.login.path);
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
                      return GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, PathEnum.student.path),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                      width: 0.25))),
                          height: 48,
                          child: Center(
                              child: Text(
                            'Entry ${entries[index]}',
                          )),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 40,
                child: SearchBar(
                  hintText: "Search for a student",
                  leading: Icon(Icons.search_rounded),
                ),
              )
            ],
          ),
        )),
      );
    });
  }
}
