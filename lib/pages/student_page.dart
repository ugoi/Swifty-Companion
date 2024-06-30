import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:swifty_companion/custom_icons.dart';
import 'package:swifty_companion/change_notifier/school_model.dart';
import 'package:swifty_companion/entities/user_data.dart';

class StudentPage extends StatelessWidget {
  const StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SchoolModel>(builder: (context, school, child) {
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
        body: Center(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: FutureBuilder(
                    future: school.userData,
                    builder: (context, snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        children = [
                          Profile(
                            profile: snapshot.data!.profile,
                          ),
                          const SizedBox(height: 20),
                          Portfolio(
                              projects: snapshot.data!.projects,
                              skills: snapshot.data!.skills)
                        ];
                      } else if (snapshot.hasError) {
                        children = <Widget>[
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('Error: ${snapshot.error}'),
                          ),
                        ];
                      } else {
                        children = const <Widget>[
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Awaiting result...'),
                          ),
                        ];
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: children,
                      );
                    }))),
      );
    });
  }
}

//DONE
class Profile extends StatelessWidget {
  const Profile({super.key, required this.profile});

  final ProfileEntity profile;

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
                  Text(profile.login,
                      style: Theme.of(context).textTheme.bodyLarge),
                  Text(profile.location),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        LinearPercentIndicator(
          center: Text(
              "level ${profile.level.level.toStringAsFixed(0)} - ${profile.level.toPercentage().toStringAsFixed(0)}%"),
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
              text: Text('${profile.firstName} ${profile.lastName}'),
              icon: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            InfoCard(
              icon: Icon(Icons.mail,
                  color: Theme.of(context).colorScheme.primary),
              text: Text(profile.email),
            ),
            InfoCard(
              icon: Icon(Icons.location_on,
                  color: Theme.of(context).colorScheme.primary),
              text: Text(profile.address),
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
        Flexible(child: text ?? const SizedBox.shrink()),
      ],
    );
  }
}

//DONE
class Portfolio extends StatelessWidget {
  const Portfolio({super.key, required this.projects, required this.skills});

  final List<ProjectEntity> projects;
  final List<SkillEntity> skills;

  @override
  Widget build(BuildContext context) {
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
                    child: projects.length == 0
                        ? Text("no projects were found")
                        : ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: projects.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Project(
                                  title: projects[index].name,
                                  score: projects[index].mark.toPercentage());
                            }),
                  ),
                  Center(
                      child: skills.length == 0
                          ? Text("no skills were found")
                          : ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: skills.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Skill(
                                  title: skills[index].name,
                                  score: skills[index].level.level,
                                  score2: skills[index].level.toPercentage(),
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
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Text(
                title,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              )),
          const SizedBox(
            width: 2,
          ),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                score.toString(),
                style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
              )),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              textAlign: TextAlign.right,
              score2.toStringAsFixed(0),
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),
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
