import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taskmallow/components/button_component.dart';
import 'package:taskmallow/components/text_component.dart';
import 'package:taskmallow/constants/color_constants.dart';
import 'package:taskmallow/constants/string_constants.dart';
import 'package:taskmallow/localization/app_localization.dart';
import 'package:taskmallow/models/invitation_model.dart';
import 'package:taskmallow/providers/providers.dart';
import 'package:taskmallow/repositories/project_repository.dart';
import 'package:taskmallow/repositories/user_repository.dart';
import 'package:taskmallow/routes/route_constants.dart';
import 'package:taskmallow/widgets/base_scaffold_widget.dart';
import '../components/icon_component.dart';
import '../constants/app_constants.dart';

class InvitationsPage extends ConsumerStatefulWidget {
  const InvitationsPage({super.key});

  @override
  ConsumerState<InvitationsPage> createState() => _InvitationsPageState();
}

class _InvitationsPageState extends ConsumerState<InvitationsPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = ref.watch(userProvider);
    ProjectRepository projectRepository = ref.watch(projectProvider);
    return BaseScaffoldWidget(
      title: getTranslated(context, AppKeys.invitations),
      leadingWidget: IconButton(
        splashRadius: AppConstants.iconSplashRadius,
        icon: const IconComponent(iconData: CustomIconData.chevronLeft),
        onPressed: () => isLoading ? null : Navigator.pop(context),
      ),
      widgetList: userRepository.incomingInvitations
          .where((element) => element.toUser.email == userRepository.userModel!.email)
          .map((invitation) => getInvitationRow(invitation, projectRepository, userRepository))
          .toList(),
    );
  }

  Widget getInvitationRow(InvitationModel invitationModel, ProjectRepository projectRepository, UserRepository userRepository) {
    return invitationModel.project.userWhoCreated.email == invitationModel.fromUser.email
        ? Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: itemBackgroundLightColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${invitationModel.project.userWhoCreated.firstName} ${invitationModel.project.userWhoCreated.lastName}",
                        style: const TextStyle(
                          color: textPrimaryLightColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint("${invitationModel.project.userWhoCreated.firstName} ${invitationModel.project.userWhoCreated.lastName}");
                          },
                      ),
                      TextSpan(
                        text: getTranslated(context, AppKeys.toInvolveMessagePart1),
                        style: const TextStyle(
                          color: textPrimaryLightColor,
                          fontSize: 18,
                          fontFamily: "Poppins",
                        ),
                      ),
                      TextSpan(
                        text: invitationModel.project.name,
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint(invitationModel.project.name);
                          },
                      ),
                      TextSpan(
                        text: getTranslated(context, AppKeys.toInvolveMessagePart2),
                        style: const TextStyle(
                          color: textPrimaryLightColor,
                          fontSize: 18,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ButtonComponent(
                        text: getTranslated(context, AppKeys.accept),
                        textPadding: 8,
                        isOutLined: true,
                        color: success,
                        onPressed: () async {
                          await projectRepository.addCollaborator(invitationModel.project, userRepository.userModel!).whenComplete(() {
                            userRepository.removeInvitation(invitationModel);
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        child: ButtonComponent(
                          text: getTranslated(context, AppKeys.reject),
                          textPadding: 8,
                          isOutLined: true,
                          color: danger,
                          onPressed: () async {
                            await userRepository.removeInvitation(invitationModel);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                TextComponent(
                  text: "${DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(
                    DateTime.fromMillisecondsSinceEpoch(invitationModel.createdDate!),
                  )} ${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(
                    DateTime.fromMillisecondsSinceEpoch(invitationModel.createdDate!),
                  )}",
                  textAlign: TextAlign.end,
                  headerType: HeaderType.h8,
                ),
              ],
            ),
          )
        : Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: itemBackgroundLightColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${invitationModel.fromUser.firstName} ${invitationModel.fromUser.lastName}",
                        style: const TextStyle(
                          color: textPrimaryLightColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, profileScreenPageRoute, arguments: invitationModel.fromUser);
                          },
                      ),
                      TextSpan(
                        text: getTranslated(context, AppKeys.toBeIncludedMessagePart1),
                        style: const TextStyle(
                          color: textPrimaryLightColor,
                          fontSize: 18,
                          fontFamily: "Poppins",
                        ),
                      ),
                      TextSpan(
                        text: invitationModel.project.name,
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            ref.read(projectProvider).projectModel = invitationModel.project;
                            if (invitationModel.project.collaborators
                                .map((collaborator) => collaborator.email)
                                .toList()
                                .contains(userRepository.userModel!.email)) {
                              Navigator.pushNamed(context, projectDetailPageRoute, arguments: invitationModel.project);
                            } else {
                              Navigator.pushNamed(context, projectScreenPageRoute, arguments: invitationModel.project);
                            }
                          },
                      ),
                      TextSpan(
                        text: getTranslated(context, AppKeys.toBeIncludedMessagePart2),
                        style: const TextStyle(
                          color: textPrimaryLightColor,
                          fontSize: 18,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ButtonComponent(
                        text: getTranslated(context, AppKeys.accept),
                        textPadding: 8,
                        isOutLined: true,
                        color: success,
                        onPressed: () async {
                          await projectRepository.addCollaborator(invitationModel.project, invitationModel.fromUser).whenComplete(() {
                            userRepository.removeInvitation(invitationModel);
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        child: ButtonComponent(
                          text: getTranslated(context, AppKeys.reject),
                          textPadding: 8,
                          isOutLined: true,
                          color: danger,
                          onPressed: () async {
                            await userRepository.removeInvitation(invitationModel);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                TextComponent(
                  text: "${DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(
                    DateTime.fromMillisecondsSinceEpoch(invitationModel.createdDate!),
                  )} ${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(
                    DateTime.fromMillisecondsSinceEpoch(invitationModel.createdDate!),
                  )}",
                  textAlign: TextAlign.end,
                  headerType: HeaderType.h8,
                ),
              ],
            ),
          );
  }
}
