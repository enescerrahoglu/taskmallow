import 'package:flutter/material.dart';
import 'package:taskmallow/components/icon_component.dart';
import 'package:taskmallow/components/text_component.dart';
import 'package:taskmallow/constants/app_constants.dart';
import 'package:taskmallow/constants/color_constants.dart';
import 'package:taskmallow/routes/route_constants.dart';
import 'package:taskmallow/widgets/base_scaffold_widget.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: "Projects",
      actionList: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, starredProjectsPageRoute);
          },
          icon: const IconComponent(iconData: CustomIconData.stars),
          splashRadius: AppConstants.iconSplashRadius,
        ),
      ],
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const IconComponent(iconData: CustomIconData.plus, color: textPrimaryDarkColor),
        onPressed: () {
          Navigator.pushNamed(context, createProjectPageRoute);
        },
      ),
      widgetList: [
        getProjectContainer(),
        getProjectContainer(),
        getProjectContainer(),
      ],
    );
  }

  Widget getProjectContainer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: itemBackgroundLightColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.pushNamed(context, projectDetailPageRoute);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextComponent(
              text: "Project Name",
              headerType: HeaderType.h4,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
            ),
            const TextComponent(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
              textAlign: TextAlign.start,
              headerType: HeaderType.h6,
            ),
            const SizedBox(height: 10),
            const TextComponent(
              text:
                  "33% Complete", //"${(tasks.where((task) => task.situation == TaskSituation.done).length / tasks.length * 100).toStringAsFixed(0)}% Complete",
              textAlign: TextAlign.start,
              overflow: TextOverflow.fade,
              softWrap: true,
              headerType: HeaderType.h7,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: LinearProgressIndicator(
                minHeight: 20,
                value: (0.33).toDouble(),
              ),
            ),
            const SizedBox(height: 10),
            const TextComponent(
              text: "created by email@gmail.com",
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.end,
              overflow: TextOverflow.fade,
              softWrap: true,
              headerType: HeaderType.h7,
            ),
          ],
        ),
      ),
    );
  }
}
