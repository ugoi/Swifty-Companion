
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/custom_icons.dart';
import 'package:swifty_companion/change_notifier/school_model.dart';

class StudentPage extends StatelessWidget {
  const StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SchoolModel?>(builder: (context, school, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          scrolledUnderElevation: 0.0,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
                onPressed: () async {
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text("Search")),
          ),
          leadingWidth: 300,
        ),
        body: const Center(
            child: Padding(
          padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
          child: Column(
            children: [Profile(), SizedBox(height: 20), Portfolio()],
          ),
        )),
      );
    });
  }
}

//DONE
class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          child: Row(
            children: [
              Image.network(CustomIcons.avatar),
              const SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("mmuster", style: Theme.of(context).textTheme.bodyLarge),
                  const Text("Unavailable"),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        LinearPercentIndicator(
          center: const Text("level 12 - 42%"),
          padding: EdgeInsets.zero,
          barRadius: const Radius.circular(15),
          lineHeight: 20,
          percent: 0.42,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
          progressColor: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            InfoCard(
              text: const Text("Max Mustermann"),
              icon: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            InfoCard(
              icon: Icon(Icons.mail,
                  color: Theme.of(context).colorScheme.primary),
              text: const Text("mmuster@student.42lausanne.ch"),
            ),
            InfoCard(
              icon: Icon(Icons.location_on,
                  color: Theme.of(context).colorScheme.primary),
              text: const Text("Luasanne, Switzerland"),
            ),
          ],
        )
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final Widget? icon;
  final Widget? text;

  const InfoCard({
    this.icon,
    this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon ?? const SizedBox.shrink(),
        if (icon != null && text != null) const SizedBox(width: 7),
        text ?? const SizedBox.shrink(),
      ],
    );
  }
}

//NOT STARTED
class Portfolio extends StatelessWidget {
  const Portfolio({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List entries = [
      'Transcendence',
      'Ft_Irc',
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
    return DefaultTabController(
        length: 2,
        child: Expanded(
          child: Column(
            children: [
              const TabBar(
                labelPadding: EdgeInsets.only(right: 16),
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: "Projects",
                  ),
                  Tab(
                    text: "Skills",
                  )
                ],
              ),
              Expanded(
                child: TabBarView(children: <Widget>[
                  Center(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Project(title: entries[index], score: 100);
                        }),
                  ),
                  Center(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: entries.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Skill(
                              title: entries[index],
                              score: 13,
                              score2: 60,
                            );
                          }))
                ]),
              ),
            ],
          ),
        ));
  }
}

class Skill extends StatelessWidget {
  final String title;
  final double score;
  final double score2;

  const Skill({
    super.key,
    required this.title,
    required this.score,
    required this.score2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outline, width: 0.25))),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          )),
          Expanded(
              child: Text(
            score.toString(),
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          )),
          Text(
            score2.toString(),
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          )
        ],
      ),
    );
  }
}

class Project extends StatelessWidget {
  final String title;
  final double score;

  const Project({super.key, required this.title, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outline, width: 0.25))),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          Text(score.toString(),
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary))
        ],
      ),
    );
  }
}
