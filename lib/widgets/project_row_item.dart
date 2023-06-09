import 'package:flutter/material.dart';
import 'package:taskmallow/components/text_component.dart';
import 'package:taskmallow/constants/color_constants.dart';
import 'package:taskmallow/constants/string_constants.dart';
import 'package:taskmallow/helpers/app_functions.dart';
import 'package:taskmallow/localization/app_localization.dart';
import 'package:taskmallow/models/project_model.dart';
import 'package:taskmallow/widgets/marquee_widget.dart';

class ProjectRowItem extends StatefulWidget {
  final ProjectModel projectModel;
  final Function()? onTap;
  const ProjectRowItem({super.key, required this.projectModel, this.onTap});

  @override
  State<ProjectRowItem> createState() => _ProjectRowItemState();
}

class _ProjectRowItemState extends State<ProjectRowItem> {
  @override
  Widget build(BuildContext context) {
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
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextComponent(
              text: widget.projectModel.name,
              headerType: HeaderType.h4,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
            ),
            TextComponent(
              text: widget.projectModel.description,
              textAlign: TextAlign.start,
              headerType: HeaderType.h6,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            MarqueeWidget(
              child: TextComponent(
                text:
                    "${(AppFunctions().getPercentageOfCompletion(widget.projectModel) * 100).toStringAsFixed(0)}% ${getTranslated(context, AppKeys.completed)}",
                textAlign: TextAlign.start,
                overflow: TextOverflow.fade,
                softWrap: true,
                headerType: HeaderType.h7,
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: LinearProgressIndicator(
                minHeight: 20,
                value: AppFunctions().getPercentageOfCompletion(widget.projectModel),
              ),
            ),
            const SizedBox(height: 10),
            TextComponent(
              text: widget.projectModel.userWhoCreated.email,
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
